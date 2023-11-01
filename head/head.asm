%include "../linux_syscalls.inc"
global _start

section .text
_start:
	; argc = [rbp+8]
	; argv = rbp

	enter FILE_READ_SIZE, 0
	sub rbp, 16
	xor ebx, ebx
	mov r12d, 10	; line/char count
	mov r13b, 0	; line mode
	xor r14d, r14d	; default: stdin

	mov eax, [rbp-8]
	cmp eax, 2
	jbe open_file

	mov rsi, [rbp-8*1]	; 0 = file name
	mov eax, [rsi]
	and eax, 0x00111111
	cmp eax, "-n"
	sete r13b
	je str_to_num
	cmp eax, "-c"
	je str_to_num
	mov [rbp+16], r12d	; previous rbp before enter (0) is now line/char count

open_file:
	lea rsp, [rbp + FILE_READ_SIZE + 16]
	mov r12d, [rbp+16]
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
	xor eax, eax	; SYS_OPEN
	mov rdi, rsp
	mov esi, FILE_READ_SIZE
	syscall
	cmp eax, ERRNO_MIN
	jae error_exit

	or eax, eax
	jz open_file

	or r13b, r13b
	jz read_file_lines

read_file_lines:
	mov r15d, eax
.loop:
		; Set up REPNE SCASB
	cld
	mov ecx, r15d
	mov al, NEWLINE
	mov rdi, rsp
	repne scasb
	sub ecx, r15d
	neg ecx			; ecx = -(ecx-r15d) = r15d-ecx = number of bytes including newline
	push rcx
	push rcx
	mov edi, r14d
	lea rsi, [rsp+16]
	mov edx, ecx
	xor eax, eax
	inc eax			; SYS_WRITE
	syscall
	cmp eax, ERRNO_MIN
	jae error_exit
	
	sub r15d, eax
	or r15d, r15d
	jz open_file
	add rsp, [rsp]
	lea rsp, [rsp+16]
	jmp read_file





read_file_chars:
	cmp eax, r12d
	cmova eax, r12d
	sub r12d, eax
	mov edx, eax
	xor edi, edi
	inc edi		; STDOUT
	mov rsi, rsp
	syscall
	cmp eax, ERRNO_MIN
	jae error_exit
	jmp read_file


str_to_num:
	mov rsi, [rbp + 8*2]
	cmp dword [rbp], 3
	jb open_file
	xor edx, edx
	xor ecx, ecx
	mov edi, 10	; IMUL and MUL require the 1-operand version have the operand in a register.
.loop:
	mov cl, [rsi]
	or cl, cl
	jz .check_result
	
	sub cl, '0'
	cmp cl, 9
	ja open_file
	
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
	or eax, eax 
	jz open_file
	mov r12d, eax
	mov bl, 2
	jmp read_file


exit_success:
	xor edi, edi
error_exit:
	neg edi
	xor eax, eax
	mov al, 60
	syscall
