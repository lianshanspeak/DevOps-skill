#!/bin/bash
#假设服务器环境为lnmp，近期访问经常出现502现象，且502错误在重启php-fpm服务后消失，因
#此需要编写监控脚本，一旦出现502，则自动重启php-fpm服务
#脚本死循环，每10秒检测一次，10秒的日志条数为300条，出现502的比例不低于10%（30条）则需要重启php-fpm服务
log=/data/log/access.log
N=30
while ;do
  err=`tail -n 300 $log|grep '502'`
if [ $err -ge $N ] 
then
/etc/init.d/php-fpm restart 2>/dev/null
  sleep 60
fi
sleep 10
done
