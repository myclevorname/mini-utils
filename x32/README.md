# mini-utils
This is a set of small commands I am making to learn x86\_64 assembly for Linux.
I want all of these to be as small as possible, meaning there are very few features, unlike GNU Coreutils, for example.

## Build
The only packages you need are `make` and `nasm`.

## Current List
- cat
	- takes up 183 bytes
- mkdir, rmdir, touch, rm
	- rm and rmdir take up 115 bytes, while touch and mkdir take up 120 bytes
	- all based on the same piece of code at `mkrmdirfile/base.asm`
- yes
	- takes up 138 bytes
	- The string printed is comprised of the first argument, so you should put everything you want to print in quotes
- clear
	- takes up 111 bytes
	- Has 3 less options than the ncurses version, but I don't think anyone should need them.
- true
	- Takes up 85 bytes
	- All it does is jump to the exit routine, which conveniently returns zero.

## Disclaimer
The W^X protection of some processors and/or operating systems may cause some programs, like cat, to not run at all.
I will not attempt to accomodate for this because my it works on my machine.
I will not accept pull requests to appease those computers unless the programs are smaller afterward.

Also, the programs are using the X32 ABI.
I had to make changes to my GRUB configuration [listed here](https://wiki.debian.org/X32Port).
Without doing that, you may or may not get an `Exec format error`,
so make sure you have those changes applied before you ask for help.

## Contact
If you need support, or just want to say something, you can contact me in these ways, sorted from most likely to respond to least likely to respond:
1. Discord: imclevor

2. Email: my Github username but I use Google's service

3. IRC: clevor@EFnet assuming my IRC client doesn't shut down AND I read it AND someone doesn't impersonate me
