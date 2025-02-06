#!/bin/bash

DISK_USAGE=$(df -hT | grep xfs)
DISK_THRESOLD=5
MSG=""

while read -r line
do 
  USAGE=$(echo $line | awk -F " " '{print $6}')
  PARTION=$(echo $line | awk -F " " '{print $NF}')
  echo "Partion of: $PARTION, usage $USAGE"
  if [ $USAGE -ge $DISK_THRESOLD ]; then
   MSG+="HIGH disk usage on partion on: $PARTION usage is: $USAGE \n

  fi

done <<< "$DISK_USAGE"

echo -e "Message: $MSG"

echo "$MSG" | sendmail -s High disk usage thrinathreddy.d@gmail.com