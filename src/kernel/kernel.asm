[org 0x0000]

mov ax, 0x1000
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0xFFFE

jmp start

%include "src/data.asm"
%include "src/SFFS/impl.asm"

start:
    call play_beep
    call sffs_init
    call console_init
    call print_memory_info

shell_loop:
    mov si, PROMPT
    call print_string
    call read_line
    call interpret_command
    jmp shell_loop

%include "src/kernel/console/console.asm"
%include "src/kernel/console/commands.asm"
%include "src/kernel/memory/memory.asm"
%include "src/kernel/console/data/blank.asm"