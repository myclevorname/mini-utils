%include "../linux_syscalls.inc"
%include "../elf-header.inc"


_start equ __exit
	dq 0		; I get an error without these 8 bytes. It looks like it is due to the alignment field in the ELF header.
_end:
