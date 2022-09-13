section .data
    num         dd      0
    num2        dd      0
    num3        dd      1
    nline		db		20h, 0h
section .bss
    input		resb	30 
	output		resb	30 
section .text
    global _start

_start:
        mov     ecx, inputE
        mov     edx, 30
        mov     ebx, 0
        mov     eax, 3
        int     80h

        push    input
        call    ATOI
        mov     [num], eax
        cmp		BYTE [num],3
	    jge		el1
	    call	FIBONACI

    el1:
        mov		eax, 0
	    push	eax
	    push	output
	    call	REATOI

        xor     ecx, ecx
        mov     ecx, output
        mov     edx, 30
        mov     ebx, 1
        mov     eax, 4
        int     80h

        xor     ecx, ecx
        mov     ecx, nline
        mov     edx, 1
        mov     ebx, 1
        mov     eax, 4
        int     80h

        mov		eax, 1
	    push	eax
        push	output
	    call	REATOI
        xor     ecx, ecx
        mov     ecx, output
        mov     edx, 30
        mov     ebx, 1
        mov     eax, 4
        int     80h

        xor     ecx, ecx
        mov     ecx, nline
        mov     edx, 1
        mov     ebx, 1
        mov     eax, 4
        int     80h

        call    FIBONACI
        push    eax
        push	output
	    call	REATOI

        xor     ecx, ecx
        mov     ecx, output
        mov     edx, 30
        mov     ebx, 1
        mov     eax, 4
        int     80h

        mov     ebx, 0
        mov     eax, 1
        int     80h

FIBONACI:
        push	ebp
	    mov		ebp, esp
	    mov		ecx, 0
	    mov		ecx, [num]
	    xor		eax, eax
	    xor		ebx, ebx
	    jmp		L1

    L3:	
	    mov		eax, ecx
	    push	eax
	    push	output
	    call	REATOI
	    xor     ecx, ecx
        mov     ecx, output
        mov     edx, 30
        mov     ebx, 1
        mov     eax, 4
        int     80h
	
        mov     ebx, 0
        mov     eax, 1
        int     80h

    L1:
	
	    cmp		ecx, 0
	    je		L3
	    cmp		ecx, 1
	    je		L3
	    cmp		ecx, 2
	    je		L6
	    jmp		L4

    L4:
	    xor		eax, eax
	    xor		ebx, ebx
	    mov		eax, [num2]
	    mov		ebx, [num3]
	    mov		[num2],ebx
	    add		eax, ebx
	    mov		[num3],eax
	    cmp		ecx, 3
	    je		L5
	    jmp		L7
    L5:
	    xor		eax, eax
	    mov		eax, [num3]
	    pop		ebp
	    ret		4

    L6:
	
	    mov		eax, 0
	    push	eax
        push	output
	    call	REATOI
	    xor     ecx, ecx
        mov     ecx, output
        mov     edx, 30
        mov     ebx, 1
        mov     eax, 4
        int     80h

        xor     ecx, ecx
        mov     ecx, nline
        mov     edx, 3
        mov     ebx, 1
        mov     eax, 4
        int     80h

	    mov		eax, 1
	    push	eax
	    push	output
	    call	REATOI
	
        xor     ecx, ecx
        mov     ecx, output
        mov     edx, 30
        mov     ebx, 1
        mov     eax, 4
        int     80h

        mov     ebx, 0
        mov     eax, 1
        int     80h

    L7:

	    mov		ebx, ecx
	    push	ebx
	    push	eax
	    push	output
	    call	REATOI
        xor     ecx, ecx
        mov     ecx, output
        mov     edx, 30
        mov     ebx, 1
        mov     eax, 4
        int     80h

	    xor     ecx, ecx
        mov     ecx, nline
        mov     edx, 3
        mov     ebx, 1
        mov     eax, 4
        int     80h
        pop		ebx
	    mov		ecx, ebx
	    dec		ecx
	    jmp		L4



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