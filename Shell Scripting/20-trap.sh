#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

set -e
trap 'echo "There is an error in $LINENO, Command: $BASH_COMMAND"' ERR

USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-scripting"
LOGS_FILE="$LOGS_FOLDER/$0.log"

if [ $USERID -ne 0 ]; then
    echo -e "$R Please try with root user$N" | tee -a $LOGS_FILE
    exit 1
fi

mkdir -p $LOGS_FOLDER

for package in $@
do
    dnf list installed $package &>>$LOGS_FILE
    if [ $? -ne 0 ]; then
        echo -e "$Y $package not installed, Installing...$N" | tee -a $LOGS_FILE
        dnf install $package -y &>>$LOGS_FILE
    else
        echo -e "$G $package already installed, skipping $N" | tee -a $LOGS_FILE
    fi
done