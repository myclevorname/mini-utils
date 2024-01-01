DIRS := mkrmdirfile cat yes clear true
COMMANDS := all clean
.PHONY: all clean $(ALL_TARGETS)
TARGET_GEN = $(foreach DIR,$(DIRS),$(DIR)/$(TARGET))
ALL_TARGETS := $(foreach TARGET,$(COMMANDS),$(TARGET_GEN))

all: make_dir $(foreach TARGET,all,$(TARGET_GEN))
make_dir:
	mkdir -p bin
clean: $(foreach TARGET,clean,$(TARGET_GEN))
	rm -rf bin/
$(ALL_TARGETS): elf-header.inc linux_syscalls.inc
	$(MAKE) -C $(@D) $(@F)
