# cat
A miniature cat program written in x86_64 assembly for Linux. It currently compiles to just 246 bytes!
It doesn't use the C standard library, only Linux syscalls.

## Usage
The syntax is almost identical to the UNIX `cat` program, except there are no command-line options.

The only special option is `-`, which inputs from standard input.
If you want to read a file named `-` instead, just use `./-` instead.

## Build
All you need to compile is `make`, `ld`, and `nasm`.

First, run `make strip_secthead` in the parent directory.
Then, you can run `make` to make cat, `make debug` to make cat-debug, and `make clean` to "clean" up the directory.
