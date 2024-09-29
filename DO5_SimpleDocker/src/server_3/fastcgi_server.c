#include <fcgi_stdio.h>
#include <stdlib.h>

int main(void) {
  while (FCGI_Accept() >= 0) {
    printf("Content-Type: text/plain\r\n\r\n");
    printf("Hello world");
  }
  return 0;
}
