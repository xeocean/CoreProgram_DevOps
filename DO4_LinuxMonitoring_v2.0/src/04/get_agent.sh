#!/bin/bash

get_agent() {
random=$((RANDOM % 9 + 1))
case $random in
1) agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101 Firefox/91.0";;  # Mozilla
2) agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36";;  # Google Chrome
3) agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Opera/77.0.4054.172 Safari/537.36";;  # Opera
4) agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Safari/537.36";;  # Safari
5) agent="Mozilla/5.0 (Windows NT 6.1; Trident/7.0; ASL 1001.2345; .NET CLR 4.5.50709) like Gecko";;  # Internet Explorer
6) agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36 Edg/91.0.864.59";;  # Microsoft Edge
7) agent="Mozilla/5.0 (compatible; Googlebot/2.1;";;  # Crawler (Googlebot)
8) agent='compatible; PostmanRuntime/7.26.5; Windows';;  # Library (Postman)
9) agent="compatible; Google-Read-Aloud;";;  # Net tool (Google-Read-Aloud)
esac
  echo "$agent"
}
