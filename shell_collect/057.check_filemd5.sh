#!/bin/bash
#对比两台文件上的md5值，达到检测一致性目的
dir=/data/web
b_ip=192.168.12.120

#指定目录下的文件全部遍历出来作为md5sum命令的参数，得到所有文件的md5值,写入到指定文件中
find $dir -type f|xargs md5sum > /tmp/md5_a.txt
ssh $b_ip "find $dir -type f|xargs md5sum > /tmp/md5_b.txt"
scp $b_ip:/tmp/md5_b.txt

#将文件名作为遍历对象一一对比
for f in `awk '{print 2} /tmp/md5_a.txt'`do
if grep -qw "$f" /tmp/md5_b.txt
then
md5_a=`grep -w "$f" /tmp/md5_a.txt |awk '{print 1}'`
md5_b=`grep -w "$f" /tmp/md5_b.txt |awk '{print 1}'`
#当文件存在时，如果md5值不一致则输出文件改变的结果
if [ $md5_a != $md5_b ]then
echo "$f changed!"
fi
else
echo "$f deleted!"
fi 
done