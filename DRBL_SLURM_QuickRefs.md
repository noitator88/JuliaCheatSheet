---
title: DRBL + SLURM 跳坑指南
author: rotation
---

# DRBL

一个很简单的无盘集群系统，基于tftp+nfs+nis的方案，做小集群很方便。服务器配置好之后，很多时候直接连接新的无盘计算节点就可以使用。

官方安装指南：http://drbl.nchc.org.tw/one4all/desktop/

## 安装之前

主控服务器双网卡配置：

```bash
$ ifconfig
enp6s0f0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.0.176  netmask 255.255.255.0  broadcast 10.0.0.255
        inet6 fe80::a60:6eff:fe17:c3ec  prefixlen 64  scopeid 0x20<link>
        ether 08:60:6e:17:c3:ec  txqueuelen 1000  (以太网)
        RX packets 529349  bytes 174284568 (174.2 MB)
        RX errors 0  dropped 13  overruns 0  frame 0
        TX packets 96796  bytes 9730978 (9.7 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device memory 0xcca20000-cca3ffff

enp6s0f1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.1.1  netmask 255.255.255.0  broadcast 192.168.1.255
        inet6 fe80::a60:6eff:fe17:c3ed  prefixlen 64  scopeid 0x20<link>
        ether 08:60:6e:17:c3:ed  txqueuelen 1000  (以太网)
        RX packets 5248968  bytes 3061215728 (3.0 GB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 8859883  bytes 10601130001 (10.6 GB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device memory 0xcca00000-cca1ffff

```

安装drbl包

```bash
$ wget -q http://drbl.nchc.org.tw/GPG-KEY-DRBL -O- | sudo apt-key add - # 取得公钥
$ deb http://free.nchc.org.tw/drbl-core drbl stable                     # 稳定版apt地址
$ sudo aptitude install drbl                                            # 安装drbl
```

可以看到drbl的核心就是一堆perl脚本

```bash
$ dpkg -L drbl
```

主要配置文件集中在/etc/drbl中，注意备份好这个目录，重装就很方便。

```bash
$ ls -l /etc/drbl
-rw-r--r-- 1 root root   172 Nov 13 12:51 IP_HOST_TABLE
-rw-r--r-- 1 root root   511 May 29  2020 auto_login_host_id_passwd.example
-rw-r--r-- 1 root root  4246 May 29  2020 boot-local-efi.cfg
-rw-r--r-- 1 root root   551 May 29  2020 client-append-fstab.example
-rw-r--r-- 1 root root   289 May 29  2020 client-extra-service.example
-rw-r--r-- 1 root root   102 Nov 13 11:49 client-ip-hostname
-rw-r--r-- 1 root root   985 May 29  2020 client-ip-hostname.example
-rw-r--r-- 1 root root    84 Nov 13 12:51 clients-of-192.168.1.1.txt
-rw-r--r-- 1 root root    84 Nov 13 12:43 clients-of-192.168.1.1.txt.drblsave
-rw-r--r-- 1 root root   415 May 29  2020 dcsrc.example
-rw-r--r-- 1 root root 29664 Nov 13 12:52 drbl-ocs.conf
-rw-r--r-- 1 root root 31124 Sep 25 21:13 drbl.conf
-rw------- 1 root root  1255 Nov 13 12:52 drbl_deploy.conf
-rw------- 1 root root   927 Nov 13 12:52 drblpush.conf
```

无盘节点只需要设置好pxe网络启动就能用，但是一般都是希望固定每个节点的ip地址。这样需要两个额外的文件：

一个是无盘节点网卡的mac地址

```bash
$ cat macadr.txt
12:45:78:9a:bd:ce   # 瞎编mac #1
12:45:78:9a:bd:cd   # 瞎编mac #2
12:45:78:9a:bd:cf
12:45:78:9a:bd:c1
12:45:78:9a:bd:c2
```

另一个是对应的ip地址

```bash
$ cat client-ip-hostname
192.168.1.101 b1
192.168.1.102 b2
192.168.1.103 b3
192.168.1.104 b4
192.168.1.105 b5
```

client-ip-hostname需要放在/etc/drbl里面，macadr.txt位置随意(最好也放在/etc/drbl里面方便备份)

## 配置drbl

极其简单，两行命令搞定。

**第一行**

```bash
$ drblsrv -i
```

此时会下载大量软件包(tftp之类的)，最好是先确保apt源的连接稳定，避免节外生枝。

**第二行**

```bash
$ drblpush -i
```

设置drbl的各个服务(tftp/nfs/nis)，很多选项都可以直接Enter接受，只有下面两项略需注意

1. ip绑定方式

   推荐用前述的client-ip-hostname配合macadr.txt设定节点ip地址。这样ip与硬件的对应很清晰(两个文件一对比就ok了)，节点出问题排查也好做。

2. drbl模式

   小集群用full drbl比较方便，这样每个节点可以单独配置，节点的root文件系统存在/tftpboot/nodes/[node-ip-address]中。

drblpush成功之后会生成/etc/drbl/drbl.conf文件，包含drbl的主要配置。之后每次服务器安装新软件包，需要跑一次drblpush，此时可以直接用这个conf文件

```bash
$ drblpush -c /etc/drbl/drbl.conf
```

drblpush成功之后就可以直接启动无盘节点了。

# SLURM

代替pbs/torque的集群管理系统，大小集群均适用。slurm包含三部分：客户端(client side commands)、计算节点服务(compute node daemon)与主控节点服务(central management daemon)。ubuntu下全家桶安装只需一行

```bash
$ apt-get install slurm-wlm
```

## 安装之前

1. slurm登陆到计算节点需要依靠munge验证。因此要首先保证munge服务正确运行

```bash
$ ps aux | grep munged
munge       2871  0.1  0.0 202916  3952 ?        Sl   Nov13   3:00 /usr/sbin/munged
```

且munge.key文件存在

```bash
$ ll /etc/munge/munge.key     # 需要root权限
-r-------- 1 munge munge 1024 Nov 13 10:57 /etc/munge/munge.key
```

2. 正确设定主控节点的hostname，这需要配置两个文件

```bash
$ cat /etc/hostname
ss1                               # 主控节点hostname
$ cat /etc/hosts
127.0.0.1	localhost

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
192.168.1.1 ss1                     # 主控节点ip地址
192.168.1.101 b1                    # 计算节点ip地址
192.168.1.102 b2
192.168.1.103 b3
192.168.1.104 b4
192.168.1.105 b5
```

## SLURM配置

slurm有配置文件生成工具

```bash
$ dpkg -L slurmctld
...
/usr/share/doc/slurmctld/slurm-wlm-configurator.easy.html
/usr/share/doc/slurmctld/slurm-wlm-configurator.html
...
$ cd /usr/share/doc/slurmctld
$ python3 -m http.server
```

然后localhost:8000端口打开slurm-wlm-configurator.html。多数可以缺省配置，只有几个地方要注意

1. SlurmctldHost

   使用之前的设定好的hostname

2. ProctrackType = linuxproc

3. SelectType = select/cons_res

4. SelectTypeParameters = CR_Core_Memory

5. AccountingStorageType=accounting_storage/filetxt

然后submit得到配置文件，存储为/etc/slurm-llnl/slurm.conf。

slurm的计算节点配置部分可以自己写

```bash
tail /etc/slurm-llnl/slurm.conf

# COMPUTE NODES
NodeName=ss1 CPUs=2 State=DOWN             # 主控节点不做计算，但是需要写在NodeName里面
NodeName=b1 CPUs=32 ThreadsPerCore=2 RealMemory=16000     # b1 节点32线程16G内存
NodeName=b[2-5] CPUs=40 ThreadsPerCore=2 RealMemory=32000 # b2-b5 节点40线程32G内存
# 缺省计算分区，包含b1-b5节点，无最大计算时间限制
PartitionName=debug Nodes=b[1-5] Default=YES MaxTime=INFINITE State=UP
```



启动slurm服务之前，还需要

```bash
touch /var/log/slurm_jobacct.log
```

否则slurmd会抱怨找不到slurm_jobacct.log

首先启动任务调度，然后检查slurmd是否正确运行

```bash
$ service slurmctld restart
$ slurmd -Dvvv
```

没报错退出的话，就可以正常启动slurmd了

```bash
$ service slurmd restart
```

## DRBL + SLURM

最后我们需要利用drblpush配置无盘计算节点。

```bash
$ drblpush -c /etc/drbl/drbl.conf
```

**注意⚠️**：此时**最大的坑**来自drlbpush的dhcp设定：因为它会修改/etc/hosts.现在我还不知道简洁的解决方案，因此每次drblpush之后都要手动修改主控服务器(/etc/hosts)与各个计算节点的hosts文件(/tftpboot/nodes/[node-ip-address]/etc/hotst)。

此时slurm已经设定完毕，重启整个系统应该可以正常使用了。最直接的检查方式是

```bash
srun -N5 hostname
b3
b5
b2
b1
b4
```



# 踩坑指南

1. SLURM 查看node状态用

```bash
$ sinfo -N
NODELIST   NODES PARTITION STATE
b3             1    debug* idle
b4             1    debug* idle
b5             1    debug* idle
...
```

当计算节点因为一场状态重启的时候(node unexpectedly reboot)，sinfo会显示node down，此时需要更新节点状态，例如

```bash
 scontrol update NodeName=b4 State=RESUME
```

2. 时间服务

   如果计算节点与主控服务器的时间不同步，slurmd会报错

   ```bash
   slurmd -Dvvv : Unable to register: Zero Bytes were transmitted or received
   ```

   此时可以用ntp服务来同步系统时间。



