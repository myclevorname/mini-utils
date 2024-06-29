bits 64
org 0x40000
file_start:
;--------ELF HEADER---------
db 0x7F, "ELF"		; magic
db 2			; 64-bit		; Not needed
db 1			; little endian		; Not needed
yes_letter:		; ELF v1
	db "y"
newline:		; Linux ABI
	db 10
__exit:
	xor eax, eax	; 2? OS ABI
__error_exit_jmp:	; padding
	mov edi, eax	; 2?
	xor eax, eax	; 2
	jmp short __exit_p2	; 2

;---------ELF HEADER PART 2------
dw 2			; executable file
dw 0x3E			; AMD64
__error_exit_generic:	; ELF v1, not needed
	mov al, -1
	jmp short __error_exit
dq _start		; entry point
dq prog_header-$$	; Program header table offset
__exit_p3:		; Section header table offset
	mov al, 60
	neg edi
__check_error:
	syscall
__check_error_after:	; Call this if you process something after the syscall, or jump to __error_exit_jmp
	test rax, rax	; AMD64 flags
	js __error_exit_jmp
	ret
__error_exit:		; ELF header size, not needed
	jmp short __error_exit_jmp
dw 0x38			; Program header entry size

dw 1			; 1 program header

;-------PROGRAM HEADER---------
prog_header:
	dd 1		; Loadable segment		; Size of section header, Number of section headers
%ifdef WRITE_EXEC
	dd 7		; RWX				; location of .shstrtab :(
%else
	dd 5		; RX
%endif
	dq 0		; offset in file
	dq $$		; location in memory
__exit_p2:		; Physical address, irrelevant
	and sp, -16	; 4
	jmp short __exit_p3		; 2

	dw 0
	dq _end-$$	; Size in file
%ifdef _bss_end
	dq _bss_end-$$	; Size in memory
%else
	dq _end-$$
%endif
; dw 0x10000		; Alignment, not needed
