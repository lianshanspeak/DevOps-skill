#!/bin/bash
#每隔 1 小时打印 inceptor server 的 jstack 信息，并以 jstack_${当前时间} 命名文件，每当目录下超过
#10 个文件后，删除最旧的文件。
DIRPATH='/tmp/jstack'
CURRENT_TIME=$(date +'%F'-'%H:%M:%S')
if [ ! -d "$DIRPATH" ];then
  mkdir -p "$DIRPATH"
else
  rm -rf "$DIRPATH"/*
fi

cd "$DIRPATH"

while true
do
  sleep 3600
  #这里需要将inceptor改后自己的java进程名称
  pid=$(ps -ef|grep 'inceptor'|grep -v grep|awk '{print $2}')
  jstack $pid >> "jstack_$(CURRENT_TIME)"
  dir_count=$(ls|wc -l)
  if [ "$dir_count" -gt 10 ];then
    rm -f $(ls -tr |head -1)
  fi
done
