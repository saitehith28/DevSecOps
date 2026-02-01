#/bin/bash

USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-scripting"
LOGS_FILE="$LOGS_FOLDER/$0.log"

if [ $USERID -ne 0 ]; then
    echo "Please try with root user" | tee -a $LOGS_FILE
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
        echo "$package not installed, Installing..."
        dnf install $package -y &>>$LOGS_FILE
        VALIDATE $? "Installing $package"
    else
        echo "$package already installed, skipping"
    fi
done