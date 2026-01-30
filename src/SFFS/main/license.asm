check_license:
    mov si, license_id
    mov di, input_license_id
.check_loop:
    mov al, [si]
    mov bl, [di]
    cmp al, bl
    jne .init_crash
    test al, al
    jz .ok
    inc si
    inc di
    jmp .check_loop
.init_crash:
    mov cx, 5
.crash_loop:
    xor ax, ax
    div ax
    loop .crash_loop
    ret
.ok:
    mov si, license_ok_msg
    call print_string
    ret

license_id db '5156-ANBS-96', 0
input_license_id db '5156-ANBS-96', 0
license_ok_msg db 'License Verified: Public Access', 13, 10, 0