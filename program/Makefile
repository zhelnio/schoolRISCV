
# small piece of Makefile magic to simplify code support
# this is only for schoolRISCV maintainers

PROGRAM = 00_counter 01_fibonacci 02_sqrt
COPY_TARGET = 01_fibonacci 02_sqrt

TARGETS = copy build clean

.PHONY: $(PROGRAM)

$(TARGETS): $(PROGRAM)

$(COPY_TARGET)::
ifeq ($(MAKECMDGOALS), copy)
	cp 00_counter/Makefile $@/Makefile
endif

$(PROGRAM)::
ifeq ($(MAKECMDGOALS), build)
	$(MAKE) -C $@ $(MAKECMDGOALS)
endif
ifeq ($(MAKECMDGOALS), clean)
	$(MAKE) -C $@ $(MAKECMDGOALS)
endif
