@echo off

IF NOT EXIST outall\ mkdir outall\

rem. > log.txt

del /S /Q outall\* >> log.txt

for /D %%d in ("outall\Mega Man Battle Network 4 (JUE) [135]\*") do rmdir "%%d"
for /D %%d in ("outall\Mega Man Battle Network 5 (JUE) [153]\*") do rmdir "%%d"
for /D %%d in ("outall\Rockman.EXE 6 (J) [160]\*") do rmdir "%%d"
for /D %%d in ("outall\*") do rmdir "%%d"

mkdir "outall\Mega Man Battle Network 4 (JUE) [135]" >> log.txt
mkdir "outall\Mega Man Battle Network 4 (JUE) [135]\Chip Transmission" >> log.txt
mkdir "outall\Mega Man Battle Network 4 (JUE) [135]\Mod Cards" >> log.txt
mkdir "outall\Mega Man Battle Network 5 (JUE) [153]" >> log.txt
mkdir "outall\Mega Man Battle Network 5 (JUE) [153]\Chip Transmission" >> log.txt
mkdir "outall\Mega Man Battle Network 5 (JUE) [153]\Mod Cards" >> log.txt
mkdir "outall\Mega Man Battle Network 5 (JUE) [153]\Item Cards" >> log.txt
mkdir "outall\Rockman.EXE 6 (J) [160]" >> log.txt
mkdir "outall\Rockman.EXE 6 (J) [160]\Chip Transmission" >> log.txt
mkdir "outall\Rockman.EXE 6 (J) [160]\Mod Cards" >> log.txt
mkdir "outall\Rockman.EXE 6 (J) [160]\Item Cards" >> log.txt
mkdir "outall\Rockman.EXE 6 (J) [160]\Request Cards" >> log.txt

:bn4mods
for %%f in ("cards\bn4\ModCards\*") do (
	echo Processing %%~nf...
	call compile.bat "%%f" > log.txt
	if errorlevel 1 goto :error

	if not exist out\card.02.raw copy out\card.01.raw "outall\Mega Man Battle Network 4 (JUE) [135]\Mod Cards\%%~nf.raw" >> log.txt
	if exist out\card.02.raw copy out\card.01.raw "outall\Mega Man Battle Network 4 (JUE) [135]\Mod Cards\%%~nf 1.raw" >> log.txt
	if exist out\card.02.raw copy out\card.02.raw "outall\Mega Man Battle Network 4 (JUE) [135]\Mod Cards\%%~nf 2.raw" >> log.txt
)

:bn4chips
for %%f in ("cards\bn4\ChipTransmission\*") do (
	echo Processing %%~nf...
	call compile.bat "%%f" > log.txt
	if errorlevel 1 goto :error

	if not exist out\card.02.raw copy out\card.01.raw "outall\Mega Man Battle Network 4 (JUE) [135]\Chip Transmission\%%~nf.raw" >> log.txt
	if exist out\card.02.raw copy out\card.01.raw "outall\Mega Man Battle Network 4 (JUE) [135]\Chip Transmission\%%~nf 1.raw" >> log.txt
	if exist out\card.02.raw copy out\card.02.raw "outall\Mega Man Battle Network 4 (JUE) [135]\Chip Transmission\%%~nf 2.raw" >> log.txt
)

:bn5mods
for %%f in ("cards\bn5\ModCards\*") do (
	echo Processing %%~nf...
	call compile.bat "%%f" > log.txt
	if errorlevel 1 goto :error

	if not exist out\card.02.raw copy out\card.01.raw "outall\Mega Man Battle Network 5 (JUE) [153]\Mod Cards\%%~nf.raw" >> log.txt
	if exist out\card.02.raw copy out\card.01.raw "outall\Mega Man Battle Network 5 (JUE) [153]\Mod Cards\%%~nf 1.raw" >> log.txt
	if exist out\card.02.raw copy out\card.02.raw "outall\Mega Man Battle Network 5 (JUE) [153]\Mod Cards\%%~nf 2.raw" >> log.txt
)

:bn5items
for %%f in ("cards\bn5\ItemCards\*") do (
	echo Processing %%~nf...
	call compile.bat "%%f" > log.txt
	if errorlevel 1 goto :error

	if not exist out\card.02.raw copy out\card.01.raw "outall\Mega Man Battle Network 5 (JUE) [153]\Item Cards\%%~nf.raw" >> log.txt
	if exist out\card.02.raw copy out\card.01.raw "outall\Mega Man Battle Network 5 (JUE) [153]\Item Cards\%%~nf 1.raw" >> log.txt
	if exist out\card.02.raw copy out\card.02.raw "outall\Mega Man Battle Network 5 (JUE) [153]\Item Cards\%%~nf 2.raw" >> log.txt
)

:bn5chips
for %%f in ("cards\bn5\ChipTransmission\*") do (
	echo Processing %%~nf...
	call compile.bat "%%f" > log.txt
	if errorlevel 1 goto :error

	if not exist out\card.02.raw copy out\card.01.raw "outall\Mega Man Battle Network 5 (JUE) [153]\Chip Transmission\%%~nf.raw" >> log.txt
	if exist out\card.02.raw copy out\card.01.raw "outall\Mega Man Battle Network 5 (JUE) [153]\Chip Transmission\%%~nf 1.raw" >> log.txt
	if exist out\card.02.raw copy out\card.02.raw "outall\Mega Man Battle Network 5 (JUE) [153]\Chip Transmission\%%~nf 2.raw" >> log.txt
)

:bn6mods
for %%f in ("cards\bn6\ModCards\*") do (
	echo Processing %%~nf...
	call compile.bat "%%f" > log.txt
	if errorlevel 1 goto :error

	if not exist out\card.02.raw copy out\card.01.raw "outall\Rockman.EXE 6 (J) [160]\Mod Cards\%%~nf.raw" >> log.txt
	if exist out\card.02.raw copy out\card.01.raw "outall\Rockman.EXE 6 (J) [160]\Mod Cards\%%~nf 1.raw" >> log.txt
	if exist out\card.02.raw copy out\card.02.raw "outall\Rockman.EXE 6 (J) [160]\Mod Cards\%%~nf 2.raw" >> log.txt
)

:bn6events
for %%f in ("cards\bn6\RequestCards\*") do (
	echo Processing %%~nf...
	call compile.bat "%%f" > log.txt
	if errorlevel 1 goto :error

	if not exist out\card.02.raw copy out\card.01.raw "outall\Rockman.EXE 6 (J) [160]\Request Cards\%%~nf.raw" >> log.txt
	if exist out\card.02.raw copy out\card.01.raw "outall\Rockman.EXE 6 (J) [160]\Request Cards\%%~nf 1.raw" >> log.txt
	if exist out\card.02.raw copy out\card.02.raw "outall\Rockman.EXE 6 (J) [160]\Request Cards\%%~nf 2.raw" >> log.txt
)

:bn6items
for %%f in ("cards\bn6\ItemCards\*") do (
	echo Processing %%~nf...
	call compile.bat "%%f" > log.txt
	if errorlevel 1 goto :error

	if not exist out\card.02.raw copy out\card.01.raw "outall\Rockman.EXE 6 (J) [160]\Item Cards\%%~nf.raw" >> log.txt
	if exist out\card.02.raw copy out\card.01.raw "outall\Rockman.EXE 6 (J) [160]\Item Cards\%%~nf 1.raw" >> log.txt
	if exist out\card.02.raw copy out\card.02.raw "outall\Rockman.EXE 6 (J) [160]\Item Cards\%%~nf 2.raw" >> log.txt
)

:bn6chips
for %%f in ("cards\bn6\ChipTransmission\*") do (
	echo Processing %%~nf...
	call compile.bat "%%f" > log.txt
	if errorlevel 1 goto :error

	if not exist out\card.02.raw copy out\card.01.raw "outall\Rockman.EXE 6 (J) [160]\Chip Transmission\%%~nf.raw" >> log.txt
	if exist out\card.02.raw copy out\card.01.raw "outall\Rockman.EXE 6 (J) [160]\Chip Transmission\%%~nf 1.raw" >> log.txt
	if exist out\card.02.raw copy out\card.02.raw "outall\Rockman.EXE 6 (J) [160]\Chip Transmission\%%~nf 2.raw" >> log.txt
)

:end
echo.
echo All finished!
pause
goto :eof

:error
echo An error occurred during compilation; check log.txt.
pause
exit /b 1

:eof
exit /b 0