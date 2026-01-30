console_init:
    mov si, welcome_msg
    call print_string
    ret

print_string:
    mov ah, 0x0e
.loop:
    lodsb
    test al, al
    jz .done
    int 0x10
    jmp .loop
.done:
    ret

read_line:
    mov di, cmd_buffer
    xor cx, cx
.loop:
    mov ah, 0x00
    int 0x16
    cmp al, 13
    je .done
    cmp al, 0x08
    je .backspace
    cmp cx, 63
    je .loop
    mov [di], al
    inc di
    inc cx
    mov ah, 0x0e
    int 0x10
    jmp .loop
.backspace:
    test cx, cx
    jz .loop
    dec di
    dec cx
    mov ah, 0x0e
    mov al, 0x08
    int 0x10
    mov al, ' '
    int 0x10
    mov al, 0x08
    int 0x10
    jmp .loop
.done:
    mov byte [di], 0
    mov ah, 0x0e
    mov al, 13
    int 0x10
    mov al, 10
    int 0x10
    ret

clear_screen:
    mov ah, 0x00
    mov al, 0x03
    int 0x10
    ret

play_beep:
    mov al, 0xb6
    out 0x43, al
    mov ax, 0x0480
    out 0x42, al
    mov al, ah
    out 0x42, al
    in al, 0x61
    or al, 0x03
    out 0x61, al
    mov cx, 0xffff
.delay:
    loop .delay
    in al, 0x61
    and al, 0xfc
    out 0x61, al
    ret

welcome_msg db 'Sysastro Loaded', 13, 10, 0