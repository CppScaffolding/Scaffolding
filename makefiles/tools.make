## setting up platform specific tool paths

## requires: include 'platform.make'

#####################################################################
SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))


GENIE=$(SELF_DIR)../tools/bin/$(OS)/genie
#GENIE=/Users/christian.helmich/Documents/Code/Projects/GENie/bin/$(OS)/genie
MAKE=make
FLATC=$(SELF_DIR)../tools/bin/$(OS)/flatc
SHADERC=$(SELF_DIR)../tools/bin/$(OS)/shaderc
GEOMETRYC=$(SELF_DIR)../tools/bin/$(OS)/geometryc
TEXTUREC=$(SELF_DIR)../tools/bin/$(OS)/texturec

BIN2C=$(SELF_DIR)../tools/bin/$(OS)/bin2c
BIN2CCHAR=$(SELF_DIR)../tools/bin/$(OS)/bin2cchar
BIN2CCHAR_INCBIN=$(SELF_DIR)../tools/bin/$(OS)/bin2cchar_incbin
BIN2CPPVEC=$(SELF_DIR)../tools/bin/$(OS)/bin2cppvec
BIN2CPPVEC_INCBIN=$(SELF_DIR)../tools/bin/$(OS)/bin2cppvec_incbin
BIN2CPPSTRING=$(SELF_DIR)../tools/bin/$(OS)/bin2cppstring
BIN2CPPSTRING_INCBIN=$(SELF_DIR)../tools/bin/$(OS)/bin2cppstring_incbin
BIN2ASM=$(SELF_DIR)../tools/bin/$(OS)/bin2asm_incbin
NKF=$(SELF_DIR)../tools/bin/$(OS)/nkf
DOS2UNIX=dos2unix

ifeq ($(OS), $(filter $(OS), windows))

GENIE=$(SELF_DIR)../tools/bin/$(OS)/genie.exe
MAKE=make
FLATC=$(SELF_DIR)../tools/bin/$(OS)/flatc.exe
SHADERC=$(SELF_DIR)../tools/bin/$(OS)/shaderc.exe
GEOMETRYC=$(SELF_DIR)../tools/bin/$(OS)/geometryc.exe
TEXTUREC=$(SELF_DIR)../tools/bin/$(OS)/texturec.exe

BIN2C=$(SELF_DIR)../tools/bin/$(OS)/bin2c.exe
BIN2CCHAR=$(SELF_DIR)../tools/bin/$(OS)/bin2cchar.exe
BIN2CPPVEC=$(SELF_DIR)../tools/bin/$(OS)/bin2cppvec.exe
BIN2CPPSTRING=$(SELF_DIR)../tools/bin/$(OS)/bin2cppstring.exe
BIN2CPPVEC_INCBIN=$(SELF_DIR)../tools/bin/$(OS)/bin2cppvec_incbin.exe
BIN2CPPSTRING_INCBIN=$(SELF_DIR)../tools/bin/$(OS)/bin2cppstring_incbin.exe
BIN2ASM=$(SELF_DIR)../tools/bin/$(OS)/bin2asm_incbin.exe

endif

version_tools:
	@echo $(GENIE)
	@echo $(FLATC)
	@echo $(SHADERC)
	@echo $(GEOMETRYC)
	@echo $(TEXTUREC)
	@echo $(BIN2C)
	@echo $(BIN2CCHAR)
	@echo $(BIN2CPPVEC)
	@echo $(BIN2CPPSTRING)
	@echo $(BIN2CPPVEC_INCBIN)
	@echo $(BIN2CPPSTRING_INCBIN)
	@echo $(BIN2ASM)
	@ $(FLATC) --version || echo ""
	@ $(SHADERC) --help || echo ""
	@ $(GEOMETRYC) --help || echo ""
	@ $(TEXTUREC) --help || echo ""
	@ $(BIN2C) --help || echo ""
	@ $(BIN2CPPVEC) --help || echo ""
	@ $(BIN2CPPSTRING) --help || echo ""

