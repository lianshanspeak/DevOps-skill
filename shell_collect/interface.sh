#!/bin/bash
#使用方法bash interface.sh eth0
NIC=$1
echo -e "In~~~~~~~~~~~~~out"

while true;do
  OLD_IN=$(awk '$0~"'$NIC'"{print $2}' /proc/net/dev)
  OLD_OUT=$(awk '$0~"'$NIC'"{print $10}' /proc/net/dev)
  sleep 1
  NEW_IN=$(awk '$0~"'$NIC'"{print $2}' /proc/net/dev)
  NEW_OLD=$(awk '$0~"'$NIC'"{print $10}' /proc/net/dev)
  IN=$(printf "%.lf%s" "$((($NEW_IN-$OLD_IN)/1024))" "KB/S")
  OUT=$(printf "%.lf%s" "$((($NEW_OUT-$OLD_OUT)/1024))" "KB/S")
  echo "$IN $OUT"
  sleep 1
done

