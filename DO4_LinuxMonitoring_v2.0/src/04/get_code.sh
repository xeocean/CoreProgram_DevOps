#!/bin/bash

get_code() {
random=$((RANDOM % 10 + 1))
case $random in
1) code="200";;  # OK – Запрос выполнен успешно
2) code="201";;  # Created – Запрос успешно выполнен, ресурс создан
3) code="400";;  # Bad Request – Неверный запрос
4) code="401";;  # Unauthorized – Не авторизован
5) code="403";;  # Forbidden – Запрещено
6) code="404";;  # Not Found – Ресурс не найден
7) code="500";;  # Internal Server Error – Ошибка на сервере
8) code="501";;  # Not Implemented – Не реализовано
9) code="502";;  # Bad Gateway – Неверный шлюз
10) code="503";;  # Service Unavailable – Сервис недоступен
esac
  echo "$code"
}