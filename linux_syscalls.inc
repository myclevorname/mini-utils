%ifndef LINUX_SYSCALLS_INC
%define LINUX_SYSCALLS_INC

; Syscalls
%define SYS_READ 0
%define SYS_OPEN 2
%define SYS_EXIT 60
%define SYS_MKDIR 83
%define SYS_RMDIR 84
%define SYS_CREAT 85
%define SYS_UNLINK 87

; File open attributes
%define O_RDONLY 0


; error from syscalls
%define ERRNO_MIN -4096
;%define ERRNO_MAX -1

%define stdin 0
%define stdout 1
%define stderr 2

%endif
