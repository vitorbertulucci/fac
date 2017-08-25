#include <stdlib.h>
#include "input_output.h"
#include "typedefs.h"
#include "operations.h"

int main (int argc, char* argv) {
    double first_coordinates[2], second_coordinates[2],
          third_coordinates[2];

    readCoordinates(first_coordinates, second_coordinates, third_coordinates);
    int result = isCollinear(first_coordinates, second_coordinates, third_coordinates);
    if (!result) {
        printf("Não tem solução\n");
    }
    return 0;
}
