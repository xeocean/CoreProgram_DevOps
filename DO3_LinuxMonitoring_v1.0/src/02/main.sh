#!/bin/bash

data="HOSTNAME = $(hostname)\n"
data+="TIMEZONE = $(cat /etc/timezone) UTC $(date +%z | sed -E 's/^([+-])0*([0-9]{1,2})([0-9]{2})$/\1\2:\3/; s/\:00$//')\n"
data+="USER = $(whoami)\n"
data+="OS = $(lsb_release -d | awk -F\\t '{print $2}')\n"
data+="DATE = $(date "+%d %B %Y %H:%M:%S")\n"
data+="UPTIME = $(uptime -p | sed 's/up //')\n"
data+="UPTIME_SEC = $(awk '{print $1}' /proc/uptime)\n"
data+="IP = $(hostname -I | awk '{print $1}')\n"
IP="$(hostname -I | awk '{print $1}')"
data+="MASK = $(ifconfig | grep "$IP" | awk '{print $4}' )\n"
data+="GATEWAY = $(ip route | grep default | awk '{print $3}')\n"
data+="RAM_TOTAL = $(free -m | awk 'NR==2 {printf "%.3f GB", $2/1024}')\n"
data+="RAM_USED = $(free -m | awk 'NR==2 {printf "%.3f GB", $3/1024}')\n"
data+="RAM_FREE = $(free -m | awk 'NR==2 {printf "%.3f GB", $4/1024}')\n"
data+="SPACE_ROOT = $(df / | awk 'NR==2 {printf "%.2f MB", $2/1024}')\n"
data+="SPACE_ROOT_USED = $(df / | awk 'NR==2 {printf "%.2f MB", $3/1024}')\n"
data+="SPACE_ROOT_FREE = $(df / | awk 'NR==2 {printf "%.2f MB", $4/1024}')"

echo -e "$data"

read -p "Do you want to save this data to a file? (Y/N): " answer

if [[ $answer == 'y' || $answer == 'Y' ]]; then
  filename=$(date "+%d_%m_%Y_%H_%M_%S").status
  echo -e "$data" > ./"$filename"
fi
