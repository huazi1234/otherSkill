
@echo on
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
for /f %%a in ('devcon findall =port * ^| find /i "%oldCOMPort%"') do set DEVICEID=%%a
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


pause
:end
