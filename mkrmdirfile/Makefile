.PHONY: all clean debug
OUTPUT := rm rmdir mkdir touch

all: $(OUTPUT)

$(OUTPUT): base.asm ../linux_syscalls.inc
	nasm -o $@.o -f elf64 base.asm -O3 -d$@
	ld -m elf_x86_64 -z noseparate-code -o $@ $@.o -s
	../bin/strip_secthead ./$@
	cp $@ ../bin/

clean:
	rm -f $(OUTPUT) *.o
