#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1 )
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log

mkdir -p $LOGS_FOLDER
echo "Script started executing at: $(date)" &>>$LOG_FILE

if [ $USERID -ne 0 ]
then
    echo -e "$R ERROR: please run with root access $N" | tee -a $LOG_FILE
    exit 1
else
    echo "You are running with root access"
fi


VALIDATE(){
    if [ $1 -eq 0 ]
then
    echo -e "Installing $2 is ...$G SUCCESS $N" | tee -a $LOG_FILE
else
    echo -e "Installing $2 is ...$R FAILURE $N" | tee -a $LOG_FILE
    exit 1
fi
}

dnf list installed mysql
if [ $? -ne 0 ]
then 
    echo -e "mysql is not installed .. $Y going to install $N" | tee -a $LOG_FILE
    dnf install mysql -y
    VALIDATE $? "mysql"
else
    echo "mysql is already installed...nothing to do" | tee -a $LOG_FILE
fi

dnf list installed python3
if [ $? -ne 0 ]
then 
    echo -e "python3 is not installed ..$Y going to install $N" | tee -a $LOG_FILE
    dnf install python3 -y
    VALIDATE $? "python3"
else
    echo "python3 is already installed...nothing to do" | tee -a $LOG_FILE
fi

dnf list installed nginx
if [ $? -ne 0 ]
then 
    echo -e "nginx is not installed ..$Y going to install $N" | tee -a $LOG_FILE
    dnf install nginx -y
    VALIDATE $? "nginx"
else
    echo "nginx is already installed...nothing to do" | tee -a $LOG_FILE
fi

