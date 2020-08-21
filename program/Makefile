# small piece of Makefile magic to simplify code support
# this is only for schoolRISCV maintainers
#
# Stanislav Zhelnio, 2020
#

help:
	$(info make help     - show this message (default))
	$(info make copy     - copy 00_counter/Makefile to other program dirs)
	$(info make clean    - clean in all program dirs)
	$(info make build    - build in all program dirs)
	$(info make icarus   - run simulation using icarus verilog in all program dirs)
	@true

PROGRAM_ALL = $(sort $(filter-out common/., $(wildcard */.)))
PROGRAM_DST = $(filter-out 00_counter/., $(PROGRAM_ALL))

TARGET_COMMON = build clean icarus
TARGET_ALL    = $(TARGET_COMMON) copy

.PHONY: $(PROGRAM_ALL)

$(TARGET_ALL): $(PROGRAM_ALL)

GOAL_COMMON := $(filter $(TARGET_COMMON),$(MAKECMDGOALS))

$(PROGRAM_ALL)::
ifneq (,$(GOAL_COMMON))
	$(MAKE) -C $@ $(GOAL_COMMON)
endif

$(PROGRAM_DST)::
ifeq ($(MAKECMDGOALS), copy)
	cp 00_counter/Makefile $@/Makefile
endif
