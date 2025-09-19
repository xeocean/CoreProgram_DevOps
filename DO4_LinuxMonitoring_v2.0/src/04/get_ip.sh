#!/bin/bash

get_ip() {
  ip1=$((RANDOM % 255 + 1))
  ip2=$((RANDOM % 255))
  ip3=$((RANDOM % 255))
  ip4=$((RANDOM % 255))
  echo "${ip1}.${ip2}.${ip3}.${ip4}"
}