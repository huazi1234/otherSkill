BAT批处理修改IP地址和DNS配置
yhw851人评论10069人阅读2013-02-05 22:32:27
1、Windows XP系统BAT批处理修改IP地址和DNS。

新建：文本文档，复制下面代码到文本文档，保存为Set IP Address.bat,双击运行，即可！

@echo off

echo **************************************************************************

echo *                             修改IP地址、DNS                            *

echo *                     Windows XP Copyright (C) 2013-02-05                *

echo **************************************************************************

echo 正在修改IP地址和DNS服务器地址,请耐心等待…………

echo 正在更改本机IP地址...

netsh interface ip set address "本地连接" static 192.168.1.100 255.255.255.0 192.168.1.1 default

echo 正在添加本机首选DNS服务器...

netsh interface ip set dns "本地连接" static 202.96.134.133

echo 正在添加本机备用DNS服务器...

netsh interface ip add dns "本地连接" 202.96.128.166

echo 检查当前本机配置...

ipconfig /all

pause

 

2、Windows 7系统BAT批处理修改IP地址和DNS。

新建：文本文档，复制下面代码到文本文档，保存为Set IP Address.bat,双击运行，即可！

@echo off

echo **************************************************************************

echo *                             修改IP地址、DNS                            *

echo *                      Windows 7 Copyright (C) 2013-02-05                *

echo **************************************************************************

echo 正在修改IP地址和DNS服务器地址,请耐心等待…………

echo 正在更改本机IP地址...

netsh interface ipv4 set address name="本地连接" source=static addr=192.168.1.100 mask=255.255.255.0 gateway=192.168.1.1 gwmetric=0 >nul

echo 正在添加本机首选DNS服务器...

netsh interface ipv4 set dns name="本地连接" source=static addr=202.96.134.133 register=PRIMARY

echo 正在添加备用DNS服务器...

netsh interface ipv4 add dns name="本地连接" addr=202.96.128.166

echo 检查当前本机配置...

ipconfig /all

pause

 

IP地址参数说明：

1.name：网络连接名称，一般为“本地连接”。你自己取的什么名就是什么名字。

2.source：获取IP的途径。动态获取，则为dhcp，手动设置，则为static。

3.addr：要设置的IP地址。

4.mask：子网掩码。

5.gateway：网关地址。

6.gwmetric：网关跃点数，可以设置为整型数值，也可以设置为“自动”:auto。

 

DNS参数说明：

1.name：网络连接名称，一般为“本地连接”。你自己取的什么名就是什么名字。

2.source：获取IP的途径。动态获取，则为dhcp，手动设置，则为static。

3.addr：要设置的IP地址。

4.register：

   primary: 只在主 DNS 后缀下注册。

      none: 禁用动态 DNS 注册。

      both: 在主 DNS 后缀下注册，也在特定连接后缀下注册。

5.index：设置的DNS的顺序号。

附件：http://down.51cto.com/data/2362269
