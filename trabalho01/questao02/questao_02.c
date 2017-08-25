#include <stdio.h>
#include <string.h>

char* removeFirstCharacters (char* string) {
  int length = strlen(string);
  return strncpy(string, &string[2], length); // remove first 2 characters from string 'name'
}

int main (int argc, char** argv) {
  printf("# de parametros: %d\n", argc - 1); // -1 to remove file name

  char *newName = removeFirstCharacters(argv[0]);
  printf("Nome executavel: %s\n", newName);

  int i = 1;
  for (i = 1; i < argc; i++) {
    printf("Parametro #%d: %s\n", i, argv[i]);
  }

  return 0;
}
