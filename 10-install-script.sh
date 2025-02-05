#!/bin/bash

USERID=$(id -u)

if [ "$USERID" -ne 0 ]; then
   echo "ERROR:: You must have sudo access to execute the script"
   exit 1
fi

dnf install mysql -y

if [ $? -eq 0 ]; then
  echo "Installation of MYSQL is...Failed"
  exit 1
else
  echo "Installation of MYSQL is...Success"
fi   