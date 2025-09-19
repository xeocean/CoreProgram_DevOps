#!/bin/bash

free=$(df / | awk 'NR==2 {print $4}')

if [ "$free" -lt 1048576 ]; then
  echo "Warning: free space < 1Gb!"
  exit 1
fi
