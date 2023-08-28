%include "../linux_syscalls.inc"
global _start

%define BUFFER_SIZE 256

section .text
_start:
	; argc = [rbp+BUFFER_SIZE]
	; argv = rbp+8

	enter BUFFER_SIZE

	xor ebx, ebx
open_file:
	inc ebx
	cmp ebx, [rbp]
	jae exit_success

