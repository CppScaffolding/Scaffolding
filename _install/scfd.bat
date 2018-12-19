@echo off

set target=%1
shift
echo "wrapping command '%1 %2 %3 %4 %5 %6 %7 %8 %9' to scaffolding/%target%.make"

make -f scaffolding/makefiles/"%target%".make "%1 %2 %3 %4 %5 %6 %7 %8 %9"

