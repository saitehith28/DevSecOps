#!/bin/bash

source ./common.sh
app_name=catalogue

check_root
app_setup
nodejs_install
systemd_setup

cp $SCRIPT_DIR/mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOGS_FILE
dnf install mongodb-mongosh -y &>>$LOGS_FILE
VALIDATE $? "Installing Mongodb"

INDEX=$(mongosh --host $MONGODB_HOST --quiet  --eval 'db.getMongo().getDBNames().indexOf("catalogue")') &>>$LOGS_FILE
if [ $INDEX -le 0 ]; then
    mongosh --host $MONGODB_HOST </app/db/master-data.js &>>$LOGS_FILE
    VALIDATE $? "Loading Products"
else
    echo -e "$(date "+%Y-%m-%d %H:%M:%S") | Products Already Loaded... $Y Skipping $N" &>>$LOGS_FILE
fi

print_total_time
