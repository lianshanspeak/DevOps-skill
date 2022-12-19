#!/bin/bash
URL="http://XXX/index.html"
HTTPP_CODE=`curl -o /dev/null -s -w "%{http_code}" "${url}"`

if [ $HTTPP_CODE != 200 ]
then
  echo -e "apache code:"$HTTPP_CODE""
fi
