#!/bin/bash

USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-roboshop"
LOGS_FILE="$LOGS_FOLDER/$0.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
SCRIPT_DIR=$PWD
MONGODB_HOST=mongodb.tehith.online

if [ $USERID -ne 0 ]; then
    echo -e "$R Please run this script with root user access $N" | tee -a $LOGS_FILE
    exit 1
fi

mkdir -p $LOGS_FOLDER

VALIDATE(){
    if [ $1 -ne 0 ]; then
        echo -e "$2 ... $R FAILURE $N" | tee -a $LOGS_FILE
        exit 1
    else
        echo -e "$2 ... $G SUCCESS $N" | tee -a $LOGS_FILE
    fi
}

dnf install python3 gcc python3-devel -y &>>$LOGS_FILE
VALIDATE $? "Installing Python"

id roboshop &>>$LOGS_FILE
if [ $? -ne 0 ]; then
    useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop &>>$LOGS_FILE
    VALIDATE $? "Creating System User"
else
    echo -e "Roboshop User Already Exist... $Y SKIPPING $N" &>>$LOGS_FILE
fi

mkdir -p /app &>>$LOGS_FILE
VALIDATE $? "Creating App Directory"

curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment-v3.zip &>>$LOGS_FILE
VALIDATE $? "Downloading Payment Code"

cd /app &>>$LOGS_FILE
VALIDATE $? "Moving to App Directory"

rm -rf /app/* &>>$LOGS_FILE
VALIDATE $? "Removing Existing Code"

unzip /tmp/payment.zip &>>$LOGS_FILE
VALIDATE $? "Unzipping shipping Code"

pip3 install -r requirements.txt &>>$LOGS_FILE
VALIDATE $? "Installing dependencies"

cp $SCRIPT_DIR/payment.service /etc/systemd/system/payment.service
VALIDATE $? "Created systemctl service"

systemctl daemon-reload &>>$LOGS_FILE
systemctl enable payment &>>$LOGS_FILE
systemctl start payment &>>$LOGS_FILE
VALIDATE $? "Reloadig Enabling and Starting payment"