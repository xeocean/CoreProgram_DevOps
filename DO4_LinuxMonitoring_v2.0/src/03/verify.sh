#!/bin/bash

if [[ $# -ne 1 ]]; then
  echo "Use remove parameter:"
  echo "1: remove by log file"
  echo "2: remove by datetime"
  echo "3: remove by mask"
  exit 1
fi

if [[ ! "$1" =~ ^[1-3]$ ]]; then
  echo "Incorrect input"
  exit 1
fi

