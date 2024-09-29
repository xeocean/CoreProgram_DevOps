CC := gcc
CFLAGS := -Wall -Wextra -Werror -std=c11 -pedantic
all: s21_grep

s21_grep: s21_grep.o 
	$(CC) $(CFLAGS) s21_grep.o -o s21_grep 
	rm -f *.o

s21_grep.o: s21_grep.c
	$(CC) $(CFLAGS) s21_grep.c -c

clear: 
	rm -f s21_grep