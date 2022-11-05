配置/etc/hosts，为了防止有重复的或错误的ip、主机名写入，做了匹配，先删除再添加；

配置sysct.conf内核参数；

禁用selinux

关闭和禁用防火墙

设置logind.conf，添加RemoveIPC=no

设置network

重新配置yun仓库（如果有可以注释掉）

禁用透明大页，在rc.loca中添加了禁用命令
