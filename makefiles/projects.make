## makefile hub for project generation

#####################################################################
SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

include $(SELF_DIR)platform.make
include $(SELF_DIR)tools.make

test:
	echo $(GENIE)

# project path definitions (PROJECT_ENTRY)
include $(SELF_DIR)../../scripts/scaffolding.make

# genie defintions (GENIE_EXTRA_FLAGS)
include $(SELF_DIR)../../scripts/genie.make


GENIE_CMD=$(GENIE) --file=$(PROJECT_ENTRY) $(GENIE_EXTRA_FLAGS)


#####################################################################

# print flags
verbose:
	@echo VS flags: $(GENIE_VS_FLAGS)
	@echo Xcode flags: $(GENIE_XCODE_MAC_FLAGS) 
	@echo extra flags: $(GENIE_EXTRA_FLAGS)

## generates all projects on all configurations and builds them
all: test verbose
	# TODO: comment out unused configurations
	#$(GENIE_CMD)                     vs2012
	#$(GENIE_CMD)                     vs2013
	$(GENIE_CMD) $(GENIE_VS_FLAGS)   vs2015
	$(GENIE_CMD) $(GENIE_VS_FLAGS) --no-ms-compat --vs=vs2015-clang vs2015
	$(GENIE_CMD) $(GENIE_VS_FLAGS)   vs2017
	$(GENIE_CMD) $(GENIE_VS_FLAGS) --no-ms-compat --vs=vs2017-clang vs2017
	$(GENIE_CMD) --gcc=mingw-gcc     gmake
	$(GENIE_CMD) $(GENIE_GCC_LINUX_FLAGS) --gcc=linux-gcc     gmake
	$(GENIE_CMD) --gcc=osx           gmake
	$(GENIE_CMD) $(GENIE_XCODE_MAC_FLAGS) --xcode=osx         xcode4
	$(GENIE_CMD) $(GENIE_XCODE_MAC_FLAGS) --xcode=ios         xcode4
	$(GENIE_CMD) --gcc=freebsd       gmake
	$(GENIE_CMD) --gcc=android-arm   gmake
	$(GENIE_CMD) --gcc=android-mips  gmake
	$(GENIE_CMD) --gcc=android-x86   gmake
	$(GENIE_CMD) --gcc=asmjs         gmake
	$(GENIE_CMD) --gcc=ios-arm       gmake
	$(GENIE_CMD) --gcc=ios-arm64     gmake
	$(GENIE_CMD) --gcc=ios-simulator gmake
	$(GENIE_CMD) --gcc=rpi           gmake


#####################################################################

$(PROJECT_OUTPUT)/projects/gmake-android-arm:
	$(GENIE_CMD) --gcc=android-arm gmake
android-arm-debug: $(PROJECT_OUTPUT)/projects/gmake-android-arm ## Build - Android ARM Debug
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-android-arm config=debug
android-arm-release: $(PROJECT_OUTPUT)/projects/gmake-android-arm ## Build - Android ARM Release
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-android-arm config=release
android-arm: android-arm-debug android-arm-release ## Build - Android ARM Debug and Release

$(PROJECT_OUTPUT)/projects/gmake-android-mips:
	$(GENIE_CMD) --gcc=android-mips gmake
android-mips-debug: $(PROJECT_OUTPUT)/projects/gmake-android-mips ## Build - Android MIPS Debug
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-android-mips config=debug
android-mips-release: $(PROJECT_OUTPUT)/projects/gmake-android-mips ## Build - Android MIPS Release
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-android-mips config=release
android-mips: android-mips-debug android-mips-release ## Build - Android MIPS Debug and Release

$(PROJECT_OUTPUT)/projects/gmake-android-x86:
	$(GENIE_CMD) --gcc=android-x86 gmake
android-x86-debug: $(PROJECT_OUTPUT)/projects/gmake-android-x86 ## Build - Android x86 Debug and Release
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-android-x86 config=debug
android-x86-release: $(PROJECT_OUTPUT)/projects/gmake-android-x86 ## Build - Android x86 Debug and Release
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-android-x86 config=release
android-x86: android-x86-debug android-x86-release ## Build - Android x86 Debug and Release

$(PROJECT_OUTPUT)/projects/gmake-asmjs:
	$(GENIE_CMD) --gcc=asmjs gmake
asmjs-debug: $(PROJECT_OUTPUT)/projects/gmake-asmjs ## Build - Emscripten Debug
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-asmjs config=debug
asmjs-release: $(PROJECT_OUTPUT)/projects/gmake-asmjs ## Build - Emscripten Release
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-asmjs config=release
asmjs: asmjs-debug asmjs-release ## Build - Emscripten Debug and Release

$(PROJECT_OUTPUT)/projects/gmake-linux:
	$(GENIE_CMD) --with-tools --with-examples --with-shared-lib --gcc=linux-gcc gmake
linux-debug32: $(PROJECT_OUTPUT)/projects/gmake-linux ## Build - Linux x86 Debug
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-linux config=debug32
linux-release32: $(PROJECT_OUTPUT)/projects/gmake-linux ## Build - Linux x86 Release
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-linux config=release32
linux-debug64: $(PROJECT_OUTPUT)/projects/gmake-linux ## Build - Linux x64 Debug
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-linux config=debug64
linux-release64: $(PROJECT_OUTPUT)/projects/gmake-linux ## Build - Linux x64 Release
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-linux config=release64
linux: linux-debug32 linux-release32 linux-debug64 linux-release64 ## Build - Linux x86/x64 Debug and Release

$(PROJECT_OUTPUT)/projects/gmake-freebsd:
	$(GENIE_CMD) --with-tools --with-examples --with-shared-lib --gcc=freebsd gmake
freebsd-debug32: $(PROJECT_OUTPUT)/projects/gmake-freebsd ## Build - FreeBSD x86 Debug
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-freebsd config=debug32
freebsd-release32: $(PROJECT_OUTPUT)/projects/gmake-freebsd ## Build - FreeBSD x86 Release
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-freebsd config=release32
freebsd-debug64: $(PROJECT_OUTPUT)/projects/gmake-freebsd ## Build - FreeBSD x86 Debug
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-freebsd config=debug64
freebsd-release64: $(PROJECT_OUTPUT)/projects/gmake-freebsd ## Build - FreeBSD x86 Release
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-freebsd config=release64
freebsd: freebsd-debug32 freebsd-release32 freebsd-debug64 freebsd-release64 ## Build - FreeBSD x86/x64 Debug and Release

$(PROJECT_OUTPUT)/projects/gmake-mingw-gcc:
	$(GENIE_CMD) --with-tools --with-examples --with-shared-lib --gcc=mingw-gcc gmake
mingw-gcc-debug32: $(PROJECT_OUTPUT)/projects/gmake-mingw-gcc ## Build - MinGW GCC x86 Debug
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-mingw-gcc config=debug32
mingw-gcc-release32: $(PROJECT_OUTPUT)/projects/gmake-mingw-gcc ## Build - MinGW GCC x86 Release
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-mingw-gcc config=release32
mingw-gcc-debug64: $(PROJECT_OUTPUT)/projects/gmake-mingw-gcc ## Build - MinGW GCC x64 Debug
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-mingw-gcc config=debug64
mingw-gcc-release64: $(PROJECT_OUTPUT)/projects/gmake-mingw-gcc ## Build - MinGW GCC x64 Release
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-mingw-gcc config=release64
mingw-gcc: mingw-gcc-debug32 mingw-gcc-release32 mingw-gcc-debug64 mingw-gcc-release64 ## Build - MinGW GCC x86/x64 Debug and Release

$(PROJECT_OUTPUT)/projects/gmake-mingw-clang:
	$(GENIE_CMD) --gcc=mingw-clang gmake
mingw-clang-debug32: $(PROJECT_OUTPUT)/projects/gmake-mingw-clang ## Build - MinGW Clang x86 Debug
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-mingw-clang config=debug32
mingw-clang-release32: $(PROJECT_OUTPUT)/projects/gmake-mingw-clang ## Build - MinGW Clang x86 Release
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-mingw-clang config=release32
mingw-clang-debug64: $(PROJECT_OUTPUT)/projects/gmake-mingw-clang ## Build - MinGW Clang x64 Debug
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-mingw-clang config=debug64
mingw-clang-release64: $(PROJECT_OUTPUT)/projects/gmake-mingw-clang ## Build - MinGW Clang x64 Release
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-mingw-clang config=release64
mingw-clang: mingw-clang-debug32 mingw-clang-release32 mingw-clang-debug64 mingw-clang-release64 ## Build - MinGW Clang x86/x64 Debug and Release

$(PROJECT_OUTPUT)/projects/vs2012:
	$(GENIE_CMD) --with-tools --with-examples --with-shared-lib vs2012
vs2012-debug32: $(PROJECT_OUTPUT)/projects/vs2012 ## Build - VS2012 x86 Debug
	devenv $(PROJECT_OUTPUT)/projects/vs2012/bgfx.sln /Build "Debug|Win32"
vs2012-release32: $(PROJECT_OUTPUT)/projects/vs2012 ## Build - VS2012 x86 Release
	devenv $(PROJECT_OUTPUT)/projects/vs2012/bgfx.sln /Build "Release|Win32"
vs2012-debug64: $(PROJECT_OUTPUT)/projects/vs2012 ## Build - VS2012 x64 Debug
	devenv $(PROJECT_OUTPUT)/projects/vs2012/bgfx.sln /Build "Debug|x64"
vs2012-release64: $(PROJECT_OUTPUT)/projects/vs2012 ## Build - VS2012 x64 Release
	devenv $(PROJECT_OUTPUT)/projects/vs2012/bgfx.sln /Build "Release|x64"
vs2012: vs2012-debug32 vs2012-release32 vs2012-debug64 vs2012-release64 ## Build - VS2012 x86/x64 Debug and Release

$(PROJECT_OUTPUT)/projects/vs2013:
	$(GENIE_CMD) --with-tools --with-examples --with-shared-lib vs2013
vs2013-debug32: $(PROJECT_OUTPUT)/projects/vs2013 ## Build - VS2013 x86 Debug
	devenv $(PROJECT_OUTPUT)/projects/vs2013/bgfx.sln /Build "Debug|Win32"
vs2013-release32: $(PROJECT_OUTPUT)/projects/vs2013 ## Build - VS2013 x86 Release
	devenv $(PROJECT_OUTPUT)/projects/vs2013/bgfx.sln /Build "Release|Win32"
vs2013-debug64: $(PROJECT_OUTPUT)/projects/vs2013 ## Build - VS2013 x64 Debug
	devenv $(PROJECT_OUTPUT)/projects/vs2013/bgfx.sln /Build "Debug|x64"
vs2013-release64: $(PROJECT_OUTPUT)/projects/vs2013 ## Build - VS2013 x64 Release
	devenv $(PROJECT_OUTPUT)/projects/vs2013/bgfx.sln /Build "Release|x64"
vs2013: vs2013-debug32 vs2013-release32 vs2013-debug64 vs2013-release64 ## Build - VS2013 x86/x64 Debug and Release

$(PROJECT_OUTPUT)/projects/vs2015:
	$(GENIE_CMD) --with-tools --with-examples --with-shared-lib vs2015
vs2015-debug32: $(PROJECT_OUTPUT)/projects/vs2015 ## Build - VS2015 x86 Debug
	devenv $(PROJECT_OUTPUT)/projects/vs2015/bgfx.sln /Build "Debug|Win32"
vs2015-release32: $(PROJECT_OUTPUT)/projects/vs2015 ## Build - VS2015 x86 Release
	devenv $(PROJECT_OUTPUT)/projects/vs2015/bgfx.sln /Build "Release|Win32"
vs2015-debug64: $(PROJECT_OUTPUT)/projects/vs2015 ## Build - VS2015 x64 Debug
	devenv $(PROJECT_OUTPUT)/projects/vs2015/bgfx.sln /Build "Debug|x64"
vs2015-release64: $(PROJECT_OUTPUT)/projects/vs2015 ## Build - VS2015 x64 Release
	devenv $(PROJECT_OUTPUT)/projects/vs2015/bgfx.sln /Build "Release|x64"
vs2015: vs2015-debug32 vs2015-release32 vs2015-debug64 vs2015-release64 ## Build - VS2015 x86/x64 Debug and Release

$(PROJECT_OUTPUT)/projects/vs2017:
	$(GENIE_CMD) --with-tools --with-examples --with-shared-lib vs2017
vs2017-debug32: $(PROJECT_OUTPUT)/projects/vs2017 ## Build - vs2017 x86 Debug
	devenv $(PROJECT_OUTPUT)/projects/vs2017/bgfx.sln /Build "Debug|Win32"
vs2017-release32: $(PROJECT_OUTPUT)/projects/vs2017 ## Build - vs2017 x86 Release
	devenv $(PROJECT_OUTPUT)/projects/vs2017/bgfx.sln /Build "Release|Win32"
vs2017-debug64: $(PROJECT_OUTPUT)/projects/vs2017 ## Build - vs2017 x64 Debug
	devenv $(PROJECT_OUTPUT)/projects/vs2017/bgfx.sln /Build "Debug|x64"
vs2017-release64: $(PROJECT_OUTPUT)/projects/vs2017 ## Build - vs2017 x64 Release
	devenv $(PROJECT_OUTPUT)/projects/vs2017/bgfx.sln /Build "Release|x64"
vs2017: vs2017-debug32 vs2017-release32 vs2017-debug64 vs2017-release64 ## Build - vs2017 x86/x64 Debug and Release

$(PROJECT_OUTPUT)/projects/gmake-nacl:
	$(GENIE_CMD) --gcc=nacl gmake
nacl-debug32: $(PROJECT_OUTPUT)/projects/gmake-nacl ## Build - Native Client x86 Debug
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-nacl config=debug32
nacl-release32: $(PROJECT_OUTPUT)/projects/gmake-nacl ## Build - Native Client x86 Release
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-nacl config=release32
nacl-debug64: $(PROJECT_OUTPUT)/projects/gmake-nacl ## Build - Native Client x64 Debug
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-nacl config=debug64
nacl-release64: $(PROJECT_OUTPUT)/projects/gmake-nacl ## Build - Native Client x64 Release
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-nacl config=release64
nacl: nacl-debug32 nacl-release32 nacl-debug64 nacl-release64 ## Build - Native Client x86/x64 Debug and Release

$(PROJECT_OUTPUT)/projects/gmake-nacl-arm:
	$(GENIE_CMD) --gcc=nacl-arm gmake
nacl-arm-debug: $(PROJECT_OUTPUT)/projects/gmake-nacl-arm ## Build - Native Client ARM Debug
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-nacl-arm config=debug
nacl-arm-release: $(PROJECT_OUTPUT)/projects/gmake-nacl-arm ## Build - Native Client ARM Release
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-nacl-arm config=release
nacl-arm: nacl-arm-debug32 nacl-arm-release32 ## Build - Native Client ARM Debug and Release

$(PROJECT_OUTPUT)/projects/gmake-pnacl:
	$(GENIE_CMD) --gcc=pnacl gmake
pnacl-debug: $(PROJECT_OUTPUT)/projects/gmake-pnacl ## Build - Portable Native Client Debug
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-pnacl config=debug
pnacl-release: $(PROJECT_OUTPUT)/projects/gmake-pnacl ## Build - Portable Native Client Release
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-pnacl config=release
pnacl: pnacl-debug pnacl-release ## Build - Portable Native Client Debug and Release

$(PROJECT_OUTPUT)/projects/gmake-osx:
	$(GENIE_CMD) --with-tools --with-examples --with-shared-lib --gcc=osx gmake
osx-debug32: $(PROJECT_OUTPUT)/projects/gmake-osx ## Build - OSX x86 Debug
	$(MAKE) -C $(PROJECT_OUTPUT)/projects/gmake-osx config=debug32
osx-release32: $(PROJECT_OUTPUT)/projects/gmake-osx ## Build - OSX x86 Release
	$(MAKE) -C $(PROJECT_OUTPUT)/projects/gmake-osx config=release32
osx-debug64: $(PROJECT_OUTPUT)/projects/gmake-osx ## Build - OSX x64 Debug
	$(MAKE) -C $(PROJECT_OUTPUT)/projects/gmake-osx config=debug64
osx-release64: $(PROJECT_OUTPUT)/projects/gmake-osx ## Build - OSX x64 Release
	$(MAKE) -C $(PROJECT_OUTPUT)/projects/gmake-osx config=release64
osx: osx-debug32 osx-release32 osx-debug64 osx-release64 ## Build - OSX x86/x64 Debug and Release

$(PROJECT_OUTPUT)/projects/gmake-ios-arm:
	$(GENIE_CMD) --gcc=ios-arm gmake
ios-arm-debug: $(PROJECT_OUTPUT)/projects/gmake-ios-arm ## Build - iOS ARM Debug
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-ios-arm config=debug
ios-arm-release: $(PROJECT_OUTPUT)/projects/gmake-ios-arm ## Build - iOS ARM Release
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-ios-arm config=release
ios-arm: ios-arm-debug ios-arm-release ## Build - iOS ARM Debug and Release

$(PROJECT_OUTPUT)/projects/gmake-ios-arm64:
	$(GENIE_CMD) --gcc=ios-arm64 gmake
ios-arm64-debug: $(PROJECT_OUTPUT)/projects/gmake-ios-arm64 ## Build - iOS ARM64 Debug
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-ios-arm64 config=debug
ios-arm64-release: $(PROJECT_OUTPUT)/projects/gmake-ios-arm64 ## Build - iOS ARM64 Release
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-ios-arm64 config=release
ios-arm64: ios-arm64-debug ios-arm64-release ## Build - iOS ARM64 Debug and Release

$(PROJECT_OUTPUT)/projects/gmake-ios-simulator:
	$(GENIE_CMD) --gcc=ios-simulator gmake
ios-simulator-debug: $(PROJECT_OUTPUT)/projects/gmake-ios-simulator ## Build - iOS Simulator Debug
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-ios-simulator config=debug
ios-simulator-release: $(PROJECT_OUTPUT)/projects/gmake-ios-simulator ## Build - iOS Simulator Release
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-ios-simulator config=release
ios-simulator: ios-simulator-debug ios-simulator-release ## Build - iOS Simulator Debug and Release

$(PROJECT_OUTPUT)/projects/gmake-rpi:
	$(GENIE_CMD) --gcc=rpi gmake
rpi-debug: $(PROJECT_OUTPUT)/projects/gmake-rpi ## Build - RasberryPi Debug
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-rpi config=debug
rpi-release: $(PROJECT_OUTPUT)/projects/gmake-rpi ## Build - RasberryPi Release
	$(MAKE) -R -C $(PROJECT_OUTPUT)/projects/gmake-rpi config=release
rpi: rpi-debug rpi-release ## Build - RasberryPi Debug and Release


# further project target defintions
include $(SELF_DIR)../../scripts/projects.make
