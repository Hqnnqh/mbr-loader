;
; A simple boot sector program that prints a message to the screen using a BIOS routine.
;
bits 16 ; 16-bit real mode
[org 0x7c00] ; where BIOS should load bootloader code into memory

mov [BOOT_DRIVE], dl ; BIOS stores boot drive in dl => store it for later

; set up stack out of the way
mov bp, 0x9000
mov sp, bp

mov bx, MSG_REAL_MODE
call print_string

call switch

jmp $ ; loop forever

; include
%include "src/real_mode/print16.asm"
%include "src/real_mode/read_disk.asm"
%include "src/real_mode/switch.asm"

; data
BOOT_DRIVE: db 0

; fill up sector binary
times 510-($-$$) db 0 ; fill entire binary except for last 2 bytes with 0 (as padding)

dw 0xaa55 ; Last two bytes form the magic number, so BIOS knows to load this program as the boot sector.

; BIOS only loads first boot sector by default
times 256 dw 0xdada
times 256 dw 0xface
