;
; Functions that can be used to print null-terminated strings to the screen using BIOS services.
;
bits 16

print_string:
    pusha
    mov si, bx

print_loop:
    lodsb           ; load the byte at ds:si into al and increment si

    cmp al, 0       ; end at null termination
    je end_print    ; exit loop if end is reached

    mov ah, 0x0e    ; int 10/ah is the scrolling teletype BIOS routine
    int 0x10

    jmp print_loop

end_print:
    popa
    ret
