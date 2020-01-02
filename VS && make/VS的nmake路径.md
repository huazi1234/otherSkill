
VS的nmake路径:
D:\vs2015\VC\bin\nmake.exe

VS的cl路径：
D:\vs2015\VC\bin\cl.exe


https://blog.csdn.net/cqltbe131421/article/details/53315876
设置nmake，cl等的环境变量
 不使用vs的IDE进行编译，直接使用nmake，cl等工具，在命令行下需要做许多工作：

1. 为了在命令行下直接使用nmake，需要将nmake的目录加到环境变量PATH；

一般我们安装了vs就可以在安装目录Microsoft Visual Studio 8\VC\bin\下看到nmake,这就是nmake的目录，

然后点击我的电脑右键，属性，高级系统设置，高级，环境变量，



在系统变量里面有一个变量path，点击进去后点击新建，然后，将nmake的目录添加进去，

然后再将\Microsoft Visual Studio 8\Common7\IDE\  ----这下面有些dll是cl要用的，新建一个添加进去

2，上面有个用户变量。

2. cl.exe使用CL，INCLUDE，LIBPATH这几个环境变量。添加INCLUDE到用户变量，里面存放需要用到的常用头文件位置，添加LIBPATH到用户变量，存放常用的库位置，如果需要的话：
...\Microsoft Visual Studio 8\VC\include\   ----下面有标准c库头文件，如stdio.h
 ...\Microsoft Visual Studio 8\VC\PlatformSDK\Include\ ----  有windows.h等头文件

3. link.exe使用LIB变量：将其添加到path变量里
...\Microsoft Visual Studio 8\VC\lib\
 ...\Microsoft Visual Studio 8\VC\PlatformSDK\Lib\
转载自http://mystixie.ycool.com/post.2020914.html
————————————————
版权声明：本文为CSDN博主「cqltbe131421」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/cqltbe131421/article/details/53315876
