#!/bin/bash

NUMBER=$1

if [$NUMBER -gt 20]; then
    echo "Number is greater than 20"
elif [$NUMBER -eq 20]; then
    echo "Number is equal to 20"
else
    echo "Number is less than 20"
fi