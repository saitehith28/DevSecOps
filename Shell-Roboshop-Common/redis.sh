#!/bin/bash

source ./common.sh
app_name=redis


dnf module disable redis -y &>>$LOGS_FILE
VALIDATE $? "Disabling Redis Default version"

dnf module enable redis:7 -y &>>$LOGS_FILE
VALIDATE $? "Enabling Redis:7"

dnf install redis -y  &>>$LOGS_FILE
VALIDATE $? "Installing Redis"

#s/protected-mode yes/protected-mode no
sed -i -e 's/127.0.0.1/0.0.0.0/g' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf &>>$LOGS_FILE
VALIDATE $? "Allowing Remote Connections"

systemctl enable redis &>>$LOGS_FILE
systemctl start redis &>>$LOGS_FILE
VALIDATE $? "Enabling and Starting Redis"

print_total_time