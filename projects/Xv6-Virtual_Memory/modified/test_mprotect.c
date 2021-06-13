#include "types.h"
#include "stat.h"
#include "user.h"
#include "mmu.h"

int main(int argc, char *argv[])
{
    /*
    sbrk() increments the program's data space by increment bytes.
    Calling sbrk() with an increment of 0 can be used to find the current
       location of the program break.
    */
    char *pg0 = sbrk(0);  // sbrk syscall allocates memory in heap
    sbrk(PGSIZE);

    char *pg1 = sbrk(0);  // sbrk syscall allocates memory in heap
    sbrk(PGSIZE);

    *pg0 = 0; // assign an initial value
    *pg1 = 1; // assign an initial value
    mprotect(pg1, 1); // call mprotect, make it read-only
    int pid = fork();
    if (pid == 0)   // child
    {
        printf(1, "I'm child, and value of pg0 is %d\n", *pg0);
        *pg0 = 10;
        printf(1, "I'm child, and I made value of pg0 %d\n", *pg0);
        printf(1, "I'm child, and protected value of pg1 is %d\n", *pg1);
        munprotect(pg1, 1);   // call munprotect, make it writable
        *pg1 = 5;
        printf(1, "After unprotecting pg1 the value became = %d\n", *pg1);
        exit();
    }
    else if (pid > 0)   // parent
    {
        wait();
        printf(1, "\nI'm parent, value of pg0 is %d...\n", *pg0);
        *pg0 = 10;
        printf(1, "I'm parent, and I made value of pg0 %d\n", *pg0);

        printf(1, "\nI'm parent, will soon trap...\n");
        *pg1 = 5; // should fail
        printf(1, "\nYOU SHOULDN'T SEE THIS LINE...\n");
        exit();
    }
    else{
        printf(1, "\nSomething wrong with forking...\n");
        exit();
    }
    exit();
}