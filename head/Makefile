.PHONY: all clean
OUTPUT := head

all: head

head: head.asm ../linux_syscalls.inc
	nasm -o $@.o -f elf64 base.asm -O3
	ld -m elf_x86_64 -z noseparate-code -o $@ $@.o -s

clean:
	rm -f $(OUTPUT) *.o
