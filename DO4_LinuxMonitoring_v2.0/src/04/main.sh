#!/bin/bash

source ./get_ip.sh
source ./get_code.sh
source ./get_method.sh
source ./get_date.sh
source ./get_url.sh
source ./get_agent.sh

count_files=5

for (( i = 1; i <= count_files; i++)); do

  count_log=$((RANDOM % 900 + 100))
  filename="./access$i.log"
  touch $filename

  for (( j = 0; j < count_log; j++ )); do
    ip=$(get_ip)
    date=$(get_date)
    method=$(get_method)
    code=$(get_code)
    url=$(get_url)
    agent=$(get_agent)
    size_byte=$((RANDOM % 1024 + 1024))
    echo "$ip - - [$date] \"$method /index.html HTTP/1.1\" $code $size_byte \"$url\" \"$agent\" -" >> $filename
  done
  sort -t '[' -k2,2 $filename -o $filename
done