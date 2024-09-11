;
; A simple boot sector program that prints a message to the screen using a BIOS routine.
;
bits 16 ; 16-bit real mode
[org 0x7c00] ; where BIOS should load bootloader code into memory

mov bx, HELLO_MSG
call print_string

mov bx, 0x1fb6
call print_hex

jmp $ ; loop forever

; include
%include "src/print.asm"

; data
HELLO_MSG :
db 'Hello, World!', 0 ; zero makes the string null-terminated

; fill up sector binary
times 510-($-$$) db 0 ; fill entire binary except for last 2 bytes with 0 (as padding)

dw 0xaa55 ; Last two bytes form the magic number, so BIOS knows to load this program as the boot sector.
