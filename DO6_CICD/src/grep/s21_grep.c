#include <getopt.h>
#include <regex.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Options {
  bool e, i, v, c, l, n, h, s, f, o;
  int files_count;
  int empty_line;
} opt;

void search_options(int argc, char* argv[], char* pattern);
void search_pattern(int* pattern_count, char* pattern, const char* optarg,
                    bool is_file);
void open_files(int argc, char* argv[], char* pattern);
void output_grep(char* argv[], char* pattern, FILE* file);

int main(int argc, char* argv[]) {
  char pattern[8192] = {0};

  if (argc > 1) {
    search_options(argc, argv, pattern);
    open_files(argc, argv, pattern);
  } else {
    printf("s21_grep: Too few arguments\n");
  }
  return 0;
}

void search_pattern(int* pattern_count, char* pattern, const char* optarg,
                    bool is_file) {
  if (*pattern_count > 0) {
    strcat(pattern, "|");
  }

  if (is_file) {
    FILE* file = fopen(optarg, "r");
    char line[8192] = {0};

    if (file != NULL) {
      fseek(file, 0, SEEK_SET);
      while (fgets(line, 8192, file) != NULL) {
        if (line[strlen(line) - 1] == '\n') line[strlen(line) - 1] = '\0';
        if (*pattern_count > 0) strcat(pattern, "|");
        if (*line == '\0') {
          opt.empty_line = 1;
          strcat(pattern, ".");
        } else {
          strcat(pattern, line);
        }
        (*pattern_count)++;
      }
      fclose(file);
    } else {
      printf("s21_grep: %s: No such file\n", optarg);
      exit(1);
    }
  } else {
    if (!optarg) {
      optarg = ".";
      opt.empty_line++;
    }
    strcat(pattern, optarg);
    (*pattern_count)++;
  }
}

void search_options(int argc, char* argv[], char* pattern) {
  int option;
  int pattern_count = 0;
  const char* optstring = "e:f:ivclnhso";

  while ((option = getopt_long(argc, argv, optstring, NULL, NULL)) != -1) {
    switch (option) {
      case 'e':
        opt.e = true;
        search_pattern(&pattern_count, pattern, optarg, false);
        break;
      case 'i':
        opt.i = true;
        break;
      case 'v':
        opt.v = true;
        break;
      case 'c':
        opt.c = true;
        break;
      case 'l':
        opt.l = true;
        break;
      case 'n':
        opt.n = true;
        break;
      case 'h':
        opt.h = true;
        break;
      case 's':
        opt.s = true;
        break;
      case 'f':
        opt.f = true;
        search_pattern(&pattern_count, pattern, optarg, true);
        break;
      case 'o':
        opt.o = true;
        break;
      default:
        exit(1);
    }
  }

  if (opt.empty_line) opt.o = false;
  if (!opt.e && !opt.f) {
    if (!argv[optind]) argv[optind] = ".";
    strcat(pattern, argv[optind]);
    optind++;
  }
}

void open_files(int argc, char* argv[], char* pattern) {
  opt.files_count = argc - optind;

  for (; optind < argc; optind++) {
    FILE* file = fopen(argv[optind], "r");
    if (file != NULL) {
      output_grep(argv, pattern, file);
      fclose(file);
    } else {
      if (!opt.s) {
        printf("s21_grep: %s: No such file or directory\n", argv[optind]);
      }
    }
  }
}

void output_grep(char* argv[], char* pattern, FILE* file) {
  regex_t regex;
  int match_result, reg_flags = REG_EXTENDED;
  char buffer[8192] = {0};
  size_t line_number = 1, nmatch = 1;
  int match_count = 0;
  regmatch_t match[1] = {0};

  if (opt.i) reg_flags |= REG_ICASE;

  if (regcomp(&regex, pattern, reg_flags)) {
    printf("Failed to compile regex.\n");
    exit(1);
  }

  while (fgets(buffer, sizeof(buffer), file)) {
    int insert_line = 1;
    match_result = regexec(&regex, buffer, nmatch, match, 0);
    if (opt.v) match_result = !match_result;

    if (match_result != REG_NOMATCH) {
      if (!opt.c && !opt.l) {
        if (opt.files_count > 1 && !opt.h) printf("%s:", argv[optind]);
        if (opt.n) printf("%lu:", line_number);

        if (opt.o && !opt.v) {
          insert_line = 0;
          char* ptr = buffer;
          while (!match_result) {
            if (match[0].rm_eo == match[0].rm_so) break;
            printf("%.*s\n", (int)(match[0].rm_eo - match[0].rm_so),
                   ptr + match[0].rm_so);
            ptr += match[0].rm_eo;
            match_result = regexec(&regex, ptr, nmatch, match, REG_NOTBOL);
          }
        }
        if (!opt.o) {
          printf("%s", buffer);
          if (buffer[strlen(buffer) - 1] != '\n' && insert_line) printf("\n");
        }
      }
      match_count++;
    }
    line_number++;
  }

  if (opt.c) {
    if (opt.files_count > 1 && !opt.h) printf("%s:", argv[optind]);
    if (opt.l && match_count)
      printf("1\n");
    else
      printf("%d\n", match_count);
  }

  if (opt.l && match_count) printf("%s\n", argv[optind]);

  regfree(&regex);
}
