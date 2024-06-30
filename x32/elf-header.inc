bits 64		; Required only because it is technically x86_64 with guaranteed 32-bit pointers


; Must be $20_XXXX
org $20_0000

db 0x7F, "ELF"

db 1		; x32 = 32-bit
db 1		; Little endian
db 1		; ELF v1
db 3		; Linux

__check_error:
	syscall	; Stable ABI, not needed
		; Padding
__check_error_after:
	cmp ah, -16
	jae __error_exit
	ret

dw 2		; Executable
dw 0x3E		; x86_64/AMD64
; dd ?		; ELF v1. Why 32 bits?
__error_exit_generic:
	mov al, -1
	jmp short __error_exit

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

%ifndef WRITE_EXEC
dd (_end-$$ + 65535) & -65536	; Size in memory, safe
db 5		; Flags
%else
dd (_bss_end-$$ + 65535) & -65536
db 7		; RWX
%endif

;dd 0		; Alignment = none

__exit:
	xor eax, eax
__error_exit:
	mov edi, eax	; Low 8 bytes are used
	xor eax, eax
	mov al, 60
	neg edi
	btr esp, 3	; 16-byte alignment when calling from __check_error
	syscall
