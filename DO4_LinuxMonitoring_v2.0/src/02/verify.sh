#!/bin/bash

if [ $# -ne 3 ]; then
  echo "Incorrect input: expected 3 parameters"
  exit 1
fi

letter_dir=$1
letter_file=$2
size=$3

if ! [[ "$letter_dir" =~ ^[a-zA-Z]{1,7}$ ]]; then
    echo "Incorrect input: $letter_dir is not a valid letters"
    exit 1
fi

if ! [[ "$letter_file" =~ ^[a-zA-Z]{1,7}\.[a-zA-Z]{1,3}$ ]]; then
    echo "Incorrect input: $letter_file is not a valid filename"
    exit 1
fi

if [[ ${size: -2} != "Mb" ]]; then
    echo "Incorrect input: $size is not Mb"
    exit 1
else
  size=${size%Mb}
fi

if [[ $size -gt 100 ]]; then
    echo "Incorrect input: $size is greater than 100 Mb"
    exit 1
fi

declare -A temp_dir
declare -A temp_file

for (( i=0; i<${#letter_dir}; i++ )); do
      char="${letter_dir:$i:1}"
      if [[ -n "${temp_dir[$char]}" ]]; then
          echo "Incorrect input: double values"
          exit 1
      fi
      temp_dir[$char]=1
done

file_name=${letter_file%.*}
for (( i=0; i<${#file_name}; i++ )); do
      char="${file_name:$i:1}"
      if [[ -n "${temp_file[$char]}" ]]; then
          echo "Incorrect input: double values"
          exit 1
      fi
      temp_file[$char]=1
done

echo "Arguments verified!"