#include <stdlib.h>
#include "input_output.h"
#include "operations.h"

int main (int argc, char* argv) {
    struct Points points[3];
    readCoordinates(points);
    int collinearity = isCollinear(points);
    if (!collinearity) {
        printf("Não tem solução\n");
    } else {
        struct Circle circle;
        findCircumcenter(&circle, points);
        printf("Raio: %.3lf\n", circle.radius);
        printf("Centro: (%.3lf, %.3lf)\n", circle.x_center, circle.y_center);
    }
    return 0;
}
