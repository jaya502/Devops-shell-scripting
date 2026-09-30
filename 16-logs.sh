#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$( echo $0 | cut -d "." -f1 )
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER
echo "Script started executed at: $(date)"

if [ $USERID -ne 0 ]; then
    echo "ERROR:: please run this script with root privelage"
    exit 1 #failure is other than 0
fi

VALIDATE (){ # functions receive inputs through arguments just like shell scripts args
    if [ $1 -ne 0 ]; then
        echo -e "Installing $2 ... $R FAILURE $N"
        exit 1
    else
        echo -e "Installing $2 ... $G SUCCESS $N"
    fi
}

dnf list installed mysql &>>$LOG_FILE
#install if it is not found
if [ $? -ne 0 ]; then
  dnf install mysql -y &>>$LOG_FILE
  VALIDATE $? "MYSQL"
else
    echo -e "MYSQL already exist .... $Y SKIPPING $N"
fi

dnf list installed nginx &>>$LOG_FILE
#install if it is not found
if [ $? -ne 0 ]; then
dnf install nginx -y &>>$LOG_FILE
VALIDATE $? "NGINX"
else
    echo -e "NGINX already exist .... $Y SKIPPING $N"
fi

dnf list installed python3 &>>$LOG_FILE
#install if it is not found
if [ $? -ne 0 ]; then
dnf install python3 -y &>>$LOG_FILE
VALIDATE $? "python3"
else
    echo -e "PYTHON3 already exist .... $Y SKIPPING $N"
fi

