#!/bin/bash
set -e
SRC_PATH="/opt/svndate"
DST_PATH="/data/svnbackup"
LOG_FILE="$DST_PATH/logs/svn_backup.log"
SVN_BACKUP_C="/bin/svnadmin_hotcopy"
SVN_LOOK_C="/bin/svnlook_youngset"
TODAY=$(date +'%F')
cd $SRC_PATH
ALL_REPOS=$(find ./ -maxdepth 1 -type d | -name 'httpd' -a | -name 'bak' |tr -d './')

#创建备份目录，备份脚本日志目录
test -d $DST_PATH || mkdir -p $DST_PATH
test -d $DST_PATH/logs || mkdir -p $DST_PATH/logs
test -d $DST_PATH/$TODAY || mkdir -p $DST_PATH/$TODAY

#备份repos文件
for repos in $ALL_REPOS
do 
  $SVN_BACKUP_C $SRC_PATH/$repo $DST_PATH/$TODAY/$repo
  #判断备份是否完成
  if $SVN_LOOK_C $DST_PATH/$TODAY/$repo;then
    echo "$TODAY: $repo BAckup success" >> $LOG_FILE
  else
    echo "$TODAY: $repo Backup fail" >> $LOG_FILE
  fi
done

#备份用户密码文件和权限文件
cp -p authz access.conf $DST_PATH/$TODAY

#日志文件转储
mv $LOG_FILE $LOG_FILE-$TODAY

#删除7天钱的备份
seven_days_ago=$(date -d "7 days ago " +"%F")
rm -rf $DST_PATH/$senven_days_ago
