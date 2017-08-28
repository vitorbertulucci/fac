#include <stdlib.h>
#include "input_output.h"
#include "operations.h"

int main (int argc, char* argv) {
    struct Points points[3];
    readCoordinates(points);
    int collinearity = isCollinear(points);
    if (!collinearity) {
        printf("Circulo nao viavel.\n");
    } else {
        struct Circle circle;
        findCircumcenter(&circle, points);
        printResults(circle);
    }
    return 0;
}
