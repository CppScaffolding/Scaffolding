-- Basic generation functions for scaffolded project types

-------------------------------------------------------------------------------

local scaffoldCppStandard = function(_name, _standard)
	local action = {}
	action['c++03'] = function() end
	action['c++11'] = function() build_cpp11(_name) end
	action['c++14'] = function() build_cpp14(_name) end
	action['c++17'] = function() build_cpp17(_name) end
	action['c++++'] = function() build_cppfwd(_name) end
	print(_name, _standard)
	action[_standard]()
end

local scaffoldCStandard = function(_name, _standard)
	local action = {}
	action['c89'] = function() end
	action['c99'] = function() build_c99(_name) end
	action['c11'] = function() build_c11(_name) end
	print(_name, _standard)
	action[_standard]()
end

-------------------------------------------------------------------------------

scaffoldCppProject = function(_name, _kind, _sourceGroups, _links, _defines, _standard)
	project(_name)
		uuid(os.uuid(_name))
		kind(_kind)
		language 'C++'
		scaffoldCppStandard(_name, _standard)

		configuration {}

		flags {
			COMMON_PROJECT_FLAGS,
		}

		defines {
			COMMON_PROJECT_DEFINES,
			SCAFFOLDING_THIRDPARTY_DEFINES,
			_defines,
		}

		includedirs {
			COMMON_PROJECT_INCLUDEDIRS,
			SCAFFOLDING_THIRDPARTY_INCLUDEDIRS,
		}

		--debugTable("sourcegroups", _sourceGroups)
		for name, sources in pairs(_sourceGroups) do
			--print(sources)
			--debugTable(name, sources)
			files(sources)
			vpaths{
				[name] = sources}
		end

		buildoptions {
			COMMON_PROJECT_BUILDOPTIONS,
		}

		libdirs {
			COMMON_PROJECT_LIBDIRS,
			SCAFFOLDING_THIRDPARTY_LIBDIRS,
		}

		links {
			COMMON_PROJECT_LINKS,
			SCAFFOLDING_THIRDPARTY_LINKS,
			_links
		}

		linkoptions {
			COMMON_PROJECT_LINKOPTIONS,
		}

		configuration {"vs*"}
			buildoptions { "/wd4201", "/wd4100", "/wd4348" }

		configuration {}
end

-------------------------------------------------------------------------------

scaffoldCProject = function(_name, _kind, _sourceGroups, _links, _defines, _standard)
	project(_name)
		uuid(os.uuid(_name))
		kind(_kind)
		language 'C'
		scaffoldCStandard(_name, _standard)

		--print("project", _name)

		configuration {}

		flags {
			COMMON_PROJECT_FLAGS,
		}

		defines {
			COMMON_PROJECT_DEFINES,
			SCAFFOLDING_THIRDPARTY_DEFINES,
			_defines,
		}

		includedirs {
			COMMON_PROJECT_INCLUDEDIRS,
			SCAFFOLDING_THIRDPARTY_INCLUDEDIRS,
		}

		--debugTable("sourcegroups", _sourceGroups)
		for name, sources in pairs(_sourceGroups) do
			--print(sources)
			--debugTable(name, sources)
			files(sources)
			vpaths{
				[name] = sources}
		end

		buildoptions {
			COMMON_PROJECT_BUILDOPTIONS,
		}

		libdirs {
			COMMON_PROJECT_LIBDIRS,
			SCAFFOLDING_THIRDPARTY_LIBDIRS,
		}

		links {
			COMMON_PROJECT_LINKS,
			SCAFFOLDING_THIRDPARTY_LINKS,
			_links
		}

		linkoptions {
			COMMON_PROJECT_LINKOPTIONS,
		}

		configuration {}
end

-------------------------------------------------------------------------------

--! scaffoldLibProject
--! _name: project name
--! _kind: project kind 'StaticLib', 'SharedLib', 'Bundle'
--! _sourceGroups: table mapping group name to sourcefiles: tab['GroupName'] = { sourcefiles }
--! _links: further dependencies: { libs }
--! _defines: preprocessor definitions
--! _standard: standard to compile
function scaffoldLibProject(_name, _kind, _sourceGroups, _links, _defines, _standard, _callback)
	scaffoldCppProject(_name, _kind, _sourceGroups, _links, _defines, _standard)

	if _callback ~= nil then
		_callback()
	end
end

----

--! scaffoldBinProject
--! _name: project name
--! _kind: project kind 'ConsoleApp', 'WindowedApp'
--! _sourceGroups: table mapping group name to sourcefiles: tab['GroupName'] = { sourcefiles }
--! _links: further dependencies: { libs }
--! _defines: optional defines: {"define"}
--! _standard: standard to compile
function scaffoldBinProject(_name, _kind, _sourceGroups, _links, _defines, _standard, _callback)
	scaffoldCppProject(_name, _kind, _sourceGroups, _links, _defines, _standard)

	configuration { "vs*" }
		buildoptions { "/wd4201", "/wd4100", "/wd4348" }
		linkoptions { "/ENTRY:mainCRTStartup" }

	configuration { "vs* or mingw*" }
		links {
			"ws2_32",
		}

	if _OPTIONS["with-openssl"] then
		configuration { "x32", "vs*" }
			libdirs { path.join(BNET_DIR, "3rdparty/openssl/lib/win32_", _ACTION, "lib") }

		configuration { "x64", "vs*" }
			libdirs { path.join(BNET_DIR, "3rdparty/openssl/lib/win64_", _ACTION, "lib") }

		configuration { "vs* or mingw*" }
			links {
				"libeay32",
				"ssleay32",
			}
	end

	configuration { "android*" }
		kind "ConsoleApp"
		targetextension ".so"
		linkoptions {
			"-shared",
		}

	configuration { "nacl or nacl-arm" }
		kind "ConsoleApp"
		targetextension ".nexe"
		links {
			"ppapi",
			"pthread",
		}

	configuration { "pnacl" }
		kind "ConsoleApp"
		targetextension ".pexe"
		links {
			"ppapi",
			"pthread",
		}

	configuration { "osx" }
		linkoptions {
			"-framework Cocoa",
			"-framework CoreFoundation",
			"-framework Foundation",
			"-framework CoreGraphics",
			"-framework OpenGL",
			"-framework Metal",
			"-framework CoreVideo",
			"-framework IOKit",
			"-framework QuartzCore",
			"-framework OpenGL",
			"-framework OpenAL",
			"-framework OpenCL",
			"-framework Accelerate",
			"-framework Security",
		}

	configuration { "ios*" }
		kind "ConsoleApp"
		linkoptions {
			"-framework CoreFoundation",
			"-framework Foundation",
			"-framework UIKit",
			"-framework QuartzCore",
			"-framework Metal",
			"-framework OpenGLES",
			"-framework Security",
		}

	configuration {}
	strip()

	if _callback ~= nil then
		_callback()
	end
end

----


--! scaffoldCLibProject
--! _name: project name
--! _kind: project kind 'StaticLib', 'SharedLib', 'Bundle'
--! _sourceGroups: table mapping group name to sourcefiles: tab['GroupName'] = { sourcefiles }
--! _links: further dependencies: { libs }
--! _defines: preprocessor definitions
--! _standard: standard to compile
function scaffoldCLibProject(_name, _kind, _sourceGroups, _links, _defines, _standard, _callback)
	scaffoldCProject(_name, _kind, _sourceGroups, _links, _defines, _standard)

	if _callback ~= nil then
		_callback()
	end
end

----

--! scaffoldCBinProject
--! _name: project name
--! _kind: project kind 'ConsoleApp', 'WindowedApp'
--! _sourceGroups: table mapping group name to sourcefiles: tab['GroupName'] = { sourcefiles }
--! _links: further dependencies: { libs }
--! _defines: optional defines: {"define"}
--! _standard: standard to compile
function scaffoldCBinProject(_name, _kind, _sourceGroups, _links, _defines, _standard, _callback)
	scaffoldCProject(_name, _kind, _sourceGroups, _links, _defines, _standard)

	configuration { "vs*" }
		buildoptions { "/wd4201", "/wd4100", "/wd4348" }
		linkoptions { "/ENTRY:mainCRTStartup" }

	configuration { "vs* or mingw*" }
		links {
			"ws2_32",
		}

	if _OPTIONS["with-openssl"] then
		configuration { "x32", "vs*" }
			libdirs { path.join(BNET_DIR, "3rdparty/openssl/lib/win32_", _ACTION, "lib") }

		configuration { "x64", "vs*" }
			libdirs { path.join(BNET_DIR, "3rdparty/openssl/lib/win64_", _ACTION, "lib") }

		configuration { "vs* or mingw*" }
			links {
				"libeay32",
				"ssleay32",
			}
	end

	configuration { "android*" }
		kind "ConsoleApp"
		targetextension ".so"
		linkoptions {
			"-shared",
		}

	configuration { "nacl or nacl-arm" }
		kind "ConsoleApp"
		targetextension ".nexe"
		links {
			"ppapi",
			"pthread",
		}

	configuration { "pnacl" }
		kind "ConsoleApp"
		targetextension ".pexe"
		links {
			"ppapi",
			"pthread",
		}

	configuration { "osx" }
		linkoptions {
			"-framework Cocoa",
			"-framework CoreFoundation",
			"-framework Foundation",
			"-framework CoreGraphics",
			"-framework Metal",
			"-framework Security",
		}

	configuration { "ios*" }
		kind "ConsoleApp"
		linkoptions {
			"-framework CoreFoundation",
			"-framework Foundation",
			"-framework UIKit",
			"-framework QuartzCore",
			"-framework Security",
		}

	configuration {}
	strip()

	if _callback ~= nil then
		_callback()
	end
end

---
