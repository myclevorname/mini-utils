%include "../linux_syscalls.inc"

FILE_READ_SIZE equ 1024

global _start

section .text
	; int argc = dword ptr [rsp] = r12d
	; char *argv[] = rsp + 8 = r13
_start:
	mov r12d, [rsp]
	lea r13, [rsp + 8]
	xor ebx, ebx
	sub rsp, FILE_READ_SIZE
	mov rbp, rsp
	cmp r12d, 1
	je read_stdin

	open_file:
		inc rbx
		cmp rbx, r12
		jae end_loop
		mov r15, [r13 + 8 * rbx]	; rbx is pre-incremented
		mov ax, [r15]
		cmp ax, '-' + 0 * 256	; little endian so al stores first byte
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
			mov rsi, rbp
			mov rdx, FILE_READ_SIZE
			syscall
			cmp rax, ERRNO_MIN
			jae error
			cmp rax, 0
			je open_file
		write_stdout:
			mov rdx, rax
			mov rsi, rbp
			mov edi, stdout
			mov eax, edi	; SYS_WRITE = 1
			syscall
			cmp rax, ERRNO_MIN
			jae error
			jmp read_file
	end_loop:
		xor edi, edi
	error_exit:
		mov eax, SYS_EXIT
		syscall
error:
	movsx rdi, eax
	neg rdi
	jmp error_exit
read_stdin:
	xor r14d, r14d	; stdin = 0
	jmp read_file
