#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "ERROR: please run with root access"
else
    echo "You are running with root access"
fi

dnf install mysql -y