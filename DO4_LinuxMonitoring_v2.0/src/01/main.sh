#!/bin/bash

source ./verify.sh

touch ./01.log

counter_dir=0
length_dir=${#letter_dir}
length_file=${#letter_file}
current_date=$(date +%d%m%y)

for ((i = 0, j = 0; i < $count_dir; i++, j++)); do
  ./check_space.sh || exit 1

  # Если мы дошли до конца строки
  if [[ $j -eq $length_dir ]]; then
      j=0      # Начинаем с начала строки
      if [[ $counter_dir -eq $length_dir ]]; then
          counter_dir=0  # Сброс позиции, если достигнут конец строки
      fi
      counter_dir=$((j + counter_dir))  # Перемещаем позицию на один символ вперёд
      replace=${letter_dir:counter_dir:1}  # Извлекаем символ на позиции counter_dir
      ((counter_dir++))  # Инкрементируем counter_dir для следующей итерации
      letter_dir="$letter_dir$replace"  # Добавляем символ к строке
  fi

  replace=${letter_dir:j:1}   # Берём очередной символ из строки
  dir_name="${letter_dir}${replace}"

  dir_path="${path}/${dir_name}_${current_date}"
  mkdir -p "$dir_path"
  echo "Create directory: $dir_path $(date +%F)" >> 01.log

  counter_file=0
  filename=${letter_file%.*}
  for (( z = 0, x = 0; z < $count_file; z++, x++)); do
    ./check_space.sh || exit 1

      # Если мы дошли до конца строки
    if [[ $x -eq $length_file ]]; then
        x=0      # Начинаем с начала строки
        if [[ $counter_file -eq $length_file ]]; then
            counter_file=0  # Сброс позиции, если достигнут конец строки
        fi
        counter_file=$((x + counter_file))  # Перемещаем позицию на один символ вперёд
        replace=${filename:counter_file:1}  # Извлекаем символ на позиции counter_dir
        ((counter_file++))  # Инкрементируем counter_dir для следующей итерации
        filename="$filename$replace"  # Добавляем символ к строке
    fi

    replace=${filename:x:1}   # Берём очередной символ из строки
    filename="${filename}${replace}"

    while [[ ${#filename} -lt 4 ]]; do
        replace=${filename:x:1}   # Берём очередной символ из строки
        filename+="$replace"        # Добавляем символ к имени директории
        ((x++))                   # Инкрементируем j
        if [[ $x -ge ${#filename} ]]; then
            x=0  # Если дошли до конца строки, начинаем с начала
        fi
    done


    file_ext="${letter_file##*.}"
    full_name="${dir_path}/${filename}_${current_date}.${file_ext}"

    touch "$full_name"
    truncate -s "${size}K" "$full_name"
    echo "Create file: $full_name $(date +%F) ${size}kb" >> 01.log
  done
done

echo "Success :)"