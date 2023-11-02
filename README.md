# mini-utils
This is a set of small commands I am making to learn x86_64 assembly for Linux.
I want all of these to be as small as possible, meaning there are very few features, unlike GNU Coreutils, for example.

## Build
The only packages you need are: `make`, `nasm`, and `ld`.
Run `make debug` to generate a debuggable binary.
I currently suck at Makefiles, so the files in mkrmdirfile will not produce debuggable programs.

## Current List
- cat
	- compiles to 255 bytes
- mkdir, rmdir, touch, rm
	- rm and rmdir take up 209 bytes, while touch and mkdir take up 214 bytes
	- all based on the same piece of code at `mkrmdirfile/base.asm`
- head
	- This is not finished yet because I need to add the line-counting.
	- Don't expect it to compile! It has not been tested yet.

- strip-secthead
	- Not really a Linux utility; just strips the section header from the other listed programs (and istelf!) to reduce file size
	- I got a 45-50% reduction in program size, but that will be **much** lower if your programs are bigger
	- Exercise moderate caution when using this program. I used ld to build the program with GNU ld's built-in linker script. Make sure your program works after using the utility.
