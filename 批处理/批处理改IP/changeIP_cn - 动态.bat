@echo off

echo **************************************************************************

echo *                             �޸�IP��ַ��DNS                            *

echo *                     Windows XP Copyright (C) 2013-02-05                *

echo **************************************************************************

echo �����޸�IP��ַ��DNS��������ַ,�����ĵȴ���������

echo ���ڸ��ı���IP��ַ...

netsh interface ip set address "WLAN" source=dhcp

echo ������ӱ�����ѡDNS������...

netsh interface ip set dnsservers name = "WLAN" source=dhcp



echo ��鵱ǰ��������...

ipconfig /all

pause