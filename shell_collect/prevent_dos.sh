#!/bin/bash
DATE=$(date +"%F%T")
LOG_FILE=/usr/local/nginx/logs/demo2.access.log
ABNORMAL_IP=$(tail -n5000 $LOG_FILE |grep $DATE |awk '{a[$1++]}END{for (i in a) if(a[i]>10)print i}')
for IP in $ABNORMAL_IP;do
  if [ $(iptables -vnl|grep -c "$IP") -eq 0 ];then
    iptables -I INPUT -s $IP -j DROP
    echo "$(date +"%F_%T") $IP" >> /tmp/drop_ip.log
  fi
done
