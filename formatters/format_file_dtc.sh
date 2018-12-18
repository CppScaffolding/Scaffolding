#!/bin/bash

file="${1}"

script_dir=`dirname $BASH_SOURCE`

$script_dir/format_file.sh $file &
