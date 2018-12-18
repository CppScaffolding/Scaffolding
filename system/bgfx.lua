-- sub-section to add bgfx projects
dofile "bgfx-settings.lua"

if not toolchain(BGFX_BUILD_DIR, BGFX_THIRD_PARTY_DIR) then
    return -- no action specified
end

function copyLib()
end


group "bgfx"
dofile(path.join(BGFX_DIR, "scripts/bgfx.lua"))
bgfxProject("", "StaticLib", {})
if _OPTIONS["with-shared-lib"] ~= nil then
    --bgfxProject("-shared-lib", "SharedLib", {})
end

dofile "bgfx-projects.lua"

group "bgfx-examples"
dofile(path.join(BGFX_DIR, "scripts/example-common.lua"))
bgfxExampleProject("00-helloworld")
bgfxExampleProject("01-cubes")
bgfxExampleProject("02-metaballs")
bgfxExampleProject("03-raymarch")
bgfxExampleProject("04-mesh")
bgfxExampleProject("05-instancing")
bgfxExampleProject("06-bump")
bgfxExampleProject("07-callback")
bgfxExampleProject("08-update")
bgfxExampleProject("09-hdr")
bgfxExampleProject("10-font")
bgfxExampleProject("11-fontsdf")
bgfxExampleProject("12-lod")
bgfxExampleProject("13-stencil")
bgfxExampleProject("14-shadowvolumes")
bgfxExampleProject("15-shadowmaps-simple")
bgfxExampleProject("16-shadowmaps")
bgfxExampleProject("17-drawstress")
bgfxExampleProject("18-ibl")
bgfxExampleProject("19-oit")
bgfxExampleProject("20-nanovg")
bgfxExampleProject("21-deferred")
bgfxExampleProject("22-windows")
bgfxExampleProject("23-vectordisplay")
bgfxExampleProject("24-nbody")
-- C99 source doesn't compile under WinRT settings
if not premake.vstudio.iswinrt() then
    bgfxExampleProject("25-c99")
end

if _OPTIONS["with-tools"] then
    group "bgfx-tools"
    dofile(path.join(BGFX_DIR, "scripts/makedisttex.lua"))
    dofile(path.join(BGFX_DIR, "scripts/shaderc.lua"))
    dofile(path.join(BGFX_DIR, "scripts/texturec.lua"))
    dofile(path.join(BGFX_DIR, "scripts/geometryc.lua"))
end
