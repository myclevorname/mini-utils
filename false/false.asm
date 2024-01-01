%include "../linux_syscalls.inc"
%include "../elf-header.inc"


_start:
	dec eax
	jmp short __error_exit
	dd 0			; I get an error without these 8 bytes. It looks like it is due to the alignment field in the ELF header.
_end:
