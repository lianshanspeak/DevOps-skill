#!/bin/bash
#host.info记录ip,name,port三个参数
#将搜集到的数据写道临时文件，在从临时文件中过滤出大于80的
#USE_RATE_LIST取出来的数据：/=18,前面一位是哪块盘的这里是根目录
HOST_INFO=host.info
for IP in $(awk '/^[^#]/{print $1}' $HOST_INFO);do
  USER=$(awk -v ip=$IP 'ip==$1{print $2}' $HOST_INFO)
  PORT=$(awk -v ip=$IP 'ip==$1{print $3}' $HOST_INFO)
  TMP_FILE=/tmp/disk.tmp
  ssh -p $PORT $USER@$IP 'df -h' > $TMP_FILE
  USE_RATE_LIST=$(awk 'BEGIN{OFS="="}/^\/dev/{print $NF,int($5)}' $TMP_FILE)
  for USE_RATE in $USE_RATE_LIST;do
    PART_NAME=${USE_RATE%=*}
    USE_RATE=${USE_RATE#*=}
    if [ $USE_RATE -ge 10 ];then
      echo "warning: $PART_NAME Partition usage $USE_RATE%"
    fi
  done
done
