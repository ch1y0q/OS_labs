# OS_labs

操作系统课程的实验内容。2020-2021-3的课程。

包含如下内容（均来自 [WISC OS labs](https://pages.cs.wisc.edu/~remzi/OSTEP/) ）：
* Reverse：C语言练手，将输入的多个字符串反过来输出。
* Unix_utilities：C语言练手，包含seucat、seuunzip、seuzip、seugrep等小程序。
* seush：包含若干条内置命令、重定向、并行运行的简单shell。
* Xv6-Syscall：新增了一个`readcount`系统调用，并加锁防止条件竞争造成读数错误。
* Xv6-Virtual_Memory：将Xv6的虚拟内存空间开始位置移到1，从而增加空指针的判断。增加系统调用`int mprotect(void *addr, int len)`和`int munprotect(void addr, int len)`对内存页设置只读保护。

注：因为不太习惯C语言，且僕内存管理本当下手，seush存在不少bug和内存泄漏，请参考我在《操作系统专题实践》课程改进后的seush（代码在另一个repo里）。
