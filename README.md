# mini-utils
This is a set of small commands I am making to learn x86\_64 assembly for Linux.
I want all of these to be as small as possible, meaning there are very few features, unlike GNU Coreutils, for example.

## Build
The only packages you need are `make` and `nasm`.

There is an experimental x32 port of the binaries in the `x32/` directory.
You will probably need some kernel flags set to get it to run without errors.

## Current List
- cat
	- takes up 210 bytes
- mkdir, rmdir, touch, rm
	- rm and rmdir take up 145 bytes, while touch and mkdir take up 150 bytes
	- all based on the same piece of code at `mkrmdirfile/base.asm`
- yes
	- takes up 162 bytes
	- The string printed is comprised of the first argument, so you should put everything you want to print in quotes
- clear
	- takes up 137 bytes
	- Has 3 less options than the ncurses version, but I don't think anyone should need them.
- true
	- takes up 118 bytes
	- Cannot be reduced even further without a change to the ELF header, or to the kernel
- false
	- takes up 118 bytes
	- Same problem as true

## Disclaimer
The W^X protection of some processors and/or operating systems may cause some programs, like cat, to not run at all.
I will not attempt to accomodate for this because my it works on my machine.
I will not accept pull requests to appease those computers unless the programs are smaller afterward.

## Contact
If you need support, or just want to say something, you can contact me in these ways, sorted from most likely to respond to least likely to respond:
1. Discord: imclevor

2. Email: my Github username but I use Google's service

3. IRC: clevor@EFnet assuming my IRC client doesn't shut down AND I read it AND someone doesn't impersonate me
