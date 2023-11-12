%define WRITE_EXEC
%include "../linux_syscalls.inc"
%include "../elf-header.inc"
%define FILE_BUFFER_SIZE 0x70
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
	lea rbp, [elf_copy]
	mov rsi, rbp
	mov edx, FILE_BUFFER_SIZE
	xor eax, eax
	mov al, SYS_READ
	syscall
	cmp eax, ERRNO_MIN
	jae error_exit	; I don't care enough right now to make it read for more ~~because I am lazy~~ for size purposes
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
	lea rsi, [zero]
	xor edx, edx
	mov dl, 2
	xor eax, eax
	mov al, SYS_WRITE
	syscall		; finally say there are 0 section headers
	cmp eax, ERRNO_MIN
	jae error_exit

	xor eax, eax
	mov al, SYS_FTRUNCATE
	mov edi, ebx
	mov esi, [rbp + 0x60]	; why 0x60? idk, but it works
;	inc esi			; offset 0x60 actually points to the *last* byte
				; oh wait, it actually doesn't
	syscall
exit:
	xor eax, eax
error_exit:
	mov edi, eax
	neg edi
	xor eax, eax
	mov al, SYS_EXIT
	syscall
_end:
elf_copy:

zero equ elf_copy+FILE_BUFFER_SIZE
_bss_end equ zero+2
