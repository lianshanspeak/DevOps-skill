#!/bin/bash
#将当前目录下大于 10K 的文件转移到 /tmp 目录，再按
#照文件大小顺序，从大到小输出文件名。

#目标目录
DIRPATH='/tmp'

#查看本地目录
FILEPATH='.'

#涉及知识点
#将xargs的每项名称，一般是一行一行赋值给 {}，可以用 {} 代替。
#NR记录文件行数，注意和FNR的区别，NF是最后一个域

find "$FILEPATH" -size +10k -type f| xargs -i mv {} "$DIRPATH"

ls -ls "$DIRPATH" | awk '{if(NR>1) print $NF}'
