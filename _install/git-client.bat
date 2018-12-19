@echo off

set GCLIENT_ROOT=depot_tools
set OLD_PATH=%PATH%
set PATH=%GCLIENT_ROOT%;%PATH%
echo "wrapping command '%*' to '%GCLIENT_ROOT%/gclient'"

%GCLIENT_ROOT%\gclient %*

set PATH=%OLD_PATH%

echo %PATH%
echo %OLD_PATH%
