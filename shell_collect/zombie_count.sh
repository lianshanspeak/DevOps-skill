#!/bin/bash
ALL_PROCESS=$(ls /proc/ |egrep '[0-9]+')

running_count=0
stop_count=0
sleeping_count=0
zombile_count=0

for pid in ${ALL_PROCESS[*]}
do
  test -f /proc/$pid/status && state=$(egrep "State" /proc/$pid/status |awk '{print $2}')
  case "$state" in
    R)
      running_count=$((running_count+1))
    ;;
    T)
      stop_count=$((stop_count+1))
    ;;
    S)
      sleeping_count=$((sleeping_count+1))
    ;;
    Z)
      zombile_count=$((zombile_count+1))
      echo "$pid" zombile.txt
      kill -9 "$pid"
    ;;
  esac
done


echo 1
echo -e "total: $((running_count+stop_count+sleeping_count+zombile_count))\n
         running: $((running_count))\n
         stoped: $((stoped_count))\n
         zombile: $((zombile_count))"
