\#!/bin/bash

LIMIT=30   #这边可以自定义限制次数

LOGFILE="/var/log/block_ssh.log"   #日志路径

TIME=$(date '+%b %e %H')   #example: Apr 11 11

BLOCK_IP=$(grep "$TIME" /var/log/secure|grep Failed|awk '{print $(NF-3)}'|sort|uniq -c|awk '$1>"$LIMIT"{print $1":"$2}')   #将1小时内ssh认证失败超过30次的ip抓出来

#测试

\#BLOCK_IP=`cat /root/ip_list`

for i in $BLOCK_IP

do

   IP=$(echo $i|awk -F: '{print $2}')

   cat /etc/hosts.deny | grep $IP>/dev/null   #先判断下是否已经被屏蔽

   if [ $? -gt 0 ];then

​     echo "sshd:$IP" >> /etc/hosts.deny  #屏蔽ip

​     NOW=$(date '+%Y-%m-%d %H:%M')

​     echo -e "$NOW : $IP">>${LOGFILE}

   fi

done