# TroubleShooting

## Unix_Utilities

1. Had trouble writing C code. We've always adopted C++ as primary programming language. STL containers, `new` and `delete` operators, and even `bool` type no longer exist in the C context. I googled a lot, read man pages, and searched through Stack Overflow for details.
2. Redundant `\n` prevents the code from passing the test. Be careful.
3. `getline` is a POSIX function, better include `#define _GNU_SOURCE` to tell the compiler about that. The function receives 3 arguments, the first should be a pointer to the buffer; the second a pointer to a `size_t` variable determining the size of the buffer; the third is a `FILE*`, and `stdin` works too. Simply pass the address of a `NULL` char pointer as the first argument, and address of a `size_t` variable (initiated with 0) as the second, and voila, `getline` is smart enough to allocate sufficient memory for reading an entire line from stdin, and the size is automatically determined. This is what I found particularly useful.

## [Stucked]Xv6+Syscall
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
Later someone told me setting up crosscompile toolchain might help:
```
sudo apt-get install gcc-8-i686-linux-gnu
sudo apt install gcc-i686-linux-gnuz
```
and modified Makefile.
But did not work for me.
-------
I tried to redirect qemu terminal output to a file, analyzed it with a hex editor, and saw "0d 0a", a.k.a. CR LF, alas.
The I looked into test_1.c: `printf(1, "XV6_TEST_OUTPUT %d %d %d\n", x2-x1, x3-x2, x4-x3);`, seems quite normal. To rule out possibility of compiler's magical behavior, I decompiled the test_1.o and test_2.o, which are used to test the Xv6 system, and the pattern string of printf ended with the normal LF("0AH")...
------
Now, it seems more like qemu's bug.
https://bugs.launchpad.net/qemu/+bug/1715296
https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg05462.html

I downloaded the source code, compiled, but got the same problem...

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

23 = 22 visible characters + \n, seems to be fine... Further investigation is needed.