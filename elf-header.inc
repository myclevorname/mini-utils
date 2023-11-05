bits 64
org 0x40000
file_start:
;--------ELF HEADER---------
db 0x7F, "ELF"		; magic
db 2			; 64-bit
db 1			; little endian
db 1			; ELF v1
db 3			; Linux ABI
db 0			; OS ABI
times 7 db 0		; padding

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
	dq 0		; Physical address, irrelevant
	dq _end-_start	; Size in file
%ifdef _bss_end
	dq _bss_end-_start		; Size in memory
%else
	dq _end-_start
%endif
	dq 0x1000	; Alignment
