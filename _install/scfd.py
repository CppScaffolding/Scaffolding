#!/usr/bin/python

import os
import sys
import string
import shlex
import colorama
import termcolor
import subprocess

colorama.init()

def main():
	target = sys.argv[1]
	subargs = sys.argv[2:]
	str_subargs = string.join(subargs, ' ')
	termcolor.cprint("wrapping command '{1}' to scaffolding/{0}.make".format(target, str_subargs), 'cyan')

	cmd = 'make -f scaffolding/makefiles/{0}.make'.format(target)
	cmdline = shlex.split(cmd) + subargs
	
	p = subprocess.Popen(cmdline, shell=(os.name == 'nt'), stdout=subprocess.PIPE, stderr=subprocess.STDOUT, bufsize=1, env=os.environ, cwd=sys.path[0])
	for line in iter(p.stdout.readline, b''):
		termcolor.cprint(line.rstrip(), 'cyan')
	p.wait() # close stdout, wait for child's exit
	return p.returncode

if __name__ == '__main__':
	main()
