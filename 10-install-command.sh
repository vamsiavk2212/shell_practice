#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "ERROR: please run with root access"
    exit 1
else
    echo "You are running with root access"
fi

dnf install mysql -y

if [ $? -eq 0 ]
then
    echo "Installing MYSQL is ...SUCCESS"
else
    echo "Installing MYSQL is ...FAILURE"
    exit 1
fi