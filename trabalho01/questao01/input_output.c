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
