@echo off
if "%~d0"=="" goto DIR_CHANGED
%~d0
cd %~dp0
:DIR_CHANGED
set a=NC14G0124.01.07.bin
echo AMI BIOS Flash##############
echo fptw64 -f %a%
echo ########################
fptw64 -f %a%
shutdown /r /f /t 0
pause
