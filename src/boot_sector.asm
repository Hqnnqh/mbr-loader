;
; A simple boot sector program that prints a message to the screen using a BIOS routine.
;
bits 16 ; 16-bit real mode
[org 0x7c00] ; where BIOS should load bootloader code into memory

mov [BOOT_DRIVE], dl ; BIOS stores boot drive in dl => store it for later

; set up stack out of the way
mov bp, 0x8000
mov sp, bp

; load 5 sectors to 0x0000(ES):0x9000(BX) from the boot disk
mov ax, 0x0000
mov es, ax
mov bx, 0x9000
mov dh, 5

mov dl, [BOOT_DRIVE]
call disk_load

mov bx, [0x9000]       ; print the first word after boot sector
call print_hex

mov bx, [0x9000 + 512]   ; print the second loaded word after the boot sector
call print_hex

jmp $ ; loop forever

; include
%include "src/print.asm"
%include "src/read_disk.asm"

; data
BOOT_DRIVE: db 0

; fill up sector binary
times 510-($-$$) db 0 ; fill entire binary except for last 2 bytes with 0 (as padding)

dw 0xaa55 ; Last two bytes form the magic number, so BIOS knows to load this program as the boot sector.

; BIOS only loads first boot sector by default
times 256 dw 0xdada
times 256 dw 0xface
