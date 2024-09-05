;
; A simple boot sector program that loops forever.
;
bits 16 ; 16-bit real mode
loop:
    jmp loop ; loop forever

times 510-($-$$) db 0 ; fill entire binary except for last 2 bytes with 0 (as padding)

dw 0xaa55 ; Last two bytes form the magic number, so BIOS knows to load this program as the boot sector.
