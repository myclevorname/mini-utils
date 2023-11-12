
%include "../linux_syscalls.inc"
%include "../elf-header.inc"

; defines:
; touch, rm, rmdir, mkdir

%ifdef touch
%define SYS_WANTED SYS_CREAT
%endif
%ifdef rm
%define SYS_WANTED SYS_UNLINK
%endif
%ifdef rmdir
%define SYS_WANTED SYS_RMDIR
%endif
%ifdef mkdir
%define SYS_WANTED SYS_MKDIR
%endif


_start:
	mov rbx, [rsp]	; argc
	cmp rbx, 1
	je exit
	xor ebp, ebp	; preserved counter
	xor r12d, r12d
	mov eax, [rsp + 8*2]
	and eax, 0x00FFFFFF 	; ignore 4th byte
	cmp eax, "-f"
	sete r12b
	dec r12d	; bitmask = 0 if "-f"

	mkdir_loop:
		inc ebp
		cmp ebp, ebx
		jae exit

		mov rdi, [rsp + 8 + 8 * rbp]	; rbp is post-incremented
		%ifdef touch
		mov esi, 0q0666
		%elifdef mkdir
		mov esi, 0q0777
		%endif
		xor eax, eax
		mov al, SYS_WANTED
		syscall

		and eax, r12d
		cmp eax, ERRNO_MIN
		jae error_exit

		jmp mkdir_loop
exit:
	xor eax, eax
error_exit:
	mov edi, eax
	neg edi
	xor eax, eax
	mov al, 60
	syscall
_end:
