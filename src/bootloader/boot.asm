[org 0x7c00]

mov [BOOT_DISK], dl

mov bp, 0x7c00
mov sp, bp

call load_kernel

jmp 0x1000:0000

load_kernel:
    mov ah, 0x02
    mov al, 10
    mov ch, 0x00
    mov dh, 0x00
    mov cl, 0x02
    mov dl, [BOOT_DISK]
    mov bx, 0x1000
    mov es, bx
    mov bx, 0x0000
    int 0x13
    ret

BOOT_DISK db 0

times 510-($-$$) db 0
dw 0xaa55