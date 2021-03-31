#define _GNU_SOURCE

#ifndef MACROS_H
#define MACROS_H

/* debug */
//#define DEBUG
#define WERR(x) write(STDERR_FILENO, x, strlen(x));
#define WOUT(x) write(STDOUT_FILENO, x, strlen(x));

/* boolean */
#define BOOL int
#define TRUE 1
#define FALSE 0

/* error message */
#define PRINT_ERROR_MESSAGE WERR("An error has occurred\n")

/* environment */
#define MAX_PATH 100     /* max length of a path */
#define MAX_PATH_NUM 100 /* max number of paths */
#define MAX_PIDS 500
#define MAX_ARGUMENTS 100
#define DEFAULT_PATHS "/bin"

#endif