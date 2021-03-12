#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#define BOOL int
#define TRUE 1
#define FALSE 0
/*----------------------------------------------------------------
getline is a POSIX function
https://www.gnu.org/software/libc/manual/html_node/Line-Input.html 
*/
struct node
{
    char *str;
    struct node *prev;
} *headNode = NULL;

int main(int argc, char *argv[])
{
    if (argc > 3) // #6 Too many arguments passed to program
    {
        fprintf(stderr, "usage: reverse <input> <output>\n");
        exit(1);
    }

    if (argc == 3)
    {
        BOOL isHardLink = FALSE;
        int result1, result2;
        struct stat s1, s2;
        result1 = stat(argv[1], &s1);
        result2 = stat(argv[2], &s2);
        if (!result1 && !result2)
        {
            if (s1.st_ino == s2.st_ino) // determine if hard-linked by comparing inode
                isHardLink = TRUE;
        }
        if (!strcmp(argv[1], argv[2]) || isHardLink)
        {
            fprintf(stderr, "reverse: input and output file must differ\n");
            exit(1);
        }
    }

    if (argc >= 2) // has input file
    {
        FILE *inFile;
        size_t len = 0;
        inFile = fopen(argv[1], "r");
        if (inFile == NULL)
        {
            fprintf(stderr, "%s%s%s\n", "reverse: cannot open file \'", argv[1], "\'");
            exit(1);
        }
        char *str = NULL;
        while (getline(&str, &len, inFile) != -1)
        {
            struct node *newNode = malloc(sizeof(struct node));
            newNode->str = str;
            newNode->prev = headNode;
            headNode = newNode;
            str = NULL;
        }
        fclose(inFile);
        struct node *curNode = headNode;
        if (argc == 3)
        { // has specified output file
            FILE *outFile = fopen(argv[2], "w");
            while (curNode)
            {
                fprintf(outFile, "%s", curNode->str);
                curNode = curNode->prev;
            }
            fclose(outFile);
        }
        else
        { // no output file, write to stdout
            while (curNode)
            {
                fprintf(stdout, "%s", curNode->str);
                curNode = curNode->prev;
            }
        }
    }
    else // no input file, read from stdin
    {
        char *str = NULL;
        size_t len = 0;
        while (getline(&str, &len, stdin) != -1)
        {
            struct node *newNode = malloc(sizeof(struct node));
            newNode->str = str;
            newNode->prev = headNode;
            headNode = newNode;
            str = NULL;
        }
        struct node *curNode = headNode;
        while (curNode)
        {
            fprintf(stdout, "%s", curNode->str);
            curNode = curNode->prev;
        }
    }
    return 0;
}
