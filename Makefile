DIRS := mkrmdirfile cat head
COMMANDS := all clean
.PHONY: all clean $(ALL_TARGETS)
TARGET_GEN = $(foreach DIR,$(DIRS),$(DIR)/$(TARGET))
ALL_TARGETS := $(foreach TARGET,$(COMMANDS),$(TARGET_GEN))

all: $(foreach TARGET,all,$(TARGET_GEN))
clean: $(foreach TARGET,clean,$(TARGET_GEN))

$(ALL_TARGETS):
	$(MAKE) -C $(@D) $(@F)
