#!/usr/local/bin/python

import argparse
import os
import glob
import ninja_syntax
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


rule_nkf = "nkf -w8XZ0Lw --oc=w8 --in-place --overwrite {0} && mv {0} {1}"
rule_clang_format = "clang-format -style=file -i {0} && mv {0} {1}"
rule_fix_nl = "sed -f fix_newlines.sed -i '.old' {0} && mv {0} {1}"
rule_chmod = "chmod 664 {0} && mv {0} {1}"

rules = [] #preferreding array over dict for fixed order 
rules.append(("nkf", rule_nkf))
rules.append(("clang", rule_clang_format))
rules.append(("fix_nl", rule_fix_nl))
rules.append(("chmod", rule_chmod))


for r, _ in rules:
	print r

files = []
for walkingDir, walkingDirSubdirs, walkingDirFiles in os.walk(args.input_folder[0]):
	print('walking {}'.format(walkingDir))
	for filetype in file_types:
		files.extend(glob.glob(os.path.join(walkingDir, filetype)))
	
with open('build.ninja', "w") as buildfile:
	ninjaWriter = ninja_syntax.Writer(buildfile)
	ninjaWriter.variable('ninja_required_version', '1.3')
	ninjaWriter.newline()

	for rule_name, rule_cmd in rules:
		ninjaWriter.rule(rule_name, command=rule_cmd.format("$in", "$out"))
		ninjaWriter.newline()

	ruleCount = len(rules)
	for f in files:
		for rule_idx in range(0, ruleCount):
			infile = f
			if rule_idx > 0:
				infile = "{0}.{1}".format(f, rules[rule_idx - 1][0])

			outfile = f
			#if rule_idx < ruleCount - 1:
			outfile = "{0}.{1}".format(f, rules[rule_idx][0])
			
			target = ninjaWriter.build(outfile, rule_name, infile)
			ninjaWriter.newline()
		
	ninjaWriter.close()

# kowabunga!
os.system('ninja')

copyfile("build.ninja", "build.ninja.old")


# copy files back
with open('build.ninja', "w") as buildfile:
	ninjaWriter = ninja_syntax.Writer(buildfile)
	ninjaWriter.variable('ninja_required_version', '1.3')
	ninjaWriter.newline()
	ninjaWriter.rule('copy', command="mv {0} {1}".format("$in", "$out"))

	for f in files:
		infile = "{0}.{1}".format(f, rules[-1][0])
		outfile = f
		target = ninjaWriter.build(outfile, 'copy', infile)
		ninjaWriter.newline()
	
	ninjaWriter.close()

# kowabunga again!
os.system('ninja')


# cleanup
fileext = []
#fileext.append("old")
for r, _ in rules:
	fileext.append(r)

tempFiles = []
for ext in fileext:
	for f in files:
		tempFiles.append("{0}.{1}".format(f, ext))

#for f in tempFiles:
	#print f
	#os.system("rm {}".format(f))

