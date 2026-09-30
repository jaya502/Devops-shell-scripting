#!/bin/bash

USERID=$(id -u)

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

dnf list installed mysql
#install if it is not found
if [ $? -ne 0 ]; then
  dnf install mysql -y
  VALIDATE $? "MYSQL"
else
    echo -e "MYSQL already exist .... $Y SKIPPING $N"
fi

dnf list installed nginx
#install if it is not found
if [ $? -ne 0 ]; then
dnf install nginx -y
VALIDATE $? "NGINX"
else
    echo -e "NGINX already exist .... $Y SKIPPING $N"
fi

dnf list installed python3
#install if it is not found
if [ $? -ne 0 ]; then
dnf install python3 -y
VALIDATE $? "python3"
else
    echo -e "PYTHON3 already exist .... $Y SKIPPING $N"
fi