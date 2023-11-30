# mini-utils
This is a set of small commands I am making to learn x86_64 assembly for Linux.
I want all of these to be as small as possible, meaning there are very few features, unlike GNU Coreutils, for example.

## Build
The only packages you need are `make` and `nasm`.

## Current List
- cat
	- takes up 210 bytes
- mkdir, rmdir, touch, rm
	- rm and rmdir take up 145 bytes, while touch and mkdir take up 150 bytes
	- all based on the same piece of code at `mkrmdirfile/base.asm`
- yes
	- takes up 177 bytes
	- The string printed is comprised of the first argument, so you should put everything you want to print in quotes

# Contact
If you need support, or just want to say something, you can contact me in these ways, sorted from most likely to respond to least likely to respond:
1. Discord: imclevor

2. Email: my Github username but I use Google's service

3. IRC: clevor@EFnet assuming my IRC client doesn't shut down AND I read it AND someone doesn't impersonate me
