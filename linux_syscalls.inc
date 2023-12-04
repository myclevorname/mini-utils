%ifndef LINUX_SYSCALLS_INC
%define LINUX_SYSCALLS_INC

; Syscalls
%define SYS_READ 0
%define SYS_WRITE 1
%define SYS_OPEN 2
%define SYS_CLOSE 3
%define SYS_LSEEK 8
%define SYS_MMAP 9
%define SYS_BRK 12
%define SYS_EXIT 60
%define SYS_FTRUNCATE 77
%define SYS_MKDIR 83
%define SYS_RMDIR 84
%define SYS_CREAT 85
%define SYS_UNLINK 87

; File open attributes
%define O_RDONLY 0
%define O_RDWR 2

; lseek whence
%define SEEK_SET 0
%define SEEK_CUR 1
%define SEEK_END 2

; error from syscalls
%define ERRNO_MIN -4096
;%define ERRNO_MAX -1

%define stdin 0
%define stdout 1
%define stderr 2

; mmap flags
%define MAP_PRIVATE 2
%define MAP_32BIT 0x40

%define PROT_NONE 0
%define PROT_READ 1

; Auxillary defines
%define NEWLINE 10
%define FILE_READ_SIZE 1024

%endif
