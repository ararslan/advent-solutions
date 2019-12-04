#include <stdio.h>
#include <stdlib.h>

#define max(a, b) (a) > (b) ? (a) : (b)

int main() {
    FILE* file = fopen("input", "r");
    char* line;
    size_t len;
    ssize_t nread;
    int fuel = 0;
    int total_fuel = 0;
    int mass;
    while ((nread = getline(&line, &len, file)) != -1) {
        mass = atoi(line);
        fuel += mass / 3 - 2;
        while (mass > 0) {
            mass = max(0, mass / 3 - 2);
            total_fuel += mass;
        }
    }
    printf("Part 1 answer: %d\n", fuel);
    printf("Part 2 answer: %d\n", total_fuel);
    fclose(file);
    return 0;
}
