;
; A simple boot sector program that prints a message to the screen using a BIOS routine.
;
bits 16 ; 16-bit real mode

; put BIOS routine identifier in high half of ax and character to print in low half.

mov ah, 0x0e ; int 10/ah is the scrolling teletype BIOS routine

mov al, 'H'
int 0x10 ; call interrupt for BIOS routines

mov al, 'e'
int 0x10

mov al, 'l'
int 0x10

mov al, 'l'
int 0x10

mov al, 'o'
int 0x10

jmp $ ; loop forever

times 510-($-$$) db 0 ; fill entire binary except for last 2 bytes with 0 (as padding)

dw 0xaa55 ; Last two bytes form the magic number, so BIOS knows to load this program as the boot sector.
