#!/bin/bash

get_random_dir() {
    # Ищем все директории
    dirs=$(find / -type d ! -path "*/bin/*" ! -path "*/sbin/*" ! -path "*/sys/*" ! -path "*/snap/*" ! -path "*/usr/*" \
     -perm /g+w,u+w 2>/dev/null | grep -v -e "Permission denied" -e "Отказано")

    dir_array=($dirs)

    random_dir="${dir_array[RANDOM % ${#dir_array[@]}]}"

    if [[ "$random_dir" == *"/bin"* || "$random_dir" == *"/sbin"* ]]; then
        echo "Script cannot be run in directories containing 'bin' or 'sbin'."
        exit 1
    fi

    echo "$random_dir"
}