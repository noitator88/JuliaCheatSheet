# JuliaCheatSheet Julia踩坑指南

A personal note on julia

## 安装与工作环境设定

### 安装

无论linux与win均可准绿色安装:
1. 直接下载相应的预编译二进制包解压缩;
2. 设定相应的path环境变量指向julia的bin目录;
3. 设定HOMEDIR，julia会安装软件包到HOMEDIR/.julia。HOMEDIR可以在julia里面用homedir()直接查看。

墙内工作，建议用国内镜像
```bash
export JULIA_PKG_SERVER=https://mirrors.tuna.tsinghua.edu.cn/julia
```

需要多线程支持，需要在启动julia前预先设定环境变量
```bash
export JULIA_NUM_THREADS=$((`nproc` / 2))
```
在Xeon E5 2650与2680 系列CPU中，设定 线程数 = CPU核心数 运行效率会更高，原因未知。

### 工作环境设定

```bash
cd path/to/dir
julia
```
julia REPL中 ] 进入包管理模式，然后启动julia并安装相应软件包：
```julia
julia> ]
pkg> activate .
pkg> add XXXpkg
```
此时可以在 path/to/dir 中看到两个文件 Manifest.toml 与 Project.toml ，其中保存有当前项目需要的软件包信息。

julia中，可以用
```julia
using Pkg
Pkg.activate("path/to/dir")
```
使用设定好的工作环境。

Note: 工作环境中实际的软件包缺省安装在.julia目录下，而不是在工作目录中。


## 日常使用

目前julia有两种推荐工作模式，一种基于REPL的模式，配置比较简单。个人比较喜欢另外一种jupyter notebook模式，使用上主要是画图方便(花哨)一点，但是需要额外配置。

conda + jupyter lab + plotly的配置实例
```bash
conda create -n lf
conda activate lf
conda update --all                                # 非必需，主要是更新conda自身
conda install -c plotly plotly=5.3.1              # plotly的显示非常方便，可以在图上直接放大/缩小/读点，比gr/pyplot等后端好用很多
conda install "jupyterlab>=3" "ipywidgets>=7.6"   # plotly需要配合ipywidgets才可以正确显示，在jupyter lab 3.0版本之前配置很麻烦，3.0之后方便很多
```
然后
```bash
cd path/to/dir
jupyter lab
...
    To access the server, open this file in a browser:
        file:///home/xxx/Dropbox/jupyter/runtime/jpserver-65355-open.html
    Or copy and paste one of these URLs:
        http://192.168.1.107:8888/lab?token=c4117ef94d53b15818bc04a4aabbd8ae0f13789daff2ef12
     or http://127.0.0.1:8888/lab?token=c4117ef94d53b15818bc04a4aabbd8ae0f13789daff2ef12
```
浏览器直接打开上述任意一个地址均可。

如果是远程使用，可以通过ssh的端口映射方式
```bash
ssh -L localhost:7777:192.168.1.107:8888 192.168.1.107 ". ~/.zshrc && cd path/to/dir && conda activate lf && jupyter lab --ip=192.168.1.107 --no-browser"
```
这里额外的
```bash
. ~/.zshrc
```
是为了设定conda与julia环境变量(这里我用的zsh)，否则后面的conda报错。

这样启动后，仍然会看到相同的提示
```bash
...
    To access the server, open this file in a browser:
        file:///home/xxx/Dropbox/jupyter/runtime/jpserver-65355-open.html
    Or copy and paste one of these URLs:
        http://192.168.1.107:8888/lab?token=c4117ef94d53b15818bc04a4aabbd8ae0f13789daff2ef12
     or http://127.0.0.1:8888/lab?token=c4117ef94d53b15818bc04a4aabbd8ae0f13789daff2ef12
```
但此时可以用 localhost:7777 代替 192.168.1.107:8888：
http://localhost:7777/lab?token=c4117ef94d53b15818bc04a4aabbd8ae0f13789daff2ef12



Jupyter lab中的julia使用详见 JuliaJupyter.ipynb 文件。

## 日常踩坑

julia包安装有时会出现一些莫名问题。此时的万能法宝是：
```bash
rm -rf .julia
```
然后重新安装一遍需要的软件包。