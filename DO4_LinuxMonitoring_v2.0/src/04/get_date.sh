#!/bin/bash

get_date() {
  date=$(date +%d/%b/%Y)
  hour=$(($RANDOM % 24))    # Случайный час от 0 до 23
  minute=$(($RANDOM % 60))  # Случайная минута от 0 до 59
  second=$(($RANDOM % 60))  # Секунда от 0 до 59
  echo "${date}:$(printf "%02d:%02d:%02d" $hour $minute $second) +0000"
}

