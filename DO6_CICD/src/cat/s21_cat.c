#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void print_file(FILE *file, int number_nonblank, int number, int squeeze_blank,
                int show_ends, int show_tabs, int show_nonprint) {
  char buffer[1024];
  static int line_number = 1;
  int prev_was_blank = 0;

  while (fgets(buffer, sizeof(buffer), file)) {
    int is_blank = (buffer[0] == '\n');

    if (squeeze_blank && is_blank && prev_was_blank) {
      continue;
    }

    if (number_nonblank && !is_blank) {
      printf("%6d\t", line_number++);
    } else if (number) {
      printf("%6d\t", line_number++);
    }

    for (char *c = buffer; *c != '\0'; c++) {
      if (show_tabs && *c == '\t') {
        printf("^I");
      } else if (show_ends && *c == '\n') {
        printf("$\n");
      } else if (show_nonprint && !isprint((unsigned char)*c) && *c != '\n' &&
                 *c != '\t') {
        if (*c < 32) {
          printf("^%c", *c + 64);
        } else if (*c == 127) {
          printf("^?");
        } else {
          printf("M-^%c", *c - 128 + 64);
        }
      } else {
        putchar(*c);
      }
    }

    prev_was_blank = is_blank;
  }
}

int main(int argc, char *argv[]) {
  int number_nonblank = 0, number = 0, squeeze_blank = 0, show_ends = 0,
      show_tabs = 0, show_nonprint = 0;

  int file_provided = 0;

  for (int i = 1; i < argc; i++) {
    if (strcmp(argv[i], "-b") == 0 ||
        strcmp(argv[i], "--number-nonblank") == 0) {
      number_nonblank = 1;
    } else if (strcmp(argv[i], "-e") == 0 || strcmp(argv[i], "-E") == 0) {
      show_ends = 1;
      show_nonprint = 1;
    } else if (strcmp(argv[i], "-n") == 0 || strcmp(argv[i], "--number") == 0) {
      number = 1;
    } else if (strcmp(argv[i], "-s") == 0 ||
               strcmp(argv[i], "--squeeze-blank") == 0) {
      squeeze_blank = 1;
    } else if (strcmp(argv[i], "-t") == 0 || strcmp(argv[i], "-T") == 0) {
      show_tabs = 1;
      show_nonprint = 1;
    } else if (strcmp(argv[i], "-v") == 0) {
      show_nonprint = 1;
    }
  }

  for (int i = 1; i < argc; i++) {
    if (argv[i][0] != '-') {
      file_provided = 1;
      FILE *file = fopen(argv[i], "r");
      if (!file) {
        perror("Ошибка:");
        return 1;
      }
      print_file(file, number_nonblank, number, squeeze_blank, show_ends,
                 show_tabs, show_nonprint);
      fclose(file);
    }
  }

  if (!file_provided) {
    print_file(stdin, number_nonblank, number, squeeze_blank, show_ends,
               show_tabs, show_nonprint);
  }

  return 0;
}
