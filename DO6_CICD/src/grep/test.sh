#!/bin/bash

echo "------------------1------------------"
echo "Команда s21_grep -e x 1.txt"
./s21_grep -e x 1.txt
echo "-------------------------------------"
echo "Стандартная команда grep -e x 1.txt"
grep -e x 1.txt

echo "------------------2------------------"
echo "Команда s21_grep -i x 1.txt"
./s21_grep -i x 1.txt
echo "-------------------------------------"
echo "Стандартная команда grep -i x 1.txt"
grep -i x 1.txt

echo "------------------3------------------"
echo "Команда s21_grep -v x 1.txt"
./s21_grep -v x 1.txt
echo "-------------------------------------"
echo "Стандартная команда grep -v x 1.txt"
grep -v x 1.txt

echo "------------------4------------------"
echo "Команда s21_grep -c x 1.txt"
./s21_grep -c x 1.txt
echo "-------------------------------------"
echo "Стандартная команда grep -c x 1.txt"
grep -c x 1.txt

echo "------------------5------------------"
echo "Команда s21_grep -l x 1.txt"
./s21_grep -l x 1.txt
echo "-------------------------------------"
echo "Стандартная команда grep -l x 1.txt"
grep -l x 1.txt

echo "------------------6------------------"
echo "Команда s21_grep -n x 1.txt"
./s21_grep -n x 1.txt
echo "-------------------------------------"
echo "Стандартная команда grep -n x 1.txt"
grep -n x 1.txt

echo "------------------7------------------"
echo "Команда s21_grep -h x 1.txt"
./s21_grep -h x 1.txt
echo "-------------------------------------"
echo "Стандартная команда grep -h x 1.txt"
grep -h x 1.txt

echo "------------------8------------------"
echo "Команда s21_grep -s x 1.txt 2.xtx"
./s21_grep -s x 1.txt 2.xtx
echo "-------------------------------------"
echo "Стандартная команда grep -s x 1.txt 2.xtx"
grep -s x 1.txt 2.xtx

echo "------------------9------------------"
echo "Команда s21_grep -f 2.txt 1.txt"
./s21_grep -f 2.txt 1.txt
echo "-------------------------------------"
echo "Стандартная команда grep -f 2.txt 1.txt"
grep -f 2.txt 1.txt

echo "------------------10-----------------"
echo "Команда s21_grep -o x 1.txt"
./s21_grep -o x 1.txt
echo "-------------------------------------"
echo "Стандартная команда grep -o x 1.txt"
grep -o x 1.txt

echo "------------------11-----------------"
echo "Команда s21_grep -iv x 1.txt"
./s21_grep -iv x 1.txt
echo "-------------------------------------"
echo "Стандартная команда grep -iv x 1.txt"
grep -iv x 1.txt

echo "------------------12-----------------"
echo "Команда s21_grep -in x 1.txt"
./s21_grep -in x 1.txt
echo "-------------------------------------"
echo "Стандартная команда grep -in x 1.txt"
grep -in x 1.txt

echo "-------------------------------------"
echo "Конец :)"

