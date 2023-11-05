.PHONY: all clean debug
all: cat # cat-debug

cat: cat.asm ../elf-header.inc ../linux_syscalls.inc
	nasm -o cat cat.asm -O3 -f bin
	chmod a+x cat
	cp cat ../bin/

# cat-debug: cat-debug.o
#	ld -m elf_x86_64 -o cat-debug cat-debug.o -g
#
#cat-debug.o: cat.asm ../linux_syscalls.inc
#	nasm -f elf64 -o cat-debug.o cat.asm -g
#
clean:
	rm -f cat.o cat
	rm -f cat-debug.o cat-debug

debug: cat-debug
