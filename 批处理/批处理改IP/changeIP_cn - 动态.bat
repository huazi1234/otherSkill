@echo off

echo **************************************************************************

echo *                             修改IP地址、DNS                            *

echo *                     Windows XP Copyright (C) 2013-02-05                *

echo **************************************************************************

echo 正在修改IP地址和DNS服务器地址,请耐心等待…………

echo 正在更改本机IP地址...

netsh interface ip set address "WLAN" source=dhcp

echo 正在添加本机首选DNS服务器...

netsh interface ip set dnsservers name = "WLAN" source=dhcp



echo 检查当前本机配置...

ipconfig /all

pause