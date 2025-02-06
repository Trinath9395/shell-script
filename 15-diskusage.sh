#!/bin/bash

DISK_USAGE=$(df -hT | grep xfs)
DISK_THRESOLD=5

while read -r line
do 
  USAGE=$(echo $line | awk -F " " '{print $6}')
  PARTION=$(echo $line | awk -F " " '{print $NF}')
  echo "Partion of: $PARTION, usage $USAGE"
done <<< "$DISK_USAGE"

