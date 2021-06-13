# Worksheet for Selective OS Labs

09019216 黄启越

## Virtual Memory
### Dereferencing a null pointer
Consider the code below:
```c
#include <unistd.h>
#include <stdio.h>

int
main()
{
    int *a = 0;
    printf("%c\n", *a);
    return 0;
}
```

In Linux, this will cause a segmentation fault.
```
[myusername@myhostname ~]$ ./dereferenct_nullptr 
Segmentation fault (core dumped)
```

In Xv6, however, code similar to above does not cause any traps. The output is like:
```
$ test_1
Now try to dereference a null pointer...
The result of dereferencing a full ptr as hexademical int is 2FCC...
After dereferencing a null pointer...
```


### Diving into Xv6
In `memlayout.h` and `vm.c`, we know how the virtual memory space is acclocated.

`memlayout.h`:

```c
// Memory layout

#define EXTMEM  0x100000            // Start of extended memory
#define PHYSTOP 0xE000000           // Top physical memory
#define DEVSPACE 0xFE000000         // Other devices are at high addresses

// Key addresses for address space layout (see kmap in vm.c for layout)
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#define V2P(a) (((uint) (a)) - KERNBASE)
#define P2V(a) ((void *)(((char *) (a)) + KERNBASE))

#define V2P_WO(x) ((x) - KERNBASE)    // same as V2P, but without casts
#define P2V_WO(x) ((x) + KERNBASE)    // same as P2V, but without casts
```

Also in `vm.c`:
```c
//   0..KERNBASE: user memory (text+data+stack+heap), mapped to
//                phys memory allocated by the kernel
//   KERNBASE..KERNBASE+EXTMEM: mapped to 0..EXTMEM (for I/O space)
//   KERNBASE+EXTMEM..data: mapped to EXTMEM..V2P(data)
//                for the kernel's instructions and r/o data
//   data..KERNBASE+PHYSTOP: mapped to V2P(data)..PHYSTOP,
//                                  rw data + free physical memory
//   0xfe000000..0: mapped direct (devices such as ioapic)
//
// The kernel allocates physical memory for its heap and for user memory
// between V2P(end) and the end of physical memory (PHYSTOP)
// (directly addressable from end..P2V(PHYSTOP)).
```

From the code above, we know the range of user memory falls in [0x0, 0x80000000] and mapped to somewhere allocated by the kernal in physical memory. Thus, pointer pointing to `0x0` is not considered a null pointer in Xv6. Dereferencing it should not cause trouble as I formerly expected.


To make Xv6 behave like other mainstream OS, there should be an address spared for null-pointer. The basic idea is to make the first page unassigned, i.e. virual address 0x0 should never be filled with any content, and make user memory space begin from 0x1.

### Add null pointer check
Here are what needs to be changed:

1. `exec.c`, sz=0 --> sz=PGSIZE
2. Add `i==0` in a `if` condition in the function `int argptr(int n, char **pp, int size)` in `syscall.c`
3. Change initial value `i=0` to `i=PGSIZE` in an `if` loop in the function of `pde_t* copyuvm(pde_t *pgdir, uint sz)` in `vm.c`, also `int loaduvm (pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)` in the same file.

4. Change `Makefile.test`: Change `0` to `0x1000`

5. Change `p = 0` to `p = 4096` in `validatetest(void)` in `usertest.c`.

#### Troubleshooting
```
SeaBIOS (version 1.13.0-1ubuntu1.1)


iPXE (http://ipxe.org) 00:03.0 CA00 PCI2.10 PnP PMM+1FF8CA10+1FECCA10 CA00
                                                                               


Booting from Hard Disk..xv6...
cpu1: starting 1
cpu0: starting 0
sb: size 1000 nblocks 941 ninodes 200 nlog 30 logstart 2 inodestart 32 bmap start 58
init: starting sh
exec: fail
init: exec sh failed
init: starting sh
exec: fail
init: exec sh failed
init: starting sh
exec: fail
init: exec sh failed
init: starting sh
exec: fail
init: exec sh failed
init: starting sh
exec: fail
[...]
```

The code passed compilation but sh cannot be executed. I looked into the directory, and found `sh` is not compiled at all. Not only `sh` but all files below `#_test_mprotect\`, oh it's my fault! I should have learned more about Makefile!

```Makefile
UPROGS=\
	_cat\
	_echo\
	_forktest\
	_grep\
	_init\
	_kill\
	_ln\
	_ls\
	_test_1\
	_test_2\
	#_test_mprotect\
	_mkdir\
	_rm\
	_sh\
	_stressfs\
	_usertests\
	_wc\
	_zombie\
```

Sometimes, calling `make -f Makefile.test -B qemu-nox` with `-B` is needed, or `make` will stupidly skip previously compiled code. This has caused me a lot of confusion.

Eventually, the program worked as I expectd - to trap when dereferencing a null pointer:

```
$ test_1
Now try to dereference a null pointer...
pid 3 test_1: trap 14 err 4 on cpu 0 eip 0x1021 addr 0x0--kill proc
```

### Testing new syscalls
`mprotect` and `munprotect` syscalls are tested with my own program, as code shown in `test_mprotect.c`. I write quite detailed comments there.

The output is like:

```
$ test_mprotect

PTE : 0x8dee1014
I'm child, and value of pg0 is 0
I'm child, and I made value of pg0 10
I'm child, and protected value of pg1 is 1

PTE : 0x8df27014
After unprotecting pg1 the value became = 5

I'm parent, value of pg0 is 0...
I'm parent, and I made value of pg0 10

I'm parent, will soon trap...
pid 3 test_mprotect: trap 14 err 7 on cpu 0 eip 0x109c addr 0x5000--kill proc
```

From the result, we can see that `pg0` is not protected, so both parent process and child process can access and modify it. However, forked process has a copy of pg0, so modifying it in the child process does not affect pg0 in the parent process, and vice versa. Similarly, `pg1` is `mprotect`ed before forking. In the child process it later gets `munprotect`ed, so can be written. After switching back to parent process, `pg1` in parent process remains `mprotect`ed, so trying to modify it immediately cause a trap.


### References
* https://hehao98.github.io/posts/2019/04/xv6-4/
* https://github.com/massoudsalem/xv6
* https://www.cs.virginia.edu/~cr4bd/4414/S2019/paging-and-protection.html