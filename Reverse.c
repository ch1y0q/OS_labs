#include <stdio.h>
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
    if (argc >= 2) // #6 Too many arguments passed to program
    {
        fprintf(stderr, "usage: reverse <input> <output>\n");
        exit(1);
    }

    if (argc == 2 && strcmp(argv[0], argv[1]))
    {
        fprintf(stderr, "Input and output file must differ\n");
        exit(1);
    }

    if (argc) // has input file
    {
        FILE *inFile = fopen(argv[0], "r");
        if (!inFile)
        {

            fprintf(stderr, strcat("error: cannot open file \'",
                                   argv[0], "\'\n"));
            exit(1);
        }
        char *str = NULL;
        while (getline(str, 0, inFile) != -1)
        {
            struct node *newNode = malloc(sizeof(struct node));
            newNode->str = str;
            newNode->prev = headNode;
            headNode = newNode;
            str = NULL;
        }
        struct node *curNode = headNode;
        if (argc == 2)
        { // has specified output file
            FILE *outFile = fopen(argv[1], "w");
            while (curNode)
            {
                fprintf(outFile, "\s\n", curNode->str);
                curNode = curNode->prev;
            }
        }
        else
        { // no output file, write to stdout
            while (curNode)
            {
                fprintf(stdout, "\s\n", curNode->str);
                curNode = curNode->prev;
            }
        }
        fclose(inFile);
    }
    else // no input file, read from stdin
    {
        char *str = NULL;
        while (getline(str, 0, stdin) != -1)
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
            fprintf(stdout, "\s\n", curNode->str);
            curNode = curNode->prev;
        }
    }
    return 0;
}