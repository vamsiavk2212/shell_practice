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
    echo -e "$R ERROR: please run with root access $N" &>>$LOG_FILE
    exit 1
else
    echo "You are running with root access" &>>$LOG_FILE
fi


VALIDATE(){
    if [ $1 -eq 0 ]
then
    echo -e "Installing $2 is ...$G SUCCESS $N" &>>$LOG_FILE
else
    echo -e "Installing $2 is ...$R FAILURE $N" &>>$LOG_FILE
    exit 1
fi
}

dnf list installed mysql &>>$LOG_FILE
if [ $? -ne 0 ]
then 
    echo -e "mysql is not installed .. $Y going to install $N" &>>$LOG_FILE
    dnf install mysql -y &>>$LOG_FILE
    VALIDATE $? "mysql"
else
    echo "mysql is already installed...nothing to do" &>>$LOG_FILE
fi

dnf list installed python3 &>>$LOG_FILE
if [ $? -ne 0 ]
then 
    echo -e "python3 is not installed ..$Y going to install $N" &>>$LOG_FILE
    dnf install python3 -y &>>$LOG_FILE
    VALIDATE $? "python3"
else
    echo "python3 is already installed...nothing to do" &>>$LOG_FILE
fi

dnf list installed nginx &>>$LOG_FILE
if [ $? -ne 0 ]
then 
    echo -e "nginx is not installed ..$Y going to install $N" &>>$LOG_FILE
    dnf install nginx -y &>>$LOG_FILE
    VALIDATE $? "nginx"
else
    echo "nginx is already installed...nothing to do" &>>$LOG_FILE
fi

