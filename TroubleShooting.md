# TroubleShooting

## Unix_Utilities

1. Had trouble writing C code. We've always adopted C++ as primary programming language. STL containers, `new` and `delete` operators, and even `bool` type no longer exist in the C context. I googled a lot, read man pages, and searched through Stack Overflow for details.
2. Redundant `\n` prevents the code from passing the test. Be careful.
3. `getline` is a POSIX function, better include `#define _GNU_SOURCE` to tell the compiler about that. The function receives 3 arguments, the first should be a pointer to the buffer; the second a pointer to a `size_t` variable determining the size of the buffer; the third is a `FILE*`, and `stdin` works too. Simply pass the address of a `NULL` char pointer as the first argument, and address of a `size_t` variable (initiated with 0) as the second, and voila, `getline` is smart enough to allocate sufficient memory for reading an entire line from stdin, and the size is automatically determined. This is what I found particularly useful.

## Xv6+Syscall
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