#!/bin/bash

USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-roboshop"
LOGS_FILE="$LOGS_FOLDER/$0.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
SCRIPT_DIR=$PWD

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

dnf module disable nodejs -y &>>$LOGS_FILE
VALIDATE $? "Disabling NodeJS Default version"

dnf module enable nodejs:20 -y &>>$LOGS_FILE
VALIDATE $? "Enabling NodeJS:20"

dnf install nodejs -y &>>$LOGS_FILE
VALIDATE $? "Installing NodeJS"

id roboshop &>>$LOGS_FILE
if [ $? -ne 0 ]; then
    useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop &>>$LOGS_FILE
    VALIDATE $? "Creating System User"
else
    echo -e "Roboshop User Already Exist... $Y SKIPPING $N" &>>$LOGS_FILE
fi

mkdir -p /app &>>$LOGS_FILE
VALIDATE $? "Creating App Directory"

curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user-v3.zip &>>$LOGS_FILE
VALIDATE $? "Downloading user Code"

cd /app &>>$LOGS_FILE
VALIDATE $? "Moving to App Directory"

rm -rf /app/* &>>$LOGS_FILE
VALIDATE $? "Removing Existing Code"

unzip /tmp/user.zip &>>$LOGS_FILE
VALIDATE $? "Unzipping user Code"

npm install &>>$LOGS_FILE
VALIDATE $? "Installing Dependencies"

cp $SCRIPT_DIR/user.service /etc/systemd/system/user.service &>>$LOGS_FILE
VALIDATE $? "Created Systemctl Service"

systemctl daemon-reload &>>$LOGS_FILE
systemctl enable user &>>$LOGS_FILE
systemctl start user &>>$LOGS_FILE
VALIDATE $? "Reload Enable and Starting user"