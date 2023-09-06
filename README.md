# mini-utils
This is a set of small commands I am making to learn x86_64 assembly for Linux.
I want all of these to be as small as possible, meaning there are very few features, unlike GNU Coreutils, for example.

## Build
The only packages you need are: `make`, `nasm`, and `ld`.
Run `make debug` to generate a debuggable binary.
I currently suck at Makefiles, so the files in mkrmdirfile will not produce debuggable programs.

## Current List
- cat
	- compiles to 464 bytes
- mkdir, rmdir, touch, rm
	- compiles to 424 bytes each
	- all based on the same piece of code at `mkrmdirfile/base.asm`
- head
	- This is not finished yet because I need to add the line-counting.
	- Don't expect it to compile! It has not been tested yet.
