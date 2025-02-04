#!/bin/bash

NUMBER1=$1
NUMBER2=$2

if [ -z "$NUMBER1" ] || [ -z "$NUMBER2" ]; then
  echo "please give the arguments to the script"
  exit 1
fi

TIMESTAMP=$(date)
echo "script executed at: $TIMESTAMP"
SUM=$((NUMBER1+NUMBER2))
echo "sum of $NUMBER1 and $NUMBER2 is $SUM"



