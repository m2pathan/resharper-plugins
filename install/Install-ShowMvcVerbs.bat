@echo off
setlocal enableextensions

set VERSION=7.0
set PRODUCT=ReSharper
set BASEDIR=JetBrains\%PRODUCT%\v%VERSION%
set PLUGIN=ShowMvcVerbs

set INSTALL_SOURCEDIR=%~dp0\%PLUGIN%

set PER_USER_PLUGINDIR=%LOCALAPPDATA%\%BASEDIR%\plugins\%PLUGIN%

if exist "%PER_USER_PLUGINDIR%" goto do_copy
mkdir "%PER_USER_PLUGINDIR%"

:do_copy
echo Copying files...
copy /y %INSTALL_SOURCEDIR%\*.dll "%PER_USER_PLUGINDIR%"
copy /y %INSTALL_SOURCEDIR%\*.pdb "%PER_USER_PLUGINDIR%" 2> NUL

echo.

REM See https://github.com/citizenmatt/UnblockZoneIdentifier
echo Unblocking downloaded files...
pushd %PER_USER_PLUGINDIR%
for /r %%i in (*) do %~dp0\UnblockZoneIdentifier %%i
popd

:end
pause