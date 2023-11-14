bits 64
org 0x40000
file_start:
;--------ELF HEADER---------
db 0x7F, "ELF"		; magic
db 2			; 64-bit
db 1			; little endian
db 1			; ELF v1
db 3			; Linux ABI

__exit_jmp:
	xor eax, eax	; 2? OS ABI
__error_exit_jmp:	; padding
	mov edi, eax	; 2?
	xor eax, eax	; 2?
	jmp short __exit_p2	; 2?

;---------ELF HEADER PART 2------
dw 2			; executable file
dw 0x3E			; AMD64
dd 1			; ELF v1
dq _start		; entry point
dq prog_header-$$	; Program header table offset
dq 0			; Section header table offset
dd 0			; AMD64 flags
dw 64			; ELF header size
dw 0x38			; Program header entry size
dw 1			; 1 program header
dw 0			; Size of section header
dw 0			; Number of section headers
dw 0			; location of .shstrtab :(

;-------PROGRAM HEADER---------
prog_header:
	dd 1		; Loadable segment
%ifdef WRITE_EXEC
	dd 7		; RWX
%else
	dd 5		; RX
%endif
	dq _start-$$	; offset in file
	dq _start	; location in memory
__exit_p2:		; Physical address, irrelevant
	mov al, 60	; 2?
	syscall		; 2?

	dd 0
	dq _end-_start	; Size in file
%ifdef _bss_end
	dq _bss_end-_start		; Size in memory
%else
	dq _end-_start
%endif
	dd 0	; Alignment, not needed
__exit:
	jmp short __exit_jmp
__error_exit:
	jmp short __error_exit_jmp
