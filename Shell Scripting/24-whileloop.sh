#/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

count=1
while [ $count -le 5 ]
do
    echo "Count is $count"
    sleep 1
    (count++)
done