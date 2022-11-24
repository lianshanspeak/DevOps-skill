#!/bin/bash
#查找 80 端口请求数最高的前 20 个 IP 地址，判断中间
#最小的请求数是否大于 500，如大于 500，则输出系统活动
#情况报告到 alert.txt，如果没有，则在 600s 后重试，直
#到有输出为止。
state="true"

while $state
do
  SMALL_REQUESTS=$(netstat -ant| awk  -F'[:]+' '/:22/{count[$4]++} END{for(ip in count) print count[ip]}' |sort -n | head -20|head -1)
  if [ "$SMALL_REQUESTS" -gt 500 ];then
    sar -A > aler.txt
    state="fales"
  else
    sleep 6
    continue
  fi
done
