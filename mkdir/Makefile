.PHONY: all clean debug
all: mkdir # mkdir-debug

mkdir: mkdir.o
	ld -m elf_x86_64 -z noseparate-code -o mkdir mkdir.o -s

mkdir.o: mkdir.asm ../linux_syscalls.inc
	nasm -o mkdir.o -f elf64 mkdir.asm -O3

mkdir-debug: mkdir-debug.o
	ld -m elf_x86_64 -o mkdir-debug mkdir-debug.o -g

mkdir-debug.o: mkdir.asm ../linux_syscalls.inc
	nasm -f elf64 -o mkdir-debug.o mkdir.asm -g

clean:
	rm -f mkdir.o mkdir
	rm -f mkdir-debug.o mkdir-debug

debug: mkdir-debug
