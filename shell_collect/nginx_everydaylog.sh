#!/bin/bash
#该脚本就是把昨天的日志文件移动到当月的文件夹中去，并按照日期命名
LOG_DIR=/usr/local/nginx/logs
YESTERDAY_TIME=$(date -d "yesterday" +%F)
LOG_MONTH_DIR=$LOG_DIR/$(date +"%Y-%m")
LOG_FILE_LIST="default.access.log"

for LOG_FILE in $LOG_FILE_LIST;do
  [ ! $LOG_MOUNTH_DIR] && mkdir -p $LOG_MOUNTH_DIR
  mv $LOG_DIR/$LOG_FILE $LOG_MOUNTH_DIR/${LOG_FILE}_${YESTERDAY_TIME)}
done


