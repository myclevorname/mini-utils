%define WRITE_EXEC		; Uncomment if you use a data section or bss section
%include "../linux_syscalls.inc"
%include "../elf-header.inc"


_start:
	; Code goes here
	mov rax, SYS_WRITE
	mov rdi, stdout
	mov rsi, hello
	mov rdx, hello_end - hello
	syscall

	mov rax, SYS_EXIT
	mov rdi, 0
	syscall

	; Read-only data also goes here.
hello:
	db "Hello, World!", NEWLINE
hello_end:

	; Writable data goes here if you uncomment the top line.
_end:
section .bss
	; bss goes here
var_1:
	resb 1
var_2 equ var_1 + 1
	resb 2
_bss_end:
