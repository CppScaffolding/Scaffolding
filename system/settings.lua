-- global static settings (defaults)

-- script folders
 
if SCAFFOLDING_DIR == nil then
	SCAFFOLDING_DIR = path.getabsolute("..")
end
if SCAFFOLDING_THIRDPARTY_DIR == nil then
	SCAFFOLDING_THIRDPARTY_DIR = path.join(SCAFFOLDING_DIR, "thirdparty")
end
if SCAFFOLDING_TOOLS_DIR == nil then
	SCAFFOLDING_TOOLS_DIR = path.join(SCAFFOLDING_DIR, "tools")
end
if SCAFFOLDING_CANARIES_DIR == nil then
	SCAFFOLDING_CANARIES_DIR = path.join(SCAFFOLDING_DIR, "canaries")
end

-- target folders

if PROJECT_ROOT == nil then 
	PROJECT_ROOT = path.getabsolute("../..")
end
if PROJECT_BUILD_DIR == nil then 
	PROJECT_BUILD_DIR = path.join(PROJECT_ROOT, ".build")
end
if PROJECT_SOURCE_DIR == nil then 
	PROJECT_SOURCE_DIR = path.join(PROJECT_ROOT, "src")
end

-- global tables
if SCAFFOLDING_THIRDPARTY_INCLUDEDIRS == nil then
	SCAFFOLDING_THIRDPARTY_INCLUDEDIRS = {}
end
if SCAFFOLDING_THIRDPARTY_LIBDIRS == nil then
	SCAFFOLDING_THIRDPARTY_LIBDIRS = {}
end
if SCAFFOLDING_THIRDPARTY_LINKS == nil then
	SCAFFOLDING_THIRDPARTY_LINKS = {}
end
if SCAFFOLDING_THIRDPARTY_DEFINES == nil then
	SCAFFOLDING_THIRDPARTY_DEFINES = {}
end

if COMMON_PROJECT_INCLUDEDIRS == nil then
	COMMON_PROJECT_INCLUDEDIRS = {}
end

if COMMON_PROJECT_LIBDIRS == nil then
	COMMON_PROJECT_LIBDIRS = {}
end
if COMMON_PROJECT_LINKS == nil then
	COMMON_PROJECT_LINKS = {}
end

if COMMON_PROJECT_DEFINES == nil then
	COMMON_PROJECT_DEFINES = {}
end
if COMMON_PROJECT_FLAGS == nil then
	COMMON_PROJECT_FLAGS = {
	--'ExtraWarnings',
	--'FatalWarnings',
	--'FloatFast',	--'FloatStrict'
	--'Unicode',
	--'Exceptions',
	}
end

if COMMON_PROJECT_BUILDOPTIONS == nil then
	COMMON_PROJECT_BUILDOPTIONS = {}
end

if COMMON_PROJECT_LINKOPTIONS == nil then
	COMMON_PROJECT_LINKOPTIONS = {}
end


--- language-specific compiler settings

--- C++ options

-- C++11 settings
cpp11_buildoptions = {
	clang = {
		"-std=c++11",
	},
	vs = {
		"/std:c++11"
	}
}

cpp11_linkoptions = {
	clang = {
		"-stdlib=libc++",
	},
	vs = {

	}
}

-- C++14 settings
cpp14_buildoptions = {
	clang = {
		"-std=c++14",
	},
	vs = {
		"/std:c++14"
	}
}

cpp14_linkoptions = {
	clang = {
		"-stdlib=libc++",
	},
	vs = {

	}
}

-- C++17 settings
cpp17_buildoptions = {
	clang = {
		"-std=c++1z",
	},
	vs = {
		"/std:c++latest"
	}
}

cpp17_linkoptions = {
	clang = {
		"-stdlib=libc++",
	},
	vs = {

	}
}

-- forward-compatible C++XY settings
-- i.e. aliasing for single place to change
cpp_fwd_buildoptions = cpp14_buildoptions
cpp_fwd_linkoptions = cpp14_linkoptions

--- C options (K&R C language)

-- C99 settings
c99_buildoptions = {
	clang = {
		"-std=c99",
	},
	vs = {

	}
}

c99_linkoptions = {
	clang = {},
	vs = {},
}

-- C11 settings 
c11_buildoptions = {
	clang = {
		"-std=c11",
	},
	vs = {

	}
}

c11_linkoptions = {
	clang = {},
	vs = {},
}

---

force_buildoptions = function(_project, _buildoptions, _linkoptions)
	project (_project)

	configuration {}
	
	configuration { "linux-steamlink" }
		buildoptions { _buildoptions.clang, }
		linkoptions { _linkoptions.clang, }

	configuration { "linux-gcc* or linux-clang*" }
		buildoptions { _buildoptions.clang, }
		linkoptions { _linkoptions.clang, }

	configuration { "vs*-clang" }
		buildoptions { _buildoptions.clang, }
		linkoptions { _linkoptions.clang, }

	configuration { "asmjs" }
		buildoptions { _buildoptions.clang, }
		linkoptions { _linkoptions.clang, }

	configuration { "mingw-*" }
		buildoptions { _buildoptions.clang, }
		linkoptions { _linkoptions.clang, }

	configuration { "linux-gcc" }
		buildoptions { _buildoptions.clang, }
		linkoptions { _linkoptions.clang, }

	configuration { "linux-mips-gcc" }
		buildoptions { _buildoptions.clang, }
		linkoptions { _linkoptions.clang, }

	configuration { "linux-arm-gcc" }
		buildoptions { _buildoptions.clang, }
		linkoptions { _linkoptions.clang, }

	configuration { "android-*" }
		buildoptions { _buildoptions.clang, }
		linkoptions { _linkoptions.clang, }

	configuration { "osx" }
		buildoptions { _buildoptions.clang, }
		linkoptions { _linkoptions.clang, }

	configuration { "ios*" }
		buildoptions { _buildoptions.clang, }
		linkoptions { _linkoptions.clang, }

	configuration { "orbis" }
		buildoptions { _buildoptions.clang, }
		linkoptions { _linkoptions.clang, }

	configuration { "qnx-arm" }
		buildoptions { _buildoptions.clang, }
		linkoptions { _linkoptions.clang, }

	configuration { "rpi" }
		buildoptions { _buildoptions.clang, }
		linkoptions { _linkoptions.clang, }

	configuration { "riscv" }
		buildoptions { _buildoptions.clang, }
		linkoptions { _linkoptions.clang, }


	configuration { "vs* and not vs*-clang" }
		buildoptions { _buildoptions.vs, }
		linkoptions { _linkoptions.vs, }
	configuration {}
end

---

force_cppbuildoptions = function(_project, _buildoptions, _linkoptions)
	project (_project)

	configuration {}
	
	configuration { "linux-steamlink" }
		buildoptions_cpp { _buildoptions.clang, }
		linkoptions { _linkoptions.clang, }

	configuration { "linux-gcc* or linux-clang*" }
		buildoptions_cpp { _buildoptions.clang, }
		linkoptions { _linkoptions.clang, }

	configuration { "asmjs" }
		buildoptions_cpp { _buildoptions.clang, }
		linkoptions { _linkoptions.clang, }

	configuration { "mingw-*" }
		buildoptions_cpp { _buildoptions.clang, }
		linkoptions { _linkoptions.clang, }

	configuration { "linux-gcc" }
		buildoptions_cpp { _buildoptions.clang, }
		linkoptions { _linkoptions.clang, }

	configuration { "linux-mips-gcc" }
		buildoptions_cpp { _buildoptions.clang, }
		linkoptions { _linkoptions.clang, }

	configuration { "linux-arm-gcc" }
		buildoptions_cpp { _buildoptions.clang, }
		linkoptions { _linkoptions.clang, }

	configuration { "android-*" }
		buildoptions_cpp { _buildoptions.clang, }
		linkoptions { _linkoptions.clang, }

	configuration { "osx" }
		buildoptions_cpp { _buildoptions.clang, }
		linkoptions { _linkoptions.clang, }

	configuration { "ios*" }
		buildoptions_cpp { _buildoptions.clang, }
		linkoptions { _linkoptions.clang, }

	configuration { "orbis" }
		buildoptions_cpp { _buildoptions.clang, }
		linkoptions { _linkoptions.clang, }

	configuration { "qnx-arm" }
		buildoptions_cpp { _buildoptions.clang, }
		linkoptions { _linkoptions.clang, }

	configuration { "rpi" }
		buildoptions_cpp { _buildoptions.clang, }
		linkoptions { _linkoptions.clang, }

	configuration { "riscv" }
		buildoptions_cpp { _buildoptions.clang, }
		linkoptions { _linkoptions.clang, }


	configuration { "vs* and not vs*-clang" }
		buildoptions_cpp { _buildoptions.vs, }
		linkoptions { _linkoptions.vs, }

	configuration { "vs*-clang" }
		buildoptions_cpp { _buildoptions.vs, }
		linkoptions { _linkoptions.vs, }

	configuration {}
end

---

build_cpp11 = function(_project)
	force_cppbuildoptions(_project, cpp11_buildoptions, cpp11_linkoptions)
end

build_cpp14 = function(_project)
	force_cppbuildoptions(_project, cpp14_buildoptions, cpp14_linkoptions)
end

build_cpp17 = function(_project)
	force_cppbuildoptions(_project, cpp17_buildoptions, cpp17_linkoptions)
end


build_cppfwd = function(_project)
	force_cppbuildoptions(_project, cpp_fwd_buildoptions, cpp_fwd_linkoptions)
end

---


---

build_c99 = function(_project)
	force_buildoptions(_project, c99_buildoptions, c99_linkoptions)
end

---

build_c11 = function(_project)
	force_buildoptions(_project, c11_buildoptions, c11_linkoptions)
end

---

