#!/bin/bash

source ./verify.sh
read -p "Input path for access.log: " path
files=$(find $path -type f -name "*.log")

if [[ -z "$files" ]]; then
  echo "No files .log"
  exit 1
else
  echo "Find files: $files"
fi

case $1 in
1)
  dir="sort_code"
  mkdir -p $dir
  for file in $files; do
    filename=$(basename "$file")
    awk '{print $9, $0}' "$file" | sort -k1,1 | cut -d ' ' -f2- > "$dir/$filename"
  done
  ;;
2)
  dir="unique_ip"
  mkdir -p $dir
  for file in $files; do
    filename=$(basename "$file")
    awk '{print $1}' "$file" | sort | uniq -c | awk '$1 == 1 {print $2}' | while read ip; do
      grep "^$ip" "$file"
    done > "$dir/$filename"
  done
  ;;
3)
  dir="error_status"
  mkdir -p $dir
  for file in $files; do
    filename=$(basename "$file")
    awk '$9 ~ /^4|^5/ {print $0}' "$file" > "$dir/$filename"
  done
  ;;
4)
  dir="error_unique_ip"
  mkdir -p $dir
  for file in $files; do
    filename=$(basename "$file")
    awk '$9 ~ /^4|^5/ {print $1}' "$file" | sort | uniq -c | awk '$1 == 1 {print $2}' | while read ip; do
      grep "^$ip" "$file"
    done > "$dir/$filename"
  done
  ;;
esac

echo "Success"