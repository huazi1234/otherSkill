在BIOS设置中集成显卡该选那个值IGD、PEG、PCI它们分别是什么意思

在BIOS设置中，集成显卡选择IGD或IFGX。
IGD：系统首先初始化igd(内置图形显示，设置集成显卡)
PEG：系统首先初始化peg(pci express图形卡)
PCI：系统首先初始化pci接口图形卡
特别说明：
　　 PCI(Peripheral Component Interconnect)是一种由英特尔（Intel）公司1991年推出的用于定义局部总线的标准。
　　 PEG（PCI Express）是新一代的总线接口。
   
   
   
   BIOS中显卡设置选项IGD,PCI,PEG的含义
   
 故障现象:


BIOS中显卡设置选项有“igd” “peg/igd” “peg/pci” “pci/peg” “pci/igd” 该如何选择？ 



解决方案:



各个选项含义如下：


“igd” 系统首先初始化igd（内置图形显示）。 


“peg/igd” 系统首先初始化peg（pci express图形卡）。如果pci express图形卡不可用，则初始化igd。


“peg/pci” 系统首先初始化peg（pci express图形卡）。如果pct express图形卡不可用，则初始化pci图形卡。 


“pci/peg” 系统首先初始化pci图形卡。如果pc旧形卡不可用，则初始化peg（pci express图形卡）卡。 


“pci/igd” 系统首先初始化pci图形卡。如果pct图形卡不可用，则初始化igd。 

带有集显，支持独显的主板在 bios 中的 video 选项有 IGDPEGPCI 可以选择，那么要选哪个呢？ 三个简称如下： 


IGD：系统首先初始化igd（内置图形显示） 


PEG：系统首先初始化peg（pci express图形卡） 


PCI：系统首先初始化pci接口图形卡 


这样就很清楚了。 
