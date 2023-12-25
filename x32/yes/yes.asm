%include "../linux_syscalls.inc"
%include "../elf-header.inc"

_start:
	pop rdx			; argc, only needed once
	push rdx		; Keep that 16-byte alignment

	mov ebp, yes_letter

	mov bl, 2		; strlen(yes)
	cmp edx, byte 2
	jb short print
strlen:
	cld
	mov ebp, [esp]
	mov edi, ebp
;	xor eax, eax
;	xor ecx, ecx
	dec ecx
	repne scasb		; ecx = -(strlen)-1=-strlen-1
				; strlen = -(ecx+1)=-ecx-1
				; not ecx = -1 - ecx
;	neg ecx
;	dec ecx
	not ecx
	mov byte [edi-1], 10
	mov ebx, ecx

print:
	xor eax, eax		; SYS_WRITE = 1
	inc eax
	mov edi, eax		; stdout=1
	mov esi, ebp
	mov edx, ebx
	call __check_error
	jmp short print
yes_letter:
	db "y", 10
_end:
