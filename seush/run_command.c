#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <string.h>

#include "macros.h"
#include "run_command.h"
#include "utilities.h"
#include "structures.h"

void run_command(char *line, Environment *environment)
{
    parse_command(line, environment);
}

void parse_command(char *line, Environment *environment)
{
    //pid_t pid = getpgrp();
    //printf("%d\n", pid);

    Process process[MAX_PIDS] = {0}; /* TROUBLESHOOTING: must initialize or will reuse */
    int process_num = 0;
    //printf("$$$$$$$$%s\n", process[0].exec_path);
    char *token;

    /* remove redundant space and tab */
    line = clean(line);

    /* parse "&" */
    char *single_commands[MAX_ARGUMENTS];
    int single_command_num = 0;
    token = strtok(line, "&");
    while (token != NULL)
    {
        single_commands[single_command_num++] = strdup(token);
        token = strtok(NULL, "&");
    }
    single_commands[single_command_num] = NULL;

    /*
    for (int _i = 0; _i < single_command_num; ++_i)
    {
        printf("%s\n", single_commands[_i]);
    }
*/

    for (int _i = 0; _i < single_command_num; ++_i)
    {
        char *cur_command = strdup(single_commands[_i]);
        cur_command = clean(cur_command);
        //printf("%s\n", cur_command);
        if (cur_command == NULL || cur_command[0] == '\0')
            continue;
        //printf("%d: %s\n", _i, cur_command);

        /* redirection */
        char *redirection_sep[5];
        int redirection_sep_num = 0;
        if (strstr(single_commands[_i], ">"))
        {

            token = strtok(single_commands[_i], ">");
            while (token != NULL)
            {
                redirection_sep[redirection_sep_num++] = strdup(token);
                token = strtok(NULL, ">");
            }

            if (redirection_sep_num == 2) /* redirected */
            {
                redirection_sep[1] = clean(redirection_sep[1]);
                if (strstr(redirection_sep[1], " ")) /* only one dest allowed */
                {
                    PRINT_ERROR_MESSAGE;
                    return;
                }

                process[process_num].redirected = TRUE;
                process[process_num].redirection = open(redirection_sep[1], O_WRONLY | O_CREAT, 0666);
            }
            else /* there can be only one ">" */
            {
                PRINT_ERROR_MESSAGE;
                return;
            }
        }
        else
        {
            process[process_num].redirected = FALSE;
            redirection_sep[redirection_sep_num++] = strdup(single_commands[_i]);
        }

        /* arguments */
        process[process_num].argv = malloc(sizeof(char *) * MAX_ARGUMENTS);
        process[process_num].argc = 0;

        token = strtok(redirection_sep[0], " ");
        while (token != NULL)
        {
            process[process_num].argv[process[process_num].argc++] = strdup(token);
            token = strtok(NULL, " ");
        }

        /* find path for command */
        if (access(process[process_num].argv[0], X_OK) == 0) /* absolute path given */
        {
            process[process_num].exec_path = strdup(process[process_num].argv[0]);
        }

        else /* finding from environment paths */
        {
#ifdef DEBUG
            for (int i = 0; environment->paths[i] && environment->paths[i][0] != '\0'; ++i)
            {
                printf("Env:%d %s\n", i, environment->paths[i]);
            }
#endif
            int path_i = 0;
            while (environment->paths[path_i] != NULL && environment->paths[path_i][0] != '\0')
            {
#ifdef DEBUG
                printf("proc %d %s\n", process_num, process[process_num].argv[0]);
#endif
                char *full_path = strdup(environment->paths[path_i]);
                if (full_path[strlen(full_path) - 1] != '/')
                {
                    strcat(full_path, "/");
                }
                strcat(full_path, process[process_num].argv[0]);

                //printf("*******%s\n",full_path);

                if (access(full_path, X_OK) == 0)
                {
                    process[process_num].exec_path = strdup(full_path);
                    break;
                }
                path_i++;
            }
        }
        /* get prepared for first parameter of execv */
        /*
        for (int i = 1; i < process[process_num].argc; i++)
        {
            strcat(process[process_num].exec_path, " ");
            strcat(process[process_num].exec_path, process[process_num].argv[i]);
        }
        */

        /* ready for a new process */
        ++process_num;
    }

    chdir(environment->cwd); /* test7: prevent cwd changed by external sh */
    run_processes(process, process_num);
}

void run_processes(struct Process process[], int process_num)
{
    //pid_t pid = 0; /* parent process */
    //const pid_t pgrp = getpgrp();
    /* run all processes and wait for them to finnish */
    for (int number = 0; number < process_num; number++)
    {
#ifdef DEBUG
        printf("%d: %s %d %d \n", number, process[number].exec_path, process[number].argc, process[number].redirected);
#endif
        int pid = process[number].pid = fork();

        if (pid < 0)
        {
            PRINT_ERROR_MESSAGE;
            exit(1);
        }

        else if (pid == 0)
        { /* forked process */
            //printf("pid: %d pgrp: %d\n", getpid(), getpgrp());
            if (process[number].redirected)
            { /* handle redirection */
                if (-1 == dup2(process[number].redirection, fileno(stderr)))
                {
                    PRINT_ERROR_MESSAGE;
                    exit(1);
                }
                //close(1); /* close STDOUT, done by dup2 */
                if (-1 == dup2(process[number].redirection, fileno(stdout)))
                {
                    PRINT_ERROR_MESSAGE;
                    exit(1);
                }
            }
            //setpgid(0, 0);
            execv(process[number].exec_path, process[number].argv);
            PRINT_ERROR_MESSAGE;
            exit(1); /* something wrong */
        }

        else /* parent process */
        {
            //printf("%d\n", getpgrp());
            //waitpid(-pgrp, 0, 0);

            int status;
            wait(&status);
            //waitpid(0, &status, WNOHANG | WUNTRACED);
        }
    }
}