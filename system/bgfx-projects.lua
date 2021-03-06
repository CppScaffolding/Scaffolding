-- functions to create projects

BGFX_INCLUDEDIRS = {
	path.join(BX_DIR,   "include"),
	path.join(BGFX_DIR, "include"),
	path.join(BGFX_DIR, "3rdparty"),
	path.join(BGFX_DIR, "examples/common"),
}


function addBgfxProjectSettings(project)

end

function bgfxExampleProject(_name)

	project ("example-" .. _name)
		uuid (os.uuid("example-" .. _name))
		kind "WindowedApp"

	configuration {}

	debugdir(path.join(BGFX_DIR, "examples/runtime"))

	includedirs {
		--path.join(BX_DIR,   "include"),
		--path.join(BGFX_DIR, "include"),
		--path.join(BGFX_DIR, "3rdparty"),
		--path.join(BGFX_DIR, "examples/common"),
		BGFX_INCLUDEDIRS,
	}

	files {
		path.join(BGFX_DIR, "examples", _name, "**.c"),
		path.join(BGFX_DIR, "examples", _name, "**.cpp"),
		path.join(BGFX_DIR, "examples", _name, "**.h"),
	}

	removefiles {
		path.join(BGFX_DIR, "examples", _name, "**.bin.h"),
	}

	links {
		"bgfx",
		"example-common",
	}

	if _OPTIONS["with-glfw"] then
		defines { "ENTRY_CONFIG_USE_GLFW=1" }
		links   {
			"glfw3"
		}

		configuration { "linux or freebsd" }
			links {
				"Xrandr",
				"Xinerama",
				"Xi",
				"Xxf86vm",
				"Xcursor",
			}

		configuration { "osx" }
			linkoptions {
				"-framework CoreVideo",
				"-framework IOKit",
			}

		configuration {}
	end

	if _OPTIONS["with-ovr"] then
		links   {
			"winmm",
			"ws2_32",
		}

		-- Check for LibOVR 5.0+
		if os.isdir(path.join(os.getenv("OVR_DIR"), "LibOVR/Lib/Windows/Win32/Debug/VS2012")) then

			configuration { "x32", "Debug" }
				libdirs { path.join("$(OVR_DIR)/LibOVR/Lib/Windows/Win32/Debug", _ACTION) }

			configuration { "x32", "Release" }
				libdirs { path.join("$(OVR_DIR)/LibOVR/Lib/Windows/Win32/Release", _ACTION) }

			configuration { "x64", "Debug" }
				libdirs { path.join("$(OVR_DIR)/LibOVR/Lib/Windows/x64/Debug", _ACTION) }

			configuration { "x64", "Release" }
				libdirs { path.join("$(OVR_DIR)/LibOVR/Lib/Windows/x64/Release", _ACTION) }

			configuration { "x32 or x64" }
				links { "libovr" }
		else
			configuration { "x32" }
				libdirs { path.join("$(OVR_DIR)/LibOVR/Lib/Win32", _ACTION) }

			configuration { "x64" }
				libdirs { path.join("$(OVR_DIR)/LibOVR/Lib/x64", _ACTION) }

			configuration { "x32", "Debug" }
				links { "libovrd" }

			configuration { "x32", "Release" }
				links { "libovr" }

			configuration { "x64", "Debug" }
				links { "libovr64d" }

			configuration { "x64", "Release" }
				links { "libovr64" }
		end

		configuration {}
	end

	configuration { "vs*" }
		linkoptions {
			"/ignore:4199", -- LNK4199: /DELAYLOAD:*.dll ignored; no imports found from *.dll
		}
		links { -- this is needed only for testing with GLES2/3 on Windows with VS2008
			"DelayImp",
		}

	configuration { "vs201*" }
		linkoptions { -- this is needed only for testing with GLES2/3 on Windows with VS201x
			"/DELAYLOAD:\"libEGL.dll\"",
			"/DELAYLOAD:\"libGLESv2.dll\"",
		}

	configuration { "mingw*" }
		targetextension ".exe"

	configuration { "vs20* or mingw*" }
		links {
			"gdi32",
			"psapi",
		}

	configuration { "winphone8* or winstore8*" }
		removelinks {
			"DelayImp",
			"gdi32",
			"psapi"
		}
		links {
			"d3d11",
			"dxgi"
		}
		linkoptions {
			"/ignore:4264" -- LNK4264: archiving object file compiled with /ZW into a static library; note that when authoring Windows Runtime types it is not recommended to link with a static library that contains Windows Runtime metadata
		}

	-- WinRT targets need their own output directories or build files stomp over each other
	configuration { "x32", "winphone8* or winstore8*" }
		targetdir (path.join(BGFX_BUILD_DIR, "win32_" .. _ACTION, "bin", _name))
		objdir (path.join(BGFX_BUILD_DIR, "win32_" .. _ACTION, "obj", _name))

	configuration { "x64", "winphone8* or winstore8*" }
		targetdir (path.join(BGFX_BUILD_DIR, "win64_" .. _ACTION, "bin", _name))
		objdir (path.join(BGFX_BUILD_DIR, "win64_" .. _ACTION, "obj", _name))

	configuration { "ARM", "winphone8* or winstore8*" }
		targetdir (path.join(BGFX_BUILD_DIR, "arm_" .. _ACTION, "bin", _name))
		objdir (path.join(BGFX_BUILD_DIR, "arm_" .. _ACTION, "obj", _name))

	configuration { "mingw-clang" }
		kind "ConsoleApp"

	configuration { "android*" }
		kind "ConsoleApp"
		targetextension ".so"
		linkoptions {
			"-shared",
		}
		links {
			"EGL",
			"GLESv2",
		}

	configuration { "nacl*" }
		kind "ConsoleApp"
		targetextension ".nexe"
		links {
			"ppapi",
			"ppapi_gles2",
			"pthread",
		}

	configuration { "pnacl" }
		kind "ConsoleApp"
		targetextension ".pexe"
		links {
			"ppapi",
			"ppapi_gles2",
			"pthread",
		}

	configuration { "asmjs" }
		kind "ConsoleApp"
		targetextension ".bc"

	configuration { "linux-* or freebsd" }
		links {
			"X11",
			"GL",
			"pthread",
		}

	configuration { "rpi" }
		links {
			"X11",
			"GLESv2",
			"EGL",
			"bcm_host",
			"vcos",
			"vchiq_arm",
			"pthread",
		}

	configuration { "osx" }
		linkoptions {
			"-framework Cocoa",
			"-framework Metal",
			"-framework QuartzCore",
			"-framework OpenGL",
		}

	configuration { "ios* or tvos*" }
		kind "ConsoleApp"
		linkoptions {
			"-framework CoreFoundation",
			"-framework Foundation",
			"-framework Metal",
			"-framework OpenGLES",
			"-framework UIKit",
			"-framework QuartzCore",
		}

	configuration { "xcode*", "ios" }
		kind "WindowedApp"
		files {
			path.join(BGFX_DIR, "examples/runtime/iOS-Info.plist"),
		}

	configuration { "xcode*", "tvos" }
		kind "WindowedApp"
		files {
			path.join(BGFX_DIR, "examples/runtime/tvOS-Info.plist"),
		}

	configuration { "qnx*" }
		targetextension ""
		links {
			"EGL",
			"GLESv2",
		}

	configuration {}

	strip()
end
