# mini-utils
This is a set of small commands I am making to learn x86_64 assembly for Linux.

## Build
The only packages you need are: `make`, `nasm`, and `ld`.
Run `make debug` to generate a debuggable binary.
I currently suck at Makefiles, so the files in mkrmdirfile will not produce debugable programs.

I don't have a Makefile set up in the root directory of this project, so you will have to run make in each subfolder.

## Current List
- cat
	- compiles to 488 bytes
- mkdir, rmdir, touch, rm
	- compiles to 400 bytes each
	- all based on the same piece of code at `mkrmdirfile/base.asm`
