# small piece of Makefile magic to simplify code support
# this is only for schoolRISCV maintainers
#
# Stanislav Zhelnio, 2020
#

help:
	$(info make help     - show this message (default))
	$(info make copy     - copy de10_lite/Makefile to other altera board dirs)
	$(info make clean    - clean in all board dirs)
	$(info make build    - build in all board dirs)
	@true

BOARDS_ALL = $(filter-out program/., $(wildcard */.))

# TODO: nexys   - add Xilinx boards support
#       de4_230 - needs Quartus license
#       de0     - the latest Quartus version that has support for Cyclone III is 13.1
BOARDS_IGNOR = $(filter nexys% de4_230% de0/., $(BOARDS_ALL)) 

BOARDS = $(filter-out $(BOARDS_IGNOR), $(BOARDS_ALL))

TARGETS = copy build clean
$(TARGETS): $(BOARDS_ALL)

.PHONY: $(BOARDS_ALL)

COPY_TARGET = $(filter-out nexys% de10_lite/., $(BOARDS_ALL))

$(COPY_TARGET)::
ifeq ($(MAKECMDGOALS), copy)
	cp de10_lite/Makefile $@/Makefile
endif

$(BOARDS)::
ifeq ($(MAKECMDGOALS), build)
	$(MAKE) -C $@ $(MAKECMDGOALS)
endif
ifeq ($(MAKECMDGOALS), clean)
	$(MAKE) -C $@ $(MAKECMDGOALS)
endif
