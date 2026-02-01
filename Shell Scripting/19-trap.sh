#/bin/bash

set -e
trap 'echo "There is an error in $LINENO, Command: $BASH_COMMAND"' ERR

echo "Hello World"
echo "I am Learning Shell"
echoo "Printing Error"
echo "No Error"