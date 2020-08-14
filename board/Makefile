
# small piece of Makefile magic to simplify code support
# this is only for schoolRISCV maintainers

BOARDS_ALL = $(filter-out program/., $(wildcard */.))

# TODO: nexys   - add Xilinx boards support
#       de4_230 - needs Quartus license
#       de0     - the latest Quartus version that has support for Cyclone III is 13.1
BOARDS_IGNOR = $(filter nexys% de4_230% de0%, $(BOARDS_ALL)) 

BOARDS = $(filter-out $(BOARDS_IGNOR), $(BOARDS_ALL))

TARGETS = copy build clean
$(TARGETS): $(BOARDS)

.PHONY: $(BOARDS)

COPY_TARGET = $(filter-out de10_lite%, $(BOARDS))

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
