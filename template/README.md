# Template for your own projects

If you want to make your own programs, follow this guide.
However, changes made to mini-utils may break your own programs.
This is the up-to-date reference for that.

## Beginner's Guide

1. Make a new directory in the repository's top-level directory.

2. Copy the Makefile and template assembly file to the directory.

3. If you rename the assembly file or want to rename the output file, modify the Makefile.

The system calls and other defines are located in `linux_syscalls.inc`.

## Built-in Functions

### Jumps

\_\_error\_exit: If the output of a system call is an error, jump here to exit with the error code returned to the shell as `$?`.

\_\_exit: Exit the program with the error code of 0.

### Calls

\_\_check\_error: Executes the `syscall` instruction, then checks if an error was returned.
If an error occurs, it jumps to \_\_error\_exit. Otherwise, it returns the return value.
This will work incorrectly if the return value isn't always going to fit in 16 bits, like `brk`.

\_\_check\_error\_after: The same as above, but it jumps to just after the `syscall` instruction.

## Disclaimer

To optimize for size, the `WRITE_EXEC` define merges the code and writable data into one memory segment.
This can result in your program being modified by malicious input, so take caution when using it.
Also, some machines will refuse to run programs that allow for self-modifying code, called W^X protection.
If you want your code to be truly portable in this way, use the stack instead, or some other techniques for dynamically allocated memory.
