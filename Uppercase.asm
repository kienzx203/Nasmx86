section .data

section .bss
    input resb 30

section .text
    global _start

_start:
        mov     ecx, input
        mov     edx, 30
        mov     ebx, 0
        mov     eax, 3
        int     80h

        push    input
        call    Uppercase

        mov     ebx, 0
        mov     eax, 1
        int     80h

Uppercase:

        push	ebp
	    mov	    ebp,esp
	    mov	    esi,[ebp+8]

    L1:

	    cmp	    BYTE [esi], 0Ah		
	    jz 	    inp
	    cmp	    BYTE [esi], 'a'		
	    jl	    nhay					
	    cmp	    BYTE [esi], 'z'		
	    jg	    nhay			
	    sub 	BYTE [esi],  20h

    nhay:

	    inc 	esi
	    jmp	    L1

    inp:

	    mov     ecx, input
        mov     edx, 30
        mov     ebx, 1
        mov     eax, 4
        int     80h

	    pop	    ebp
	    ret		