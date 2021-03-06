最简单-转换MBR为GPT

https://www.jianshu.com/p/8e7cae1dcb64
MBR+BIOS 该退出历史舞台了。GPT+UEFI 拥有更好的性能与更高的安全性。之前MBR转换到GPT，需要拷贝资料然后全盘格式化。现在微软推出了一个新的工具MBR2GPT，可以快速无损转换MBR到GPT。

注意事项：

以下方式要求系统是Windows 10 1703 及以后的版本,如果不是, 请先升级

在转换过程中会创建UEFI系统分区，这会占用一个MBR主分区，而因为MBR磁盘最多只能有四个主分区，所以待转换的MBR磁盘不能超过四个主分区

BitLocker加密磁盘需要先解除BitLocker加密之后才能使用MBR2GPT进行转换

将硬盘转换为GPT后，必须配合 UEFI 引导，操作系统才能启动。执行此操作前请务必确认您的电脑和系统是否支持 UEFI 引导模式！

使用此工具理论上不会丢失硬盘数据，但仍建议您备份好重要数据，避免不必要的损失

此操作不可逆转，转换为 GPT 后，无法再以无损方式转换回 MBR ；换回 MBR 需清空硬盘上现有的分区结构及数据，再重新安装系统

步骤一：以管理员身份运行命令提示符
win+x，选择 命令提示符(管理员)

步骤二：运行MBR2GPT验证磁盘
输入以下命令：mbr2gpt /validate /allowfullos 然后回车


该命令会验证磁盘是否满足转换要求，提示Validation completed successfully验证完成之后，再运行下面的转换命令。

步骤三：运行MBR2GPT进行转换
对于只有一块硬盘的电脑
可以直接输入mbr2gpt /convert /allowfullos开始转换

对于有多块硬盘的电脑
需先查看磁盘编号。先后执行以下命令:
diskpart
list disk


在显示的列表里找出你要转换的那块硬盘。最简单的方式就是判断容量大小。

找到硬盘了，看列表最左边的“磁盘 ###”，这一列就是磁盘编号了。比如我的是“磁盘 0”，那么我的磁盘编号就是 0。

最后，输入exit来退出diskpart。

好了，现在可以转换了。

命令：mbr2gpt /convert /disk:磁盘编号 /allowfullos

第二个参数，把“磁盘编号”四个字，换成你的磁盘编号的数字，OK，执行。


当提示Conversion completed successfully时即转换完成，并且会提示你需要将系统启动模式更改为UEFI模式。必须要将系统启动模式更改为UEFI模式，否则重启后系统无法引导！这一步非常重要，切记！

步骤四：更改为UEFI启动模式
在磁盘分区形式转换为GPT之后，需要把系统引导模式修改为UEFI模式才能正常启动系统。不同的主板BIOS设置界面不完全一样，但大同小异。


电脑开机时按Del键或F2键进入主板BIOS设置界面 ，按方向键移动到Boot标签，把Boot Mode启动模式设置为UEFI即可。

备注
本文方案的优点：无需重装系统、不破坏现有分区和数据，实现从 MBR 到 GPT 的转换，并且是微软官方方案，相比第三方软件更有优势。

对于Win7、Win8/8.1，微软的建议是先升级到最新版本的Win10，然后再进行从 MBR 到 GPT 的转换。
