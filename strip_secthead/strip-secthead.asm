%include "../linux_syscalls.inc"
global _start
section .bss
%define FILE_BUFFER_SIZE 0x80
file_buffer:	resb FILE_BUFFER_SIZE	; just enough for e_phnum and e_phoff and other stuff and things
zero:		resw 1

section .text

_start:
	pop rax		; argc, might as well put it here because ~~it is available~~ I only need it once
	pop rbx		; argv[0], not needed, but 16-byte alignment required by the ABI(TM)
	cmp eax, 2
	jne error_exit

	mov rdi, [rsp]
;	xor esi, esi	; every register except rsp basically guaranteed to be zero; uncomment if this is a problem
	mov si, O_RDWR
	syscall
	cmp eax, ERRNO_MIN
	jae error_exit

	mov ebx, eax	; fd
	mov edi, ebx
	mov esi, file_buffer
	mov edx, FILE_BUFFER_SIZE
	xor eax, eax
	mov eax, SYS_READ
	syscall
	cmp eax, ERRNO_MIN
	jae error_exit	; I don't care enough right now to make it read for more ~~because I am lazy~~ for size purposes
	mov rbp, file_buffer
	mov ax, [rbp + 0x38]
	and ax, ax
	je exit

remove_section_headers:
	; first doing lseek and write

	mov edi, ebx
	mov esi, 0x3C
	xor edx, edx
	mov dl, SEEK_SET
	xor eax, eax
	mov al, SYS_LSEEK
	syscall

	cmp eax, ERRNO_MIN
	jae error_exit

	mov edi, ebx
	mov rsi, zero
	xor edx, edx
	mov dl, 2
	mov eax, SYS_WRITE
	syscall		; finally say there are 0 section headers
	cmp eax, ERRNO_MIN
	jae error_exit

	xor eax, eax
	mov al, SYS_FTRUNCATE
	mov edi, ebx
	mov esi, [rbp + 0x60]	; why 0x60? idk, but it works
	inc esi			; offset 0x60 actually points to the *last* byte
	syscall
exit:
	xor edi, edi
error_exit:
	neg edi
	xor eax, eax
	mov al, SYS_EXIT
	syscall
