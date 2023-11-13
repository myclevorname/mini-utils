%define WRITE_EXEC
%include "../linux_syscalls.inc"
%include "../elf-header.inc"

%define FILE_READ_SIZE 4096

_start:
	pop rbx		; argc, only needed once
	mov rbp, rsp	; pointer to current arg, and it is pre-incremented
	mov sp, ERRNO_MIN	; try to avoid using r8-r15 while not using an immediate ERRNO_MIN
	dec ebx
	jz read_file
open_file:
	add rbp, byte 8
	mov rdi, [rbp]
	or rdi, rdi
	jz exit
	xor ebx, ebx	; fd
	cmp word [rdi], "-"
	je read_file

	xor eax, eax
	mov al, SYS_OPEN
	xor esi, esi	; O_RDONLY = 0
	syscall

	cmp ax, sp
	jae error_exit
	
	mov ebx, eax
read_file:
	xor edx, edx
	mov dh, FILE_READ_SIZE >> 8
	lea esi, [file_buffer]
	mov edi, ebx
	xor eax, eax	; SYS_READ = 0
	syscall

	cmp ax, sp
	jae error_exit

	and eax, eax
	jz open_file
write_stdout:
	mov edx, eax
	mov esi, file_buffer
	xor edi, edi
	inc edi		; stdout = 1
	mov eax, edi	; SYS_WRITE = 1
	syscall

	cmp ax, sp
	jae error_exit

	jmp read_file
exit:
	xor eax, eax
error_exit:
	mov edi, eax
	neg edi		; if no error, edi=0
	xor eax, eax
	mov al, 60
	syscall
_end:
file_buffer:
_bss_end equ file_buffer + FILE_READ_SIZE
