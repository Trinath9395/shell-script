#!/bin/bash

USERID=$(id -u)

LOGS_FOLDER="var/log/shellscript-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date '+%Y%m%d%H%M%S')
LOG_FILE_NAME=$LOGS_FOLDER/LOG_FILE-$TIMESTAMP.log

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

dnf list installed mysql

if [ $? -ne 0 ]; then
   dnf install mysql -y
   VALIDATE $? "Installation of MySQL"
else
   echo "Mysql is already installed"
fi    

dnf list installed git
if [ $? -ne 0 ]; then
   dnf install git -y
   VALIDATE $? "Installation of Git"
else
   echo "Git is already installed"
fi