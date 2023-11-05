.PHONY: all clean # debug
TARGET := strip_secthead
all: strip_secthead

$(TARGET): $(TARGET).asm ../linux_syscalls.inc ../elf-header.inc
	nasm -o $@ $@.asm -f bin
	chmod a+x $@
	cp $@ ../bin/$@ -f

#$(TARGET)-debug: $(TARGET)-debug.o
#	ld -m elf_x86_64 -o $(TARGET)-debug $(TARGET)-debug.o -g

#$(TARGET)-debug.o: strip-secthead.asm ../linux_syscalls.inc
#	nasm -f elf64 -o $(TARGET)-debug.o strip-secthead.asm -g

clean:
	rm -f $(TARGET).o $(TARGET)
#	rm -f $(TARGET)-debug.o $(TARGET)-debug

#debug: $(TARGET)-debug
