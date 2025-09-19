#!/bin/bash

get_method() {
random=$((RANDOM % 5 + 1))
case $random in
1) method="GET";;
2) method="POST";;
3) method="PUT";;
4) method="PATCH";;
5) method="DELETE";;
esac
  echo "$method"
}
