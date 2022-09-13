section .data
	msg		db	'Hello_world', 0Ah, 0h
section .bss
	
section .text
	global _start
	
_start:
	mov		eax, 4
	mov		ebx, 1
	mov 	edx, 13
	mov		ecx, msg
	int 	80h

	mov 	eax, 1
	mov 	ebx, 0
	int 	80h