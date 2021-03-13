#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define BOOL int
#define TRUE 1
#define FALSE 0

int main(int argc, char *argv[])
{
    if (argc < 2) // Too few arguments passed to program
    {
        printf("seuunzip: file1 [file2 ...]\n");
        exit(1);
    }
    FILE *inFile;
    char curChar = 0;
    unsigned int charCnt = 0;
    for (int i = 1; i < argc; ++i)
    {
        inFile = fopen(argv[i], "r");
        curChar = charCnt = 0;
        if (inFile == NULL)
        {
            printf("cannot open file\n");
            exit(1);
        }
        fread(&charCnt, 4, 1, inFile);
        fread(&curChar, 1, 1, inFile);
        while (curChar != EOF)
        {
            while (charCnt--)
            {
                printf("%c", curChar);
            }
            fread(&charCnt, 4, 1, inFile);
            fread(&curChar, 1, 1, inFile);
        }
    }
    fclose(inFile);

    return 0;
}
