#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1 )
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log
PACKAGES=("mysql" "python" "nginx" "httpd")

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

for package in ${PACKAGES[@]}
do
    dnf list installed $package &>>$LOG_FILE
    if [ $? -ne 0 ]
    then 
        echo -e "$package is not installed .. $Y going to install $N" | tee -a $LOG_FILE
        dnf install $package -y
        VALIDATE $? "$package"
    else
        echo "$package is already installed...nothing to do" | tee -a $LOG_FILE
    fi
done



