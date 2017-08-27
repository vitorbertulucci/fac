#include <math.h>
#define POINTS 3

double determinant (double matrix[POINTS][POINTS]) { // only for 3x3 matrix
    return ((matrix[2][2] * (matrix[1][1] * matrix[0][0] - matrix[1][0] * matrix[0][1])) +
            (matrix[1][2] * (matrix[0][1] * matrix[2][0] - matrix[0][0] * matrix[2][1])) +
            (matrix[0][2] * (matrix[1][0] * matrix[2][1] - matrix[1][1] * matrix[2][0])));
}
/*  solution of determinat of the following matrix:
    result = | x1 y1 1 |
             | x2 y2 1 |
             | x3 y3 1 |
*/
int isCollinear (struct Points* points) {
    return ((points[0].x * (points[1].y - points[2].y)) +
            (points[1].x * (points[2].y - points[0].y)) +
            (points[2].x * (points[0].y - points[1].y)));
}

void findCircumcenter (struct Circle* circle, struct Points* points) {
    double  x_dividend_matrix[POINTS][POINTS],
            y_dividend_matrix[POINTS][POINTS],
            divisor_matrix[POINTS][POINTS];
    int i = 0;
    for (i = 0; i < POINTS; i++) {
        // initializing x_dividend matrix
        x_dividend_matrix[i][0] = pow(points[i].x, 2) + pow(points[i].y, 2);
        x_dividend_matrix[i][1] = points[i].y;
        x_dividend_matrix[i][2] = 1;

        // initiaizing y_dividend matrix
        y_dividend_matrix[i][0] = points[i].x;
        y_dividend_matrix[i][1] = pow(points[i].x, 2) + pow(points[i].y, 2);
        y_dividend_matrix[i][2] = 1;

        // initializing divisor matrix
        divisor_matrix[i][0] = points[i].x;
        divisor_matrix[i][1] = points[i].y;
        divisor_matrix[i][2] = 1;
    }

    circle->x_center = determinant(x_dividend_matrix) / (2 * determinant(divisor_matrix));
    circle->y_center = determinant(y_dividend_matrix) / (2 * determinant(divisor_matrix));
    circle->radius = sqrt(pow(points[0].x - circle->x_center, 2) + pow(points[0].y - circle->y_center, 2));
    return;
}

