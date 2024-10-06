;
; Routine used to switch from real mode to protected mode.
;

switch:
    cli ; disable interrupts using cli
    lgdt [gdt_descriptor] ; load gdt
    ; enable protected mode
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax
    ; force CPU to  flush the pipeline (i.e. complete all of instructions currently in different stages of the pipeline)
    jmp CODE_SEG:init_protected_mode ; cs is automatically updated

[bits 32]
init_protected_mode:
; set all segment registers to the appropriate 32-bit ones.
mov ax, DATA_SEG
mov ds, ax,
mov ss, ax
mov es, ax
mov fs, ax
mov gs, ax

; update stack pointer
mov ebp, 0x90000 ; top of stack to free space
mov esp, ebp

begin_protected_mode:
    mov ebx, MSG_PROT_MODE
    call print_string_pm

    jmp $

; global variables
MSG_REAL_MODE db " Started in 16 - bit Real Mode ", 0
MSG_PROT_MODE db " Successfully landed in 32 - bit Protected Mode ", 0



%include "src/protected_mode/gdt.asm"
%include "src/protected_mode/print32.asm"
