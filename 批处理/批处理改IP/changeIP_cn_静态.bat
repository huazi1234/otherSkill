@echo off

echo **************************************************************************

echo *                             修改IP地址、DNS                            *

echo *                     Windows XP Copyright (C) 2013-02-05                *

echo **************************************************************************

echo 正在修改IP地址和DNS服务器地址,请耐心等待…………

echo 正在更改本机IP地址...

netsh interface ip set address "WLAN" static 192.168.1.100 255.255.255.0 192.168.1.1 

echo 正在添加本机首选DNS服务器...

netsh interface ip set dns "WLAN" static 8.8.8.8

echo 正在添加本机备用DNS服务器...

netsh interface ip add dns "WLAN" 114.114.114.114

echo 检查当前本机配置...

ipconfig /all

pause