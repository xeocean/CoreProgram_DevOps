#!/bin/bash

if [ $# -ne 6 ]; then
  echo "Incorrect input: expected 6 parameters"
  exit 1
fi

path=$1
count_dir=$2
letter_dir=$3
count_file=$4
letter_file=$5
size=$6

if [ ! -d "$path" ]; then
    echo "Incorrect input: $path is not a directory"
    exit 1
fi

if ! [[ "$count_dir" =~ ^[0-9]+$ ]]; then
    echo "Incorrect input: $count_dir is not a digit"
    exit 1
fi

if ! [[ "$count_file" =~ ^[0-9]+$ ]]; then
    echo "Incorrect input: $count_file is not a digit"
    exit 1
fi

if ! [[ "$letter_dir" =~ ^[a-zA-Z]{1,7}$ ]]; then
    echo "Incorrect input: $letter_dir is not a valid letters"
    exit 1
fi

if ! [[ "$letter_file" =~ ^[a-zA-Z]{1,7}\.[a-zA-Z]{1,3}$ ]]; then
    echo "Incorrect input: $letter_file is not a valid filename"
    exit 1
fi

if [[ ${size: -2} != "kb" ]]; then
    echo "Incorrect input: $size is not kb"
    exit 1
else
  size=${size%kb}
fi

if [[ $size -gt 100 ]]; then
    echo "Incorrect input: $size is greater than 100 kb"
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