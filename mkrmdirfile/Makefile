.PHONY: all clean debug
OUTPUT := rm rmdir mkdir touch

all: $(OUTPUT)

$(OUTPUT): base.asm ../linux_syscalls.inc ../elf-header.inc
	nasm -o $@ -f bin base.asm -O3 -d$@
	chmod a+x $@
	cp $@ ../bin/

clean:
	rm -f $(OUTPUT) *.o *-old
