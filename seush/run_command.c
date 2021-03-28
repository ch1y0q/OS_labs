#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "macros.h"
#include "run_command.h"

Process *process;
int pid_amount;

void run_command(char *line, Environment *environment)
{
    parse_command(line, environment);
    run_processes();
}

void parse_command(char *line, Environment *environment)
{
    line = clean(line);
    int character = 0;
    BOOL has_redirection = FALSE; /* turns TRUE when encountering first '>' */
    char *to_redirect = NULL;     /* destination to redirect output */
    BOOL command_read = FALSE;    /* turns TRUE when the command is read, i.e. encountering first space */
    while (line[character] != '\0')
    {
        /* redirection */
        if (line[character] == '>')
        {
            if (has_redirection)
            {
                PRINT_ERROR_MESSAGE;
                return;
            }
            else
            {
                to_redirect = line + character + 1;
                line[character] = '\0';
                has_redirection = TRUE;
            }
        }

        /* parallel */
        else if (line[character] == '&'){
            line[character] = '\0';
            run_command(line+character+1, environment);
            return;
        }

        /* arguments */
        else if (line[character] == ' ')
        {
            // TODO
        }

        character++;
    }
}

void run_processes()
{
    /* run all processes and wait for them to finnish */
    for (int number = 0; number < pid_amount; number++)
    {
        waitpid(process[number].pid, 0, 0);
        if (!process[number].redirection)
        {
            /* write directly to stdout and stderr */
            pipe_to_std(process[number].stdout[0], STDOUT_FILENO);
            pipe_to_std(process[number].stderr[0], STDERR_FILENO);
        }
        else
        {
            close(process[number].redirection);
        }
        close(process[number].stdout[0]);
        close(process[number].stderr[0]);
        close(process[number].stdin[1]);
    }
}