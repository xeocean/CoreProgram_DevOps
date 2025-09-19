#!/bin/bash

if [[ -d $1 && $1 == */ ]]; then
  start=$(date +%s)
  echo "Total number of folders (including all nested ones) = $(find "$1" -type d 2>/dev/null | wc -l)"
  echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
  du -h --max-depth=1 "$1" 2>/dev/null | sort -rh | head -n 5 | awk '{print NR " - " $2, $1}'
  echo "Total number of files = $(find "$1" -type f 2>/dev/null | wc -l)"
  echo "Number of:"
  echo "Configuration files (with the .conf extension) = $(find "$1" -type f -name "*.conf" 2>/dev/null | wc -l)"
  echo "Text files = $(find "$1" -type f -name "*.txt" 2>/dev/null | wc -l)"
  echo "Executable files = $(find "$1" -type f -executable 2>/dev/null | wc -l)"
  echo "Log files (with the extension .log) = $(find "$1" -type f -name "*.log" 2>/dev/null | wc -l)"
  echo "Archive files = $(find "$1" -type f \( -name "*.tar" -o -name "*.gz" -o -name "*.zip" -o -name "*.7z" -o -name "*.bz2" -o -name "*.xz" \) 2>/dev/null | wc -l)"
  echo "Symbolic links = $(find "$1" -type l 2>/dev/null | wc -l)"
  echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
  find "$1" -type f -exec du -h {} + 2>/dev/null | sort -rh | head -n 10 | awk '{
  ext = ($2 ~ /\./) ? $2 : "not defined"
  sub(/.*\./, "", ext)
  print NR " - " $2, $1, ext
  }'
  echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
  find "$1" -type f -exec du -h {} + 2>/dev/null | sort -rh | head -n 10 | awk '{
  command = "md5sum " $2 " | awk \x27{print $1}\x27"
  command | getline hash
  close(command)
  print NR " - " $2, $1, hash
  }'
  echo "Script execution time (in seconds) = $(($(date +%s) - $start))"
fi