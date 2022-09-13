section .data
    dem			dd	0
	len1		dd  0
    space		db	' ', 0
	check		dd	1
    sline1		db  "S = ", 0h
    sline2      db  "C = ", 0h
	line_feed	db	0Ah, 0Dh, 0

section .bss
    input		resb	200 
    line        resb    1
	output		resb	200 
    input1		resb	200

section .text
    global _start

_start:
        xor     ecx, ecx
        mov     ecx, sline1
        mov     edx, 4
        mov     ebx, 1
        mov     eax, 4
        int     80h

        mov     ecx, input
        mov     edx, 200
        mov     ebx, 0
        mov     eax, 3
        int     80h

        xor     ecx, ecx
        mov     ecx, sline2
        mov     edx, 4
        mov     ebx, 1
        mov     eax, 4
        int     80h

        mov     ecx, input1
        mov     edx, 200
        mov     ebx, 0
        mov     eax, 3
        int     80h

        push	input1
	    call	LEN
        mov     [len1], eax

        mov		esi, input
	    mov		edi, input1
	    mov		ebx, 0
	    mov		eax, 0
    L1:	

	    mov		edx, 0
	    mov		eax, 0
	    mov		dl,	BYTE  [esi + ebx]
	    mov		dh,	BYTE  [edi + eax]
	    cmp		dl, 0Ah
	    jz		L5
	    cmp		dl, dh
	    je		L2
	    inc		ebx
	    jmp		L1

    L2:
	    mov		edx, 0
	    mov		dl,	BYTE  [esi + ebx]
	    mov		dh,	BYTE  [edi + eax]
	    cmp		dh, 0Ah
	    jz		L3
	    inc		ebx
	    inc		eax
	    cmp		dh,dl
	    je		L2
	    jmp		L1

    L3:
	    cmp		BYTE [check], 0
	    jz		L6
	    mov		eax, 0
	    mov		eax, [dem]
	    inc		eax
	    mov		[dem], eax
	    jmp		L1

    L5:
	    cmp		BYTE [check], 0
	    jz		L7
        mov     eax, 0
        mov     eax, [dem]
	    push	eax
        push    output
        call    REATOI

        xor     ecx, ecx
        mov     ecx, output
        mov     edx, 200
        mov     ebx, 1
        mov     eax, 4
        int     80h

        xor     ecx, ecx
        mov     ecx, line_feed
        mov     edx, 3
        mov     ebx, 1
        mov     eax, 4
        int     80h

        mov		BYTE [check], 0
	    mov		ebx, 0
	    mov		eax, 0
	    jmp 	L1
    
    L6:
	    mov		eax, 0
	    mov		eax, ebx
        push    ebx
	    sub		eax, [len1]
	    push	eax
        push    output
        call    REATOI

        xor     ecx, ecx
        mov     ecx, output
        mov     edx, 200
        mov     ebx, 1
        mov     eax, 4
        int     80h

        xor     ecx, ecx
        mov     ecx, space
        mov     edx, 2
        mov     ebx, 1
        mov     eax, 4
        int     80h
        pop     ebx
        jmp     L1

    L7:
        mov     ebx, 0
        mov     eax, 1
        int     80h


LEN:

	    push	ebp
	    mov		ebp, esp
	    mov		ecx, [ebp+08h]
	    xor		esi, esi
	    xor		eax, eax
		
    L13:
	    cmp		BYTE [ecx+esi], 0Ah
	    jz		L23
	    inc		esi
	    jmp		L13

    L23:
	    mov		eax, esi
	    pop		ebp
	    ret		4

REATOI:

        push    ebp
        mov     ebp, esp
        push	ebx
	    push	ecx
	    push	eax
	    push	esi
	    push	edi
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
	    pop		edi
	    pop		esi
	    pop		eax
	    pop		ecx
	    pop		ebx
        pop     ebp
        ret     8