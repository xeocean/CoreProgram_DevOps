#!/bin/bash

start_time=$SECONDS

source ./verify.sh
source ./random_dir.sh

touch ./02.log
echo "Start script: $(date)"
echo "Start script: $(date)" >> ./02.log

length_dir=${#letter_dir}
length_file=${#letter_file}
current_date=$(date +%d%m%y)

count_path=$((RANDOM % 100 + 1))
count_dir=$((RANDOM % 100 + 1))
count_file=$((RANDOM % 100 + 1))

#count_path=4
#count_dir=4
#count_file=4

for (( p = 0; p < $count_path; p++ )); do

  path=$(get_random_dir)
  while ! touch "${path}/test_file" 2>/dev/null; do
      path=$(get_random_dir)
  done

  rm -f "$path/test_file"

  counter_dir=0
  for ((i = 0, j = 0; i < $count_dir; i++, j++)); do
    ./check_space.sh || exit 1

    # Если мы дошли до конца строки
    if [[ $j -eq $length_dir ]]; then
        j=0      # Начинаем с начала строки
        if [[ $counter_dir -eq $length_dir ]]; then
            counter_dir=0  # Сброс позиции, если достигнут конец строки
        fi
        counter_dir=$((j + counter_dir))
        replace=${letter_dir:counter_dir:1}
        ((counter_dir++))
        letter_dir="$letter_dir$replace"
    fi

    replace=${letter_dir:j:1}   # Берём очередной символ из строки
    dir_name="${letter_dir}${replace}"

    dir_path="${path}/${dir_name}_${current_date}"
    mkdir -p "$dir_path"
    echo "Create directory: $dir_path $(date +%F)" >> 02.log

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
      truncate -s "${size}M" "$full_name"
      echo "Create file: $full_name $(date +%F) ${size}Mb" >> 02.log
    done
  done
done

echo "Success :)"

echo "End script: $(date)"
echo "End script: $(date)" >> ./02.log

end_time=$SECONDS
time=$((end_time - start_time))
echo "Script execution time: $time seconds"
echo "Script execution time: $time seconds" >> ./02.log