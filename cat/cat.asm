%include "../linux_syscalls.inc"
%include "../elf-header.inc"

	; char *argv[] = rbp = r13
_start:
	lea r13, [rsp + 8]
	xor ebx, ebx
	enter FILE_READ_SIZE, 0
	add rbp, 16	; Skip the original rbp and argc
	xor r14d, r14d
	cmp dword [rbp], 1
	je read_file

	open_file:
		inc ebx
		cmp ebx, [rbp-8]
		jae end_loop
		mov r15, [rbp + 8 * rbx]	; rbx is pre-incremented
		xor r14d, r14d
		cmp word [r15], '-' + 0 * 256	; little endian so al stores first byte
		je read_file
		mov eax, SYS_OPEN
		mov rdi, r15
		xor esi, esi	; O_RDONLY = 0
		syscall
		cmp eax, ERRNO_MIN
		jae error
		mov r14d, eax
		
		read_file:
			xor eax, eax	; SYS_READ = 0
			mov edi, r14d
			mov rsi, rsp
			mov edx, FILE_READ_SIZE
			syscall
			cmp eax, ERRNO_MIN
			jae error
			or eax, eax
			jz open_file
		write_stdout:
			mov edx, eax
			mov rsi, rsp
			xor eax, eax
			inc al
			mov edi, eax	; SYS_WRITE = 1
			syscall
			cmp eax, ERRNO_MIN
			jae error
			jmp read_file
end_loop:
	xor edi, edi
error:
	neg edi	; if no error, edi=0
error_exit:
	xor eax, eax
	mov al, SYS_EXIT
	syscall
_end:
