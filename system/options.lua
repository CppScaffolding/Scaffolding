-- options

--- from bgfx/genie.lua

newoption {
	trigger = "with-amalgamated",
	description = "Enable amalgamated build.",
}

newoption {
	trigger = "with-sdl",
	description = "Enable SDL entry.",
}

newoption {
	trigger = "with-glfw",
	description = "Enable GLFW entry.",
}

newoption {
	trigger = "with-profiler",
	description = "Enable build with intrusive profiler.",
}

newoption {
	trigger = "with-scintilla",
	description = "Enable building with Scintilla editor.",
}

newoption {
	trigger = "with-shared-lib",
	description = "Enable building shared library.",
}

newoption {
	trigger = "with-tools",
	description = "Enable building tools.",
}

newoption {
	trigger = "with-combined-examples",
	description = "Enable building examples (combined as single executable).",
}

newoption {
	trigger = "with-examples",
	description = "Enable building examples.",
}

--- own additions
newoption {
	trigger     = "with-unittest",
	description = "add global define WITH_UNIT_TEST to all projects"
}

newoption {
	trigger = "no-ms-compat",
	description = "Disable MS compatibility flag (for vs-clang).",
}

newoption {
	trigger = "only-thirdparty",
	description = "Generate only thirdparty projects in a different solution",
}

---

--- TODO: add this part to your solution
--	if _OPTIONS["no-ms-compat"] ~= nil then
--		configuration { "vs*-clang" }
--			buildoptions {
--				"-fno-ms-compatibility",
--				"-fno-delayed-template-parsing"
--			}
--		configuration {}
--	end
