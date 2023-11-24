%define WRITE_EXEC
%include "../linux_syscalls.inc"
%include "../elf-header.inc"

%define FILE_READ_SIZE 4096

_start:
	pop rbx			; argc, only needed once
	mov rbp, rsp		; pointer to current arg, and it is pre-incremented
	push rbx		; Keep that 16-byte alignment
	dec ebx
	jz short read_file
open_file:
	add rbp, byte 8
	mov rdi, [rbp]
	and rdi, rdi
	jz short __exit
	xor ebx, ebx	; fd
	cmp word [rdi], "-"
	je short read_file

	xor eax, eax
	mov al, SYS_OPEN
	xor esi, esi	; O_RDONLY = 0
	syscall

;	cmp ah, -16
;	jae __error_exit
	call __check_error
	
	mov ebx, eax
read_file:
	xor edx, edx
	mov dh, FILE_READ_SIZE >> 8
	lea esi, [file_buffer]
	mov edi, ebx
	xor eax, eax	; SYS_READ = 0
	syscall

;	cmp ah, -16
;	jae __error_exit
	call __check_error

	and eax, eax
	jnz short write_stdout
close_file:
	cmp ebx, byte 2
	jbe open_file
	mov edi, ebx
	xor eax, eax
	mov al, 3
	syscall
	jmp short open_file

write_stdout:
	mov edx, eax
	mov esi, file_buffer
	xor edi, edi
	inc edi		; stdout = 1
	mov eax, edi	; SYS_WRITE = 1
	syscall

;	cmp ah, -16
;	jae __error_exit
	call __check_error

	jmp short read_file
_end:
file_buffer:
_bss_end equ file_buffer + FILE_READ_SIZE
