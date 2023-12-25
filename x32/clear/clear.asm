%include "../linux_syscalls.inc"
%include "../elf-header.inc"

_start:
	inc al		; SYS_WRITE = 1
	inc edi
	mov esi, clear_text
	mov dl, clear_end - clear_text
	syscall

	jmp __exit

clear_text:
	db 0x1B, "[H", 0x1B, "[2J", 0x1B, "[3J"
clear_end:

_end:

