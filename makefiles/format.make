## makefile hub for formatting project source files

#####################################################################
SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

include $(SELF_DIR)platform.make
include $(SELF_DIR)tools.make

FORMAT_CMD=clang-format -i
TIDY_CMD=clang-tidy -format-style=file 

test:
	echo $(FORMAT_CMD)

# project path definitions
include $(SELF_DIR)../../scripts/scaffolding.make

# makerules
include $(SELF_DIR)../../scripts/format.make
