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

/**
 *  Applies a function to a zero terminated list of integers (in place).
 */
int *foreach(int (*pred)(int), int *src) {
  int *head = src;
  while ((*src)) {
    *src = (*pred)(*src);
    src++;
  }
  return head;
}

int addone(int num) {
  return num + 1;
}

int sub(int a, int b) {
  return a - b;
}

int foldr(int (*binop)(int, int), int init, int* list) {
  if (!*list){
      return init;
  }
    int head=*list++;
    return binop(head, foldr(binop, init, list));
}

int foldl(int (*binop)(int, int), int init, int* list) {
  if (!*list){
      return init;
  }
    int head=*list++;
    return foldl(binop, binop(init, head), list);
}

//functoin take two pointers to ints

int f(int *a, int *b){
    *a = 0;
    *b = 1;
    return *a;
}



int main() {
  char *orig = "123456789";
  char *copy = malloc(200);
  int intlist[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 0};
  int *pointto = &intlist[0];

  int *pointer1 = &intlist[0];
  int *pointer2 = &intlist[0];

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
  printintlist(foreach(addone, pointto));
  int a,b = 9;
  printf("\n function f returns %d\n", f(&a, &b));
  printf("foldr subtracting 2-10 %d\n", foldr(sub, 0, pointto));
  printf("foldl subtracting 2-10 %d\n", foldl(sub, 0, pointto));


}
