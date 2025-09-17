@echo off
cd /d "%~dp0"

:ADDDRIVER
pnputil /add-driver %pathmodel%\Bios\txei\*.inf /subdirs /install

:CLEANINGSSD
if exist "X:\Check.txt" del "X:\Check.txt" > nul
call diskpart /s "%pathmodel%\Bios\CheckDisk.txt" > "X:\Check.txt"
X:\Windows\System32\find "Disk 0" X:\Check.txt > nul
if not errorlevel 1 goto FORMAT > nul
X:\Windows\System32\find "Disco 0" X:\Check.txt > nul
if not errorlevel 1 goto FORMAT > nul
goto ERRO_SSD

:FORMAT
echo "FORMAT..."
rem diskpart /s "%pathmodel%\Bios\CreatePartitions.txt" > nul
if exist "X:\Check.txt" del "X:\Check.txt"

:RETRY
%pathmodel%\Bios\AFUWINx64.exe NC14G0124.01.07.bin /p /n /x
rem %pathmodel%\Bios\FPTW64.exe -y -f NC14G0124.01.05.bin
echo %errorlevel% 

if %errorlevel% == 0 goto PASS
goto RETRY

:PASS
::wpeutil SHUTDOWN
wpeutil REBOOT

:ERRO_SSD
color 04
title EQUIPAMENTO SEM HD/SSD
if exist "X:\Check.txt" del "X:\Check.txt" > nul
cls
color CF
echo.
echo ===================================================================
echo ======                                                       ======
echo ======       O HD/SSD DESTA MAQUINA NAO FOI RECONHECIDO      ======
echo ======            FAVOR CHECAR E TENTAR NOVAMENTE            ======
echo ======                                                       ======
echo ===================================================================
echo.
echo.
pause
goto ERRO_SSD