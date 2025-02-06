#!/bin/bash

USERID=$(id -u)

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} 

LOGS_FOLDER="/home/ec2-user/shellscript-logs"
LOG_FILE=$(basename "$0" | cut -d '.' -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

mkdir -p "$LOGS_FOLDER"

VALIDATE(){
    if [ $1 -ne 0 ]; then
     echo "$2...Failure" | tee -a "$LOG_FILE_NAME"
    else
     echo "$2...Success" | tee -a "$LOG_FILE_NAME"
    fi
}

echo "Script execution started at: $TIMESTAMP" | tee -a "$LOG_FILE_NAME"

USAGE(){
    echo "USAGE:: sh 14-backup.sh <SOURCE_DIR> <DEST_DIR> <DAYS(optional)>" | tee -a "$LOG_FILE_NAME"
    exit 1
}

if [ $# -lt 2 ]; then
 USAGE
fi

if [ ! -d "$SOURCE_DIR" ]; then
 echo "$SOURCE_DIR does not exist...Please check" | tee -a "$LOG_FILE_NAME"
 exit 1
fi

if [ ! -d "$DEST_DIR" ]; then
 echo "$DEST_DIR does not exist...Please Check" | tee -a "$LOG_FILE_NAME"
 exit 1
fi

FILES=$(find "$SOURCE_DIR" -name "*.log" -mtime +"$DAYS")

if [[ -n "$FILES" ]]; then
  echo "Files to be zipped: $FILES" | tee -a "$LOG_FILE_NAME"
  ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"
  echo "$FILES" | zip -@ "$ZIP_FILE"
  if [ -f $ZIP_FILE ]; then
   echo "$ZIP_FILE is is created successfully"
  else
   echo "$ZIP_FILE is failed to create"
   exit 1
  fi 
  VALIDATE $? "Zipping log files"
else
 echo "No files found to zip older than $DAYS days." | tee -a "$LOG_FILE_NAME"
fi
