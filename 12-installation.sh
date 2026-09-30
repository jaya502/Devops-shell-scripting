#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "ERROR:: please run this script with root privelage"
fi

dnf isnatll mysql -y

if [ $? -ne 0 ]; then
    echo "ERROR:: Installing MYSQL is failuring"
else
    echo "Installing MYSQL is SUCCESS"
fi