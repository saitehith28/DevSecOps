#!/bin/bash

echo "All variables passed to the script: $@"
echo "Number of variables passed: $#"
echo "Script Name: $0"
echo "Presentt which directory you are in: $PWD"
echo "Who is running the script: $USER"
echo "Home directory of the user: $HOME"
echo "PID of the current script: $$"
sleep 10&
echo "PID of the background process $!"
echo "All arguments passed to script: $*"
echo "Exit status of last command: $?"