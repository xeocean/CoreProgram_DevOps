#!/bin/bash

if [ $# -ne 4 ]; then
  echo "Use: $0 <parameters>"
  exit 1
fi

for param in "$@"; do
  if [[ ! $param =~ [1-6] ]]; then
    echo -e "Incorrect input"
    exit 1
  fi
  if [[ "$1" == "$2" || "$3" == "$4" ]]; then
    echo -e "Incorrect input | Double values"
    exit 1
  fi
done

source ./colors.sh
left_col=$(select_color $1 $2)
right_col=$(select_color $3 $4)
reset="\e[0m"

data="$left_col HOSTNAME = $right_col $(hostname)$reset\n"
data+="$left_col TIMEZONE = $right_col $(cat /etc/timezone) UTC $(date +%z | sed -E 's/^([+-])0*([0-9]{1,2})([0-9]{2})$/\1\2:\3/; s/\:00$//')$reset\n"
data+="$left_col USER = $right_col $(whoami)$reset\n"
data+="$left_col OS = $right_col $(lsb_release -d | awk -F\\t '{print $2}')$reset\n"
data+="$left_col DATE = $right_col $(date "+%d %B %Y %H:%M:%S")$reset\n"
data+="$left_col UPTIME = $right_col $(uptime -p | sed 's/up //')$reset\n"
data+="$left_col UPTIME_SEC = $right_col $(awk '{print $1}' /proc/uptime)$reset\n"
data+="$left_col IP = $right_col $(hostname -I | awk '{print $1}')$reset\n"
IP="$(hostname -I | awk '{print $1}')"
data+="$left_col MASK = $right_col $(ifconfig | grep "$IP" | awk '{print $4}' )$reset\n"
data+="$left_col GATEWAY = $right_col $(ip route | grep default | awk '{print $3}')$reset\n"
data+="$left_col RAM_TOTAL = $right_col $(free -m | awk 'NR==2 {printf "%.3f GB", $2/1024}')$reset\n"
data+="$left_col RAM_USED = $right_col $(free -m | awk 'NR==2 {printf "%.3f GB", $3/1024}')$reset\n"
data+="$left_col RAM_FREE = $right_col $(free -m | awk 'NR==2 {printf "%.3f GB", $4/1024}')$reset\n"
data+="$left_col SPACE_ROOT = $right_col $(df / | awk 'NR==2 {printf "%.2f MB", $2/1024}')$reset\n"
data+="$left_col SPACE_ROOT_USED = $right_col $(df / | awk 'NR==2 {printf "%.2f MB", $3/1024}')$reset\n"
data+="$left_col SPACE_ROOT_FREE = $right_col $(df / | awk 'NR==2 {printf "%.2f MB", $4/1024}')$reset"

echo -e "$data"

