%include "../linux_syscalls.inc"
%include "../elf-header.inc"

_start:
	inc al
	jmp short __error_exit

_end:

