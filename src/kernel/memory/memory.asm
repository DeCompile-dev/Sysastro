get_memory_size:
    clc
    int 0x12
    mov [mem_size_kb], ax
    ret

print_memory_info:
    call get_memory_size
    mov ax, [mem_size_kb]
    call print_int
    mov si, kb_suffix
    call print_string
    ret

print_int:
    mov bx, 10
    mov cx, 0
.push_digits:
    xor dx, dx
    div bx
    push dx
    inc cx
    test ax, ax
    jnz .push_digits
.pop_digits:
    pop dx
    add dl, '0'
    mov al, dl
    mov ah, 0x0e
    int 0x10
    loop .pop_digits
    ret

mem_size_kb dw 0
kb_suffix db ' KB Low Memory Available', 13, 10, 0