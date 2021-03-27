#ifndef LOOP_H
#define LOOP_H

void run_shell(char *batch);
char *getNextLine(FILE *batchFile);
char* readline(char *prompt);
char *clean(char *line);

#endif