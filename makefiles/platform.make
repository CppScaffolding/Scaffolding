## setting up platform specific paths

#####################################################################

ifeq ($(OS),Windows_NT)
	OS=windows
else
	UNAME:=$(shell uname)
	ifeq ($(UNAME),$(filter $(UNAME),Linux Darwin))
		CMD_MKDIR=mkdir -p "$(1)"
		CMD_RMDIR=rm -r "$(1)"
		ifeq ($(UNAME),$(filter $(UNAME),Darwin))
			OS=darwin
		else
			OS=linux
		endif
	else
		CMD_MKDIR=cmd /C "if not exist "$(subst /,\,$(1))" mkdir "$(subst /,\,$(1))""
		CMD_RMDIR=cmd /C "if exist "$(subst /,\,$(1))" rmdir /S /Q "$(subst /,\,$(1))""
		OS=windows
	endif
endif

$(info $(OS))

