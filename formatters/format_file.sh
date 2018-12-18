#!/bin/bash

file="${1}"

script_dir=`dirname $BASH_SOURCE`

#echo "processing $file"

$script_dir/tools/bin/darwin/nkf -w80XZ0Lu --oc=w80 --in-place --overwrite $file
#mimic --check $file
sed -f fix_newlines.sed -i '' $file
chmod 664 $file
clang-format -style=file -i $file
