#include "types.h"
#include "stat.h"
#include "user.h"
int
main(int argc, char *argv[])
{
    int *a = 0;
    printf(1, "Now try to dereference a null pointer...\n");
    printf(1, "The result of dereferencing a full ptr is %c...\n", *a);
    printf(1, "After dereferencing a null pointer...\n");
    exit();
}