#/bin/bash

R="\e[31m"
G="\e[32m"
B="\e[33m"
N="\e[0m"

USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-scripting"
LOGS_FILE="$LOGS_FOLDER/$0.log"

if [ $USERID -ne 0 ]; then
    echo -e "$R Please try with root user$N" | tee -a $LOGS_FILE
    exit 1
fi

mkdir -p $LOGS_FOLDER

VALIDATE(){
    if [ $1 -ne 0 ]; then
        echo "$2 FAILURE" | tee -a $LOGS_FILE
        exit 1
    else
        echo "$2 SUCCESS" | tee -a $LOGS_FILE
    fi
}

for package in $@
do
    dnf list installed $package &>>$LOGS_FILE
    if [ $? -ne 0 ]; then
        echo -e "$B $package not installed, Installing...$N" | tee -a $LOGS_FILE
        dnf install $package -y &>>$LOGS_FILE
        VALIDATE $? "Installing $package"
    else
        echo -e "$G $package already installed, skipping $N" | tee -a $LOGS_FILE
    fi
done