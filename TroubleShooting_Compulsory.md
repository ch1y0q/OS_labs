# TroubleShooting

## Unix_Utilities

1. Had trouble writing C code. We've always adopted C++ as primary programming language. STL containers, `new` and `delete` operators, and even `bool` type no longer exist in the C context. I googled a lot, read man pages, and searched through Stack Overflow for details.
2. Redundant `\n` prevents the code from passing the test. Be careful.
3. `getline` is a POSIX function, better include `#define _GNU_SOURCE` to tell the compiler about that. The function receives 3 arguments, the first should be a pointer to the buffer; the second a pointer to a `size_t` variable determining the size of the buffer; the third is a `FILE*`, and `stdin` works too. Simply pass the address of a `NULL` char pointer as the first argument, and address of a `size_t` variable (initiated with 0) as the second, and voila, `getline` is smart enough to allocate sufficient memory for reading an entire line from stdin, and the size is automatically determined. This is what I found particularly useful.

## [Solved]Xv6+Syscall
Seems that my tests-out/1.out and 2.out use CRLF for newline, while the answer uses LF, thus I constantly see some weired diff results like 
```
1c1
< XV6_TEST_OUTPUT 200000
---
> XV6_TEST_OUTPUT 200000
```
output seem to be identical. The difference can be found only with a hex editor. My output should be correct, except for the different newline deliminator.
Haven't found a good solution yet. But tests can be passed by using `diff -w`, -w ignores blankspaces.
I think its related to configuration of `Expect`.

03.15:
Later someone told me setting up crosscompile toolchain might help:
```
sudo apt-get install gcc-8-i686-linux-gnu
sudo apt install gcc-i686-linux-gnuz
```
and modified Makefile.
But did not work for me.

I tried to redirect qemu terminal output to a file, analyzed it with a hex editor, and saw "0d 0a", a.k.a. CR LF, alas.
The I looked into test_1.c: `printf(1, "XV6_TEST_OUTPUT %d %d %d\n", x2-x1, x3-x2, x4-x3);`, seems quite normal. To rule out possibility of compiler's magical behavior, I decompiled the test_1.o and test_2.o, which are used to test the Xv6 system, and the pattern string of printf ended with the normal LF("0AH")...


03.17:
Now, it seems more like qemu's bug.

https://bugs.launchpad.net/qemu/+bug/1715296
https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg05462.html

I downloaded the source code, compiled, but got the same problem...
Then I run dos2unix to everything in the project folder to replace CRLF with LF, but not work.


03.19: 
Finally I found the most probable reason:
https://stackoverflow.com/questions/27531065/where-does-the-r-come-from
https://os.mbed.com/questions/2190/Serial-output-CRLF/

Ran Xv6 directly in qemu, and 
```
$ cat 2.out
XV6_TEST_OUTPUT 200000
```

```
$ ls
...
2.out          2 21 23
...
```

23 = 22 visible characters + \n, seems to be fine... Further investigation is needed. Now it's highly likely `\r` comes from expect not qemu.

I also put forward a question on Stack Overflow: https://stackoverflow.com/questions/66706868/how-to-prevent-expect-from-outputting-crlf. The only one comment I received suggest that Expect always use `\r\n` as line endings. Fine.

03.26
Try to run test with a classmate's code(passed tests on his machine), results same as mine. The problem must be related to environment, not my code!

用了同学的VM镜像测试，解决。

## Unix Shell
This lab is of a lot of work.

### Compiling
`gcc` always returns error in locating my source code files. I wrote a `CMakeLists.txt` to make it know where to find the sources. What's more, `make` is way shorter than `gcc -o seush seush.c`.

### Parsing Commands
Initially, I parse a command by scanning character by character, which is a lot of effort. Variables for recording occurence of `&` and `>` are needed, and I had to filter all the redundant whitespaces and tabs.
Then I switch to `strtok`. First separate by `&`, then `>`, then ` `. It then gets much more concise and clear.

### Initialization of Variables
In function `void parse_command(char *line, Environment *environment)`, a `process[]` is used to store processes that are about to execute. But in test #7, the path changed to empty string from `\bin` and my shell still found the location of `ls`. At beginning I thought it's handling `path` built-in command, but nothing seemed to be wrong. Then I output my Environment.paths and process[], and found that `process[]` seemed to be reused in handling the second command...
By initializing it like `Process process[MAX_PIDS] = {0};`, the problem solved.

### Parallel Execution
I tried various ways of calling `waitpid` with different arguments, but all seem to fail the target.
By putting the `waitpid(&wait_status)` in the end of the loop of executing processes stored in `struct Process`, it becomes serial and would fail test #22. By putting it outside the loop and at the end of the function, shell continues to perform next line upon the return of first subprocess instead of waiting for all subprocess to terminate. Calling with `waitpid(-getpid(), &wait_status, WUNTRACED);` (`-getpid()` means the process group that parent process belongs to; all subprocesses belong to the same process group) didn't work, either.
The solution is to put `wait` into a `while` loop: `while ((wpid = wait(&wait_status)) > 0);`.
