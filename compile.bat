@echo off
if ""%1""=="""" goto :usage

IF NOT EXIST out\ mkdir out\
del /S /Q out\*

tools\grit\grit.exe img\pal.png img\prixpowr.png ^
-ftb -fh! ^
-mR! ^
-pn16 ^
-gB4 ^
-m! ^
-pS ^
-fa ^
-o out\prixpowr

tools\grit\grit.exe img\pal.png img\duo.png ^
-ftb -fh! ^
-mR! ^
-pn16 ^
-gB4 ^
-m! ^
-pS ^
-fa ^
-o out\duo

tools\grit\grit.exe img\pal.png img\leaderr.png ^
-ftb -fh! ^
-mR! ^
-pn16 ^
-gB4 ^
-m! ^
-pS ^
-fa ^
-o out\leaderr

tools\grit\grit.exe img\pal.png img\chaosl.png ^
-ftb -fh! ^
-mR! ^
-pn16 ^
-gB4 ^
-m! ^
-pS ^
-fa ^
-o out\chaosl

tools\grit\grit.exe img\pal.png img\dblbeast.png ^
-ftb -fh! ^
-mR! ^
-pn16 ^
-gB4 ^
-m! ^
-pS ^
-fa ^
-o out\dblbeast

tools\grit\grit.exe img\pal.png img\gregar.png ^
-ftb -fh! ^
-mR! ^
-pn16 ^
-gB4 ^
-m! ^
-pS ^
-fa ^
-o out\gregar

tools\grit\grit.exe img\pal.png img\falzar.png ^
-ftb -fh! ^
-mR! ^
-pn16 ^
-gB4 ^
-m! ^
-pS ^
-fa ^
-o out\falzar

tools\armips.exe text1.asm -erroronwarning ^
-equ card_info_file ""%1"" ^
-equ lang 0
if errorlevel 1 goto :error

tools\armips.exe text2.asm -erroronwarning ^
-equ card_info_file ""%1"" ^
-equ lang 0
if errorlevel 1 goto :error

rename out\text1.bin text1_jp.bin
rename out\text2.bin text2_jp.bin
copy out\text1_jp.bin out\text1_jp.lz
copy out\text2_jp.bin out\text2_jp.lz
tools\lzss.exe -ewo out\text1_jp.lz
tools\lzss.exe -ewo out\text2_jp.lz

tools\armips.exe text1.asm -erroronwarning ^
-equ card_info_file ""%1"" ^
-equ lang 1
if errorlevel 1 goto :error

tools\armips.exe text2.asm -erroronwarning ^
-equ card_info_file ""%1"" ^
-equ lang 1
if errorlevel 1 goto :error

rename out\text1.bin text1_en.bin
rename out\text2.bin text2_en.bin
copy out\text1_en.bin out\text1_en.lz
copy out\text2_en.bin out\text2_en.lz
tools\lzss.exe -ewo out\text1_en.lz
tools\lzss.exe -ewo out\text2_en.lz

tools\armips.exe card.asm -erroronwarning ^
-equ card_info_file ""%1""
if errorlevel 1 goto :error

tools\nevpk ^
-i out\card.01.mb ^
-o out\card.01.vpk ^
-c ^
-level 2

set fullname=%~n1
set cardname=%fullname:~9%

set cardnum=%fullname:~6,2%
if %cardnum:~0,1%==0 set cardnum=%cardnum:~1%

set basenum=0
if %fullname:~0,5%==134-D set basenum=30
if %fullname:~0,5%==134-E set basenum=60
if %fullname:~0,5%==134-F set basenum=90
if %fullname:~0,5%==134-G set basenum=120
if %fullname:~0,5%==136-B set basenum=50
if %fullname:~0,5%==136-C set basenum=100
if %fullname:~0,5%==136-D set basenum=110
if %fullname:~0,5%==136-F set basenum=20
if %fullname:~0,5%==137-B set basenum=53
if %fullname:~0,5%==137-C set basenum=106
if %fullname:~0,5%==137-F set basenum=20

if not %basenum%==0 set /a cardnum=%basenum%+%cardnum%

set cardnum=00%cardnum%
set cardnum=%cardnum:~-3%

if %fullname:~0,5%==134-A set cardname="Mod Card %cardnum%"
if %fullname:~0,5%==134-B set cardname="Mod Card 000"
if %fullname:~0,5%==134-C set cardname="%cardname%"
if %fullname:~0,5%==134-D set cardname="Mod Card %cardnum%"
if %fullname:~0,5%==134-E set cardname="Mod Card %cardnum%"
if %fullname:~0,5%==134-F set cardname="Mod Card %cardnum%"
if %fullname:~0,5%==134-G set cardname="Mod Card %cardnum%"
if %fullname:~0,5%==136-A set cardname="Mod Card %cardnum%"
if %fullname:~0,5%==136-B set cardname="Mod Card %cardnum%"
if %fullname:~0,5%==136-C set cardname="Special Mod Card"
if %fullname:~0,5%==136-D set cardname="BassCross MegaMan"
if %fullname:~0,5%==136-E set cardname="Item Card %cardnum%"
if %fullname:~0,5%==136-F set cardname="Item Card %cardnum%"
if %fullname:~0,5%==136-G set cardname="%cardname%"
if %fullname:~0,5%==137-A set cardname="Mod Card %cardnum%"
if %fullname:~0,5%==137-B set cardname="Mod Card %cardnum%"
if %fullname:~0,5%==137-C set cardname="Special Mod Card"
if %fullname:~0,5%==137-D set cardname="Sub Event Card %cardnum%"
if %fullname:~0,5%==137-E set cardname="Item Card %cardnum%"
if %fullname:~0,5%==137-F set cardname="Item Card %cardnum%"
if %fullname:~0,5%==137-G set cardname="%cardname%"

tools\nedcmake ^
-i out\card.01.vpk ^
-o out\card ^
-type 2 ^
-region 1 ^
-name %cardname% ^
-title "" ^
-titlemode 3 ^
-save 0 ^
-bin

if exist out\card.01.bin tools\nedcenc -e -i out\card.01.bin -o out\card.01.raw
if exist out\card.02.bin tools\nedcenc -e -i out\card.02.bin -o out\card.02.raw

goto :eof

:error
exit /b 1

:usage
echo Usage: compile path_to_asm_file
exit /b 1

:eof
exit /b 0