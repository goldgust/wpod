#include <stdio.h>
#include <stdlib.h>

void mystrcpy(const char *orig, char *copy) {
  while (*copy++ = *orig++);
}

// strlen
int mystrlen(const char *str) {
  int c = 0;
  while (*str++) {
    c++;
  }
  return c;
}

// duplicate string
char *mystrdup(const char *orig) {
  char *dup = malloc(mystrlen(orig + 1));
  mystrcpy(orig, dup);
  return dup;
}

int isEven(const int number) {
    return !(number % 2);
}

int intarrlen(const int *arr) {
  int c = 0;
  while (*arr++) {
    c++;
  }
  return c;
}

/**
 * Zero terminated.
 */
void printintlist(const int *arr) {
  while (*arr) {
    printf("%d, ", *arr++);
  }
}

/**
 *  Filters a zero terminated list of integers.
 *  Allocates maximum amount of memory.
 */
int *filter(int (*pred)(int), const int *src) {
  int *dest = malloc(intarrlen(src));
  int *head = dest;
  while ((*dest = *src++)) {
    (*pred)(*dest) && dest++;
  }
  return head;
}

//foreach apply functoin to array in place

int main() {
  char *orig = "123456789";
  char *copy = malloc(200);
  int intlist[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 0};
  int *pointto = &intlist[0];

  printf("Orig: %s\n", orig);
  printf("Length: %d\n", mystrlen(orig));
  mystrcpy(orig, copy);
  printf("Copy: %s\n", copy);
  printf("Duplicate: %s\n", mystrdup(orig));
  printf("Evenness of 2: %d\n", isEven(2));
  printintlist(pointto);
  printf("\nlength of intlist before filter %d\n", intarrlen(pointto));
  printintlist(filter(isEven, pointto));
  printf("length after filter %d\n", intarrlen(filter(isEven, pointto)));
}
