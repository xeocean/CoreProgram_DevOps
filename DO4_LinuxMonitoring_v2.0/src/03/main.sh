#!/bin/bash

source ./verify.sh

case $1 in
1)
  deleted=$(grep -o 'Create directory: */[^ ]*' ../02/02.log | grep -o '[^ ]*/[^ ]*' | xargs -r rm -rfv | wc -l)
  echo "Success: deleted $deleted files"
  ;;
2)
  # WARNING !!!
  read -p "Input first datetime (YYYY-MM-DD HH:MM:SS): " firstdate
  read -p "Input second datetime (YYYY-MM-DD HH:MM:SS): " seconddate
  files_to_delete=$(find / -name '*_*' -type d -not -path '*sbin*' -not -path '*bin*' -newerct "$firstdate" ! -newerct "$seconddate" 2>/dev/null)
  if [ -z "$files_to_delete" ]; then
    echo "No files found for deletion."
  else
    count=$(echo "$files_to_delete" | wc -l)
    echo "$files_to_delete" | xargs -r rm -rf
    echo "Success: deleted $count directories."
  fi
  ;;
3)
  read -p "Input mask (azxc): " mask
  read -p "Input date (300125): " date #111125
  files_to_delete=$(find / -type d -name "$mask*_$date" 2>/dev/null)
  if [ -z "$files_to_delete" ]; then
    echo "No files found for deletion."
  else
    count=$(echo "$files_to_delete" | wc -l)
    echo "$files_to_delete" | xargs -r rm -rf
    echo "Success: deleted"
  fi
  ;;
esac