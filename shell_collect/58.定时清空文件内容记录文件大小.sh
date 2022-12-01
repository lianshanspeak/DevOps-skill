#!/bin/bash
logfile=/tmp/`date +%H-%F`.log
n=`date +%H`
if [ $n -eq 00] || [ $n -eq 12]
then
#通过for循环，以find遍历，将目标目录下的文件遍历
for i in `find /data/log -type f`
do
true > $i
done
else
for i in `find /data/logfile -type f`
do
du -sh $i >> $logfile
done
fi
