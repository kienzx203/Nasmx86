section .data

section .bss
    input   resb  30

section .text
    global _start

_start:
    mov     ecx, input
    mov     edx, 30
    mov     ebx, 0
    mov     eax, 3
    int     80h

    push    input
    call    REVERSE

    mov     ecx, input
    mov     edx, 30
    mov     ebx, 1
    mov     eax, 4
    int     80h

    mov     ebx, 0
    mov     eax, 1
    int     80h

REVERSE:
    push	ebp
	mov		ebp, esp
	mov		esi, [ebp+8]
	mov		edi, [ebp+8]
	mov		ecx, 0
L1:	
	mov		eax, 0
	mov		al, [esi]
	cmp		al, 0Ah 
	jz		L2
	push	eax
	inc		esi
	inc		ecx
	jmp		L1
L2:			
	mov		eax, 0
	pop		eax
	mov		[edi],al
	inc		edi
	loop	L2
	pop		ebp
	ret		4