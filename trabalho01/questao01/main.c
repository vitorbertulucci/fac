#include <stdlib.h>
#include "input_output.c"


int main (int argc, char* argv) {
      double first_coordinates[2], second_coordinates[2],
             third_coordinates[2];
      readCoordinates(first_coordinates, second_coordinates, third_coordinates);
      int i = 0;
      for (i = 0; i < 2; i++) {
        printf("%lf %lf %lf\n", first_coordinates[i],
                second_coordinates[i],
                third_coordinates[i]);
      }
      return 0;
}
