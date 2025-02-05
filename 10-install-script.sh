#!/bin/bash

USERID=$(id -u)

if [ "$USERID" -ne 0 ]; then
   echo "ERROR:: You must have sudo access to execute the script"
   exit 1
fi

dnf install mysql

if [ $? -ne 0 ]; then
 dnf install mysql -y
 if [ $? -ne 0 ]; then
   echo "Installation of MySQL is...Failed"
   exit 1
 else
   echo "Installation of MySQL is....Success"
 fi
else
 echo "Mysql is already installed"
fi    



dnf install git 

if [ $? -ne 0 ]; then
 dnf install git -y
 if [ $? -ne 0 ]; then
  echo "Installation of Git is...Failed"
  exit 1
 else
  echo "Installation of Git is....Success"
 fi
else
 echo "Git is already installed"
fi

