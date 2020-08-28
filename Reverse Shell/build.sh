echo "[+] Assembling file with nasm"
nasm -f elf32 -o $1.o $1.nasm
echo "[+] Linking file with ld"
ld -o $1 $1.o
echo "[+] File ready!"
