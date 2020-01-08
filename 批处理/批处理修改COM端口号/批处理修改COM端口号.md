批处理修改COM端口号
原创soso7733 发布于2018-04-16 16:23:03 阅读数 413  收藏
展开
最近在做WES7系统封装，发现恢复镜像到国光WES7终端的时候发生了串口号与出厂设置不一致的问题，造成串口设备按业务系统默认进行设置时无法访问，因此需要在系统第一次进桌面时调用一个程序自动修改串口号为与出厂一致，在CSDN上找到了一篇名为《批处理：修改COM端口号》的博客，发现该程序不够完善，于是进行了改写，改写后的代码如下：

COMPortNumberChanger.bat:

@echo off
cls
setlocal EnableDelayedExpansion
set oldCOMPort=%~1
set newCOMPort=%~2


if "%oldCOMPort%" == "" (
    echo.
    echo 用法：COMPortNumberChanger 旧串口号 新串口号
    echo.
    echo       例如：COMPortNumberChanger COM1 COM3
    echo.
    goto end
)
if "%newCOMPort%" == "" (
    echo.
    echo 用法：COMPortNumberChanger 旧串口号 新串口号
    echo.
    echo       例如：COMPortNumberChanger COM1 COM3
    echo.
    goto end
)

rem :ReadDeviceId
for /f %%a in ('.\devcon findall =port * ^| find /i "%oldCOMPort%"') do set DEVICEID=%%a
if "%DEVICEID%" == "" (
        echo.
        echo %oldCOMPort%不存在, 请打开设备管理器检查该设备是否已正确安装。
        echo.
        echo 按任意键退出。
        pause>NUL
        goto END
)

:ReadFriendlyName
for /f "tokens=1,2,* " %%a in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\%DEVICEID%" /v "FriendlyName"') do set oldFriendlyName=%%c
if "%oldFriendlyName%" == ""  (
        echo Error: Cannot find friendly name for %oldCOMPort%, check regedit: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\%DEVICEID%. Check if device is installed correctly and try again.
        echo Press any key to detect again.
        pause
        goto ReadFriendlyName
)

:FindDeviceMap
for /f "tokens=1,2,3" %%a in ('reg query "HKEY_LOCAL_MACHINE\HARDWARE\DEVICEMAP\SERIALCOMM" /s') do if /i "%oldCOMPort%" == "%%c" set SerialCommKey=%%a

if "%SerialCommKey%"=="" (
    echo Error: cannot find Device map for %oldCOMPort%, check regedit: HKLM\HARDWARE\DEVICEMAP\SERIALCOMM. Check if device is installed correctly and try again.
        echo Press any key to detect again.
        pause
        goto FindDeviceMap
)

subinacl /keyreg "HKEY_LOCAL_MACHINE\System\CurrentControlSet\ENUM\%DEVICEID%" /setowner=administrators
subinacl /keyreg "HKEY_LOCAL_MACHINE\System\CurrentControlSet\ENUM\%DEVICEID%" /grant=administrators=f
subinacl /keyreg "HKEY_LOCAL_MACHINE\System\CurrentControlSet\ENUM\%DEVICEID%\Device Parameters" /grant=administrators=f

reg add "HKLM\SYSTEM\CurrentControlSet\ENUM\%DEVICEID%\DEVICE Parameters" /v PORTNAME /t REG_SZ /d %newCOMPort% /F

set newFriendlyName=!oldFriendlyName:%oldCOMPort%=%newCOMPort%!
reg add "HKLM\SYSTEM\CurrentControlSet\ENUM\%DEVICEID%" /v FriendlyName /t REG_SZ /d "%newFriendlyName%" /F

reg add "HKLM\HARDWARE\DEVICEMAP\SERIALCOMM" /v %SerialCommKey% /t REG_SZ /d %newCOMPort% /F

rem 计算已占用串口号之和，结果为十进制数
set /a ii=0
for /f "skip=2 tokens=1,2,3" %%a in ('reg query "HKEY_LOCAL_MACHINE\HARDWARE\DEVICEMAP\SERIALCOMM" /s') do (
        set jj=%%c
        set jj=!jj:~3,3!
        set /a ii = !jj!+ii
)

rem 已占用串口号之和ii转十六进制，转换结果为%ii%%str%
set code=0123456789ABCDEF
:again
set /a tra=%ii%%%16
call,set tra=%%code:~%tra%,1%%
set /a ii/=16
set str=%tra%%str%
if %ii% geq 16 goto again

reg add "HKLM\SYSTEM\CurrentControlSet\Control\COM Name Arbiter" /v "ComDB" /t REG_BINARY /d %ii%%str%00000000000000000000000000000000000000000000000000000000000000 /f

:end

调用方法：

COMPortNumberChanger.bat COM3 COM5
参考：https://blog.csdn.net/binhualiu1983/article/details/51646092
————————————————
版权声明：本文为CSDN博主「soso7733」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/soso7733/article/details/79962034
