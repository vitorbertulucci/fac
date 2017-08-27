#include <math.h>
#define POINTS 3

/* solution of det of the following matrix:
    result = | x1 y1 1 |
             | x2 y2 1 |
             | x3 y3 1 |
*/
int isCollinear (struct Points* points) {
    return ((points[0].x * (points[1].y - points[2].y)) +
            (points[1].x * (points[2].y - points[0].y)) +
            (points[2].x * (points[0].y - points[1].y)));
}

int isCircumferencePoints (struct Points* points) {
    int i = 0;
    int onCircumference = 0;
    int result = 0;
    for (i = 0; i < POINTS; i++) {
        points[i].radius = sqrt(pow(points[i].x, 2) + pow(points[i].y, 2)); // x² + y² = r²
        printf("%d: Raio = %.3lf\n", i, points[i].radius);
        if (i != 0) {
            if (points[i - 1].radius == points[i].radius) {
                result = 1;
            } else {
                result = 0;
            }
        }
    }
    return result;
}

