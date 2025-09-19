#!/bin/bash

get_url() {
random=$((RANDOM % 2 + 1))
case $random in
1) protocol="http://";;
2) protocol="https://";;
esac
random=$((RANDOM % 5 + 1))
case $random in
1) domain=".com";;
2) domain=".ru";;
3) domain=".gov";;
4) domain=".info";;
5) domain=".net";;
esac
url=$((RANDOM % 1000))

echo "$protocol$url$domain"
}
