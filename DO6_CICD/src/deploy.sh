#!/bin/bash

scp src/cat/s21_cat itsme@192.168.1.104:/usr/local/bin/
scp src/grep/s21_grep itsme@192.168.1.104:/usr/local/bin/
ssh itsme@192.168.1.104 ls /usr/local/bin/

