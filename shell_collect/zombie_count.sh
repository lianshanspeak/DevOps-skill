#!/bin/bash
ALL_PROCESS=$(ls /proc/ |egrep '[0-9]+')

running_count=0
stop_count=0
sleeping_count=0
zombie_count=0

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
      zombie_count=$((zombie_count+1))
      echo "$pid" >> zombie.txt
      kill -9 "$pid"
    ;;
  esac
done

echo -e "total: $((stop_count+sleeping_count+zombie_count))"
#echo -e "running: $((running_count))\nstoped: $((stoped_count))\nombie: $((zombie_count))"
#echo -e "total: $((running_count+stop_count+sleeping_count+zombie_count))\n
#         running: $((running_count))\n
#         stoped: $((stoped_count))\n
#         zombie: $((zombie_count))"
