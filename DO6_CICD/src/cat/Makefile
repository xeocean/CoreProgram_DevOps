CC := gcc 
CFLAGS := -Wall -Wextra -Werror -std=c11

all: s21_cat

s21_cat: s21_cat.o 
	$(CC) $(CFLAGS) s21_cat.o -o s21_cat 
	rm -f *.o

s21_cat.o: s21_cat.c
	$(CC) $(CFLAGS) s21_cat.c -c

clear: 
	rm -f s21_cat
