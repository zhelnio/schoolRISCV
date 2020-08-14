
# small piece of Makefile magic to simplify code support
# this is only for schoolRISCV maintainers

BOARDS = $(filter-out program/., $(wildcard */.))
BOARDS_ALTERA = $(filter-out nexys%, $(BOARDS))
BOARDS_XILINX = $(filter nexys%, $(BOARDS))

# TODO: add Xilinx boards support
TARGETS = copy build clean
$(TARGETS): $(BOARDS_ALTERA)

.PHONY: $(BOARDS_ALTERA)

COPY_TARGET = $(filter-out de10_lite%, $(BOARDS_ALTERA))

$(COPY_TARGET)::
ifeq ($(MAKECMDGOALS), copy)
	cp de10_lite/Makefile $@/Makefile
endif

$(BOARDS_ALTERA)::
ifeq ($(MAKECMDGOALS), build)
	$(MAKE) -C $@ $(MAKECMDGOALS)
endif
ifeq ($(MAKECMDGOALS), clean)
	$(MAKE) -C $@ $(MAKECMDGOALS)
endif
