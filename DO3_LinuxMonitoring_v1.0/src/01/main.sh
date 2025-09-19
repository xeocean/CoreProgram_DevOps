#!/bin/bash

if [ $# -ne 1 ]
then
  echo "Use: $0 <parameter>"
  exit 1
fi

if [[ $1 =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then
    echo -e "Incorrect input"
    exit 1
else
  echo "$1"
fi