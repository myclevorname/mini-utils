.PHONY: all clean debug
all: mkdir rmdir rm touch

mkdir: mkdir.o
	ld -m elf_x86_64 -z noseparate-code -o mkdir mkdir.o -s

rmdir: rmdir.o
	ld -m elf_x86_64 -z noseparate-code -o rmdir rmdir.o -s

rm: rm.o
	ld -m elf_x86_64 -z noseparate-code -o rm rm.o -s

touch: touch.o
	ld -m elf_x86_64 -z noseparate-code -o touch touch.o -s

mkdir.o: mkdir.asm base.asm ../linux_syscalls.inc
	nasm -o mkdir.o -f elf64 mkdir.asm -O3

rmdir.o: rmdir.asm base.asm ../linux_syscalls.inc
	nasm -o rmdir.o -f elf64 rmdir.asm -O3

rm.o: rm.asm base.asm ../linux_syscalls.inc
	nasm -o rm.o -f elf64 rm.asm -O3

touch.o: touch.asm base.asm ../linux_syscalls.inc
	nasm -o touch.o -f elf64 touch.asm -O3

#-debug: cat-debug.o
#	ld -m elf_x86_64 -o cat-debug cat-debug.o -g

#cat-debug.o: cat.asm ../linux_syscalls.inc
#	nasm -f elf64 -o cat-debug.o cat.asm -g

clean:
	rm -f mkdir rmdir rm
	rm -f mkdir.o rmdir.o rm.o
#	rm -f cat-debug.o cat-debug

#debug: cat-debug
