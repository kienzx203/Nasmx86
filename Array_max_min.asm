section .data
    space		db  20h, 0h
    min	        dd	1000000
	max		    dd	0
    line_feed   db  0Ah, 0h

section .bss
    input		resb	30 
	output		resb	30 
    len			resd	1
section .text
    global _start

_start:
        mov     ecx, input
        mov     edx, 30
        mov     ebx, 0
        mov     eax, 3
        int     80h

        push    input
        call    ATOI
        mov     [len], eax

    L1:
        cmp		BYTE [len], 0
	    jz		L4
        mov     ecx, input
        mov     edx, 30
        mov     ebx, 0
        mov     eax, 3
        int     80h
        dec     BYTE [len]
        push    input
        call    ATOI
        mov		ebx, 0
	    mov		ebx, eax
	    cmp		ebx, [max]
	    jg		L3
	    jmp		L2

    L2:	
	    cmp		ebx, [min]
	    jl		L5
	    jmp		L1
    
    L5:
	    mov		[min],ebx
	    jmp		L1

    L3: 

	    mov		[max],ebx
	    jmp		L2

    L4:
        mov 	ebx, [max]
        push    ebx
	    push	output
	    call	REATOI
        xor     ecx, ecx
        mov     ecx, output
        mov     edx, 30
        mov     ebx, 1
        mov     eax, 4
        int     80h

        xor     ecx, ecx
        mov     ecx, space
        mov     edx, 3
        mov     ebx, 1
        mov     eax, 4
        int     80h

        mov 	ebx, [min]
        push    ebx
	    push	output
	    call	REATOI
        xor     ecx, ecx
        mov     ecx, output
        mov     edx, 30
        mov     ebx, 1
        mov     eax, 4
        int     80h

        xor     ecx, ecx
        mov     ecx, line_feed
        mov     edx, 1
        mov     ebx, 1
        mov     eax, 4
        int     80h

        mov     ebx, 0
        mov     eax, 1
        int     80h


ATOI:
        push	ebp
	    mov		ebp, esp
	    push	ebx
	    mov		ebx, [ebp+08h]
	    xor		esi, esi								
	    xor		eax, eax
	    mov		ecx, 10
    L12:
	    xor		edx, edx
	    mov		dl, BYTE [ebx+esi]				
	    cmp		dl, 0Ah								
	    jz		L21
	    sub 	edx, 30h							
	    add		eax, edx							
	    mul		ecx									
	    inc		esi									
	    jmp		L12

    L21:
        xor     edx, edx
	    div		ecx
	    pop		ebx
	    pop		ebp
	    ret		4

REATOI:

        push    ebp
        mov     ebp, esp
	    xor		eax, eax
	    xor		ebx, ebx
        mov     eax, [ebp + 0Ch]						
        mov     ebx, [ebp + 08h]						
        xor     esi, esi 
        mov     ecx, 10
        push    3Ah										

    L11:
        xor     edx, edx
        div     ecx									
        or      edx, 30h						
        push    edx									
        cmp     eax, 0						
        jz      L22
        jmp     L11

    L22:

        pop     edx
        cmp     dl, 3Ah								
        jz      L33						
        mov     BYTE [ebx + esi], dl			
        inc     esi
        jmp     L22

    L33:

        mov     BYTE [ebx + esi], 0
        pop     ebp
        ret     8