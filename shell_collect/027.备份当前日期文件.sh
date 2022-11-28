#!/bin/bash
#一月前
historyTime=$(date "+%Y-%m-%d %H" -d '1 month ago')
echo ${historyTime}
historyTimeStamp=$(date -d "$historyTime" +%s)
echo ${historyTimeStamp}

#一周前
$(date "+%Y-%m-%d %H" -d '7 day ago')

#本月一月一日
date_this_mounth=`date +%Y%m01`


#一天前
date_today=`date -d '1 days ago' +%Y%m%d`


#一小时前
$(date "+%Y-%m-%d %H" -d '-1 hours')
