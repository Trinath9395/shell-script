#!/bin/bash

USERID=$(id -u)

VALIDATE(){
    if [ $1 -ne 0 ]; then
     echo "$2 ...Failure"
     exit 1
    else
     echo "$2 ...Success"
    fi
}

if [ $USERID -ne 0 ]; then
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