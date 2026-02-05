#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "Please run with root user access"
    exit 1
fi
echo "Installing"
dnf install nginx -y

if [ $? -ne 0 ]; then
    echo "FAILURE"
    exit 1
else
    echo "SUCCESS"
fi