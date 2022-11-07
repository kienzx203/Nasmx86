section .data
    space		db  20h, 0

section .bss
    input		resb	30 
    input1 		resb 	30
    output		resb	30 
    Tong_chan	resd	1
    Tong_le		resd	1
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
       mov      ecx, input
       mov      edx, 30
       mov      ebx, 0
       mov      eax, 3
       int      80h
       mov      esi, input
       mov      edi, input1

    L2:
        cmp		byte [esi], 0Ah
		je      L4
		cmp	byte [esi], 20h
		je      L3
		mov	al, byte [esi]
		mov	byte [edi], al
		inc	edi
		inc	esi
		jmp	L2

    L3:
        mov     byte [edi], 0Ah
        mov     ebx, esi
        push    input1
        call    ATOI
        mov     esi, ebx
        call    Sum
        mov     ecx, [len]
        dec     ecx
        mov     [len], ecx
        inc     esi
        mov     edi, input1 
        jmp     L2
    L4:
        mov     byte [edi], 0Ah
        mov     ebx, esi
        push    input1
        call    ATOI
        mov     esi, ebx
        call    Sum
        mov     ecx, [len]
        dec     ecx
        mov     [len], ecx
        cmp     byte [len], 0
        je      L5
        jmp     L1
    L5:
        mov     ecx, [Tong_chan]
        push    ecx
        push    output
        call    REATOI

        xor     ecx, ecx
        mov     ecx, output
        mov     edx, 30
        mov     ebx, 1
        mov     eax, 4
        int     80h

        mov     ecx, space
        mov     edx, 3
        mov     ebx, 1
        mov     eax, 4
        int     80h
        
        mov     ecx, [Tong_le]
        push    ecx
        push    output
        call    REATOI

        xor     ecx, ecx
        mov     ecx, output
        mov     edx, 30
        mov     ebx, 1
        mov     eax, 4
        int     80h

        mov     ebx, 0
        mov     eax, 1
        int     80h

Sum:
    push    ebp
    mov     ebp, esp
	L@1:
		mov	ebx, 0
		mov	ecx, 0
		mov	ecx, eax
		mov	ebx, 2
		mov	edx, 0
		div	ebx
		cmp	edx, 0
		jz	L@3
		jmp	L@2

	L@2:
		add	[Tong_le], ecx
		pop	ebp
		ret     

	L@3:

		add	[Tong_chan], ecx
		pop	ebp
		ret 

ATOI:
        push	ebp
	mov	ebp, esp
	push	ebx
	mov	ebx, [ebp+08h]
	xor	esi, esi								
	xor	eax, eax
	mov	ecx, 10
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
            xor     	edx, edx
	    div		ecx
	    pop		ebx
	    pop		ebp
	    ret		4

REATOI:

        push    ebp
        mov     ebp, esp
	xor	eax, eax
	xor	ebx, ebx
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
