#define BOOL int
#define TRUE 1
#define FALSE 0

char error_message[30] = "An error has occurred\n";
#define PRINT_ERROR_MESSAGE write(STDERR_FILENO, error_message, strlen(error_message)); 