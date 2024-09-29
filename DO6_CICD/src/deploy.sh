#!/bin/bash

scp src/cat/s21_cat belbysha@192.168.1.104:/usr/local/bin/
scp src/grep/s21_grep belbysha@192.168.1.104:/usr/local/bin/
ssh belbysha@192.168.1.104 ls /usr/local/bin/

