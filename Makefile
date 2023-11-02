DIRS := mkrmdirfile cat # head
DIRS_WITH_SPECIAL := $(DIRS) strip_secthead
COMMANDS := all clean
.PHONY: all clean $(ALL_TARGETS)
TARGET_GEN = $(foreach DIR,$(DIRS),$(DIR)/$(TARGET))
ALL_TARGETS := $(foreach TARGET,$(COMMANDS),$(TARGET_GEN))

TARGET_GEN_SPECIAL = $(foreach DIR,$(DIRS_WITH_SPECIAL),$(DIR)/$(TARGET))
ALL_TARGETS_SPECIAL = $(foreach TARGET,$(COMMANDS),$(TARGET_GEN_SPECIAL))

all: make_dir strip_secthead/all $(foreach TARGET,all,$(TARGET_GEN))
make_dir:
	mkdir -p bin
clean: $(foreach TARGET,clean,$(TARGET_GEN_SPECIAL))
	rm -rf bin/
$(ALL_TARGETS_SPECIAL):
	$(MAKE) -C $(@D) $(@F)
