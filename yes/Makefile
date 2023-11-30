.PHONY: all clean # debug
all: yes # cat-debug

yes: yes.asm ../elf-header.inc ../linux_syscalls.inc
	nasm -o yes yes.asm -O3 -f bin
	chmod a+x yes
	cp yes ../bin/

# cat-debug: cat-debug.o
#	ld -m elf_x86_64 -o cat-debug cat-debug.o -g
#
#cat-debug.o: cat.asm ../linux_syscalls.inc
#	nasm -f elf64 -o cat-debug.o cat.asm -g
#
clean:
	rm -f yes.o yes
#	rm -f cat-debug.o cat-debug

#debug: cat-debug
