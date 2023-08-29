%include "../linux_syscalls.inc"
global _start

%define BUFFER_SIZE 256

section .text
_start:
	; argc = [rbp+8]
	; argv = rbp

	enter BUFFER_SIZE
	sub rbp, 16
	xor ebx, ebx
	mov r12d, 10	; line/char count
	mov r13b, 0	; line mode
	xor r14d, r14d	; default: stdin

	cmp dword 2, [rbp-8]

	mov rsi, [rbp+8*1]	; 0 = file name
	mov eax, [rsi]
	and eax, 0x00111111
	cmp eax "-n"
	sete r13b
	je str_to_num
	cmp eax, "-c"
	je str_to_num


open_file:
	inc ebx
	cmp ebx, [rbp+8]
	jae exit_success
	xor r14d, r14d	; file number
	mov rdi, [rbp + 8 * rbx]
	mov eax, [rdi]
	cmp ax, '-'	; actually "-\0"
	je read_file
	xor esi, esi	; O_RDONLY
	syscall
	cmp eax, ERRNO_MIN
	jae error_exit
	mov r14d, eax
read_file:
	or r13b, r13b
	jz read_file_lines

read_file_chars:
	xor eax, eax	; SYS_OPEN
	mov edi, rsp
	mov rsi, FILE_READ_SIZE
	syscall
	cmp eax, ERRNO_MIN
	jae error_exit
	or eax, eax
	jz open_file
	cmp eax, r12d
	cmova eax, r12d
	sub r12d, eax
	mov edx, eax
	xor edi, edi
	inc edi		; STDOUT
	mov esi, rsp
	syscall
	cmp eax, ERRNO_MIN
	jae error_exit
	jmp read_file_chars


str_to_num:
	mov rsi, [rbp + 8*2]
	xor eax, eax	; may not be needed because rax probably equals zero at this point
	xor edx, edx
	xor ecx, ecx
	mov edi, 10	; IMUL and MUL require the 1-operand version have the operand in a register.
.loop:
	mov cl, [rsi]
	or cl, cl
	jz .check_result
	
	sub cl, '0'
	cmp cl, 9
	ja error_arg
	
	add eax, ecx
	jc .too_big
	or dl, dl
	jnz .too_big
	inc rsi
	jmp .loop
.too_big:
	xor eax, eax
	dec eax
.check_result:
	cmp rsi, [rbp+8*2]
	je error_arg
	mov r12d, eax
	mov bl, 2
	jmp read_file


error_arg:
	mov edi, -22	; Error: Bad argument
	jmp error_exit
exit_success:
	xor edi, edi
error_exit:
	neg edi
	xor eax, eax
	mov al, 60
	syscall
