@echo off 

set path1=%~d0
set path2=%cd%
set path3=%0
set path4=%~dp0
set path5=%~sdp0

echo 当前盘符path1：%path1%
echo 当前路径path2：%path2%
echo 当前执行命令行path3：%path3%
echo 当前bat文件路径path4：%path4%
echo 当前bat文件短路径path5：%path5%

pause>nul 