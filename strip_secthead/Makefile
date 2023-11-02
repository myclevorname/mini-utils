.PHONY: all clean debug
TARGET := strip_secthead
all: strip_secthead

$(TARGET): $(TARGET).o
	ld -m elf_x86_64 -z noseparate-code -o $@ $@.o -s
	cp $@ ../bin/$@
	../bin/$@ $@
	cp $@ ../bin/$@ -f

$(TARGET).o: strip-secthead.asm ../linux_syscalls.inc
	nasm -o $(TARGET).o -f elf64 strip-secthead.asm -O3

$(TARGET)-debug: $(TARGET)-debug.o
	ld -m elf_x86_64 -o $(TARGET)-debug $(TARGET)-debug.o -g

$(TARGET)-debug.o: strip-secthead.asm ../linux_syscalls.inc
	nasm -f elf64 -o $(TARGET)-debug.o strip-secthead.asm -g

clean:
	rm -f $(TARGET).o $(TARGET)
	rm -f $(TARGET)-debug.o $(TARGET)-debug

debug: $(TARGET)-debug
