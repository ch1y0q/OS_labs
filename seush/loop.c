#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "macros.h"

char *clean(char *line)
{
    size_t len = strlen(line), i = 0;
    int character = 0;
    int lastNonSpace = -1;
    while (line[i] == ' ' || line[i] == '\t')
    { /* remove initial spaces*/
        ++i;
    }

    BOOL LAST_IS_SPACE_TAB = FALSE;
    while (line[character + i] != '\0' && line[character + i] != '\n')
    {
        line[character] = line[character + i];
        if (line[character + i] != ' ' && line[character + i] != '\t')
        {
            LAST_IS_SPACE_TAB = FALSE;
            lastNonSpace = character;
        }
        else
        {
            while (line[character + i] == ' ' || line[character + i] == '\t')
            {
                LAST_IS_SPACE_TAB = TRUE;++i;
            }
        }
        if(LAST_IS_SPACE_TAB)--i;
        character++;
    }
    line[lastNonSpace + 1] = '\0';
    //write(STDOUT_FILENO, line, strlen(line)); // DEBUG
    return line;
}

char *getNextLine(FILE *batchFile)
{
    char *line = NULL;
    size_t len = 0;
    if (batchFile == NULL)
    {
        write(STDOUT_FILENO, "seush>", strlen("seush>"));
        while (getline(&line, &len, stdin) == -1)
        {
        };
    }
    else if (getline(&line, &len, batchFile) == -1)
    {
        free(line);
        return line;
    }
    return clean(line);
}

void run_shell(char *batch)
{
    FILE *batchFile = NULL;
    if (batch != NULL)
    { // read from file
        batchFile = fopen(batch, "r");
        if (batchFile == NULL)
        {
            PRINT_ERROR_MESSAGE;
            exit(1);
        }
    }

    char *line;
    while (TRUE)
    {
        line = getNextLine(batchFile);
        if (line == NULL)
            break;
        if (line[0] == '\0')
            continue;

        /* built-in commands */
        if (strncmp(line, "exit", 4) == 0)
        {
            if (line[4] == '\0')
            {
                free(line);
                exit(0);
            }
            else
            {
                PRINT_ERROR_MESSAGE;
            }
            break;
        }
        else if (strncmp(line, "path", 4) == 0)
        {
            // TODO
        }
        else if (strncmp(line, "cd", 2) == 0)
        {
            // TODO
        }
        free(line);
    }

    /* close batch file */
    if (batchFile != NULL)
    {
        fclose(batchFile);
    }
}
