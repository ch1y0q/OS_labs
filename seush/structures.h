#define _GNU_SOURCE
#include <linux/limits.h>
#include <limits.h>
#include <sys/types.h>
#include <stdio.h>
#include "macros.h"

#ifndef STRUCTURES_H
#define STRUCTURES_H

typedef struct Environment  // run-time context
{ 
    char *paths;            // paths to be searched
    char cwd[MAX_PATH];     // current working directory
    BOOL path_set_by_user;  // if the path was set by user
} Environment;

typedef struct Process
{
    pid_t pid;
    int stdin[2];
    int stdout[2];
    int stderr[2];
    BOOL redirection;
    int redirection;
} Process;

typedef struct Launch
{
    struct Environment *environment;
    char *command;
    char *args;
    char *redirection;
} Launch;

typedef struct PreLaunch
{
    struct Process *process;
    char **argv;
    char *path_to_run;
} PreLaunch;


#endif