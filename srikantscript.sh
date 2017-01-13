#!/bin/bash

INPUT1=$1
INPUT2=$2

awk /REJECT/ > outputcount.log 20000.log
echo "Number of rejected entries:" >> outputcount.log
tr -s ' ' '\n' < outputcount.log | grep REJECT | wc -l >> outputcount.log

aws s3 cp outputcount.log s3://technical-srikanth
