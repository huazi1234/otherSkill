批处理学习之Bat命令——获取当前盘符、当前目录、上级目录
命令

当前盘符：%~d0
当前路径：%cd%
当前执行命令行：%0
当前bat文件路径：%~dp0
当前bat文件短路径：%~sdp0
测试

下载testBatPath.bat测试文件，双击.bat运行。
测试结果（我把文件放在了桌面）

Next
使用方式

set赋值给一个变量，在命令中引用这个变量
举例：执行批处理命令，调用.bat当前目录下的SQL文件
复制代码
@echo off 
set filepath=%cd%

echo 创建中间表开始
sqlplus GXGXH/GXGXH @%filepath%\createTable.sql 
echo 创建中间表成功

pause>nul 
复制代码
在命令中直接使用
举例：执行批处理命令，调用.bat当前目录下的SQL文件
复制代码
@echo off 

echo 创建中间表开始
sqlplus GXGXH/GXGXH @%cd%\createTable.sql 
echo 创建中间表成功

pause>nul 
复制代码
Next
