# mini-utils
This is a set of small commands I am making to learn x86_64 assembly for Linux.
I want all of these to be as small as possible, meaning there are very few features, unlike GNU Coreutils, for example.

## Build
The only packages you need are `make` and `nasm`.

## Current List
- cat
	- compiles to 246 bytes
- mkdir, rmdir, touch, rm
	- rm and rmdir take up 195 bytes, while touch and mkdir take up 200 bytes
	- all based on the same piece of code at `mkrmdirfile/base.asm`
- head
	- This is not finished yet because I need to add the line-counting.
	- Don't expect it to compile! It has not been tested yet.

- strip-secthead
	- Not really a Linux utility; just strips the section header ~~from the other listed programs~~ from your assembly programs to reduce file size
	- I got a 45-50% reduction in program size, but that will be **much** lower if your assembly programs are bigger
	- Exercise moderate caution when using this program. ~~I used ld to build the program with GNU ld's built-in linker script.~~ I transitioned to each program using a pre-made ELF header, but I have tested this before. Make sure your program works after using the utility.

