
# small piece of Makefile magic to simplify code support
# this is only for schoolRISCV maintainers

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
