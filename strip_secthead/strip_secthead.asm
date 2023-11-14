%define WRITE_EXEC
%include "../linux_syscalls.inc"
%include "../elf-header.inc"
%define FILE_BUFFER_SIZE 0x70

_start:
	pop rax		; argc, might as well put it here because ~~it is available~~ I only need it once
	mov rdi, [rsp + 8]	; argv[0]
	mov sp, ERRNO_MIN
	sub eax, byte 2
	jne short __error_exit

;	mov rdi, rbp
;	xor esi, esi	; every register except rsp basically guaranteed to be zero; uncomment if this is a problem
	mov si, O_RDWR
	syscall
	cmp ax, sp
	jae short __error_exit

	mov ebx, eax	; fd
	mov edi, ebx
	lea ebp, [elf_copy]
	mov esi, ebp
	xor edx, edx
	mov dl, FILE_BUFFER_SIZE
	xor eax, eax
	mov al, SYS_READ
	syscall
	cmp ax, sp
	jae short __error_exit	; I don't care enough right now to make it read for more ~~because I am lazy~~ for size purposes
	mov ax, [rbp + 0x38]
	and ax, ax
	je short __exit

remove_section_headers:
	; first doing lseek and write

	mov edi, ebx
	xor esi, esi
	add esi, byte 0x3C
	xor edx, edx
	mov dl, SEEK_SET
	xor eax, eax
	mov al, SYS_LSEEK
	syscall

	cmp ax, sp
	jae short __error_exit

	mov edi, ebx
	lea esi, [zero]
	xor edx, edx
	mov dl, 2
	xor eax, eax
	mov al, SYS_WRITE
	syscall		; finally say there are 0 section headers
	cmp ax, sp
	jae short __error_exit

	xor eax, eax
	mov al, SYS_FTRUNCATE
	mov edi, ebx
	mov esi, [rbp + 0x60]	; why 0x60? idk, but it works
;	inc esi			; offset 0x60 actually points to the *last* byte
				; oh wait, it actually doesn't
	syscall
_end:
elf_copy:

zero equ elf_copy+FILE_BUFFER_SIZE
_bss_end equ zero+2
