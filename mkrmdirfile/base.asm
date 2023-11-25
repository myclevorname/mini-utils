
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
	pop rcx			; argc
	pop rax			; keep 16-byte alignment
	mov rbp, rsp

	dec ecx
	jz __exit

	and eax, 0x00FFFFFF 	; ignore 4th byte
	cmp eax, "-f"
	sete bl
	dec ebx			; bitmask = 0 if "-f"

	mkdir_loop:
		cmp qword rbp, 0
		jz __exit

		mov rdi, [rbp]	; rbp is post-incremented
		%ifdef touch
		mov esi, 0q0666
		%elifdef mkdir
		mov esi, 0q0777
		%endif
		xor eax, eax
		mov al, SYS_WANTED
		syscall

		and eax, ebx
		jnz __check_error

		jmp short mkdir_loop
_end:
