#include <stdio.h>
#include "typedefs.h"
#define POINTS 3

void readCoordinates(struct Points* points) {
      int i = 0;
      for (i = 0; i < POINTS; i++) {
            scanf("%lf %lf", &points[i].x, &points[i].y);
      }
      return;
}

void printResults(struct Circle circle) {
      printf("Raio: %.3lf.\n", circle.radius);
      printf("Centro: (%.3lf, %.3lf).\n", circle.x_center, circle.y_center);
      return;
}
