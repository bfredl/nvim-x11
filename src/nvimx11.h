#include <stdlib.h>
#include <stdbool.h>

int nvimx11_test(int x);
char* nvimx11_getsel(int name, int* type, size_t* len);
bool x11clip_putsel(int name, int type, const char* data, size_t len);
