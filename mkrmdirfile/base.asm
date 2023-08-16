%include "../linux_syscalls.inc"
global _start

section .text
_start:
	mov rbx, [rsp]	; argc
	cmp rbx, 1
	je exit
	xor rbp, rbp	; preserved version of rcx

	mkdir_loop:
		inc rbp
		cmp rbp, rbx
		jae exit

		mov rdi, [rsp + 8 + 8 * rbp]	; rbp is post-incremented
		%if SYS_WANTED = SYS_CREAT
		mov esi, 0q0666
		%elif SYS_WANTED = SYS_MKDIR
		mov esi, 0q0777
		%endif
		xor eax, eax
		mov al, SYS_WANTED
		syscall

		cmp eax, ERRNO_MIN
		jae error

		jmp mkdir_loop

error:
	movsx rdi, eax
	neg rdi
	jmp error_exit

exit:
	xor rdi, rdi
error_exit:
	xor eax, eax
	mov al, 60
	syscall
