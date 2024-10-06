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


print_hex:
    pusha
    mov cx, 4 ; handle 4 digit hex numbers
    mov si, HEX_OUT + 2 ; place string manipulation register at beginning of of the hex digits and after the 0x prefix

    mov dx, bx ; load value to print into dx

    transform_digit:
       rol dx, 4 ; rotate left by 4 bits; move next hex digit into lowest nibble
       mov al, dl ; copy lowest 8 bits out of al into dl
       and al, 0b00001111 ; only keep lowest 4 bits (current hex digit)

       cmp al, 10 ; check if digit is between 0-9
       jl digit_decimal
       ; digit is A - F
       add al, 'a' - 10 ; convert decimal 10 - 15 to A - F
       jmp store_digit

    digit_decimal:
        add al, '0' ; transform to proper ascii value

    store_digit:
        mov [si], al ; store converted hex in HEX_OUT
        inc si ; continue with next character in HEX_OUT
        loop transform_digit ; continue, until all digits have been processed

        ; print HEX_OUT
        mov bx, HEX_OUT
        call print_string

    jmp end_print

HEX_OUT:
db '0x0000', 0
