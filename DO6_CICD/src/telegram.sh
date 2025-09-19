#!/bin/bash

TOKEN = "TOKEN"
URL="https://api.telegram.org/bot$TOKEN/sendMessage"
TEXT="$CI_JOB_NAME - $CI_JOB_STATUS"
CHAT_ID = "CHAT_ID"

curl -s $URL -d "chat_id=$CHAT_ID" -d "text=$TEXT" >> /dev/null
