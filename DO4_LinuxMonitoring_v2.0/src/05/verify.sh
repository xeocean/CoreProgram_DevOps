#!/bin/bash

if [[ $# -ne 1 ]]; then
  echo "Use $0 {parameter}"
  exit 1
fi

if [[ ! "$1" =~ ^[1-4]$ ]]; then
  echo "Incorrect input"
  exit 1
fi