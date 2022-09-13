section .data
   inp      db      "Nhap_vao: ", 0h
   outp     db      "In_ra: ", 0h
section .bss
    input resb 30

section .text
global _start

_start:
    mov     ecx, inp
    mov     ebx, 1
    mov     eax, 4
    mov     edx, 11
    int     80h

    mov     ecx, input
    mov     edx, 30
    mov     ebx, 0
    mov     eax, 3
    int     80h

    mov     ecx, outp
    mov     ebx, 1
    mov     eax, 4
    mov     edx, 8
    int     80h

    mov     edx, 100
    mov     ecx, input
    mov     ebx, 1
    mov     eax, 4
    int     80h

    mov     ebx, 0
    mov     eax, 1
    int     80h

