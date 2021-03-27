#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "loop.h"



int main(int argc, char *argv[])
{
    if (argc >= 3) // Too many arguments passed to program
    {
        fprintf(stderr, "usage: seush <batch file>\n");
        exit(1);
    }

    if (argc == 2) // has input file
    {
        run_shell(argv[1]);
    }
    else // no input file, read from stdin
    {
        run_shell(NULL);
    }
    return 0;
}
