#!/bin/bash
function MyInstall
{
  if ! rpm -qa|grep -q "^$1"
  then
    yum install $1
    if [ $? -eq 0 ]
    then
      echo -e "$1 install ok\n"
    else
      echo -e "$1 install no\n"
   fi
  else
    echo -e "已安装!\n"
  fi
}

for i in mysql php httpd
do 
  MyInstall $i
done

