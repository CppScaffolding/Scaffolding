#!/bin/bash

path="${1-src}"

script_dir=`dirname $BASH_SOURCE`

echo "fixing encoding on $path"
#find -X $path -name "*.inl" -exec $script_dir/tools/bin/darwin/nkf -w8XZ0Lw --oc=w8 --in-place --overwrite {} \;
#find -X $path -name "*.cpp" -exec $script_dir/tools/bin/darwin/nkf -w8XZ0Lw --oc=w8 --in-place --overwrite {} \;
#find -X $path -name "*.c" -exec $script_dir/tools/bin/darwin/nkf -w8XZ0Lw --oc=w8 --in-place --overwrite {} \;
#find -X $path -name "*.h" -exec $script_dir/tools/bin/darwin/nkf -w8XZ0Lw --oc=w8 --in-place --overwrite {} \;
#find -X $path -name "*.hpp" -exec $script_dir/tools/bin/darwin/nkf -w8XZ0Lw --oc=w8 --in-place --overwrite {} \;
#find -X $path -name "*.vs" -exec $script_dir/tools/bin/darwin/nkf -w8XZ0Lw --oc=w8 --in-place --overwrite {} \;
#find -X $path -name "*.ps" -exec $script_dir/tools/bin/darwin/nkf -w8XZ0Lw --oc=w8 --in-place --overwrite {} \;
#find -X $path -name "*.gs" -exec $script_dir/tools/bin/darwin/nkf -w8XZ0Lw --oc=w8 --in-place --overwrite {} \;
#find -X $path -name "*.cg" -exec $script_dir/tools/bin/darwin/nkf -w8XZ0Lw --oc=w8 --in-place --overwrite {} \;
#find -X $path -name "*.glsl" -exec $script_dir/tools/bin/darwin/nkf -w8XZ0Lw --oc=w8 --in-place --overwrite {} \;
#find -X $path -name "*.fbs" -exec $script_dir/tools/bin/darwin/nkf -w8XZ0Lw --oc=w8 --in-place --overwrite {} \;
##find -X $path -name "*.cs" -exec $script_dir/tools/bin/darwin/nkf -w8XZ0Lw --oc=w8 --in-place --overwrite {} \;

echo "mimic --reverse $path"
##find -X $path -name "*.inl" -exec mimic --check {} \;
##find -X $path -name "*.cpp" -exec mimic --check {} \;
##find -X $path -name "*.c" -exec mimic --check {} \;
##find -X $path -name "*.h" -exec mimic --check {} \;
##find -X $path -name "*.hpp" -exec mimic --check {} \;
##find -X $path -name "*.vs" -exec mimic --check {} \;
##find -X $path -name "*.ps" -exec mimic --check {} \;
##find -X $path -name "*.gs" -exec mimic --check {} \;
##find -X $path -name "*.cg" -exec mimic --check {} \;
##find -X $path -name "*.glsl" -exec mimic --check {} \;
###find -X $path -name "*.fbs" -exec mimic --check {} \;
###find -X $path -name "*.cs" -exec mimic --check {} \;

echo "formatting $path"
#find -X $path -name "*.inl" -exec clang-format -style=file -i {} \;
#find -X $path -name "*.cpp" -exec clang-format -style=file -i {} \;
#find -X $path -name "*.c" -exec clang-format -style=file -i {} \;
#find -X $path -name "*.h" -exec clang-format -style=file -i {} \;
#find -X $path -name "*.hpp" -exec clang-format -style=file -i {} \;
#find -X $path -name "*.vs" -exec clang-format -style=file -i {} \;
#find -X $path -name "*.ps" -exec clang-format -style=file -i {} \;
#find -X $path -name "*.gs" -exec clang-format -style=file -i {} \;
#find -X $path -name "*.cg" -exec clang-format -style=file -i {} \;
#find -X $path -name "*.glsl" -exec clang-format -style=file -i {} \;
#find -X $path -name "*.fbs" -exec clang-format -style=file -i {} \;
##find -X $path -name "*.cs" -exec clang-format -style=file -style=$script_dir/.clang-format -i {} \;

echo "fixing line endings on $path"
#find -X $path -name "*.inl" -exec sed -f fix_newlines.sed -i '' {} \;
#find -X $path -name "*.cpp" -exec sed -f fix_newlines.sed -i '' {} \;
#find -X $path -name "*.c" -exec sed -f fix_newlines.sed -i '' {} \;
#find -X $path -name "*.h" -exec sed -f fix_newlines.sed -i '' {} \;
#find -X $path -name "*.hpp" -exec sed -f fix_newlines.sed -i '' {} \;
#find -X $path -name "*.vs" -exec sed -f fix_newlines.sed -i '' {} \;
#find -X $path -name "*.ps" -exec sed -f fix_newlines.sed -i '' {} \;
#find -X $path -name "*.gs" -exec sed -f fix_newlines.sed -i '' {} \;
#find -X $path -name "*.cg" -exec sed -f fix_newlines.sed -i '' {} \;
#find -X $path -name "*.glsl" -exec sed -f fix_newlines.sed -i '' {} \;
#find -X $path -name "*.fbs" -exec sed -f fix_newlines.sed -i '' {} \;
##find -X $path -name "*.cs" -exec sed -f fix_newlines.sed -i '' {} \;

echo "fixing file rights on $path"
#find -X $path -name "*.inl" -exec chmod 664 {} \;
#find -X $path -name "*.cpp" -exec chmod 664 {} \;
#find -X $path -name "*.c" -exec chmod 664 {} \;
#find -X $path -name "*.h" -exec chmod 664 {} \;
#find -X $path -name "*.hpp" -exec chmod 664 {} \;
#find -X $path -name "*.vs" -exec chmod 664 {} \;
#find -X $path -name "*.ps" -exec chmod 664 {} \;
#find -X $path -name "*.gs" -exec chmod 664 {} \;
#find -X $path -name "*.cg" -exec chmod 664 {} \;
#find -X $path -name "*.glsl" -exec chmod 664 {} \;
#find -X $path -name "*.fbs" -exec chmod 664 {} \;
##find -X $path -name "*.cs" -exec chmod 664 {} \;

find -X $path -name "*.inl" -exec $script_dir/format_file_dtc.sh {} \;
find -X $path -name "*.cpp" -exec $script_dir/format_file_dtc.sh {} \;
find -X $path -name "*.c" -exec $script_dir/format_file_dtc.sh {} \;
find -X $path -name "*.h" -exec $script_dir/format_file_dtc.sh {} \;
find -X $path -name "*.hpp" -exec $script_dir/format_file_dtc.sh {} \;
find -X $path -name "*.vs" -exec $script_dir/format_file_dtc.sh {} \;
find -X $path -name "*.ps" -exec $script_dir/format_file_dtc.sh {} \;
find -X $path -name "*.gs" -exec $script_dir/format_file_dtc.sh {} \;
find -X $path -name "*.cg" -exec $script_dir/format_file_dtc.sh {} \;
find -X $path -name "*.glsl" -exec $script_dir/format_file_dtc.sh {} \;
find -X $path -name "*.fbs" -exec $script_dir/format_file_dtc.sh {} \;



find -X $path -name "*.old" -exec rm {} \;