@echo off

echo **************************************************************************

echo *                             �޸�IP��ַ��DNS                            *

echo *                     Windows XP Copyright (C) 2013-02-05                *

echo **************************************************************************

echo �����޸�IP��ַ��DNS��������ַ,�����ĵȴ���������

echo ���ڸ��ı���IP��ַ...

netsh interface ip set address "WLAN" static 192.168.1.100 255.255.255.0 192.168.1.1 

echo ������ӱ�����ѡDNS������...

netsh interface ip set dns "WLAN" static 8.8.8.8

echo ������ӱ�������DNS������...

netsh interface ip add dns "WLAN" 114.114.114.114

echo ��鵱ǰ��������...

ipconfig /all

pause