# mkrmdirfile
Create and remove files and directories

## Usage
touch: Creates files, doesn't care if the file already exists.

rm: Removes files, but cannot remove folders or act recursively.
Use `rm -f $(find PATH)` to do that.

rmdir: Removes empty directories.

mkdir: Creates directories.

### Arguments
`-f`: Ignore all errors

Warning: The `-f` option has to be the FIRST argument and has to be typed in EXACTLY as specified.
If you have a file or directory named `-f`, prepend `./` to the argument.

## Errors
No error messages are returned to the console.
If you want to check the error message, use the `echo $?` command after to check for errors.
