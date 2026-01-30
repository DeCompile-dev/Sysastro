sffs_init:
    mov si, sffs_msg
    call print_string
    call check_license
    call sffs_list_files
    ret

sffs_list_files:
    mov si, sffs_list_header
    call print_string
    mov si, sffs_file_1
    call print_string
    ret

sffs_msg db 'Initializing SFFS...', 13, 10, 0
sffs_list_header db 'SFFS Root Directory:', 13, 10, 0
sffs_file_1 db '  - kernel.bin [System File]', 13, 10, 0