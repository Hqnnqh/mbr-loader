;
; Routine that reads the first n sectors following the boot sector from a specified disk device
;

; load dh sectors to es:bx from drive dl
disk_load:
    push dx ; store dx on the stack to later recall the number of sectores requested

    mov ah, 0x02 ; BIOS read section routine
    mov al, dh ; read dh sectors
    ; use Cylinder-Head-Sector addressing to select the parts of disk to load
    mov ch, 0x00 ; select cylinder 0
    mov dh, 0x00 ; select head 0
    mov cl, 0x02 ; start reading from second sector (right after boot sector)

    int 0x13 ; call BIOS interrupt. carry flag is set in case of an error

    jc disk_error

    pop dx ; restore dx from stack
    cmp dh, al ; if al (sectors read) != dh (sectors expected)
    jne disk_error

    ret

disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string
    jmp $

; variables
DISK_ERROR_MSG  db "Disk read error!", 0
