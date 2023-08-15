%include "linux_syscalls.inc"

FILE_READ_SIZE equ 1024

global _start

section .bss

read_buffer resb FILE_READ_SIZE

section .text
	; int argc = dword ptr [rsp] = r12d
	; char *argv[] = rsp + 8 = r13
_start:
	mov r12d, [rsp]
	lea r13, [rsp + 8]
	xor ebx, ebx
	cmp r12d, 1
	je read_stdin

	open_file:
		inc rbx
		cmp rbx, r12
		jae end_loop
		mov r15, [rsp + 8 * rbx + 8]	; rbx is pre-incremented
						; r13 already equals rsp + 8
		mov ax, [r15]
		cmp ax, '-' + 0 * 256	; little endian so r15l stores first byte
		je read_stdin
		mov eax, SYS_OPEN
		mov rsi, r13
		mov rdi, r15
		xor esi, esi	; O_RDONLY = 0
		syscall
		cmp eax, ERRNO_MIN
		jae error
		mov r14d, eax
		
		read_file:
			xor eax, eax	; SYS_READ = 0
			mov edi, r14d
			mov rsi, read_buffer
			mov rdx, FILE_READ_SIZE
			syscall
			cmp rax, -4096
			jae error
			cmp rax, 0
			je open_file
		write_stdout:
			mov rdx, rax
			mov rsi, read_buffer
			mov edi, stdout
			mov eax, 1
			syscall
			cmp rax, -4096
			jae error
			jmp read_file
	end_loop:
		xor edi, edi
	error_exit:
		mov eax, SYS_EXIT
		syscall
error:
	movsx rdi, eax
	jmp error_exit
read_stdin:
	xor r14d, r14d	; stdin = 0
	jmp read_file
