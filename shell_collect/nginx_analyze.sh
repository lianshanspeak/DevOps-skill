#!/bin/bash
#日志格式 $remoter_addr - $remoter_user [$time_local] "$request" $status $body_bytes_sent "$http_referer" "$http_user_agent" "$http_forwarded_for" 
LOG_FILE=$1
echo "统计访问最多得10个IP"
awk '{a[$1]++}END{print "UV:",length(a);for (v in a)print v,a[v]}' $LOG_FILE |sort -k2 -nr |head -10

echo "-----------"

echo "统计时间段访问最多得IP"
awk '$4>="[01/Dec/2021:12:23:43]" && $4<="[27/Nov/2021:16:12]"{a[$1++]END{for (v in a)print v,a[v]}}' $LOG_FILE |sort -k2 -nr|head -10

echo "-----------" 


echo "统计访问最多得10个页面"
awk '{a[$7]++}END{print "PV:",length(a);for (v in a){if(a[v]>10)print v,a[v]};}' $LOG_FILE |sort -k2 -nr
echo "-----------"

echo "统计访问页面状态码数量"
awk '{a[$7" "$9]++}END{for(v in a){if(a[v]>5)print v,a[v]}}'
