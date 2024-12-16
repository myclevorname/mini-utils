%include "../linux_syscalls.inc"
bits 64		; Required only because it is technically x86_64 with guaranteed 32-bit pointers


; Must be $20_XXXX
org $20_0000

db 0x7F, "ELF"

db 1		; x32 = 32-bit


clear_text:
	db 0x1B, "[H", 0x1B, "[2J", 0x1B, "[3J"
clear_end:


dw 2		; Executable
dw 0x3E		; x86_64/AMD64
; dd ?		; ELF v1. Why 32 bits?
_start:
	inc al
	jmp short _start_2

dd _start	; Entry
dd prog_start-$$; Program header table offset
; dd ?		; Section header table offset
; dd ?		; Flags
; dw ?		; ELF header size
; dw 0x20	; Program header table entry size
;dw 1		; 1 memory segment		; Overlap with below
;dw ?		; Section header entry size
;dw 0		; No sections
;dw ?		; No section header strings

prog_start:
dd 1		; Loadable
dd 0		; Offset in file
dd $$		; Offset in memory
dd 1		; Physical address
dd (_end-$$ + 65535) & -65536	; Size in file
dd (_end-$$ + 65535) & -65536	; Size in memory, safe
;db 5		; Flags

;dd 0		; Alignment = none

_start_2:
;	inc al		; SYS_WRITE = 1
	inc edi
	mov esi, clear_text
	mov dl, clear_end - clear_text
	syscall

	xor eax, eax
	xor edi, edi
	mov al, 60
	syscall


_end:

