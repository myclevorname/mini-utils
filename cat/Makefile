.PHONY: all clean debug
all: cat # cat-debug

cat: cat.o ../bin/strip_secthead
	ld -m elf_x86_64 -z noseparate-code -o cat cat.o -s
	../bin/strip_secthead ./cat
	cp cat ../bin/

cat.o: cat.asm ../linux_syscalls.inc
	nasm -o cat.o -f elf64 cat.asm -O3

cat-debug: cat-debug.o
	ld -m elf_x86_64 -o cat-debug cat-debug.o -g

cat-debug.o: cat.asm ../linux_syscalls.inc
	nasm -f elf64 -o cat-debug.o cat.asm -g

clean:
	rm -f cat.o cat
	rm -f cat-debug.o cat-debug

debug: cat-debug
