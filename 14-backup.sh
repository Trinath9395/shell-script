#!/bin/bash

USERID=$(id -u)

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} 

LOGS_FOLDER="/var/log/shellscript-logs"
LOG_FILE=$(echo $0 | cut -d '.' -f1)
TIMESTAMP=$(date +%Y-m%-d%-H%-M%-S%)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

VALIDATE(){
    if [ $1 -ne 0 ]; then
     echo "$2...Failure"
    else
     echo "$2...Success"
    fi
}

echo "Script exectuion starting time at: $TIMESTAMP" >>"$LOG_FILE_NAME"

USAGE(){
    echo "USAGE:: sh sh 14-backup.sh <SOURCE_DIR> <DEST_DIR> <DAYS(optinal)>" 
}

mkdir -p /home/ec2-user/shellscript-logs

if [ $# -lt 2 ]; then
 USAGE
fi



