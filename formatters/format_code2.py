#!/usr/local/bin/python

import argparse
import os
import glob
import platform
from shutil import copyfile


parser = argparse.ArgumentParser(description='Format code files')

parser.add_argument('-i', '--input_folder', nargs=1, default=['../src'],
    help='path containing the files to format (wildcard allowed)')

parser.print_help()

args = parser.parse_args()
print args


file_types = []
file_types.append("*.inl")
file_types.append("*.cpp")
file_types.append("*.c")
file_types.append("*.h")
file_types.append("*.hpp")
file_types.append("*.vs")
file_types.append("*.ps")
file_types.append("*.gs")
file_types.append("*.cg")
file_types.append("*.glsl")
file_types.append("*.fbs")



cmd = "./format_file.sh {0}"
if platform.system() == 'Windows':
	cmd = "format_file.bat {0}"


files = []
for walkingDir, walkingDirSubdirs, walkingDirFiles in os.walk(args.input_folder[0]):
	print('walking {}'.format(walkingDir))
	for filetype in file_types:
		files.extend(glob.glob(os.path.join(walkingDir, filetype)))


for f in files:
	print f
	os.system(cmd.format(f))
