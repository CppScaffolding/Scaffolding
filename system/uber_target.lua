-- UBER Target project
-- dummy project that has dependencies on all other projects in the solution
-- BUILD_ALL target


group "__all"

local sln = solution()
local prjs = sln.projects
for i, prj in ipairs(prjs) do
end

project("__all_targets")
	kind("SharedLib")
	configuration {}
	files {}
	for _, prj in ipairs(prjs) do
	    print("all targets: ", prj.name)		
    	links{
			(prj.name)
		}
	end

