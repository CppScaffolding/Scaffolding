## makefile hub for unitbuild source generation

#####################################################################
SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

include $(SELF_DIR)platform.make
include $(SELF_DIR)tools.make

test:
	echo $(FLATC)
	@ $(FLATC) --version

# project path definitions
include $(SELF_DIR)../../scripts/scaffolding.make

# makerules
include $(SELF_DIR)../../scripts/unitbuild.make
