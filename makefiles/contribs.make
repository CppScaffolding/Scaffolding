## makefile hub for contributions + bundling thereof

#####################################################################
SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

include $(SELF_DIR)platform.make
include $(SELF_DIR)tools.make

COPY_CMD=rsync -arvmyzh

test:
	echo $(COPY_CMD)

# project path definitions
include $(SELF_DIR)../../scripts/scaffolding.make

# makerules
include $(SELF_DIR)../../scripts/contribs.make
