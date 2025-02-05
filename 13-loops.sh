#!/bin/bash

USERID=$(id -u)

LOGS_FOLDER="var/log/shellscript-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date '+%Y%m%d%H%M%S')
LOG_FILE_NAME=$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log

VALIDATE(){
    if [ $1 -ne 0 ]; then
     echo "$2 ...Failure"
     exit 1
    else
     echo "$2 ...Success"
    fi
}

echo "script execution started at: $TIMESTAMP" &>> "$LOG_FILE_NAME"

if [ "$USERID" -ne 0 ]; then
    echo "ERROR:: You must have sudo access to execute the script"
    exit 1
fi

for package in "$@" ; do
 dnf list installed $package
  if [ $? -ne 0 ]; then
    dnf install $package -y
    VALIDATE $? "Installation of $package"
  else
    echo "$package is already installed"
  fi
done


