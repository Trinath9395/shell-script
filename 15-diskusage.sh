#!/bin/bash

DISK_USAGE=$(df -hT | grep xfs)
DISK_THRESOLD=5

while read -r line
do 
  USAGE=$(echo $line | awk -F " " '{print $6}')

done <<< "$DISK_USAGE"

