#!/bin/bash
DATE=$(date +%F_%H-%M-%S)
HOST=localhost
USER=backup
PASS=123.com
BACKUP_DIR=/data/db_backup
DB_LIST=$(mysql -h$HOST -u$USER -p$PASS -s -e "show databses;" 2>/dev/null|egrep -v "Database|information_schema|mysql|performance_schema|sys")

for DB in $DB_LSIT;do
  BACKUP_NAME=$BACKUP_DIR/${DB}_${DATE}.sql
#如果后面没有执行成功就是返回失败
  if ! mysqldump -h$HOST -u$USER -p$PASS -B $DB > $BACKUP_NAME 2>/dev/null;
then
  echo "$NACKUP_NAME 备份失败"
  fi
done
