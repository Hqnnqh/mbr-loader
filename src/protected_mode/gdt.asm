; GDT for the switch to 32-bit protected mode

gdt_start:

gdt_null: ; null descriptor
    dd 0x0 ; dd = define double word (4bytes)
    dd 0x0

gdt_code: ; code descriptor
    ; base = 0x0, limit = 0xfffff
    ; access byte = PRESENT 1, PRIVILEGE 00, CODE 1, EXECUTABLE 1, CONFORMING 0, READABLE 1, ACCESSED 0 => 10011010b
    ; descriptor flags = GRANULARITY 1, 32-BIT 1, 64-BIT 0, AVL 0 => 1100b
    dw 0xffff ; limit (bits 0 - 15)
    dw 0x0 ; base (bits 0 - 15)
    db 0x0 ; base (bits 16 - 23)
    db 10011010b ; access byte
    db 11001111b ; descriptor flags + limit (bits 16 - 19)
    db 0x0 ; base (bits 24 - 31)

gdt_data: ; data descriptor
    ; base = 0x0, limit = 0xfffff
    ; access byte = PRESENT 1, PRIVILEGE 00, CODE 1, EXECUTABLE 0, CONFORMING 0, READABLE 1, ACCESSED 0 => 10011010b
    ; descriptor flags = GRANULARITY 1, 32-BIT 1, 64-BIT 0, AVL 0 => 1100b
    dw 0xffff ; limit (bits 0 - 15)
    dw 0x0 ; base (bits 0 - 15)
    db 0x0 ; base (bits 16 - 23)
    db 10010010b ; access byte
    db 11001111b ; descriptor flags + limit (bits 16 - 19)
    db 0x0 ; base (bits 24 - 31)

gdt_end: ; used to calculate gdt size more easily

gdt_descriptor:
    dw gdt_end - gdt_start - 1 ; gdt size - 1
    dd gdt_start ; start address of gdt

; define some handy constants
CODE_SEG equ gdt_code - gdt_start ; 0x08
DATA_SEG equ gdt_data - gdt_start ; 0x10
