#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define BOOL int
#define TRUE 1
#define FALSE 0

int main(int argc, char *argv[])
{
    if (argc < 2) // too few arguments
    {
        exit(0);
    }
    for (int i = 1; i < argc; ++i)
    {
        FILE *inFile;
        size_t len = 0;
        inFile = fopen(argv[i], "r");
        if (inFile == NULL)
        {
            printf("%s\n", "cannot open file");
            exit(1);
        }
        char *str = NULL;
        while (getline(&str, &len, inFile) != -1)
        {
            printf("%s", str);
            str = NULL;
        }
        fclose(inFile);
    }
    return 0;
}
