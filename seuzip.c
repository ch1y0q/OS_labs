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
        printf("seuzip: file1 [file2 ...]\n");
        exit(1);
    }
    char lastChar = 0;
    unsigned int charCnt = 0;
    FILE *inFile;
    char curChar = 0;
    for (int i = 1; i < argc; ++i)
    {
        inFile = fopen(argv[i], "r");
        if (inFile == NULL)
        {
            printf("cannot open file\n");
            exit(1);
        }
        lastChar = curChar = fgetc(inFile);
        while (curChar != EOF)
        {
            if (curChar != lastChar)
            {
                fwrite(&charCnt, 4, 1, stdout);
                fwrite(&lastChar, 1, 1, stdout);
                lastChar = curChar;
                charCnt = 1;
            }
            else
            {
                charCnt++;
            }
            curChar = fgetc(inFile);
        }
    }
    fwrite(&charCnt, 4, 1, stdout);
    fwrite(&lastChar, 1, 1, stdout);
    fclose(inFile);

    return 0;
}
