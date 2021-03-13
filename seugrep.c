#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define BOOL int
#define TRUE 1
#define FALSE 0
/*----------------------------------------------------------------
getline is a POSIX function
https://www.gnu.org/software/libc/manual/html_node/Line-Input.html 
*/

int main(int argc, char *argv[])
{
    if (argc < 2) // Too few arguments passed to program
    {
        printf("searchterm [file ...]\n");
        exit(1);
    }

    if (argc == 2) // read from stdin
    {
        char *str;
        size_t len = 0;
        while (getline(&str, &len, stdin) != -1)
        {
            if (strstr(str, argv[1]))
            {
                printf("%s", str);
            }
        }
    }

    else if (argc > 2) // has input file
    {
        for (int i = 2; i < argc; ++i)
        {
            FILE *inFile;
            size_t len = 0;
            inFile = fopen(argv[i], "r");
            if (inFile == NULL)
            {
                printf("cannot open file\n");
                exit(1);
            }
            char *str = NULL;
            while (getline(&str, &len, inFile) != -1)
            {
                if (strstr(str, argv[1]))
                {
                    printf("%s", str);
                }
            }
            fclose(inFile);
        }
    }
    return 0;
}
