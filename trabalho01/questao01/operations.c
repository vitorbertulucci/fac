int isCollinear (double* first, double* second, double* third) {
    return ((first[0] * (second[1] - third[1])) +
            (second[0] * (third[1] - first[1])) +
            (third[0] * (first[1] - second[1])));
}
