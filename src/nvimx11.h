#include <stdlib.h>
#include <stdbool.h>

int nvimx11_test(int x);
const char *nvimx11_getsel(int name, int *type, size_t *len);
bool x11clip_setsel(int name, int type, const char *data, size_t len);
