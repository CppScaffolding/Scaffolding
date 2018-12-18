-- functions

require "ansicolors"

function colorize(clr, txt)
	return clr .. txt .. ansicolors.reset
end

function clone(t) -- deep-copy a table
	if type(t) ~= "table" then return t end
	local meta = getmetatable(t)
	local target = {}
	for k, v in pairs(t) do
		if type(v) == "table" then
			target[k] = clone(v)
		else
			target[k] = v
		end
	end
	setmetatable(target, meta)
	return target
end

-- avalon helper functions

function isMacBuild()
	return _ACTION:match('xcode[0-9]')
		or _OPTIONS["gcc"] == 'osx'
end

function isIosBuild()
	return _ACTION:match('xcode[0-9]')
		or _OPTIONS["gcc"] == 'ios'
end


function isWinBuild()
	return _ACTION:match('vs[0-9]')
end


function isLinuxBuild()
	return  _ACTION:match('gmake')
		and os.is('linux')
end
----

-- special function to set define macros with string values
function stringMacroDeclaration(name, value)
	if _ACTION:match('xcode[0-9]') then
		return string.format('%s=\'"%s"\'', name, value)
	elseif _ACTION:match('gmake') then
		return string.format('%s=\'"%s"\'', name, value)
	else
		return string.format('%s=%s', name, value)
	end
end

----

function correctPath(oldPath)
	local prj = project()
	local prjdir = os.getcwd()
	if prj ~= nil then
		prjdir = prj.basedir
	end

	local sln = solution()
	local slndir = sln.basedir

	if type(oldPath) == 'table' then
		local newPaths = {}
		for i, p in pairs(oldPath) do
			table.insert(newPaths, correctPath(p))
		end
		return newPaths
	elseif oldPath == nil then
		return nil
	else
		local pathFromSlndir = slndir .. "/" .. oldPath
		local rep = path.getrelative(prjdir, pathFromSlndir)
		--printf("rebased path: "..p.." -> "..rep)
		return rep
	end
end

----

function currentDir()
	local sln = solution()
	local slndir = sln.basedir
	return path.getrelative(slndir, os.getcwd())
end

----

function printTable(t)
	if t == nil then
		printf('nil table')
		return
	end
	if tableSize(t) == 0 then
		printf('empty table')
		return
	end
	print(t)
	for k,v in pairs(t) do
		print(colorize(ansicolors.green, k), v)
	end
end

function printTableReq(t)
	local function rr(tt)
		if tt == nil then
			printf('nil table')
			return
		end
		if tableSize(tt) == 0 then
			printf('empty table')
			return
		end
		print(tt)
		if type(tt) == 'table' then
			rr(tt)
		else
			for k,v in pairs(tt) do
				print(colorize(ansicolors.green, k), v)
			end
		end
	end
	rr(t)
end


function debugTable(name, t)
	print(colorize(ansicolors.yellow, name))
	printTable(t)
end

function debugTableReq(name, t)
	print(colorize(ansicolors.yellow, name))
	printTableReq(t)
end
----

function mergeTables(t1, t2)
	if t2 then
		for i, p in pairs(t2) do
			table.insert(t1, p)
		end
	end
	return t1
end

---

function flattenTable(t)
	local result = { }

	local function flatten(t)
		for _, v in pairs(t) do
			if type(v) == "table" then
				flatten(v)
			else
				table.insert(result, v)
			end
		end
	end

	flatten(t)
	return result
end

---

function joinTables(...)
	local result = { }
	for _,t in pairs(arg) do
		if type(t) == "table" then
			for _,v in pairs(t) do
				table.insert(result, v)
			end
		else
			table.insert(result, t)
		end
	end
	return result
end

---

----

function tableSize(t)
	local count = 0
	for i, p in pairs(t) do
		count = count + 1
	end
	return count
end
----

function flatC(filename)
	local flatc = path.join(SCAFFOLDING_TOOLS_DIR, "_flatc.sh")
	local cmd = flatc .. " " .. filename .. " ."
	printf(cmd)
	os.execute(cmd)
end

---

function gatherDynLibs_postbuildcommands(_searchDirs)
	local cfg = configuration()

	sd = cfg.libdirs
	for _, dirs in pairs(_searchDirs) do
		mergeTables(sd, dirs)
	end

	for _, lib in pairs(cfg.links) do
		for _, libdir in pairs(sd) do
			libfile = path.join(libdir, lib)
			if isWinBuild() then
				libfile = libfile .. ".dll"
			elseif isMacBuild() or isIosBuild() then
				libfile = libfile .. ".dylib"
			elseif isLinuxBuild() then
				libfile = libfile .. ".so"
			end
			--print("searching", libfile)

			absfile = path.getabsolute(libfile)
			if os.isfile(absfile) then
				if isWinBuild() then
					postbuildcommands { "copy " .. absfile .. " " .. cfg.targetdir }
				else
					postbuildcommands { "cp " .. absfile .. " " .. cfg.targetdir }
				end
			end
		end
	end
end

---
-- Lua implementation of PHP scandir function

function scandir(directory)
	local i, t, popen = 0, {}, io.popen
	local pfile = popen(iif(os.is("windows"), 'dir /b /a "'..directory..'"', 'ls -a "'..directory..'"'))
	for filename in pfile:lines() do
		i = i + 1
		t[i] = filename
	end
	pfile:close()
	return t
end


---
--

function fixup_bin_extension(terms, ext)
	debugTable("terms", terms)

	local cfg = configuration(terms)
	debugTable("cfg.terms", cfg.terms)
	print("cfg.kind", cfg.kind)

	for _, cc in pairs(configurations()) do
		debugTable("cc", cc)
		print("cc.kind", cc.kind)
		if cc.kind == "ConsoleApp" then
			configuration {terms, cc}
				targetextension (ext)
		end
	end


	configuration {}
end

---

-- iterates of list of project files in given folder

function do_project_files_obsolete(_folder, _projects)
	if _projects then
		for _, pf in pairs(_projects) do
			dofile(path.join(_folder, pf))
		end
	end
end

-- packages are scaffolding v2 luafiles
-- add package settings to current project
function add_packages(_packages)
	if _packages then
		for _, pkg in pairs(_packages) do
			-- explicitely NOT checking for nil pkg in order to fail!
			pkg._add_includedirs()
			pkg._add_defines()

			configuration { "not StaticLib" }
				pkg._add_libdirs()
				pkg._add_external_links()
				pkg._add_self_links()
			configuration {}
		end
	end
end

-- add package header + define settings to current project
function add_packages_headers(_packages)
	if _packages then
		for _, pkg in pairs(_packages) do
			-- explicitely NOT checking for nil pkg in order to fail!
			pkg._add_includedirs()
			pkg._add_defines()
		end
	end
end

-- creates projects for packages
function create_packages_projects(_packages)
	if _packages then
		for k, pkg in pairs(_packages) do
			-- explicitely NOT checking for nil pkg in order to fail!
			print('creating projects for package', colorize(ansicolors.cyan, k))
			pkg._create_projects()
		end
	end
end

---

function filter_non_unitbuild_sources(_sourceGroups, _unitbuildFileTag, _softExclude)
	local result = { }
	for _,g in pairs(flattenTable(_sourceGroups)) do
		for __,f in pairs(os.matchfiles(g)) do
			if not string.match(f, '(.*)('.. _unitbuildFileTag ..').(.*)') then
				table.insert(result, f)
			end
		end
	end

	if _softExclude == true then
		excludes { result }
	else
		removefiles { result }
	end
end

---
