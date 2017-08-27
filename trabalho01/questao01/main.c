#include <stdlib.h>
#include "input_output.h"
#include "operations.h"

int main (int argc, char* argv) {
    struct Points points[3];

    readCoordinates(points);
    printf("%lf\n", points[0].x);
    int collinearity = isCollinear(points);
    if (!collinearity) {
        printf("Não tem solução\n");
    } else {
        int isCirclePoints = isCircumferencePoints(points);
        printf("RAIO SAO IGUAIS = %d\n", isCirclePoints);
    }
    return 0;
}
