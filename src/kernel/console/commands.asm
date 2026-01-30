interpret_command:
    mov si, cmd_buffer
    mov di, cmd_help
    call strcmp
    jc .help
    
    mov si, cmd_buffer
    mov di, cmd_ver
    call strcmp
    jc .version

    mov si, cmd_buffer
    mov di, cmd_cls
    call strcmp
    jc .cls

    mov si, cmd_buffer
    mov di, cmd_ff
    call strcmp
    jc .fastfetch
    
    mov si, unknown_cmd
    call print_string
    ret

.help:
    mov si, help_text
    call print_string
    ret

.version:
    mov si, SYS_NAME
    call print_string
    mov si, space_char
    call print_string
    mov si, SYS_VER
    call print_string
    mov si, newline
    call print_string
    ret

.cls:
    call clear_screen
    ret

.fastfetch:
    mov si, ff_art
    call print_string
    ret

strcmp:
.loop:
    mov al, [si]
    mov bl, [di]
    cmp al, bl
    jne .not_equal
    test al, al
    jz .equal
    inc si
    inc di
    jmp .loop
.not_equal:
    clc
    ret
.equal:
    stc
    ret

cmd_help    db 'help', 0
cmd_ver     db 'ver', 0
cmd_cls     db 'cls', 0
cmd_ff      db 'fastfetch', 0
help_text   db 'Available: help, ver, cls, fastfetch', 13, 10, 0
unknown_cmd db 'Unknown command', 13, 10, 0
space_char  db ' ', 0
newline     db 13, 10, 0

ff_art:
    db '    +-----------+', 13, 10
    db '    |           |       OS: Sysastro v0.1', 13, 10
    db '    |   ____    |       Kernel: 16 Bit Real mode', 13, 10
    db '    |  / ___|   |       Created by: Adam', 13, 10
    db '    |  \___ \   |       License for: public-access', 13, 10
    db '    |   ___) |  |       Version: 0.1', 13, 10
    db '    |  |____/   |       Kernel-info: Beta-sysastro_kernel build 15', 13, 10
    db '    |           |', 13, 10
    db '    +-----------+', 13, 10, 0