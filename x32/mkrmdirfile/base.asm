
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
	mov ebp, esp		; Shortcut to first argument
	push rcx		; keep 16-byte alignment

	dec ecx
	jz __exit

	mkdir_loop:
		mov edi, [ebp]
		and edi, edi
		jz __exit

		%ifdef touch
		mov esi, 0q0666
		%elifdef mkdir
		mov esi, 0q0777
		%endif
		xor eax, eax
		mov al, SYS_WANTED

		call __check_error
		add ebp, byte 4
		jmp short mkdir_loop
_end:
