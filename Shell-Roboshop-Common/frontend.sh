#!/bin/bash

source ./common.sh
app_name=frontend

check_root


dnf module disable nginx -y &>>$LOGS_FILE
dnf module enable nginx:1.24 -y &>>$LOGS_FILE
dnf install nginx -y &>>$LOGS_FILE
VALIDATE $? "Installing Nginx"

systemctl enable nginx &>>$LOGS_FILE
systemctl start nginx &>>$LOGS_FILE
VALIDATE $? "Enabling and Starting Nginx"

rm -rf /usr/share/nginx/html/* &>>$LOGS_FILE
VALIDATE $? "Remove Default Content"

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip &>>$LOGS_FILE
cd /usr/share/nginx/html &>>$LOGS_FILE
unzip /tmp/frontend.zip &>>$LOGS_FILE
VALIDATE $? "Downloaded and Unzipped Frontend"

rm -rf /etc/nginx/nginx.conf &>>$LOGS_FILE
cp $SCRIPT_DIR/nginx.conf /etc/nginx/nginx.conf &>>$LOGS_FILE
VALIDATE $? "Copied our nginx conf file"

systemctl restart nginx &>>$LOGS_FILE
VALIDATE $? "Restarting Nginx"