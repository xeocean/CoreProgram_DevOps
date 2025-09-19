#!/bin/bash

source ./config.conf
param1=$column1_background
param2=$column1_font_color
param3=$column2_background
param4=$column2_font_color

params=($param1 $param2 $param3 $param4)
flag=0

default() {
  param1=6
  param2=1
  param3=2
  param4=4
}

if [[ "$param1" == "$param2" || "$param3" == "$param4" ]]; then
  echo -e "Incorrect config | Double values | Use default\n"
  default
  flag=1
fi

if [[ ${#params[@]} -ne 4 ]]; then
  echo -e "Incorrect config | Few values | Use default\n"
  default
  flag=1
fi

for param in "${params[@]}"; do
  if [[ ! "$param" =~ ^[1-6]$ ]]; then
    echo -e "Incorrect config | Out of range | Use default\n"
    default
    flag=1
  fi
done

source ./colors.sh
left_col=$(select_color $param1 $param2)
right_col=$(select_color $param3 $param4)
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
data+="$left_col SPACE_ROOT_FREE = $right_col $(df / | awk 'NR==2 {printf "%.2f MB", $4/1024}')$reset\n"

echo -e "$data"


# Функция для определения цвета
select_colorname() {
  case $1 in
    1) echo -e "white" ;;
    2) echo -e "red" ;;
    3) echo -e "green" ;;
    4) echo -e "blue" ;;
    5) echo -e "purple" ;;
    6) echo -e "black" ;;
  esac
}

if [ $flag == 1 ]; then
  echo "Column 1 background = default ($(select_colorname $param1))"
  echo "Column 1 font color = default ($(select_colorname $param2))"
  echo "Column 2 background = default ($(select_colorname $param3))"
  echo "Column 2 font color = default ($(select_colorname $param4))"
else
  echo "Column 1 background = $param1 ($(select_colorname $param1))"
  echo "Column 1 font color = $param2 ($(select_colorname $param2))"
  echo "Column 2 background = $param3 ($(select_colorname $param3))"
  echo "Column 2 font color = $param4 ($(select_colorname $param4))"
fi