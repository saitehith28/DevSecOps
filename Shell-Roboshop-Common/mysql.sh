#!/bin/bash

source ./common.sh
app_name=mysql



dnf install mysql-server -y &>>$LOGS_FILE
VALIDATE $? "Installing MySQL Server"

systemctl enable mysqld &>>$LOGS_FILE
systemctl start mysqld &>>$LOGS_FILE
VALIDATE $? "Enabling and Starting MySQL"

mysql_secure_installation --set-root-pass RoboShop@1 &>>$LOGS_FILE
VALIDATE $? "Setup Root Password"

print_total_time
