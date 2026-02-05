#!/bin/bash

USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-roboshop"
LOGS_FILE="$LOGS_FOLDER/$0.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$1
DAYS=${3:-14} #14 days is the default value, if the user not supplied

log(){
    echo -e "$(date +"%Y-%m-%d %H:%M:%S") | $1 | tee -a $LOGS_FILE"
}

if [ $USERID -ne 0 ]; then
    echo -e "$R Please run the script with root user access $N"
    exit 1
fi

mkdir -p $LOGS_FOLDER

USAGE(){
    log "$R USAGE: sudo backup <SOURCE DIR> <DEST DIR> <DAYS> [Default 14 days] $N"
}

if [ $# -lt 2 ]; then
    USAGE
fi

if [ ! -d $SOURCE_DIR ]; then
    log "$R Source Directory: $SOURCE_DIR does not exist $N"
    exit 1
fi

if [ ! -d $DEST_DIR ]; then
    log "$R Destination Directory: $DEST_DIR does not exit $N"
    exit 1
fi

#Find the files
FILES=$(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

log "Backup Started"
log "Source Directory: $SOURCE_DIR"
log "Destination Directory: $DEST_DIR"
log "Days: $DAYS"

if [ -z "${FILES}" ]; then
    log "No files to archieve ... $Y Skipping $N"
else
    #app-logs-$timestamp.zip
    log "Files found to Archieve: $FILES"
    TIMESTAMP=$(date +%F-%H-%M-%S)
    ZIP_FILE_NAME="$DEST_DIR/app-logs-$TIMESTAMP.tar.gz"
    log "Archieve Name: $ZIP_FILE_NAME"
    tar -zcvf $ZIP_FILE_NAME $(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

    #Check Archieve is success or not
    if [ -f $ZIP_FILE_NAME ]; then
        log "Archieval is ... $G SUCCESS $N"

        while IFS= read -r filepath; do
            log "Deleting file: $filepath"
            rm -f $filepath
            log "Deleted file: $filepath"
        done <<< $FILES
    else
        log "Archieval is ... $R FAILURE $N"
        exit 1
    fi
fi
