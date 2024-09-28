[bits 32]

;
; Functions that can be used to print null-terminated strings to the screen using the VGA buffer.
;

; define constants
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

; prints a null-terminated string pointed to by EDX
print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY

print_string_pm_loop:
    mov al, [ebx] ; store char at EBX in al
    mov ah, WHITE_ON_BLACK ; store attributes for char in ah

    cmp al, 0 ; exit at end of string
    je print_string_pm_done

    mov [edx], ax ; store the char and attributes at the current character cell

    add ebx, 1 ; move to next char
    add edx, 2 ; move to next cell in video memory

    jmp print_string_pm_loop

print_string_pm_done:
    popa
    ret
