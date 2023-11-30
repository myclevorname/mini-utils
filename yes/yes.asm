%define WRITE_EXEC
%include "../linux_syscalls.inc"
%include "../elf-header.inc"

_start:
	pop rdx			; argc, only needed once
	mov ebp, newline	; use for part 2
	pop rbx			; Keep that 16-byte alignment

	mov ebx, yes

	inc r12d		; strlen(yes)
	inc r13d		; strlen(newline)
	cmp edx, byte 2
	jb short print
strlen:
	cld
	mov rbx, [rsp]
	mov rdi, rbx
;	xor eax, eax
;	xor ecx, ecx
	dec ecx
	repne scasb		; ecx = -(strlen+1)-1=-strlen-2
				; strlen = -(ecx+1)-1=-ecx-2
				; not ecx = -1 - ecx
;	neg ecx
;	dec ecx
	not ecx
	dec ecx
	mov r12d, ecx

print:
	xor eax, eax		; SYS_WRITE = 1
	inc eax
	mov edi, eax		; stdout=1
	mov rsi, rbx
	mov edx, r12d
	call __check_error
	xchg rbx, rbp
	xchg r12d, r13d
	jmp short print
_end:
