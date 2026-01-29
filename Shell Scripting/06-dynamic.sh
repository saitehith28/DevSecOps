#!/bin/bash

START_TIME=$(date +%s)
echo "Script started at: $START_TIME"

sleep 10
END_TIME=$(dat +%s)
TOTAL_TIME=$(($END_TIME-$START_TIME))
echo "Script executed in $TOTAL_TIME"
