
_usertests：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <main>:
  return randstate;
}

int
main(int argc, char *argv[])
{
       0:	f3 0f 1e fb          	endbr32 
       4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       8:	83 e4 f0             	and    $0xfffffff0,%esp
       b:	ff 71 fc             	pushl  -0x4(%ecx)
       e:	55                   	push   %ebp
       f:	89 e5                	mov    %esp,%ebp
      11:	51                   	push   %ecx
      12:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "usertests starting\n");
      15:	68 36 4e 00 00       	push   $0x4e36
      1a:	6a 01                	push   $0x1
      1c:	e8 bf 3a 00 00       	call   3ae0 <printf>

  if(open("usertests.ran", 0) >= 0){
      21:	59                   	pop    %ecx
      22:	58                   	pop    %eax
      23:	6a 00                	push   $0x0
      25:	68 4a 4e 00 00       	push   $0x4e4a
      2a:	e8 94 39 00 00       	call   39c3 <open>
      2f:	83 c4 10             	add    $0x10,%esp
      32:	85 c0                	test   %eax,%eax
      34:	78 13                	js     49 <main+0x49>
    printf(1, "already ran user tests -- rebuild fs.img\n");
      36:	52                   	push   %edx
      37:	52                   	push   %edx
      38:	68 b4 55 00 00       	push   $0x55b4
      3d:	6a 01                	push   $0x1
      3f:	e8 9c 3a 00 00       	call   3ae0 <printf>
    exit();
      44:	e8 3a 39 00 00       	call   3983 <exit>
  }
  close(open("usertests.ran", O_CREATE));
      49:	50                   	push   %eax
      4a:	50                   	push   %eax
      4b:	68 00 02 00 00       	push   $0x200
      50:	68 4a 4e 00 00       	push   $0x4e4a
      55:	e8 69 39 00 00       	call   39c3 <open>
      5a:	89 04 24             	mov    %eax,(%esp)
      5d:	e8 49 39 00 00       	call   39ab <close>

  argptest();
      62:	e8 29 36 00 00       	call   3690 <argptest>
  createdelete();
      67:	e8 04 12 00 00       	call   1270 <createdelete>
  linkunlink();
      6c:	e8 cf 1a 00 00       	call   1b40 <linkunlink>
  concreate();
      71:	e8 ca 17 00 00       	call   1840 <concreate>
  fourfiles();
      76:	e8 f5 0f 00 00       	call   1070 <fourfiles>
  sharedfd();
      7b:	e8 30 0e 00 00       	call   eb0 <sharedfd>

  bigargtest();
      80:	e8 bb 32 00 00       	call   3340 <bigargtest>
  bigwrite();
      85:	e8 f6 23 00 00       	call   2480 <bigwrite>
  bigargtest();
      8a:	e8 b1 32 00 00       	call   3340 <bigargtest>
  bsstest();
      8f:	e8 3c 32 00 00       	call   32d0 <bsstest>
  sbrktest();
      94:	e8 27 2d 00 00       	call   2dc0 <sbrktest>
  validatetest();
      99:	e8 72 31 00 00       	call   3210 <validatetest>

  opentest();
      9e:	e8 6d 03 00 00       	call   410 <opentest>
  writetest();
      a3:	e8 08 04 00 00       	call   4b0 <writetest>
  writetest1();
      a8:	e8 e3 05 00 00       	call   690 <writetest1>
  createtest();
      ad:	e8 ae 07 00 00       	call   860 <createtest>

  openiputtest();
      b2:	e8 59 02 00 00       	call   310 <openiputtest>
  exitiputtest();
      b7:	e8 54 01 00 00       	call   210 <exitiputtest>
  iputtest();
      bc:	e8 5f 00 00 00       	call   120 <iputtest>

  mem();
      c1:	e8 1a 0d 00 00       	call   de0 <mem>
  pipe1();
      c6:	e8 95 09 00 00       	call   a60 <pipe1>
  preempt();
      cb:	e8 30 0b 00 00       	call   c00 <preempt>
  exitwait();
      d0:	e8 8b 0c 00 00       	call   d60 <exitwait>

  rmdot();
      d5:	e8 96 27 00 00       	call   2870 <rmdot>
  fourteen();
      da:	e8 51 26 00 00       	call   2730 <fourteen>
  bigfile();
      df:	e8 7c 24 00 00       	call   2560 <bigfile>
  subdir();
      e4:	e8 a7 1c 00 00       	call   1d90 <subdir>
  linktest();
      e9:	e8 32 15 00 00       	call   1620 <linktest>
  unlinkread();
      ee:	e8 9d 13 00 00       	call   1490 <unlinkread>
  dirfile();
      f3:	e8 f8 28 00 00       	call   29f0 <dirfile>
  iref();
      f8:	e8 f3 2a 00 00       	call   2bf0 <iref>
  forktest();
      fd:	e8 0e 2c 00 00       	call   2d10 <forktest>
  bigdir(); // slow
     102:	e8 49 1b 00 00       	call   1c50 <bigdir>

  uio();
     107:	e8 04 35 00 00       	call   3610 <uio>

  exectest();
     10c:	e8 ff 08 00 00       	call   a10 <exectest>

  exit();
     111:	e8 6d 38 00 00       	call   3983 <exit>
     116:	66 90                	xchg   %ax,%ax
     118:	66 90                	xchg   %ax,%ax
     11a:	66 90                	xchg   %ax,%ax
     11c:	66 90                	xchg   %ax,%ax
     11e:	66 90                	xchg   %ax,%ax

00000120 <iputtest>:
{
     120:	f3 0f 1e fb          	endbr32 
     124:	55                   	push   %ebp
     125:	89 e5                	mov    %esp,%ebp
     127:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "iput test\n");
     12a:	68 dc 3e 00 00       	push   $0x3edc
     12f:	ff 35 dc 5e 00 00    	pushl  0x5edc
     135:	e8 a6 39 00 00       	call   3ae0 <printf>
  if(mkdir("iputdir") < 0){
     13a:	c7 04 24 6f 3e 00 00 	movl   $0x3e6f,(%esp)
     141:	e8 a5 38 00 00       	call   39eb <mkdir>
     146:	83 c4 10             	add    $0x10,%esp
     149:	85 c0                	test   %eax,%eax
     14b:	78 58                	js     1a5 <iputtest+0x85>
  if(chdir("iputdir") < 0){
     14d:	83 ec 0c             	sub    $0xc,%esp
     150:	68 6f 3e 00 00       	push   $0x3e6f
     155:	e8 99 38 00 00       	call   39f3 <chdir>
     15a:	83 c4 10             	add    $0x10,%esp
     15d:	85 c0                	test   %eax,%eax
     15f:	0f 88 85 00 00 00    	js     1ea <iputtest+0xca>
  if(unlink("../iputdir") < 0){
     165:	83 ec 0c             	sub    $0xc,%esp
     168:	68 6c 3e 00 00       	push   $0x3e6c
     16d:	e8 61 38 00 00       	call   39d3 <unlink>
     172:	83 c4 10             	add    $0x10,%esp
     175:	85 c0                	test   %eax,%eax
     177:	78 5a                	js     1d3 <iputtest+0xb3>
  if(chdir("/") < 0){
     179:	83 ec 0c             	sub    $0xc,%esp
     17c:	68 91 3e 00 00       	push   $0x3e91
     181:	e8 6d 38 00 00       	call   39f3 <chdir>
     186:	83 c4 10             	add    $0x10,%esp
     189:	85 c0                	test   %eax,%eax
     18b:	78 2f                	js     1bc <iputtest+0x9c>
  printf(stdout, "iput test ok\n");
     18d:	83 ec 08             	sub    $0x8,%esp
     190:	68 14 3f 00 00       	push   $0x3f14
     195:	ff 35 dc 5e 00 00    	pushl  0x5edc
     19b:	e8 40 39 00 00       	call   3ae0 <printf>
}
     1a0:	83 c4 10             	add    $0x10,%esp
     1a3:	c9                   	leave  
     1a4:	c3                   	ret    
    printf(stdout, "mkdir failed\n");
     1a5:	50                   	push   %eax
     1a6:	50                   	push   %eax
     1a7:	68 48 3e 00 00       	push   $0x3e48
     1ac:	ff 35 dc 5e 00 00    	pushl  0x5edc
     1b2:	e8 29 39 00 00       	call   3ae0 <printf>
    exit();
     1b7:	e8 c7 37 00 00       	call   3983 <exit>
    printf(stdout, "chdir / failed\n");
     1bc:	50                   	push   %eax
     1bd:	50                   	push   %eax
     1be:	68 93 3e 00 00       	push   $0x3e93
     1c3:	ff 35 dc 5e 00 00    	pushl  0x5edc
     1c9:	e8 12 39 00 00       	call   3ae0 <printf>
    exit();
     1ce:	e8 b0 37 00 00       	call   3983 <exit>
    printf(stdout, "unlink ../iputdir failed\n");
     1d3:	52                   	push   %edx
     1d4:	52                   	push   %edx
     1d5:	68 77 3e 00 00       	push   $0x3e77
     1da:	ff 35 dc 5e 00 00    	pushl  0x5edc
     1e0:	e8 fb 38 00 00       	call   3ae0 <printf>
    exit();
     1e5:	e8 99 37 00 00       	call   3983 <exit>
    printf(stdout, "chdir iputdir failed\n");
     1ea:	51                   	push   %ecx
     1eb:	51                   	push   %ecx
     1ec:	68 56 3e 00 00       	push   $0x3e56
     1f1:	ff 35 dc 5e 00 00    	pushl  0x5edc
     1f7:	e8 e4 38 00 00       	call   3ae0 <printf>
    exit();
     1fc:	e8 82 37 00 00       	call   3983 <exit>
     201:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     208:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     20f:	90                   	nop

00000210 <exitiputtest>:
{
     210:	f3 0f 1e fb          	endbr32 
     214:	55                   	push   %ebp
     215:	89 e5                	mov    %esp,%ebp
     217:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exitiput test\n");
     21a:	68 a3 3e 00 00       	push   $0x3ea3
     21f:	ff 35 dc 5e 00 00    	pushl  0x5edc
     225:	e8 b6 38 00 00       	call   3ae0 <printf>
  pid = fork();
     22a:	e8 4c 37 00 00       	call   397b <fork>
  if(pid < 0){
     22f:	83 c4 10             	add    $0x10,%esp
     232:	85 c0                	test   %eax,%eax
     234:	0f 88 86 00 00 00    	js     2c0 <exitiputtest+0xb0>
  if(pid == 0){
     23a:	75 4c                	jne    288 <exitiputtest+0x78>
    if(mkdir("iputdir") < 0){
     23c:	83 ec 0c             	sub    $0xc,%esp
     23f:	68 6f 3e 00 00       	push   $0x3e6f
     244:	e8 a2 37 00 00       	call   39eb <mkdir>
     249:	83 c4 10             	add    $0x10,%esp
     24c:	85 c0                	test   %eax,%eax
     24e:	0f 88 83 00 00 00    	js     2d7 <exitiputtest+0xc7>
    if(chdir("iputdir") < 0){
     254:	83 ec 0c             	sub    $0xc,%esp
     257:	68 6f 3e 00 00       	push   $0x3e6f
     25c:	e8 92 37 00 00       	call   39f3 <chdir>
     261:	83 c4 10             	add    $0x10,%esp
     264:	85 c0                	test   %eax,%eax
     266:	0f 88 82 00 00 00    	js     2ee <exitiputtest+0xde>
    if(unlink("../iputdir") < 0){
     26c:	83 ec 0c             	sub    $0xc,%esp
     26f:	68 6c 3e 00 00       	push   $0x3e6c
     274:	e8 5a 37 00 00       	call   39d3 <unlink>
     279:	83 c4 10             	add    $0x10,%esp
     27c:	85 c0                	test   %eax,%eax
     27e:	78 28                	js     2a8 <exitiputtest+0x98>
    exit();
     280:	e8 fe 36 00 00       	call   3983 <exit>
     285:	8d 76 00             	lea    0x0(%esi),%esi
  wait();
     288:	e8 fe 36 00 00       	call   398b <wait>
  printf(stdout, "exitiput test ok\n");
     28d:	83 ec 08             	sub    $0x8,%esp
     290:	68 c6 3e 00 00       	push   $0x3ec6
     295:	ff 35 dc 5e 00 00    	pushl  0x5edc
     29b:	e8 40 38 00 00       	call   3ae0 <printf>
}
     2a0:	83 c4 10             	add    $0x10,%esp
     2a3:	c9                   	leave  
     2a4:	c3                   	ret    
     2a5:	8d 76 00             	lea    0x0(%esi),%esi
      printf(stdout, "unlink ../iputdir failed\n");
     2a8:	83 ec 08             	sub    $0x8,%esp
     2ab:	68 77 3e 00 00       	push   $0x3e77
     2b0:	ff 35 dc 5e 00 00    	pushl  0x5edc
     2b6:	e8 25 38 00 00       	call   3ae0 <printf>
      exit();
     2bb:	e8 c3 36 00 00       	call   3983 <exit>
    printf(stdout, "fork failed\n");
     2c0:	51                   	push   %ecx
     2c1:	51                   	push   %ecx
     2c2:	68 89 4d 00 00       	push   $0x4d89
     2c7:	ff 35 dc 5e 00 00    	pushl  0x5edc
     2cd:	e8 0e 38 00 00       	call   3ae0 <printf>
    exit();
     2d2:	e8 ac 36 00 00       	call   3983 <exit>
      printf(stdout, "mkdir failed\n");
     2d7:	52                   	push   %edx
     2d8:	52                   	push   %edx
     2d9:	68 48 3e 00 00       	push   $0x3e48
     2de:	ff 35 dc 5e 00 00    	pushl  0x5edc
     2e4:	e8 f7 37 00 00       	call   3ae0 <printf>
      exit();
     2e9:	e8 95 36 00 00       	call   3983 <exit>
      printf(stdout, "child chdir failed\n");
     2ee:	50                   	push   %eax
     2ef:	50                   	push   %eax
     2f0:	68 b2 3e 00 00       	push   $0x3eb2
     2f5:	ff 35 dc 5e 00 00    	pushl  0x5edc
     2fb:	e8 e0 37 00 00       	call   3ae0 <printf>
      exit();
     300:	e8 7e 36 00 00       	call   3983 <exit>
     305:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     30c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000310 <openiputtest>:
{
     310:	f3 0f 1e fb          	endbr32 
     314:	55                   	push   %ebp
     315:	89 e5                	mov    %esp,%ebp
     317:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "openiput test\n");
     31a:	68 d8 3e 00 00       	push   $0x3ed8
     31f:	ff 35 dc 5e 00 00    	pushl  0x5edc
     325:	e8 b6 37 00 00       	call   3ae0 <printf>
  if(mkdir("oidir") < 0){
     32a:	c7 04 24 e7 3e 00 00 	movl   $0x3ee7,(%esp)
     331:	e8 b5 36 00 00       	call   39eb <mkdir>
     336:	83 c4 10             	add    $0x10,%esp
     339:	85 c0                	test   %eax,%eax
     33b:	0f 88 9b 00 00 00    	js     3dc <openiputtest+0xcc>
  pid = fork();
     341:	e8 35 36 00 00       	call   397b <fork>
  if(pid < 0){
     346:	85 c0                	test   %eax,%eax
     348:	78 7b                	js     3c5 <openiputtest+0xb5>
  if(pid == 0){
     34a:	75 34                	jne    380 <openiputtest+0x70>
    int fd = open("oidir", O_RDWR);
     34c:	83 ec 08             	sub    $0x8,%esp
     34f:	6a 02                	push   $0x2
     351:	68 e7 3e 00 00       	push   $0x3ee7
     356:	e8 68 36 00 00       	call   39c3 <open>
    if(fd >= 0){
     35b:	83 c4 10             	add    $0x10,%esp
     35e:	85 c0                	test   %eax,%eax
     360:	78 5e                	js     3c0 <openiputtest+0xb0>
      printf(stdout, "open directory for write succeeded\n");
     362:	83 ec 08             	sub    $0x8,%esp
     365:	68 6c 4e 00 00       	push   $0x4e6c
     36a:	ff 35 dc 5e 00 00    	pushl  0x5edc
     370:	e8 6b 37 00 00       	call   3ae0 <printf>
      exit();
     375:	e8 09 36 00 00       	call   3983 <exit>
     37a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  sleep(1);
     380:	83 ec 0c             	sub    $0xc,%esp
     383:	6a 01                	push   $0x1
     385:	e8 89 36 00 00       	call   3a13 <sleep>
  if(unlink("oidir") != 0){
     38a:	c7 04 24 e7 3e 00 00 	movl   $0x3ee7,(%esp)
     391:	e8 3d 36 00 00       	call   39d3 <unlink>
     396:	83 c4 10             	add    $0x10,%esp
     399:	85 c0                	test   %eax,%eax
     39b:	75 56                	jne    3f3 <openiputtest+0xe3>
  wait();
     39d:	e8 e9 35 00 00       	call   398b <wait>
  printf(stdout, "openiput test ok\n");
     3a2:	83 ec 08             	sub    $0x8,%esp
     3a5:	68 10 3f 00 00       	push   $0x3f10
     3aa:	ff 35 dc 5e 00 00    	pushl  0x5edc
     3b0:	e8 2b 37 00 00       	call   3ae0 <printf>
}
     3b5:	83 c4 10             	add    $0x10,%esp
     3b8:	c9                   	leave  
     3b9:	c3                   	ret    
     3ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
     3c0:	e8 be 35 00 00       	call   3983 <exit>
    printf(stdout, "fork failed\n");
     3c5:	52                   	push   %edx
     3c6:	52                   	push   %edx
     3c7:	68 89 4d 00 00       	push   $0x4d89
     3cc:	ff 35 dc 5e 00 00    	pushl  0x5edc
     3d2:	e8 09 37 00 00       	call   3ae0 <printf>
    exit();
     3d7:	e8 a7 35 00 00       	call   3983 <exit>
    printf(stdout, "mkdir oidir failed\n");
     3dc:	51                   	push   %ecx
     3dd:	51                   	push   %ecx
     3de:	68 ed 3e 00 00       	push   $0x3eed
     3e3:	ff 35 dc 5e 00 00    	pushl  0x5edc
     3e9:	e8 f2 36 00 00       	call   3ae0 <printf>
    exit();
     3ee:	e8 90 35 00 00       	call   3983 <exit>
    printf(stdout, "unlink failed\n");
     3f3:	50                   	push   %eax
     3f4:	50                   	push   %eax
     3f5:	68 01 3f 00 00       	push   $0x3f01
     3fa:	ff 35 dc 5e 00 00    	pushl  0x5edc
     400:	e8 db 36 00 00       	call   3ae0 <printf>
    exit();
     405:	e8 79 35 00 00       	call   3983 <exit>
     40a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000410 <opentest>:
{
     410:	f3 0f 1e fb          	endbr32 
     414:	55                   	push   %ebp
     415:	89 e5                	mov    %esp,%ebp
     417:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "open test\n");
     41a:	68 22 3f 00 00       	push   $0x3f22
     41f:	ff 35 dc 5e 00 00    	pushl  0x5edc
     425:	e8 b6 36 00 00       	call   3ae0 <printf>
  fd = open("echo", 0);
     42a:	58                   	pop    %eax
     42b:	5a                   	pop    %edx
     42c:	6a 00                	push   $0x0
     42e:	68 2d 3f 00 00       	push   $0x3f2d
     433:	e8 8b 35 00 00       	call   39c3 <open>
  if(fd < 0){
     438:	83 c4 10             	add    $0x10,%esp
     43b:	85 c0                	test   %eax,%eax
     43d:	78 36                	js     475 <opentest+0x65>
  close(fd);
     43f:	83 ec 0c             	sub    $0xc,%esp
     442:	50                   	push   %eax
     443:	e8 63 35 00 00       	call   39ab <close>
  fd = open("doesnotexist", 0);
     448:	5a                   	pop    %edx
     449:	59                   	pop    %ecx
     44a:	6a 00                	push   $0x0
     44c:	68 45 3f 00 00       	push   $0x3f45
     451:	e8 6d 35 00 00       	call   39c3 <open>
  if(fd >= 0){
     456:	83 c4 10             	add    $0x10,%esp
     459:	85 c0                	test   %eax,%eax
     45b:	79 2f                	jns    48c <opentest+0x7c>
  printf(stdout, "open test ok\n");
     45d:	83 ec 08             	sub    $0x8,%esp
     460:	68 70 3f 00 00       	push   $0x3f70
     465:	ff 35 dc 5e 00 00    	pushl  0x5edc
     46b:	e8 70 36 00 00       	call   3ae0 <printf>
}
     470:	83 c4 10             	add    $0x10,%esp
     473:	c9                   	leave  
     474:	c3                   	ret    
    printf(stdout, "open echo failed!\n");
     475:	50                   	push   %eax
     476:	50                   	push   %eax
     477:	68 32 3f 00 00       	push   $0x3f32
     47c:	ff 35 dc 5e 00 00    	pushl  0x5edc
     482:	e8 59 36 00 00       	call   3ae0 <printf>
    exit();
     487:	e8 f7 34 00 00       	call   3983 <exit>
    printf(stdout, "open doesnotexist succeeded!\n");
     48c:	50                   	push   %eax
     48d:	50                   	push   %eax
     48e:	68 52 3f 00 00       	push   $0x3f52
     493:	ff 35 dc 5e 00 00    	pushl  0x5edc
     499:	e8 42 36 00 00       	call   3ae0 <printf>
    exit();
     49e:	e8 e0 34 00 00       	call   3983 <exit>
     4a3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     4aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000004b0 <writetest>:
{
     4b0:	f3 0f 1e fb          	endbr32 
     4b4:	55                   	push   %ebp
     4b5:	89 e5                	mov    %esp,%ebp
     4b7:	56                   	push   %esi
     4b8:	53                   	push   %ebx
  printf(stdout, "small file test\n");
     4b9:	83 ec 08             	sub    $0x8,%esp
     4bc:	68 7e 3f 00 00       	push   $0x3f7e
     4c1:	ff 35 dc 5e 00 00    	pushl  0x5edc
     4c7:	e8 14 36 00 00       	call   3ae0 <printf>
  fd = open("small", O_CREATE|O_RDWR);
     4cc:	58                   	pop    %eax
     4cd:	5a                   	pop    %edx
     4ce:	68 02 02 00 00       	push   $0x202
     4d3:	68 8f 3f 00 00       	push   $0x3f8f
     4d8:	e8 e6 34 00 00       	call   39c3 <open>
  if(fd >= 0){
     4dd:	83 c4 10             	add    $0x10,%esp
     4e0:	85 c0                	test   %eax,%eax
     4e2:	0f 88 8c 01 00 00    	js     674 <writetest+0x1c4>
    printf(stdout, "creat small succeeded; ok\n");
     4e8:	83 ec 08             	sub    $0x8,%esp
     4eb:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 100; i++){
     4ed:	31 db                	xor    %ebx,%ebx
    printf(stdout, "creat small succeeded; ok\n");
     4ef:	68 95 3f 00 00       	push   $0x3f95
     4f4:	ff 35 dc 5e 00 00    	pushl  0x5edc
     4fa:	e8 e1 35 00 00       	call   3ae0 <printf>
     4ff:	83 c4 10             	add    $0x10,%esp
     502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     508:	83 ec 04             	sub    $0x4,%esp
     50b:	6a 0a                	push   $0xa
     50d:	68 cc 3f 00 00       	push   $0x3fcc
     512:	56                   	push   %esi
     513:	e8 8b 34 00 00       	call   39a3 <write>
     518:	83 c4 10             	add    $0x10,%esp
     51b:	83 f8 0a             	cmp    $0xa,%eax
     51e:	0f 85 d9 00 00 00    	jne    5fd <writetest+0x14d>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     524:	83 ec 04             	sub    $0x4,%esp
     527:	6a 0a                	push   $0xa
     529:	68 d7 3f 00 00       	push   $0x3fd7
     52e:	56                   	push   %esi
     52f:	e8 6f 34 00 00       	call   39a3 <write>
     534:	83 c4 10             	add    $0x10,%esp
     537:	83 f8 0a             	cmp    $0xa,%eax
     53a:	0f 85 d6 00 00 00    	jne    616 <writetest+0x166>
  for(i = 0; i < 100; i++){
     540:	83 c3 01             	add    $0x1,%ebx
     543:	83 fb 64             	cmp    $0x64,%ebx
     546:	75 c0                	jne    508 <writetest+0x58>
  printf(stdout, "writes ok\n");
     548:	83 ec 08             	sub    $0x8,%esp
     54b:	68 e2 3f 00 00       	push   $0x3fe2
     550:	ff 35 dc 5e 00 00    	pushl  0x5edc
     556:	e8 85 35 00 00       	call   3ae0 <printf>
  close(fd);
     55b:	89 34 24             	mov    %esi,(%esp)
     55e:	e8 48 34 00 00       	call   39ab <close>
  fd = open("small", O_RDONLY);
     563:	5b                   	pop    %ebx
     564:	5e                   	pop    %esi
     565:	6a 00                	push   $0x0
     567:	68 8f 3f 00 00       	push   $0x3f8f
     56c:	e8 52 34 00 00       	call   39c3 <open>
  if(fd >= 0){
     571:	83 c4 10             	add    $0x10,%esp
  fd = open("small", O_RDONLY);
     574:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
     576:	85 c0                	test   %eax,%eax
     578:	0f 88 b1 00 00 00    	js     62f <writetest+0x17f>
    printf(stdout, "open small succeeded ok\n");
     57e:	83 ec 08             	sub    $0x8,%esp
     581:	68 ed 3f 00 00       	push   $0x3fed
     586:	ff 35 dc 5e 00 00    	pushl  0x5edc
     58c:	e8 4f 35 00 00       	call   3ae0 <printf>
  i = read(fd, buf, 2000);
     591:	83 c4 0c             	add    $0xc,%esp
     594:	68 d0 07 00 00       	push   $0x7d0
     599:	68 20 86 00 00       	push   $0x8620
     59e:	53                   	push   %ebx
     59f:	e8 f7 33 00 00       	call   399b <read>
  if(i == 2000){
     5a4:	83 c4 10             	add    $0x10,%esp
     5a7:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     5ac:	0f 85 94 00 00 00    	jne    646 <writetest+0x196>
    printf(stdout, "read succeeded ok\n");
     5b2:	83 ec 08             	sub    $0x8,%esp
     5b5:	68 21 40 00 00       	push   $0x4021
     5ba:	ff 35 dc 5e 00 00    	pushl  0x5edc
     5c0:	e8 1b 35 00 00       	call   3ae0 <printf>
  close(fd);
     5c5:	89 1c 24             	mov    %ebx,(%esp)
     5c8:	e8 de 33 00 00       	call   39ab <close>
  if(unlink("small") < 0){
     5cd:	c7 04 24 8f 3f 00 00 	movl   $0x3f8f,(%esp)
     5d4:	e8 fa 33 00 00       	call   39d3 <unlink>
     5d9:	83 c4 10             	add    $0x10,%esp
     5dc:	85 c0                	test   %eax,%eax
     5de:	78 7d                	js     65d <writetest+0x1ad>
  printf(stdout, "small file test ok\n");
     5e0:	83 ec 08             	sub    $0x8,%esp
     5e3:	68 49 40 00 00       	push   $0x4049
     5e8:	ff 35 dc 5e 00 00    	pushl  0x5edc
     5ee:	e8 ed 34 00 00       	call   3ae0 <printf>
}
     5f3:	83 c4 10             	add    $0x10,%esp
     5f6:	8d 65 f8             	lea    -0x8(%ebp),%esp
     5f9:	5b                   	pop    %ebx
     5fa:	5e                   	pop    %esi
     5fb:	5d                   	pop    %ebp
     5fc:	c3                   	ret    
      printf(stdout, "error: write aa %d new file failed\n", i);
     5fd:	83 ec 04             	sub    $0x4,%esp
     600:	53                   	push   %ebx
     601:	68 90 4e 00 00       	push   $0x4e90
     606:	ff 35 dc 5e 00 00    	pushl  0x5edc
     60c:	e8 cf 34 00 00       	call   3ae0 <printf>
      exit();
     611:	e8 6d 33 00 00       	call   3983 <exit>
      printf(stdout, "error: write bb %d new file failed\n", i);
     616:	83 ec 04             	sub    $0x4,%esp
     619:	53                   	push   %ebx
     61a:	68 b4 4e 00 00       	push   $0x4eb4
     61f:	ff 35 dc 5e 00 00    	pushl  0x5edc
     625:	e8 b6 34 00 00       	call   3ae0 <printf>
      exit();
     62a:	e8 54 33 00 00       	call   3983 <exit>
    printf(stdout, "error: open small failed!\n");
     62f:	51                   	push   %ecx
     630:	51                   	push   %ecx
     631:	68 06 40 00 00       	push   $0x4006
     636:	ff 35 dc 5e 00 00    	pushl  0x5edc
     63c:	e8 9f 34 00 00       	call   3ae0 <printf>
    exit();
     641:	e8 3d 33 00 00       	call   3983 <exit>
    printf(stdout, "read failed\n");
     646:	52                   	push   %edx
     647:	52                   	push   %edx
     648:	68 4d 43 00 00       	push   $0x434d
     64d:	ff 35 dc 5e 00 00    	pushl  0x5edc
     653:	e8 88 34 00 00       	call   3ae0 <printf>
    exit();
     658:	e8 26 33 00 00       	call   3983 <exit>
    printf(stdout, "unlink small failed\n");
     65d:	50                   	push   %eax
     65e:	50                   	push   %eax
     65f:	68 34 40 00 00       	push   $0x4034
     664:	ff 35 dc 5e 00 00    	pushl  0x5edc
     66a:	e8 71 34 00 00       	call   3ae0 <printf>
    exit();
     66f:	e8 0f 33 00 00       	call   3983 <exit>
    printf(stdout, "error: creat small failed!\n");
     674:	50                   	push   %eax
     675:	50                   	push   %eax
     676:	68 b0 3f 00 00       	push   $0x3fb0
     67b:	ff 35 dc 5e 00 00    	pushl  0x5edc
     681:	e8 5a 34 00 00       	call   3ae0 <printf>
    exit();
     686:	e8 f8 32 00 00       	call   3983 <exit>
     68b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     68f:	90                   	nop

00000690 <writetest1>:
{
     690:	f3 0f 1e fb          	endbr32 
     694:	55                   	push   %ebp
     695:	89 e5                	mov    %esp,%ebp
     697:	56                   	push   %esi
     698:	53                   	push   %ebx
  printf(stdout, "big files test\n");
     699:	83 ec 08             	sub    $0x8,%esp
     69c:	68 5d 40 00 00       	push   $0x405d
     6a1:	ff 35 dc 5e 00 00    	pushl  0x5edc
     6a7:	e8 34 34 00 00       	call   3ae0 <printf>
  fd = open("big", O_CREATE|O_RDWR);
     6ac:	58                   	pop    %eax
     6ad:	5a                   	pop    %edx
     6ae:	68 02 02 00 00       	push   $0x202
     6b3:	68 d7 40 00 00       	push   $0x40d7
     6b8:	e8 06 33 00 00       	call   39c3 <open>
  if(fd < 0){
     6bd:	83 c4 10             	add    $0x10,%esp
     6c0:	85 c0                	test   %eax,%eax
     6c2:	0f 88 5d 01 00 00    	js     825 <writetest1+0x195>
     6c8:	89 c6                	mov    %eax,%esi
  for(i = 0; i < MAXFILE; i++){
     6ca:	31 db                	xor    %ebx,%ebx
     6cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(write(fd, buf, 512) != 512){
     6d0:	83 ec 04             	sub    $0x4,%esp
    ((int*)buf)[0] = i;
     6d3:	89 1d 20 86 00 00    	mov    %ebx,0x8620
    if(write(fd, buf, 512) != 512){
     6d9:	68 00 02 00 00       	push   $0x200
     6de:	68 20 86 00 00       	push   $0x8620
     6e3:	56                   	push   %esi
     6e4:	e8 ba 32 00 00       	call   39a3 <write>
     6e9:	83 c4 10             	add    $0x10,%esp
     6ec:	3d 00 02 00 00       	cmp    $0x200,%eax
     6f1:	0f 85 b3 00 00 00    	jne    7aa <writetest1+0x11a>
  for(i = 0; i < MAXFILE; i++){
     6f7:	83 c3 01             	add    $0x1,%ebx
     6fa:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     700:	75 ce                	jne    6d0 <writetest1+0x40>
  close(fd);
     702:	83 ec 0c             	sub    $0xc,%esp
     705:	56                   	push   %esi
     706:	e8 a0 32 00 00       	call   39ab <close>
  fd = open("big", O_RDONLY);
     70b:	5b                   	pop    %ebx
     70c:	5e                   	pop    %esi
     70d:	6a 00                	push   $0x0
     70f:	68 d7 40 00 00       	push   $0x40d7
     714:	e8 aa 32 00 00       	call   39c3 <open>
  if(fd < 0){
     719:	83 c4 10             	add    $0x10,%esp
  fd = open("big", O_RDONLY);
     71c:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
     71e:	85 c0                	test   %eax,%eax
     720:	0f 88 e8 00 00 00    	js     80e <writetest1+0x17e>
  n = 0;
     726:	31 f6                	xor    %esi,%esi
     728:	eb 1d                	jmp    747 <writetest1+0xb7>
     72a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(i != 512){
     730:	3d 00 02 00 00       	cmp    $0x200,%eax
     735:	0f 85 9f 00 00 00    	jne    7da <writetest1+0x14a>
    if(((int*)buf)[0] != n){
     73b:	a1 20 86 00 00       	mov    0x8620,%eax
     740:	39 f0                	cmp    %esi,%eax
     742:	75 7f                	jne    7c3 <writetest1+0x133>
    n++;
     744:	83 c6 01             	add    $0x1,%esi
    i = read(fd, buf, 512);
     747:	83 ec 04             	sub    $0x4,%esp
     74a:	68 00 02 00 00       	push   $0x200
     74f:	68 20 86 00 00       	push   $0x8620
     754:	53                   	push   %ebx
     755:	e8 41 32 00 00       	call   399b <read>
    if(i == 0){
     75a:	83 c4 10             	add    $0x10,%esp
     75d:	85 c0                	test   %eax,%eax
     75f:	75 cf                	jne    730 <writetest1+0xa0>
      if(n == MAXFILE - 1){
     761:	81 fe 8b 00 00 00    	cmp    $0x8b,%esi
     767:	0f 84 86 00 00 00    	je     7f3 <writetest1+0x163>
  close(fd);
     76d:	83 ec 0c             	sub    $0xc,%esp
     770:	53                   	push   %ebx
     771:	e8 35 32 00 00       	call   39ab <close>
  if(unlink("big") < 0){
     776:	c7 04 24 d7 40 00 00 	movl   $0x40d7,(%esp)
     77d:	e8 51 32 00 00       	call   39d3 <unlink>
     782:	83 c4 10             	add    $0x10,%esp
     785:	85 c0                	test   %eax,%eax
     787:	0f 88 af 00 00 00    	js     83c <writetest1+0x1ac>
  printf(stdout, "big files ok\n");
     78d:	83 ec 08             	sub    $0x8,%esp
     790:	68 fe 40 00 00       	push   $0x40fe
     795:	ff 35 dc 5e 00 00    	pushl  0x5edc
     79b:	e8 40 33 00 00       	call   3ae0 <printf>
}
     7a0:	83 c4 10             	add    $0x10,%esp
     7a3:	8d 65 f8             	lea    -0x8(%ebp),%esp
     7a6:	5b                   	pop    %ebx
     7a7:	5e                   	pop    %esi
     7a8:	5d                   	pop    %ebp
     7a9:	c3                   	ret    
      printf(stdout, "error: write big file failed\n", i);
     7aa:	83 ec 04             	sub    $0x4,%esp
     7ad:	53                   	push   %ebx
     7ae:	68 87 40 00 00       	push   $0x4087
     7b3:	ff 35 dc 5e 00 00    	pushl  0x5edc
     7b9:	e8 22 33 00 00       	call   3ae0 <printf>
      exit();
     7be:	e8 c0 31 00 00       	call   3983 <exit>
      printf(stdout, "read content of block %d is %d\n",
     7c3:	50                   	push   %eax
     7c4:	56                   	push   %esi
     7c5:	68 d8 4e 00 00       	push   $0x4ed8
     7ca:	ff 35 dc 5e 00 00    	pushl  0x5edc
     7d0:	e8 0b 33 00 00       	call   3ae0 <printf>
      exit();
     7d5:	e8 a9 31 00 00       	call   3983 <exit>
      printf(stdout, "read failed %d\n", i);
     7da:	83 ec 04             	sub    $0x4,%esp
     7dd:	50                   	push   %eax
     7de:	68 db 40 00 00       	push   $0x40db
     7e3:	ff 35 dc 5e 00 00    	pushl  0x5edc
     7e9:	e8 f2 32 00 00       	call   3ae0 <printf>
      exit();
     7ee:	e8 90 31 00 00       	call   3983 <exit>
        printf(stdout, "read only %d blocks from big", n);
     7f3:	52                   	push   %edx
     7f4:	68 8b 00 00 00       	push   $0x8b
     7f9:	68 be 40 00 00       	push   $0x40be
     7fe:	ff 35 dc 5e 00 00    	pushl  0x5edc
     804:	e8 d7 32 00 00       	call   3ae0 <printf>
        exit();
     809:	e8 75 31 00 00       	call   3983 <exit>
    printf(stdout, "error: open big failed!\n");
     80e:	51                   	push   %ecx
     80f:	51                   	push   %ecx
     810:	68 a5 40 00 00       	push   $0x40a5
     815:	ff 35 dc 5e 00 00    	pushl  0x5edc
     81b:	e8 c0 32 00 00       	call   3ae0 <printf>
    exit();
     820:	e8 5e 31 00 00       	call   3983 <exit>
    printf(stdout, "error: creat big failed!\n");
     825:	50                   	push   %eax
     826:	50                   	push   %eax
     827:	68 6d 40 00 00       	push   $0x406d
     82c:	ff 35 dc 5e 00 00    	pushl  0x5edc
     832:	e8 a9 32 00 00       	call   3ae0 <printf>
    exit();
     837:	e8 47 31 00 00       	call   3983 <exit>
    printf(stdout, "unlink big failed\n");
     83c:	50                   	push   %eax
     83d:	50                   	push   %eax
     83e:	68 eb 40 00 00       	push   $0x40eb
     843:	ff 35 dc 5e 00 00    	pushl  0x5edc
     849:	e8 92 32 00 00       	call   3ae0 <printf>
    exit();
     84e:	e8 30 31 00 00       	call   3983 <exit>
     853:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     85a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000860 <createtest>:
{
     860:	f3 0f 1e fb          	endbr32 
     864:	55                   	push   %ebp
     865:	89 e5                	mov    %esp,%ebp
     867:	53                   	push   %ebx
  name[2] = '\0';
     868:	bb 30 00 00 00       	mov    $0x30,%ebx
{
     86d:	83 ec 0c             	sub    $0xc,%esp
  printf(stdout, "many creates, followed by unlink test\n");
     870:	68 f8 4e 00 00       	push   $0x4ef8
     875:	ff 35 dc 5e 00 00    	pushl  0x5edc
     87b:	e8 60 32 00 00       	call   3ae0 <printf>
  name[0] = 'a';
     880:	c6 05 10 86 00 00 61 	movb   $0x61,0x8610
  name[2] = '\0';
     887:	83 c4 10             	add    $0x10,%esp
     88a:	c6 05 12 86 00 00 00 	movb   $0x0,0x8612
  for(i = 0; i < 52; i++){
     891:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fd = open(name, O_CREATE|O_RDWR);
     898:	83 ec 08             	sub    $0x8,%esp
    name[1] = '0' + i;
     89b:	88 1d 11 86 00 00    	mov    %bl,0x8611
  for(i = 0; i < 52; i++){
     8a1:	83 c3 01             	add    $0x1,%ebx
    fd = open(name, O_CREATE|O_RDWR);
     8a4:	68 02 02 00 00       	push   $0x202
     8a9:	68 10 86 00 00       	push   $0x8610
     8ae:	e8 10 31 00 00       	call   39c3 <open>
    close(fd);
     8b3:	89 04 24             	mov    %eax,(%esp)
     8b6:	e8 f0 30 00 00       	call   39ab <close>
  for(i = 0; i < 52; i++){
     8bb:	83 c4 10             	add    $0x10,%esp
     8be:	80 fb 64             	cmp    $0x64,%bl
     8c1:	75 d5                	jne    898 <createtest+0x38>
  name[0] = 'a';
     8c3:	c6 05 10 86 00 00 61 	movb   $0x61,0x8610
  name[2] = '\0';
     8ca:	bb 30 00 00 00       	mov    $0x30,%ebx
     8cf:	c6 05 12 86 00 00 00 	movb   $0x0,0x8612
  for(i = 0; i < 52; i++){
     8d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     8dd:	8d 76 00             	lea    0x0(%esi),%esi
    unlink(name);
     8e0:	83 ec 0c             	sub    $0xc,%esp
    name[1] = '0' + i;
     8e3:	88 1d 11 86 00 00    	mov    %bl,0x8611
  for(i = 0; i < 52; i++){
     8e9:	83 c3 01             	add    $0x1,%ebx
    unlink(name);
     8ec:	68 10 86 00 00       	push   $0x8610
     8f1:	e8 dd 30 00 00       	call   39d3 <unlink>
  for(i = 0; i < 52; i++){
     8f6:	83 c4 10             	add    $0x10,%esp
     8f9:	80 fb 64             	cmp    $0x64,%bl
     8fc:	75 e2                	jne    8e0 <createtest+0x80>
  printf(stdout, "many creates, followed by unlink; ok\n");
     8fe:	83 ec 08             	sub    $0x8,%esp
     901:	68 20 4f 00 00       	push   $0x4f20
     906:	ff 35 dc 5e 00 00    	pushl  0x5edc
     90c:	e8 cf 31 00 00       	call   3ae0 <printf>
}
     911:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     914:	83 c4 10             	add    $0x10,%esp
     917:	c9                   	leave  
     918:	c3                   	ret    
     919:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000920 <dirtest>:
{
     920:	f3 0f 1e fb          	endbr32 
     924:	55                   	push   %ebp
     925:	89 e5                	mov    %esp,%ebp
     927:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "mkdir test\n");
     92a:	68 0c 41 00 00       	push   $0x410c
     92f:	ff 35 dc 5e 00 00    	pushl  0x5edc
     935:	e8 a6 31 00 00       	call   3ae0 <printf>
  if(mkdir("dir0") < 0){
     93a:	c7 04 24 18 41 00 00 	movl   $0x4118,(%esp)
     941:	e8 a5 30 00 00       	call   39eb <mkdir>
     946:	83 c4 10             	add    $0x10,%esp
     949:	85 c0                	test   %eax,%eax
     94b:	78 58                	js     9a5 <dirtest+0x85>
  if(chdir("dir0") < 0){
     94d:	83 ec 0c             	sub    $0xc,%esp
     950:	68 18 41 00 00       	push   $0x4118
     955:	e8 99 30 00 00       	call   39f3 <chdir>
     95a:	83 c4 10             	add    $0x10,%esp
     95d:	85 c0                	test   %eax,%eax
     95f:	0f 88 85 00 00 00    	js     9ea <dirtest+0xca>
  if(chdir("..") < 0){
     965:	83 ec 0c             	sub    $0xc,%esp
     968:	68 bd 46 00 00       	push   $0x46bd
     96d:	e8 81 30 00 00       	call   39f3 <chdir>
     972:	83 c4 10             	add    $0x10,%esp
     975:	85 c0                	test   %eax,%eax
     977:	78 5a                	js     9d3 <dirtest+0xb3>
  if(unlink("dir0") < 0){
     979:	83 ec 0c             	sub    $0xc,%esp
     97c:	68 18 41 00 00       	push   $0x4118
     981:	e8 4d 30 00 00       	call   39d3 <unlink>
     986:	83 c4 10             	add    $0x10,%esp
     989:	85 c0                	test   %eax,%eax
     98b:	78 2f                	js     9bc <dirtest+0x9c>
  printf(stdout, "mkdir test ok\n");
     98d:	83 ec 08             	sub    $0x8,%esp
     990:	68 55 41 00 00       	push   $0x4155
     995:	ff 35 dc 5e 00 00    	pushl  0x5edc
     99b:	e8 40 31 00 00       	call   3ae0 <printf>
}
     9a0:	83 c4 10             	add    $0x10,%esp
     9a3:	c9                   	leave  
     9a4:	c3                   	ret    
    printf(stdout, "mkdir failed\n");
     9a5:	50                   	push   %eax
     9a6:	50                   	push   %eax
     9a7:	68 48 3e 00 00       	push   $0x3e48
     9ac:	ff 35 dc 5e 00 00    	pushl  0x5edc
     9b2:	e8 29 31 00 00       	call   3ae0 <printf>
    exit();
     9b7:	e8 c7 2f 00 00       	call   3983 <exit>
    printf(stdout, "unlink dir0 failed\n");
     9bc:	50                   	push   %eax
     9bd:	50                   	push   %eax
     9be:	68 41 41 00 00       	push   $0x4141
     9c3:	ff 35 dc 5e 00 00    	pushl  0x5edc
     9c9:	e8 12 31 00 00       	call   3ae0 <printf>
    exit();
     9ce:	e8 b0 2f 00 00       	call   3983 <exit>
    printf(stdout, "chdir .. failed\n");
     9d3:	52                   	push   %edx
     9d4:	52                   	push   %edx
     9d5:	68 30 41 00 00       	push   $0x4130
     9da:	ff 35 dc 5e 00 00    	pushl  0x5edc
     9e0:	e8 fb 30 00 00       	call   3ae0 <printf>
    exit();
     9e5:	e8 99 2f 00 00       	call   3983 <exit>
    printf(stdout, "chdir dir0 failed\n");
     9ea:	51                   	push   %ecx
     9eb:	51                   	push   %ecx
     9ec:	68 1d 41 00 00       	push   $0x411d
     9f1:	ff 35 dc 5e 00 00    	pushl  0x5edc
     9f7:	e8 e4 30 00 00       	call   3ae0 <printf>
    exit();
     9fc:	e8 82 2f 00 00       	call   3983 <exit>
     a01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a0f:	90                   	nop

00000a10 <exectest>:
{
     a10:	f3 0f 1e fb          	endbr32 
     a14:	55                   	push   %ebp
     a15:	89 e5                	mov    %esp,%ebp
     a17:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exec test\n");
     a1a:	68 64 41 00 00       	push   $0x4164
     a1f:	ff 35 dc 5e 00 00    	pushl  0x5edc
     a25:	e8 b6 30 00 00       	call   3ae0 <printf>
  if(exec("echo", echoargv) < 0){
     a2a:	5a                   	pop    %edx
     a2b:	59                   	pop    %ecx
     a2c:	68 e0 5e 00 00       	push   $0x5ee0
     a31:	68 2d 3f 00 00       	push   $0x3f2d
     a36:	e8 80 2f 00 00       	call   39bb <exec>
     a3b:	83 c4 10             	add    $0x10,%esp
     a3e:	85 c0                	test   %eax,%eax
     a40:	78 02                	js     a44 <exectest+0x34>
}
     a42:	c9                   	leave  
     a43:	c3                   	ret    
    printf(stdout, "exec echo failed\n");
     a44:	50                   	push   %eax
     a45:	50                   	push   %eax
     a46:	68 6f 41 00 00       	push   $0x416f
     a4b:	ff 35 dc 5e 00 00    	pushl  0x5edc
     a51:	e8 8a 30 00 00       	call   3ae0 <printf>
    exit();
     a56:	e8 28 2f 00 00       	call   3983 <exit>
     a5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     a5f:	90                   	nop

00000a60 <pipe1>:
{
     a60:	f3 0f 1e fb          	endbr32 
     a64:	55                   	push   %ebp
     a65:	89 e5                	mov    %esp,%ebp
     a67:	57                   	push   %edi
     a68:	56                   	push   %esi
  if(pipe(fds) != 0){
     a69:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
     a6c:	53                   	push   %ebx
     a6d:	83 ec 38             	sub    $0x38,%esp
  if(pipe(fds) != 0){
     a70:	50                   	push   %eax
     a71:	e8 1d 2f 00 00       	call   3993 <pipe>
     a76:	83 c4 10             	add    $0x10,%esp
     a79:	85 c0                	test   %eax,%eax
     a7b:	0f 85 38 01 00 00    	jne    bb9 <pipe1+0x159>
  pid = fork();
     a81:	e8 f5 2e 00 00       	call   397b <fork>
  if(pid == 0){
     a86:	85 c0                	test   %eax,%eax
     a88:	0f 84 8d 00 00 00    	je     b1b <pipe1+0xbb>
  } else if(pid > 0){
     a8e:	0f 8e 38 01 00 00    	jle    bcc <pipe1+0x16c>
    close(fds[1]);
     a94:	83 ec 0c             	sub    $0xc,%esp
     a97:	ff 75 e4             	pushl  -0x1c(%ebp)
  seq = 0;
     a9a:	31 db                	xor    %ebx,%ebx
    cc = 1;
     a9c:	be 01 00 00 00       	mov    $0x1,%esi
    close(fds[1]);
     aa1:	e8 05 2f 00 00       	call   39ab <close>
    total = 0;
     aa6:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
     aad:	83 c4 10             	add    $0x10,%esp
     ab0:	83 ec 04             	sub    $0x4,%esp
     ab3:	56                   	push   %esi
     ab4:	68 20 86 00 00       	push   $0x8620
     ab9:	ff 75 e0             	pushl  -0x20(%ebp)
     abc:	e8 da 2e 00 00       	call   399b <read>
     ac1:	83 c4 10             	add    $0x10,%esp
     ac4:	89 c7                	mov    %eax,%edi
     ac6:	85 c0                	test   %eax,%eax
     ac8:	0f 8e a7 00 00 00    	jle    b75 <pipe1+0x115>
     ace:	8d 0c 3b             	lea    (%ebx,%edi,1),%ecx
      for(i = 0; i < n; i++){
     ad1:	31 c0                	xor    %eax,%eax
     ad3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ad7:	90                   	nop
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     ad8:	89 da                	mov    %ebx,%edx
     ada:	83 c3 01             	add    $0x1,%ebx
     add:	38 90 20 86 00 00    	cmp    %dl,0x8620(%eax)
     ae3:	75 1c                	jne    b01 <pipe1+0xa1>
      for(i = 0; i < n; i++){
     ae5:	83 c0 01             	add    $0x1,%eax
     ae8:	39 d9                	cmp    %ebx,%ecx
     aea:	75 ec                	jne    ad8 <pipe1+0x78>
      cc = cc * 2;
     aec:	01 f6                	add    %esi,%esi
      total += n;
     aee:	01 7d d4             	add    %edi,-0x2c(%ebp)
     af1:	b8 00 20 00 00       	mov    $0x2000,%eax
     af6:	81 fe 00 20 00 00    	cmp    $0x2000,%esi
     afc:	0f 4f f0             	cmovg  %eax,%esi
     aff:	eb af                	jmp    ab0 <pipe1+0x50>
          printf(1, "pipe1 oops 2\n");
     b01:	83 ec 08             	sub    $0x8,%esp
     b04:	68 9e 41 00 00       	push   $0x419e
     b09:	6a 01                	push   $0x1
     b0b:	e8 d0 2f 00 00       	call   3ae0 <printf>
          return;
     b10:	83 c4 10             	add    $0x10,%esp
}
     b13:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b16:	5b                   	pop    %ebx
     b17:	5e                   	pop    %esi
     b18:	5f                   	pop    %edi
     b19:	5d                   	pop    %ebp
     b1a:	c3                   	ret    
    close(fds[0]);
     b1b:	83 ec 0c             	sub    $0xc,%esp
     b1e:	ff 75 e0             	pushl  -0x20(%ebp)
  seq = 0;
     b21:	31 db                	xor    %ebx,%ebx
    close(fds[0]);
     b23:	e8 83 2e 00 00       	call   39ab <close>
     b28:	83 c4 10             	add    $0x10,%esp
      for(i = 0; i < 1033; i++)
     b2b:	31 c0                	xor    %eax,%eax
     b2d:	8d 76 00             	lea    0x0(%esi),%esi
        buf[i] = seq++;
     b30:	8d 14 18             	lea    (%eax,%ebx,1),%edx
      for(i = 0; i < 1033; i++)
     b33:	83 c0 01             	add    $0x1,%eax
        buf[i] = seq++;
     b36:	88 90 1f 86 00 00    	mov    %dl,0x861f(%eax)
      for(i = 0; i < 1033; i++)
     b3c:	3d 09 04 00 00       	cmp    $0x409,%eax
     b41:	75 ed                	jne    b30 <pipe1+0xd0>
      if(write(fds[1], buf, 1033) != 1033){
     b43:	83 ec 04             	sub    $0x4,%esp
        buf[i] = seq++;
     b46:	81 c3 09 04 00 00    	add    $0x409,%ebx
      if(write(fds[1], buf, 1033) != 1033){
     b4c:	68 09 04 00 00       	push   $0x409
     b51:	68 20 86 00 00       	push   $0x8620
     b56:	ff 75 e4             	pushl  -0x1c(%ebp)
     b59:	e8 45 2e 00 00       	call   39a3 <write>
     b5e:	83 c4 10             	add    $0x10,%esp
     b61:	3d 09 04 00 00       	cmp    $0x409,%eax
     b66:	75 77                	jne    bdf <pipe1+0x17f>
    for(n = 0; n < 5; n++){
     b68:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
     b6e:	75 bb                	jne    b2b <pipe1+0xcb>
    exit();
     b70:	e8 0e 2e 00 00       	call   3983 <exit>
    if(total != 5 * 1033){
     b75:	81 7d d4 2d 14 00 00 	cmpl   $0x142d,-0x2c(%ebp)
     b7c:	75 26                	jne    ba4 <pipe1+0x144>
    close(fds[0]);
     b7e:	83 ec 0c             	sub    $0xc,%esp
     b81:	ff 75 e0             	pushl  -0x20(%ebp)
     b84:	e8 22 2e 00 00       	call   39ab <close>
    wait();
     b89:	e8 fd 2d 00 00       	call   398b <wait>
  printf(1, "pipe1 ok\n");
     b8e:	5a                   	pop    %edx
     b8f:	59                   	pop    %ecx
     b90:	68 c3 41 00 00       	push   $0x41c3
     b95:	6a 01                	push   $0x1
     b97:	e8 44 2f 00 00       	call   3ae0 <printf>
     b9c:	83 c4 10             	add    $0x10,%esp
     b9f:	e9 6f ff ff ff       	jmp    b13 <pipe1+0xb3>
      printf(1, "pipe1 oops 3 total %d\n", total);
     ba4:	53                   	push   %ebx
     ba5:	ff 75 d4             	pushl  -0x2c(%ebp)
     ba8:	68 ac 41 00 00       	push   $0x41ac
     bad:	6a 01                	push   $0x1
     baf:	e8 2c 2f 00 00       	call   3ae0 <printf>
      exit();
     bb4:	e8 ca 2d 00 00       	call   3983 <exit>
    printf(1, "pipe() failed\n");
     bb9:	57                   	push   %edi
     bba:	57                   	push   %edi
     bbb:	68 81 41 00 00       	push   $0x4181
     bc0:	6a 01                	push   $0x1
     bc2:	e8 19 2f 00 00       	call   3ae0 <printf>
    exit();
     bc7:	e8 b7 2d 00 00       	call   3983 <exit>
    printf(1, "fork() failed\n");
     bcc:	50                   	push   %eax
     bcd:	50                   	push   %eax
     bce:	68 cd 41 00 00       	push   $0x41cd
     bd3:	6a 01                	push   $0x1
     bd5:	e8 06 2f 00 00       	call   3ae0 <printf>
    exit();
     bda:	e8 a4 2d 00 00       	call   3983 <exit>
        printf(1, "pipe1 oops 1\n");
     bdf:	56                   	push   %esi
     be0:	56                   	push   %esi
     be1:	68 90 41 00 00       	push   $0x4190
     be6:	6a 01                	push   $0x1
     be8:	e8 f3 2e 00 00       	call   3ae0 <printf>
        exit();
     bed:	e8 91 2d 00 00       	call   3983 <exit>
     bf2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000c00 <preempt>:
{
     c00:	f3 0f 1e fb          	endbr32 
     c04:	55                   	push   %ebp
     c05:	89 e5                	mov    %esp,%ebp
     c07:	57                   	push   %edi
     c08:	56                   	push   %esi
     c09:	53                   	push   %ebx
     c0a:	83 ec 24             	sub    $0x24,%esp
  printf(1, "preempt: ");
     c0d:	68 dc 41 00 00       	push   $0x41dc
     c12:	6a 01                	push   $0x1
     c14:	e8 c7 2e 00 00       	call   3ae0 <printf>
  pid1 = fork();
     c19:	e8 5d 2d 00 00       	call   397b <fork>
  if(pid1 == 0)
     c1e:	83 c4 10             	add    $0x10,%esp
     c21:	85 c0                	test   %eax,%eax
     c23:	75 0b                	jne    c30 <preempt+0x30>
    for(;;)
     c25:	eb fe                	jmp    c25 <preempt+0x25>
     c27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     c2e:	66 90                	xchg   %ax,%ax
     c30:	89 c3                	mov    %eax,%ebx
  pid2 = fork();
     c32:	e8 44 2d 00 00       	call   397b <fork>
     c37:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
     c39:	85 c0                	test   %eax,%eax
     c3b:	75 03                	jne    c40 <preempt+0x40>
    for(;;)
     c3d:	eb fe                	jmp    c3d <preempt+0x3d>
     c3f:	90                   	nop
  pipe(pfds);
     c40:	83 ec 0c             	sub    $0xc,%esp
     c43:	8d 45 e0             	lea    -0x20(%ebp),%eax
     c46:	50                   	push   %eax
     c47:	e8 47 2d 00 00       	call   3993 <pipe>
  pid3 = fork();
     c4c:	e8 2a 2d 00 00       	call   397b <fork>
  if(pid3 == 0){
     c51:	83 c4 10             	add    $0x10,%esp
  pid3 = fork();
     c54:	89 c7                	mov    %eax,%edi
  if(pid3 == 0){
     c56:	85 c0                	test   %eax,%eax
     c58:	75 3e                	jne    c98 <preempt+0x98>
    close(pfds[0]);
     c5a:	83 ec 0c             	sub    $0xc,%esp
     c5d:	ff 75 e0             	pushl  -0x20(%ebp)
     c60:	e8 46 2d 00 00       	call   39ab <close>
    if(write(pfds[1], "x", 1) != 1)
     c65:	83 c4 0c             	add    $0xc,%esp
     c68:	6a 01                	push   $0x1
     c6a:	68 a1 47 00 00       	push   $0x47a1
     c6f:	ff 75 e4             	pushl  -0x1c(%ebp)
     c72:	e8 2c 2d 00 00       	call   39a3 <write>
     c77:	83 c4 10             	add    $0x10,%esp
     c7a:	83 f8 01             	cmp    $0x1,%eax
     c7d:	0f 85 b8 00 00 00    	jne    d3b <preempt+0x13b>
    close(pfds[1]);
     c83:	83 ec 0c             	sub    $0xc,%esp
     c86:	ff 75 e4             	pushl  -0x1c(%ebp)
     c89:	e8 1d 2d 00 00       	call   39ab <close>
     c8e:	83 c4 10             	add    $0x10,%esp
    for(;;)
     c91:	eb fe                	jmp    c91 <preempt+0x91>
     c93:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c97:	90                   	nop
  close(pfds[1]);
     c98:	83 ec 0c             	sub    $0xc,%esp
     c9b:	ff 75 e4             	pushl  -0x1c(%ebp)
     c9e:	e8 08 2d 00 00       	call   39ab <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     ca3:	83 c4 0c             	add    $0xc,%esp
     ca6:	68 00 20 00 00       	push   $0x2000
     cab:	68 20 86 00 00       	push   $0x8620
     cb0:	ff 75 e0             	pushl  -0x20(%ebp)
     cb3:	e8 e3 2c 00 00       	call   399b <read>
     cb8:	83 c4 10             	add    $0x10,%esp
     cbb:	83 f8 01             	cmp    $0x1,%eax
     cbe:	75 67                	jne    d27 <preempt+0x127>
  close(pfds[0]);
     cc0:	83 ec 0c             	sub    $0xc,%esp
     cc3:	ff 75 e0             	pushl  -0x20(%ebp)
     cc6:	e8 e0 2c 00 00       	call   39ab <close>
  printf(1, "kill... ");
     ccb:	58                   	pop    %eax
     ccc:	5a                   	pop    %edx
     ccd:	68 0d 42 00 00       	push   $0x420d
     cd2:	6a 01                	push   $0x1
     cd4:	e8 07 2e 00 00       	call   3ae0 <printf>
  kill(pid1);
     cd9:	89 1c 24             	mov    %ebx,(%esp)
     cdc:	e8 d2 2c 00 00       	call   39b3 <kill>
  kill(pid2);
     ce1:	89 34 24             	mov    %esi,(%esp)
     ce4:	e8 ca 2c 00 00       	call   39b3 <kill>
  kill(pid3);
     ce9:	89 3c 24             	mov    %edi,(%esp)
     cec:	e8 c2 2c 00 00       	call   39b3 <kill>
  printf(1, "wait... ");
     cf1:	59                   	pop    %ecx
     cf2:	5b                   	pop    %ebx
     cf3:	68 16 42 00 00       	push   $0x4216
     cf8:	6a 01                	push   $0x1
     cfa:	e8 e1 2d 00 00       	call   3ae0 <printf>
  wait();
     cff:	e8 87 2c 00 00       	call   398b <wait>
  wait();
     d04:	e8 82 2c 00 00       	call   398b <wait>
  wait();
     d09:	e8 7d 2c 00 00       	call   398b <wait>
  printf(1, "preempt ok\n");
     d0e:	5e                   	pop    %esi
     d0f:	5f                   	pop    %edi
     d10:	68 1f 42 00 00       	push   $0x421f
     d15:	6a 01                	push   $0x1
     d17:	e8 c4 2d 00 00       	call   3ae0 <printf>
     d1c:	83 c4 10             	add    $0x10,%esp
}
     d1f:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d22:	5b                   	pop    %ebx
     d23:	5e                   	pop    %esi
     d24:	5f                   	pop    %edi
     d25:	5d                   	pop    %ebp
     d26:	c3                   	ret    
    printf(1, "preempt read error");
     d27:	83 ec 08             	sub    $0x8,%esp
     d2a:	68 fa 41 00 00       	push   $0x41fa
     d2f:	6a 01                	push   $0x1
     d31:	e8 aa 2d 00 00       	call   3ae0 <printf>
    return;
     d36:	83 c4 10             	add    $0x10,%esp
     d39:	eb e4                	jmp    d1f <preempt+0x11f>
      printf(1, "preempt write error");
     d3b:	83 ec 08             	sub    $0x8,%esp
     d3e:	68 e6 41 00 00       	push   $0x41e6
     d43:	6a 01                	push   $0x1
     d45:	e8 96 2d 00 00       	call   3ae0 <printf>
     d4a:	83 c4 10             	add    $0x10,%esp
     d4d:	e9 31 ff ff ff       	jmp    c83 <preempt+0x83>
     d52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d60 <exitwait>:
{
     d60:	f3 0f 1e fb          	endbr32 
     d64:	55                   	push   %ebp
     d65:	89 e5                	mov    %esp,%ebp
     d67:	56                   	push   %esi
     d68:	be 64 00 00 00       	mov    $0x64,%esi
     d6d:	53                   	push   %ebx
     d6e:	eb 10                	jmp    d80 <exitwait+0x20>
    if(pid){
     d70:	74 68                	je     dda <exitwait+0x7a>
      if(wait() != pid){
     d72:	e8 14 2c 00 00       	call   398b <wait>
     d77:	39 d8                	cmp    %ebx,%eax
     d79:	75 2d                	jne    da8 <exitwait+0x48>
  for(i = 0; i < 100; i++){
     d7b:	83 ee 01             	sub    $0x1,%esi
     d7e:	74 41                	je     dc1 <exitwait+0x61>
    pid = fork();
     d80:	e8 f6 2b 00 00       	call   397b <fork>
     d85:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
     d87:	85 c0                	test   %eax,%eax
     d89:	79 e5                	jns    d70 <exitwait+0x10>
      printf(1, "fork failed\n");
     d8b:	83 ec 08             	sub    $0x8,%esp
     d8e:	68 89 4d 00 00       	push   $0x4d89
     d93:	6a 01                	push   $0x1
     d95:	e8 46 2d 00 00       	call   3ae0 <printf>
      return;
     d9a:	83 c4 10             	add    $0x10,%esp
}
     d9d:	8d 65 f8             	lea    -0x8(%ebp),%esp
     da0:	5b                   	pop    %ebx
     da1:	5e                   	pop    %esi
     da2:	5d                   	pop    %ebp
     da3:	c3                   	ret    
     da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "wait wrong pid\n");
     da8:	83 ec 08             	sub    $0x8,%esp
     dab:	68 2b 42 00 00       	push   $0x422b
     db0:	6a 01                	push   $0x1
     db2:	e8 29 2d 00 00       	call   3ae0 <printf>
        return;
     db7:	83 c4 10             	add    $0x10,%esp
}
     dba:	8d 65 f8             	lea    -0x8(%ebp),%esp
     dbd:	5b                   	pop    %ebx
     dbe:	5e                   	pop    %esi
     dbf:	5d                   	pop    %ebp
     dc0:	c3                   	ret    
  printf(1, "exitwait ok\n");
     dc1:	83 ec 08             	sub    $0x8,%esp
     dc4:	68 3b 42 00 00       	push   $0x423b
     dc9:	6a 01                	push   $0x1
     dcb:	e8 10 2d 00 00       	call   3ae0 <printf>
     dd0:	83 c4 10             	add    $0x10,%esp
}
     dd3:	8d 65 f8             	lea    -0x8(%ebp),%esp
     dd6:	5b                   	pop    %ebx
     dd7:	5e                   	pop    %esi
     dd8:	5d                   	pop    %ebp
     dd9:	c3                   	ret    
      exit();
     dda:	e8 a4 2b 00 00       	call   3983 <exit>
     ddf:	90                   	nop

00000de0 <mem>:
{
     de0:	f3 0f 1e fb          	endbr32 
     de4:	55                   	push   %ebp
     de5:	89 e5                	mov    %esp,%ebp
     de7:	56                   	push   %esi
     de8:	31 f6                	xor    %esi,%esi
     dea:	53                   	push   %ebx
  printf(1, "mem test\n");
     deb:	83 ec 08             	sub    $0x8,%esp
     dee:	68 48 42 00 00       	push   $0x4248
     df3:	6a 01                	push   $0x1
     df5:	e8 e6 2c 00 00       	call   3ae0 <printf>
  ppid = getpid();
     dfa:	e8 04 2c 00 00       	call   3a03 <getpid>
     dff:	89 c3                	mov    %eax,%ebx
  if((pid = fork()) == 0){
     e01:	e8 75 2b 00 00       	call   397b <fork>
     e06:	83 c4 10             	add    $0x10,%esp
     e09:	85 c0                	test   %eax,%eax
     e0b:	74 0f                	je     e1c <mem+0x3c>
     e0d:	e9 8e 00 00 00       	jmp    ea0 <mem+0xc0>
     e12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *(char**)m2 = m1;
     e18:	89 30                	mov    %esi,(%eax)
     e1a:	89 c6                	mov    %eax,%esi
    while((m2 = malloc(10001)) != 0){
     e1c:	83 ec 0c             	sub    $0xc,%esp
     e1f:	68 11 27 00 00       	push   $0x2711
     e24:	e8 17 2f 00 00       	call   3d40 <malloc>
     e29:	83 c4 10             	add    $0x10,%esp
     e2c:	85 c0                	test   %eax,%eax
     e2e:	75 e8                	jne    e18 <mem+0x38>
    while(m1){
     e30:	85 f6                	test   %esi,%esi
     e32:	74 18                	je     e4c <mem+0x6c>
     e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      m2 = *(char**)m1;
     e38:	89 f0                	mov    %esi,%eax
      free(m1);
     e3a:	83 ec 0c             	sub    $0xc,%esp
      m2 = *(char**)m1;
     e3d:	8b 36                	mov    (%esi),%esi
      free(m1);
     e3f:	50                   	push   %eax
     e40:	e8 6b 2e 00 00       	call   3cb0 <free>
    while(m1){
     e45:	83 c4 10             	add    $0x10,%esp
     e48:	85 f6                	test   %esi,%esi
     e4a:	75 ec                	jne    e38 <mem+0x58>
    m1 = malloc(1024*20);
     e4c:	83 ec 0c             	sub    $0xc,%esp
     e4f:	68 00 50 00 00       	push   $0x5000
     e54:	e8 e7 2e 00 00       	call   3d40 <malloc>
    if(m1 == 0){
     e59:	83 c4 10             	add    $0x10,%esp
     e5c:	85 c0                	test   %eax,%eax
     e5e:	74 20                	je     e80 <mem+0xa0>
    free(m1);
     e60:	83 ec 0c             	sub    $0xc,%esp
     e63:	50                   	push   %eax
     e64:	e8 47 2e 00 00       	call   3cb0 <free>
    printf(1, "mem ok\n");
     e69:	58                   	pop    %eax
     e6a:	5a                   	pop    %edx
     e6b:	68 6c 42 00 00       	push   $0x426c
     e70:	6a 01                	push   $0x1
     e72:	e8 69 2c 00 00       	call   3ae0 <printf>
    exit();
     e77:	e8 07 2b 00 00       	call   3983 <exit>
     e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "couldn't allocate mem?!!\n");
     e80:	83 ec 08             	sub    $0x8,%esp
     e83:	68 52 42 00 00       	push   $0x4252
     e88:	6a 01                	push   $0x1
     e8a:	e8 51 2c 00 00       	call   3ae0 <printf>
      kill(ppid);
     e8f:	89 1c 24             	mov    %ebx,(%esp)
     e92:	e8 1c 2b 00 00       	call   39b3 <kill>
      exit();
     e97:	e8 e7 2a 00 00       	call   3983 <exit>
     e9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
     ea0:	8d 65 f8             	lea    -0x8(%ebp),%esp
     ea3:	5b                   	pop    %ebx
     ea4:	5e                   	pop    %esi
     ea5:	5d                   	pop    %ebp
    wait();
     ea6:	e9 e0 2a 00 00       	jmp    398b <wait>
     eab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     eaf:	90                   	nop

00000eb0 <sharedfd>:
{
     eb0:	f3 0f 1e fb          	endbr32 
     eb4:	55                   	push   %ebp
     eb5:	89 e5                	mov    %esp,%ebp
     eb7:	57                   	push   %edi
     eb8:	56                   	push   %esi
     eb9:	53                   	push   %ebx
     eba:	83 ec 34             	sub    $0x34,%esp
  printf(1, "sharedfd test\n");
     ebd:	68 74 42 00 00       	push   $0x4274
     ec2:	6a 01                	push   $0x1
     ec4:	e8 17 2c 00 00       	call   3ae0 <printf>
  unlink("sharedfd");
     ec9:	c7 04 24 83 42 00 00 	movl   $0x4283,(%esp)
     ed0:	e8 fe 2a 00 00       	call   39d3 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
     ed5:	5b                   	pop    %ebx
     ed6:	5e                   	pop    %esi
     ed7:	68 02 02 00 00       	push   $0x202
     edc:	68 83 42 00 00       	push   $0x4283
     ee1:	e8 dd 2a 00 00       	call   39c3 <open>
  if(fd < 0){
     ee6:	83 c4 10             	add    $0x10,%esp
     ee9:	85 c0                	test   %eax,%eax
     eeb:	0f 88 26 01 00 00    	js     1017 <sharedfd+0x167>
     ef1:	89 c7                	mov    %eax,%edi
  memset(buf, pid==0?'c':'p', sizeof(buf));
     ef3:	8d 75 de             	lea    -0x22(%ebp),%esi
     ef6:	bb e8 03 00 00       	mov    $0x3e8,%ebx
  pid = fork();
     efb:	e8 7b 2a 00 00       	call   397b <fork>
  memset(buf, pid==0?'c':'p', sizeof(buf));
     f00:	83 f8 01             	cmp    $0x1,%eax
  pid = fork();
     f03:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
     f06:	19 c0                	sbb    %eax,%eax
     f08:	83 ec 04             	sub    $0x4,%esp
     f0b:	83 e0 f3             	and    $0xfffffff3,%eax
     f0e:	6a 0a                	push   $0xa
     f10:	83 c0 70             	add    $0x70,%eax
     f13:	50                   	push   %eax
     f14:	56                   	push   %esi
     f15:	e8 c6 28 00 00       	call   37e0 <memset>
     f1a:	83 c4 10             	add    $0x10,%esp
     f1d:	eb 06                	jmp    f25 <sharedfd+0x75>
     f1f:	90                   	nop
  for(i = 0; i < 1000; i++){
     f20:	83 eb 01             	sub    $0x1,%ebx
     f23:	74 26                	je     f4b <sharedfd+0x9b>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     f25:	83 ec 04             	sub    $0x4,%esp
     f28:	6a 0a                	push   $0xa
     f2a:	56                   	push   %esi
     f2b:	57                   	push   %edi
     f2c:	e8 72 2a 00 00       	call   39a3 <write>
     f31:	83 c4 10             	add    $0x10,%esp
     f34:	83 f8 0a             	cmp    $0xa,%eax
     f37:	74 e7                	je     f20 <sharedfd+0x70>
      printf(1, "fstests: write sharedfd failed\n");
     f39:	83 ec 08             	sub    $0x8,%esp
     f3c:	68 74 4f 00 00       	push   $0x4f74
     f41:	6a 01                	push   $0x1
     f43:	e8 98 2b 00 00       	call   3ae0 <printf>
      break;
     f48:	83 c4 10             	add    $0x10,%esp
  if(pid == 0)
     f4b:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     f4e:	85 c9                	test   %ecx,%ecx
     f50:	0f 84 f5 00 00 00    	je     104b <sharedfd+0x19b>
    wait();
     f56:	e8 30 2a 00 00       	call   398b <wait>
  close(fd);
     f5b:	83 ec 0c             	sub    $0xc,%esp
  nc = np = 0;
     f5e:	31 db                	xor    %ebx,%ebx
  close(fd);
     f60:	57                   	push   %edi
     f61:	8d 7d e8             	lea    -0x18(%ebp),%edi
     f64:	e8 42 2a 00 00       	call   39ab <close>
  fd = open("sharedfd", 0);
     f69:	58                   	pop    %eax
     f6a:	5a                   	pop    %edx
     f6b:	6a 00                	push   $0x0
     f6d:	68 83 42 00 00       	push   $0x4283
     f72:	e8 4c 2a 00 00       	call   39c3 <open>
  if(fd < 0){
     f77:	83 c4 10             	add    $0x10,%esp
  nc = np = 0;
     f7a:	31 d2                	xor    %edx,%edx
  fd = open("sharedfd", 0);
     f7c:	89 45 d0             	mov    %eax,-0x30(%ebp)
  if(fd < 0){
     f7f:	85 c0                	test   %eax,%eax
     f81:	0f 88 aa 00 00 00    	js     1031 <sharedfd+0x181>
     f87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f8e:	66 90                	xchg   %ax,%ax
  while((n = read(fd, buf, sizeof(buf))) > 0){
     f90:	83 ec 04             	sub    $0x4,%esp
     f93:	89 55 d4             	mov    %edx,-0x2c(%ebp)
     f96:	6a 0a                	push   $0xa
     f98:	56                   	push   %esi
     f99:	ff 75 d0             	pushl  -0x30(%ebp)
     f9c:	e8 fa 29 00 00       	call   399b <read>
     fa1:	83 c4 10             	add    $0x10,%esp
     fa4:	85 c0                	test   %eax,%eax
     fa6:	7e 28                	jle    fd0 <sharedfd+0x120>
    for(i = 0; i < sizeof(buf); i++){
     fa8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     fab:	89 f0                	mov    %esi,%eax
     fad:	eb 13                	jmp    fc2 <sharedfd+0x112>
     faf:	90                   	nop
        np++;
     fb0:	80 f9 70             	cmp    $0x70,%cl
     fb3:	0f 94 c1             	sete   %cl
     fb6:	0f b6 c9             	movzbl %cl,%ecx
     fb9:	01 cb                	add    %ecx,%ebx
    for(i = 0; i < sizeof(buf); i++){
     fbb:	83 c0 01             	add    $0x1,%eax
     fbe:	39 c7                	cmp    %eax,%edi
     fc0:	74 ce                	je     f90 <sharedfd+0xe0>
      if(buf[i] == 'c')
     fc2:	0f b6 08             	movzbl (%eax),%ecx
     fc5:	80 f9 63             	cmp    $0x63,%cl
     fc8:	75 e6                	jne    fb0 <sharedfd+0x100>
        nc++;
     fca:	83 c2 01             	add    $0x1,%edx
      if(buf[i] == 'p')
     fcd:	eb ec                	jmp    fbb <sharedfd+0x10b>
     fcf:	90                   	nop
  close(fd);
     fd0:	83 ec 0c             	sub    $0xc,%esp
     fd3:	ff 75 d0             	pushl  -0x30(%ebp)
     fd6:	e8 d0 29 00 00       	call   39ab <close>
  unlink("sharedfd");
     fdb:	c7 04 24 83 42 00 00 	movl   $0x4283,(%esp)
     fe2:	e8 ec 29 00 00       	call   39d3 <unlink>
  if(nc == 10000 && np == 10000){
     fe7:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     fea:	83 c4 10             	add    $0x10,%esp
     fed:	81 fa 10 27 00 00    	cmp    $0x2710,%edx
     ff3:	75 5b                	jne    1050 <sharedfd+0x1a0>
     ff5:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
     ffb:	75 53                	jne    1050 <sharedfd+0x1a0>
    printf(1, "sharedfd ok\n");
     ffd:	83 ec 08             	sub    $0x8,%esp
    1000:	68 8c 42 00 00       	push   $0x428c
    1005:	6a 01                	push   $0x1
    1007:	e8 d4 2a 00 00       	call   3ae0 <printf>
    100c:	83 c4 10             	add    $0x10,%esp
}
    100f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1012:	5b                   	pop    %ebx
    1013:	5e                   	pop    %esi
    1014:	5f                   	pop    %edi
    1015:	5d                   	pop    %ebp
    1016:	c3                   	ret    
    printf(1, "fstests: cannot open sharedfd for writing");
    1017:	83 ec 08             	sub    $0x8,%esp
    101a:	68 48 4f 00 00       	push   $0x4f48
    101f:	6a 01                	push   $0x1
    1021:	e8 ba 2a 00 00       	call   3ae0 <printf>
    return;
    1026:	83 c4 10             	add    $0x10,%esp
}
    1029:	8d 65 f4             	lea    -0xc(%ebp),%esp
    102c:	5b                   	pop    %ebx
    102d:	5e                   	pop    %esi
    102e:	5f                   	pop    %edi
    102f:	5d                   	pop    %ebp
    1030:	c3                   	ret    
    printf(1, "fstests: cannot open sharedfd for reading\n");
    1031:	83 ec 08             	sub    $0x8,%esp
    1034:	68 94 4f 00 00       	push   $0x4f94
    1039:	6a 01                	push   $0x1
    103b:	e8 a0 2a 00 00       	call   3ae0 <printf>
    return;
    1040:	83 c4 10             	add    $0x10,%esp
}
    1043:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1046:	5b                   	pop    %ebx
    1047:	5e                   	pop    %esi
    1048:	5f                   	pop    %edi
    1049:	5d                   	pop    %ebp
    104a:	c3                   	ret    
    exit();
    104b:	e8 33 29 00 00       	call   3983 <exit>
    printf(1, "sharedfd oops %d %d\n", nc, np);
    1050:	53                   	push   %ebx
    1051:	52                   	push   %edx
    1052:	68 99 42 00 00       	push   $0x4299
    1057:	6a 01                	push   $0x1
    1059:	e8 82 2a 00 00       	call   3ae0 <printf>
    exit();
    105e:	e8 20 29 00 00       	call   3983 <exit>
    1063:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    106a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001070 <fourfiles>:
{
    1070:	f3 0f 1e fb          	endbr32 
    1074:	55                   	push   %ebp
    1075:	89 e5                	mov    %esp,%ebp
    1077:	57                   	push   %edi
    1078:	56                   	push   %esi
  printf(1, "fourfiles test\n");
    1079:	be ae 42 00 00       	mov    $0x42ae,%esi
{
    107e:	53                   	push   %ebx
  for(pi = 0; pi < 4; pi++){
    107f:	31 db                	xor    %ebx,%ebx
{
    1081:	83 ec 34             	sub    $0x34,%esp
  char *names[] = { "f0", "f1", "f2", "f3" };
    1084:	c7 45 d8 ae 42 00 00 	movl   $0x42ae,-0x28(%ebp)
  printf(1, "fourfiles test\n");
    108b:	68 b4 42 00 00       	push   $0x42b4
    1090:	6a 01                	push   $0x1
  char *names[] = { "f0", "f1", "f2", "f3" };
    1092:	c7 45 dc f7 43 00 00 	movl   $0x43f7,-0x24(%ebp)
    1099:	c7 45 e0 fb 43 00 00 	movl   $0x43fb,-0x20(%ebp)
    10a0:	c7 45 e4 b1 42 00 00 	movl   $0x42b1,-0x1c(%ebp)
  printf(1, "fourfiles test\n");
    10a7:	e8 34 2a 00 00       	call   3ae0 <printf>
    10ac:	83 c4 10             	add    $0x10,%esp
    unlink(fname);
    10af:	83 ec 0c             	sub    $0xc,%esp
    10b2:	56                   	push   %esi
    10b3:	e8 1b 29 00 00       	call   39d3 <unlink>
    pid = fork();
    10b8:	e8 be 28 00 00       	call   397b <fork>
    if(pid < 0){
    10bd:	83 c4 10             	add    $0x10,%esp
    10c0:	85 c0                	test   %eax,%eax
    10c2:	0f 88 60 01 00 00    	js     1228 <fourfiles+0x1b8>
    if(pid == 0){
    10c8:	0f 84 e5 00 00 00    	je     11b3 <fourfiles+0x143>
  for(pi = 0; pi < 4; pi++){
    10ce:	83 c3 01             	add    $0x1,%ebx
    10d1:	83 fb 04             	cmp    $0x4,%ebx
    10d4:	74 06                	je     10dc <fourfiles+0x6c>
    fname = names[pi];
    10d6:	8b 74 9d d8          	mov    -0x28(%ebp,%ebx,4),%esi
    10da:	eb d3                	jmp    10af <fourfiles+0x3f>
    wait();
    10dc:	e8 aa 28 00 00       	call   398b <wait>
  for(i = 0; i < 2; i++){
    10e1:	31 f6                	xor    %esi,%esi
    wait();
    10e3:	e8 a3 28 00 00       	call   398b <wait>
    10e8:	e8 9e 28 00 00       	call   398b <wait>
    10ed:	e8 99 28 00 00       	call   398b <wait>
    fname = names[i];
    10f2:	8b 44 b5 d8          	mov    -0x28(%ebp,%esi,4),%eax
    fd = open(fname, 0);
    10f6:	83 ec 08             	sub    $0x8,%esp
    total = 0;
    10f9:	31 db                	xor    %ebx,%ebx
    fd = open(fname, 0);
    10fb:	6a 00                	push   $0x0
    10fd:	50                   	push   %eax
    fname = names[i];
    10fe:	89 45 d0             	mov    %eax,-0x30(%ebp)
    fd = open(fname, 0);
    1101:	e8 bd 28 00 00       	call   39c3 <open>
    while((n = read(fd, buf, sizeof(buf))) > 0){
    1106:	83 c4 10             	add    $0x10,%esp
    fd = open(fname, 0);
    1109:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    110c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1110:	83 ec 04             	sub    $0x4,%esp
    1113:	68 00 20 00 00       	push   $0x2000
    1118:	68 20 86 00 00       	push   $0x8620
    111d:	ff 75 d4             	pushl  -0x2c(%ebp)
    1120:	e8 76 28 00 00       	call   399b <read>
    1125:	83 c4 10             	add    $0x10,%esp
    1128:	89 c7                	mov    %eax,%edi
    112a:	85 c0                	test   %eax,%eax
    112c:	7e 20                	jle    114e <fourfiles+0xde>
      for(j = 0; j < n; j++){
    112e:	31 c0                	xor    %eax,%eax
        if(buf[j] != '0'+i){
    1130:	83 fe 01             	cmp    $0x1,%esi
    1133:	0f be 88 20 86 00 00 	movsbl 0x8620(%eax),%ecx
    113a:	19 d2                	sbb    %edx,%edx
    113c:	83 c2 31             	add    $0x31,%edx
    113f:	39 d1                	cmp    %edx,%ecx
    1141:	75 5c                	jne    119f <fourfiles+0x12f>
      for(j = 0; j < n; j++){
    1143:	83 c0 01             	add    $0x1,%eax
    1146:	39 c7                	cmp    %eax,%edi
    1148:	75 e6                	jne    1130 <fourfiles+0xc0>
      total += n;
    114a:	01 fb                	add    %edi,%ebx
    114c:	eb c2                	jmp    1110 <fourfiles+0xa0>
    close(fd);
    114e:	83 ec 0c             	sub    $0xc,%esp
    1151:	ff 75 d4             	pushl  -0x2c(%ebp)
    1154:	e8 52 28 00 00       	call   39ab <close>
    if(total != 12*500){
    1159:	83 c4 10             	add    $0x10,%esp
    115c:	81 fb 70 17 00 00    	cmp    $0x1770,%ebx
    1162:	0f 85 d4 00 00 00    	jne    123c <fourfiles+0x1cc>
    unlink(fname);
    1168:	83 ec 0c             	sub    $0xc,%esp
    116b:	ff 75 d0             	pushl  -0x30(%ebp)
    116e:	e8 60 28 00 00       	call   39d3 <unlink>
  for(i = 0; i < 2; i++){
    1173:	83 c4 10             	add    $0x10,%esp
    1176:	83 fe 01             	cmp    $0x1,%esi
    1179:	75 1a                	jne    1195 <fourfiles+0x125>
  printf(1, "fourfiles ok\n");
    117b:	83 ec 08             	sub    $0x8,%esp
    117e:	68 f2 42 00 00       	push   $0x42f2
    1183:	6a 01                	push   $0x1
    1185:	e8 56 29 00 00       	call   3ae0 <printf>
}
    118a:	83 c4 10             	add    $0x10,%esp
    118d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1190:	5b                   	pop    %ebx
    1191:	5e                   	pop    %esi
    1192:	5f                   	pop    %edi
    1193:	5d                   	pop    %ebp
    1194:	c3                   	ret    
    1195:	be 01 00 00 00       	mov    $0x1,%esi
    119a:	e9 53 ff ff ff       	jmp    10f2 <fourfiles+0x82>
          printf(1, "wrong char\n");
    119f:	83 ec 08             	sub    $0x8,%esp
    11a2:	68 d5 42 00 00       	push   $0x42d5
    11a7:	6a 01                	push   $0x1
    11a9:	e8 32 29 00 00       	call   3ae0 <printf>
          exit();
    11ae:	e8 d0 27 00 00       	call   3983 <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    11b3:	83 ec 08             	sub    $0x8,%esp
    11b6:	68 02 02 00 00       	push   $0x202
    11bb:	56                   	push   %esi
    11bc:	e8 02 28 00 00       	call   39c3 <open>
      if(fd < 0){
    11c1:	83 c4 10             	add    $0x10,%esp
      fd = open(fname, O_CREATE | O_RDWR);
    11c4:	89 c6                	mov    %eax,%esi
      if(fd < 0){
    11c6:	85 c0                	test   %eax,%eax
    11c8:	78 45                	js     120f <fourfiles+0x19f>
      memset(buf, '0'+pi, 512);
    11ca:	83 ec 04             	sub    $0x4,%esp
    11cd:	83 c3 30             	add    $0x30,%ebx
    11d0:	68 00 02 00 00       	push   $0x200
    11d5:	53                   	push   %ebx
    11d6:	bb 0c 00 00 00       	mov    $0xc,%ebx
    11db:	68 20 86 00 00       	push   $0x8620
    11e0:	e8 fb 25 00 00       	call   37e0 <memset>
    11e5:	83 c4 10             	add    $0x10,%esp
        if((n = write(fd, buf, 500)) != 500){
    11e8:	83 ec 04             	sub    $0x4,%esp
    11eb:	68 f4 01 00 00       	push   $0x1f4
    11f0:	68 20 86 00 00       	push   $0x8620
    11f5:	56                   	push   %esi
    11f6:	e8 a8 27 00 00       	call   39a3 <write>
    11fb:	83 c4 10             	add    $0x10,%esp
    11fe:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    1203:	75 4a                	jne    124f <fourfiles+0x1df>
      for(i = 0; i < 12; i++){
    1205:	83 eb 01             	sub    $0x1,%ebx
    1208:	75 de                	jne    11e8 <fourfiles+0x178>
      exit();
    120a:	e8 74 27 00 00       	call   3983 <exit>
        printf(1, "create failed\n");
    120f:	51                   	push   %ecx
    1210:	51                   	push   %ecx
    1211:	68 4f 45 00 00       	push   $0x454f
    1216:	6a 01                	push   $0x1
    1218:	e8 c3 28 00 00       	call   3ae0 <printf>
        exit();
    121d:	e8 61 27 00 00       	call   3983 <exit>
    1222:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      printf(1, "fork failed\n");
    1228:	83 ec 08             	sub    $0x8,%esp
    122b:	68 89 4d 00 00       	push   $0x4d89
    1230:	6a 01                	push   $0x1
    1232:	e8 a9 28 00 00       	call   3ae0 <printf>
      exit();
    1237:	e8 47 27 00 00       	call   3983 <exit>
      printf(1, "wrong length %d\n", total);
    123c:	50                   	push   %eax
    123d:	53                   	push   %ebx
    123e:	68 e1 42 00 00       	push   $0x42e1
    1243:	6a 01                	push   $0x1
    1245:	e8 96 28 00 00       	call   3ae0 <printf>
      exit();
    124a:	e8 34 27 00 00       	call   3983 <exit>
          printf(1, "write failed %d\n", n);
    124f:	52                   	push   %edx
    1250:	50                   	push   %eax
    1251:	68 c4 42 00 00       	push   $0x42c4
    1256:	6a 01                	push   $0x1
    1258:	e8 83 28 00 00       	call   3ae0 <printf>
          exit();
    125d:	e8 21 27 00 00       	call   3983 <exit>
    1262:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001270 <createdelete>:
{
    1270:	f3 0f 1e fb          	endbr32 
    1274:	55                   	push   %ebp
    1275:	89 e5                	mov    %esp,%ebp
    1277:	57                   	push   %edi
    1278:	56                   	push   %esi
    1279:	53                   	push   %ebx
  for(pi = 0; pi < 4; pi++){
    127a:	31 db                	xor    %ebx,%ebx
{
    127c:	83 ec 44             	sub    $0x44,%esp
  printf(1, "createdelete test\n");
    127f:	68 00 43 00 00       	push   $0x4300
    1284:	6a 01                	push   $0x1
    1286:	e8 55 28 00 00       	call   3ae0 <printf>
    128b:	83 c4 10             	add    $0x10,%esp
    pid = fork();
    128e:	e8 e8 26 00 00       	call   397b <fork>
    if(pid < 0){
    1293:	85 c0                	test   %eax,%eax
    1295:	0f 88 bf 01 00 00    	js     145a <createdelete+0x1ea>
    if(pid == 0){
    129b:	0f 84 0f 01 00 00    	je     13b0 <createdelete+0x140>
  for(pi = 0; pi < 4; pi++){
    12a1:	83 c3 01             	add    $0x1,%ebx
    12a4:	83 fb 04             	cmp    $0x4,%ebx
    12a7:	75 e5                	jne    128e <createdelete+0x1e>
    wait();
    12a9:	e8 dd 26 00 00       	call   398b <wait>
  for(i = 0; i < N; i++){
    12ae:	31 f6                	xor    %esi,%esi
    12b0:	8d 7d c8             	lea    -0x38(%ebp),%edi
    wait();
    12b3:	e8 d3 26 00 00       	call   398b <wait>
    12b8:	e8 ce 26 00 00       	call   398b <wait>
    12bd:	e8 c9 26 00 00       	call   398b <wait>
  name[0] = name[1] = name[2] = 0;
    12c2:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
  for(i = 0; i < N; i++){
    12c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    12cd:	8d 76 00             	lea    0x0(%esi),%esi
      if((i == 0 || i >= N/2) && fd < 0){
    12d0:	83 fe 09             	cmp    $0x9,%esi
    12d3:	8d 46 30             	lea    0x30(%esi),%eax
    12d6:	0f 9f c3             	setg   %bl
    12d9:	85 f6                	test   %esi,%esi
    12db:	88 45 c7             	mov    %al,-0x39(%ebp)
    12de:	0f 94 c0             	sete   %al
    12e1:	09 c3                	or     %eax,%ebx
      } else if((i >= 1 && i < N/2) && fd >= 0){
    12e3:	8d 46 ff             	lea    -0x1(%esi),%eax
    12e6:	89 45 c0             	mov    %eax,-0x40(%ebp)
      if((i == 0 || i >= N/2) && fd < 0){
    12e9:	88 5d c6             	mov    %bl,-0x3a(%ebp)
    12ec:	bb 70 00 00 00       	mov    $0x70,%ebx
      fd = open(name, 0);
    12f1:	83 ec 08             	sub    $0x8,%esp
      name[1] = '0' + i;
    12f4:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
      name[0] = 'p' + pi;
    12f8:	88 5d c8             	mov    %bl,-0x38(%ebp)
      fd = open(name, 0);
    12fb:	6a 00                	push   $0x0
    12fd:	57                   	push   %edi
      name[1] = '0' + i;
    12fe:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    1301:	e8 bd 26 00 00       	call   39c3 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    1306:	83 c4 10             	add    $0x10,%esp
    1309:	80 7d c6 00          	cmpb   $0x0,-0x3a(%ebp)
    130d:	0f 84 7d 00 00 00    	je     1390 <createdelete+0x120>
    1313:	85 c0                	test   %eax,%eax
    1315:	0f 88 2a 01 00 00    	js     1445 <createdelete+0x1d5>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    131b:	83 7d c0 08          	cmpl   $0x8,-0x40(%ebp)
    131f:	76 73                	jbe    1394 <createdelete+0x124>
        close(fd);
    1321:	83 ec 0c             	sub    $0xc,%esp
    1324:	50                   	push   %eax
    1325:	e8 81 26 00 00       	call   39ab <close>
    132a:	83 c4 10             	add    $0x10,%esp
    for(pi = 0; pi < 4; pi++){
    132d:	83 c3 01             	add    $0x1,%ebx
    1330:	80 fb 74             	cmp    $0x74,%bl
    1333:	75 bc                	jne    12f1 <createdelete+0x81>
  for(i = 0; i < N; i++){
    1335:	83 c6 01             	add    $0x1,%esi
    1338:	83 fe 14             	cmp    $0x14,%esi
    133b:	75 93                	jne    12d0 <createdelete+0x60>
    133d:	be 70 00 00 00       	mov    $0x70,%esi
    1342:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for(pi = 0; pi < 4; pi++){
    1348:	8d 46 c0             	lea    -0x40(%esi),%eax
      name[0] = 'p' + i;
    134b:	bb 04 00 00 00       	mov    $0x4,%ebx
    1350:	88 45 c7             	mov    %al,-0x39(%ebp)
      unlink(name);
    1353:	83 ec 0c             	sub    $0xc,%esp
      name[0] = 'p' + i;
    1356:	89 f0                	mov    %esi,%eax
      unlink(name);
    1358:	57                   	push   %edi
      name[0] = 'p' + i;
    1359:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    135c:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
    1360:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    1363:	e8 6b 26 00 00       	call   39d3 <unlink>
    for(pi = 0; pi < 4; pi++){
    1368:	83 c4 10             	add    $0x10,%esp
    136b:	83 eb 01             	sub    $0x1,%ebx
    136e:	75 e3                	jne    1353 <createdelete+0xe3>
  for(i = 0; i < N; i++){
    1370:	83 c6 01             	add    $0x1,%esi
    1373:	89 f0                	mov    %esi,%eax
    1375:	3c 84                	cmp    $0x84,%al
    1377:	75 cf                	jne    1348 <createdelete+0xd8>
  printf(1, "createdelete ok\n");
    1379:	83 ec 08             	sub    $0x8,%esp
    137c:	68 13 43 00 00       	push   $0x4313
    1381:	6a 01                	push   $0x1
    1383:	e8 58 27 00 00       	call   3ae0 <printf>
}
    1388:	8d 65 f4             	lea    -0xc(%ebp),%esp
    138b:	5b                   	pop    %ebx
    138c:	5e                   	pop    %esi
    138d:	5f                   	pop    %edi
    138e:	5d                   	pop    %ebp
    138f:	c3                   	ret    
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1390:	85 c0                	test   %eax,%eax
    1392:	78 99                	js     132d <createdelete+0xbd>
        printf(1, "oops createdelete %s did exist\n", name);
    1394:	50                   	push   %eax
    1395:	57                   	push   %edi
    1396:	68 e4 4f 00 00       	push   $0x4fe4
    139b:	6a 01                	push   $0x1
    139d:	e8 3e 27 00 00       	call   3ae0 <printf>
        exit();
    13a2:	e8 dc 25 00 00       	call   3983 <exit>
    13a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    13ae:	66 90                	xchg   %ax,%ax
      name[0] = 'p' + pi;
    13b0:	83 c3 70             	add    $0x70,%ebx
      name[2] = '\0';
    13b3:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    13b7:	be 01 00 00 00       	mov    $0x1,%esi
    13bc:	8d 7d c8             	lea    -0x38(%ebp),%edi
      name[0] = 'p' + pi;
    13bf:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[2] = '\0';
    13c2:	31 db                	xor    %ebx,%ebx
    13c4:	eb 15                	jmp    13db <createdelete+0x16b>
    13c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    13cd:	8d 76 00             	lea    0x0(%esi),%esi
      for(i = 0; i < N; i++){
    13d0:	83 fe 14             	cmp    $0x14,%esi
    13d3:	74 6b                	je     1440 <createdelete+0x1d0>
    13d5:	83 c3 01             	add    $0x1,%ebx
    13d8:	83 c6 01             	add    $0x1,%esi
        fd = open(name, O_CREATE | O_RDWR);
    13db:	83 ec 08             	sub    $0x8,%esp
        name[1] = '0' + i;
    13de:	8d 43 30             	lea    0x30(%ebx),%eax
        fd = open(name, O_CREATE | O_RDWR);
    13e1:	68 02 02 00 00       	push   $0x202
    13e6:	57                   	push   %edi
        name[1] = '0' + i;
    13e7:	88 45 c9             	mov    %al,-0x37(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    13ea:	e8 d4 25 00 00       	call   39c3 <open>
        if(fd < 0){
    13ef:	83 c4 10             	add    $0x10,%esp
    13f2:	85 c0                	test   %eax,%eax
    13f4:	78 78                	js     146e <createdelete+0x1fe>
        close(fd);
    13f6:	83 ec 0c             	sub    $0xc,%esp
    13f9:	50                   	push   %eax
    13fa:	e8 ac 25 00 00       	call   39ab <close>
        if(i > 0 && (i % 2 ) == 0){
    13ff:	83 c4 10             	add    $0x10,%esp
    1402:	85 db                	test   %ebx,%ebx
    1404:	74 cf                	je     13d5 <createdelete+0x165>
    1406:	f6 c3 01             	test   $0x1,%bl
    1409:	75 c5                	jne    13d0 <createdelete+0x160>
          if(unlink(name) < 0){
    140b:	83 ec 0c             	sub    $0xc,%esp
          name[1] = '0' + (i / 2);
    140e:	89 d8                	mov    %ebx,%eax
          if(unlink(name) < 0){
    1410:	57                   	push   %edi
          name[1] = '0' + (i / 2);
    1411:	d1 f8                	sar    %eax
    1413:	83 c0 30             	add    $0x30,%eax
    1416:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    1419:	e8 b5 25 00 00       	call   39d3 <unlink>
    141e:	83 c4 10             	add    $0x10,%esp
    1421:	85 c0                	test   %eax,%eax
    1423:	79 ab                	jns    13d0 <createdelete+0x160>
            printf(1, "unlink failed\n");
    1425:	52                   	push   %edx
    1426:	52                   	push   %edx
    1427:	68 01 3f 00 00       	push   $0x3f01
    142c:	6a 01                	push   $0x1
    142e:	e8 ad 26 00 00       	call   3ae0 <printf>
            exit();
    1433:	e8 4b 25 00 00       	call   3983 <exit>
    1438:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    143f:	90                   	nop
      exit();
    1440:	e8 3e 25 00 00       	call   3983 <exit>
        printf(1, "oops createdelete %s didn't exist\n", name);
    1445:	83 ec 04             	sub    $0x4,%esp
    1448:	57                   	push   %edi
    1449:	68 c0 4f 00 00       	push   $0x4fc0
    144e:	6a 01                	push   $0x1
    1450:	e8 8b 26 00 00       	call   3ae0 <printf>
        exit();
    1455:	e8 29 25 00 00       	call   3983 <exit>
      printf(1, "fork failed\n");
    145a:	83 ec 08             	sub    $0x8,%esp
    145d:	68 89 4d 00 00       	push   $0x4d89
    1462:	6a 01                	push   $0x1
    1464:	e8 77 26 00 00       	call   3ae0 <printf>
      exit();
    1469:	e8 15 25 00 00       	call   3983 <exit>
          printf(1, "create failed\n");
    146e:	83 ec 08             	sub    $0x8,%esp
    1471:	68 4f 45 00 00       	push   $0x454f
    1476:	6a 01                	push   $0x1
    1478:	e8 63 26 00 00       	call   3ae0 <printf>
          exit();
    147d:	e8 01 25 00 00       	call   3983 <exit>
    1482:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001490 <unlinkread>:
{
    1490:	f3 0f 1e fb          	endbr32 
    1494:	55                   	push   %ebp
    1495:	89 e5                	mov    %esp,%ebp
    1497:	56                   	push   %esi
    1498:	53                   	push   %ebx
  printf(1, "unlinkread test\n");
    1499:	83 ec 08             	sub    $0x8,%esp
    149c:	68 24 43 00 00       	push   $0x4324
    14a1:	6a 01                	push   $0x1
    14a3:	e8 38 26 00 00       	call   3ae0 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    14a8:	5b                   	pop    %ebx
    14a9:	5e                   	pop    %esi
    14aa:	68 02 02 00 00       	push   $0x202
    14af:	68 35 43 00 00       	push   $0x4335
    14b4:	e8 0a 25 00 00       	call   39c3 <open>
  if(fd < 0){
    14b9:	83 c4 10             	add    $0x10,%esp
    14bc:	85 c0                	test   %eax,%eax
    14be:	0f 88 e6 00 00 00    	js     15aa <unlinkread+0x11a>
  write(fd, "hello", 5);
    14c4:	83 ec 04             	sub    $0x4,%esp
    14c7:	89 c3                	mov    %eax,%ebx
    14c9:	6a 05                	push   $0x5
    14cb:	68 5a 43 00 00       	push   $0x435a
    14d0:	50                   	push   %eax
    14d1:	e8 cd 24 00 00       	call   39a3 <write>
  close(fd);
    14d6:	89 1c 24             	mov    %ebx,(%esp)
    14d9:	e8 cd 24 00 00       	call   39ab <close>
  fd = open("unlinkread", O_RDWR);
    14de:	58                   	pop    %eax
    14df:	5a                   	pop    %edx
    14e0:	6a 02                	push   $0x2
    14e2:	68 35 43 00 00       	push   $0x4335
    14e7:	e8 d7 24 00 00       	call   39c3 <open>
  if(fd < 0){
    14ec:	83 c4 10             	add    $0x10,%esp
  fd = open("unlinkread", O_RDWR);
    14ef:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    14f1:	85 c0                	test   %eax,%eax
    14f3:	0f 88 10 01 00 00    	js     1609 <unlinkread+0x179>
  if(unlink("unlinkread") != 0){
    14f9:	83 ec 0c             	sub    $0xc,%esp
    14fc:	68 35 43 00 00       	push   $0x4335
    1501:	e8 cd 24 00 00       	call   39d3 <unlink>
    1506:	83 c4 10             	add    $0x10,%esp
    1509:	85 c0                	test   %eax,%eax
    150b:	0f 85 e5 00 00 00    	jne    15f6 <unlinkread+0x166>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    1511:	83 ec 08             	sub    $0x8,%esp
    1514:	68 02 02 00 00       	push   $0x202
    1519:	68 35 43 00 00       	push   $0x4335
    151e:	e8 a0 24 00 00       	call   39c3 <open>
  write(fd1, "yyy", 3);
    1523:	83 c4 0c             	add    $0xc,%esp
    1526:	6a 03                	push   $0x3
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    1528:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
    152a:	68 92 43 00 00       	push   $0x4392
    152f:	50                   	push   %eax
    1530:	e8 6e 24 00 00       	call   39a3 <write>
  close(fd1);
    1535:	89 34 24             	mov    %esi,(%esp)
    1538:	e8 6e 24 00 00       	call   39ab <close>
  if(read(fd, buf, sizeof(buf)) != 5){
    153d:	83 c4 0c             	add    $0xc,%esp
    1540:	68 00 20 00 00       	push   $0x2000
    1545:	68 20 86 00 00       	push   $0x8620
    154a:	53                   	push   %ebx
    154b:	e8 4b 24 00 00       	call   399b <read>
    1550:	83 c4 10             	add    $0x10,%esp
    1553:	83 f8 05             	cmp    $0x5,%eax
    1556:	0f 85 87 00 00 00    	jne    15e3 <unlinkread+0x153>
  if(buf[0] != 'h'){
    155c:	80 3d 20 86 00 00 68 	cmpb   $0x68,0x8620
    1563:	75 6b                	jne    15d0 <unlinkread+0x140>
  if(write(fd, buf, 10) != 10){
    1565:	83 ec 04             	sub    $0x4,%esp
    1568:	6a 0a                	push   $0xa
    156a:	68 20 86 00 00       	push   $0x8620
    156f:	53                   	push   %ebx
    1570:	e8 2e 24 00 00       	call   39a3 <write>
    1575:	83 c4 10             	add    $0x10,%esp
    1578:	83 f8 0a             	cmp    $0xa,%eax
    157b:	75 40                	jne    15bd <unlinkread+0x12d>
  close(fd);
    157d:	83 ec 0c             	sub    $0xc,%esp
    1580:	53                   	push   %ebx
    1581:	e8 25 24 00 00       	call   39ab <close>
  unlink("unlinkread");
    1586:	c7 04 24 35 43 00 00 	movl   $0x4335,(%esp)
    158d:	e8 41 24 00 00       	call   39d3 <unlink>
  printf(1, "unlinkread ok\n");
    1592:	58                   	pop    %eax
    1593:	5a                   	pop    %edx
    1594:	68 dd 43 00 00       	push   $0x43dd
    1599:	6a 01                	push   $0x1
    159b:	e8 40 25 00 00       	call   3ae0 <printf>
}
    15a0:	83 c4 10             	add    $0x10,%esp
    15a3:	8d 65 f8             	lea    -0x8(%ebp),%esp
    15a6:	5b                   	pop    %ebx
    15a7:	5e                   	pop    %esi
    15a8:	5d                   	pop    %ebp
    15a9:	c3                   	ret    
    printf(1, "create unlinkread failed\n");
    15aa:	51                   	push   %ecx
    15ab:	51                   	push   %ecx
    15ac:	68 40 43 00 00       	push   $0x4340
    15b1:	6a 01                	push   $0x1
    15b3:	e8 28 25 00 00       	call   3ae0 <printf>
    exit();
    15b8:	e8 c6 23 00 00       	call   3983 <exit>
    printf(1, "unlinkread write failed\n");
    15bd:	51                   	push   %ecx
    15be:	51                   	push   %ecx
    15bf:	68 c4 43 00 00       	push   $0x43c4
    15c4:	6a 01                	push   $0x1
    15c6:	e8 15 25 00 00       	call   3ae0 <printf>
    exit();
    15cb:	e8 b3 23 00 00       	call   3983 <exit>
    printf(1, "unlinkread wrong data\n");
    15d0:	53                   	push   %ebx
    15d1:	53                   	push   %ebx
    15d2:	68 ad 43 00 00       	push   $0x43ad
    15d7:	6a 01                	push   $0x1
    15d9:	e8 02 25 00 00       	call   3ae0 <printf>
    exit();
    15de:	e8 a0 23 00 00       	call   3983 <exit>
    printf(1, "unlinkread read failed");
    15e3:	56                   	push   %esi
    15e4:	56                   	push   %esi
    15e5:	68 96 43 00 00       	push   $0x4396
    15ea:	6a 01                	push   $0x1
    15ec:	e8 ef 24 00 00       	call   3ae0 <printf>
    exit();
    15f1:	e8 8d 23 00 00       	call   3983 <exit>
    printf(1, "unlink unlinkread failed\n");
    15f6:	50                   	push   %eax
    15f7:	50                   	push   %eax
    15f8:	68 78 43 00 00       	push   $0x4378
    15fd:	6a 01                	push   $0x1
    15ff:	e8 dc 24 00 00       	call   3ae0 <printf>
    exit();
    1604:	e8 7a 23 00 00       	call   3983 <exit>
    printf(1, "open unlinkread failed\n");
    1609:	50                   	push   %eax
    160a:	50                   	push   %eax
    160b:	68 60 43 00 00       	push   $0x4360
    1610:	6a 01                	push   $0x1
    1612:	e8 c9 24 00 00       	call   3ae0 <printf>
    exit();
    1617:	e8 67 23 00 00       	call   3983 <exit>
    161c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001620 <linktest>:
{
    1620:	f3 0f 1e fb          	endbr32 
    1624:	55                   	push   %ebp
    1625:	89 e5                	mov    %esp,%ebp
    1627:	53                   	push   %ebx
    1628:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "linktest\n");
    162b:	68 ec 43 00 00       	push   $0x43ec
    1630:	6a 01                	push   $0x1
    1632:	e8 a9 24 00 00       	call   3ae0 <printf>
  unlink("lf1");
    1637:	c7 04 24 f6 43 00 00 	movl   $0x43f6,(%esp)
    163e:	e8 90 23 00 00       	call   39d3 <unlink>
  unlink("lf2");
    1643:	c7 04 24 fa 43 00 00 	movl   $0x43fa,(%esp)
    164a:	e8 84 23 00 00       	call   39d3 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
    164f:	58                   	pop    %eax
    1650:	5a                   	pop    %edx
    1651:	68 02 02 00 00       	push   $0x202
    1656:	68 f6 43 00 00       	push   $0x43f6
    165b:	e8 63 23 00 00       	call   39c3 <open>
  if(fd < 0){
    1660:	83 c4 10             	add    $0x10,%esp
    1663:	85 c0                	test   %eax,%eax
    1665:	0f 88 1e 01 00 00    	js     1789 <linktest+0x169>
  if(write(fd, "hello", 5) != 5){
    166b:	83 ec 04             	sub    $0x4,%esp
    166e:	89 c3                	mov    %eax,%ebx
    1670:	6a 05                	push   $0x5
    1672:	68 5a 43 00 00       	push   $0x435a
    1677:	50                   	push   %eax
    1678:	e8 26 23 00 00       	call   39a3 <write>
    167d:	83 c4 10             	add    $0x10,%esp
    1680:	83 f8 05             	cmp    $0x5,%eax
    1683:	0f 85 98 01 00 00    	jne    1821 <linktest+0x201>
  close(fd);
    1689:	83 ec 0c             	sub    $0xc,%esp
    168c:	53                   	push   %ebx
    168d:	e8 19 23 00 00       	call   39ab <close>
  if(link("lf1", "lf2") < 0){
    1692:	5b                   	pop    %ebx
    1693:	58                   	pop    %eax
    1694:	68 fa 43 00 00       	push   $0x43fa
    1699:	68 f6 43 00 00       	push   $0x43f6
    169e:	e8 40 23 00 00       	call   39e3 <link>
    16a3:	83 c4 10             	add    $0x10,%esp
    16a6:	85 c0                	test   %eax,%eax
    16a8:	0f 88 60 01 00 00    	js     180e <linktest+0x1ee>
  unlink("lf1");
    16ae:	83 ec 0c             	sub    $0xc,%esp
    16b1:	68 f6 43 00 00       	push   $0x43f6
    16b6:	e8 18 23 00 00       	call   39d3 <unlink>
  if(open("lf1", 0) >= 0){
    16bb:	58                   	pop    %eax
    16bc:	5a                   	pop    %edx
    16bd:	6a 00                	push   $0x0
    16bf:	68 f6 43 00 00       	push   $0x43f6
    16c4:	e8 fa 22 00 00       	call   39c3 <open>
    16c9:	83 c4 10             	add    $0x10,%esp
    16cc:	85 c0                	test   %eax,%eax
    16ce:	0f 89 27 01 00 00    	jns    17fb <linktest+0x1db>
  fd = open("lf2", 0);
    16d4:	83 ec 08             	sub    $0x8,%esp
    16d7:	6a 00                	push   $0x0
    16d9:	68 fa 43 00 00       	push   $0x43fa
    16de:	e8 e0 22 00 00       	call   39c3 <open>
  if(fd < 0){
    16e3:	83 c4 10             	add    $0x10,%esp
  fd = open("lf2", 0);
    16e6:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    16e8:	85 c0                	test   %eax,%eax
    16ea:	0f 88 f8 00 00 00    	js     17e8 <linktest+0x1c8>
  if(read(fd, buf, sizeof(buf)) != 5){
    16f0:	83 ec 04             	sub    $0x4,%esp
    16f3:	68 00 20 00 00       	push   $0x2000
    16f8:	68 20 86 00 00       	push   $0x8620
    16fd:	50                   	push   %eax
    16fe:	e8 98 22 00 00       	call   399b <read>
    1703:	83 c4 10             	add    $0x10,%esp
    1706:	83 f8 05             	cmp    $0x5,%eax
    1709:	0f 85 c6 00 00 00    	jne    17d5 <linktest+0x1b5>
  close(fd);
    170f:	83 ec 0c             	sub    $0xc,%esp
    1712:	53                   	push   %ebx
    1713:	e8 93 22 00 00       	call   39ab <close>
  if(link("lf2", "lf2") >= 0){
    1718:	58                   	pop    %eax
    1719:	5a                   	pop    %edx
    171a:	68 fa 43 00 00       	push   $0x43fa
    171f:	68 fa 43 00 00       	push   $0x43fa
    1724:	e8 ba 22 00 00       	call   39e3 <link>
    1729:	83 c4 10             	add    $0x10,%esp
    172c:	85 c0                	test   %eax,%eax
    172e:	0f 89 8e 00 00 00    	jns    17c2 <linktest+0x1a2>
  unlink("lf2");
    1734:	83 ec 0c             	sub    $0xc,%esp
    1737:	68 fa 43 00 00       	push   $0x43fa
    173c:	e8 92 22 00 00       	call   39d3 <unlink>
  if(link("lf2", "lf1") >= 0){
    1741:	59                   	pop    %ecx
    1742:	5b                   	pop    %ebx
    1743:	68 f6 43 00 00       	push   $0x43f6
    1748:	68 fa 43 00 00       	push   $0x43fa
    174d:	e8 91 22 00 00       	call   39e3 <link>
    1752:	83 c4 10             	add    $0x10,%esp
    1755:	85 c0                	test   %eax,%eax
    1757:	79 56                	jns    17af <linktest+0x18f>
  if(link(".", "lf1") >= 0){
    1759:	83 ec 08             	sub    $0x8,%esp
    175c:	68 f6 43 00 00       	push   $0x43f6
    1761:	68 be 46 00 00       	push   $0x46be
    1766:	e8 78 22 00 00       	call   39e3 <link>
    176b:	83 c4 10             	add    $0x10,%esp
    176e:	85 c0                	test   %eax,%eax
    1770:	79 2a                	jns    179c <linktest+0x17c>
  printf(1, "linktest ok\n");
    1772:	83 ec 08             	sub    $0x8,%esp
    1775:	68 94 44 00 00       	push   $0x4494
    177a:	6a 01                	push   $0x1
    177c:	e8 5f 23 00 00       	call   3ae0 <printf>
}
    1781:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1784:	83 c4 10             	add    $0x10,%esp
    1787:	c9                   	leave  
    1788:	c3                   	ret    
    printf(1, "create lf1 failed\n");
    1789:	50                   	push   %eax
    178a:	50                   	push   %eax
    178b:	68 fe 43 00 00       	push   $0x43fe
    1790:	6a 01                	push   $0x1
    1792:	e8 49 23 00 00       	call   3ae0 <printf>
    exit();
    1797:	e8 e7 21 00 00       	call   3983 <exit>
    printf(1, "link . lf1 succeeded! oops\n");
    179c:	50                   	push   %eax
    179d:	50                   	push   %eax
    179e:	68 78 44 00 00       	push   $0x4478
    17a3:	6a 01                	push   $0x1
    17a5:	e8 36 23 00 00       	call   3ae0 <printf>
    exit();
    17aa:	e8 d4 21 00 00       	call   3983 <exit>
    printf(1, "link non-existant succeeded! oops\n");
    17af:	52                   	push   %edx
    17b0:	52                   	push   %edx
    17b1:	68 2c 50 00 00       	push   $0x502c
    17b6:	6a 01                	push   $0x1
    17b8:	e8 23 23 00 00       	call   3ae0 <printf>
    exit();
    17bd:	e8 c1 21 00 00       	call   3983 <exit>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    17c2:	50                   	push   %eax
    17c3:	50                   	push   %eax
    17c4:	68 5a 44 00 00       	push   $0x445a
    17c9:	6a 01                	push   $0x1
    17cb:	e8 10 23 00 00       	call   3ae0 <printf>
    exit();
    17d0:	e8 ae 21 00 00       	call   3983 <exit>
    printf(1, "read lf2 failed\n");
    17d5:	51                   	push   %ecx
    17d6:	51                   	push   %ecx
    17d7:	68 49 44 00 00       	push   $0x4449
    17dc:	6a 01                	push   $0x1
    17de:	e8 fd 22 00 00       	call   3ae0 <printf>
    exit();
    17e3:	e8 9b 21 00 00       	call   3983 <exit>
    printf(1, "open lf2 failed\n");
    17e8:	53                   	push   %ebx
    17e9:	53                   	push   %ebx
    17ea:	68 38 44 00 00       	push   $0x4438
    17ef:	6a 01                	push   $0x1
    17f1:	e8 ea 22 00 00       	call   3ae0 <printf>
    exit();
    17f6:	e8 88 21 00 00       	call   3983 <exit>
    printf(1, "unlinked lf1 but it is still there!\n");
    17fb:	50                   	push   %eax
    17fc:	50                   	push   %eax
    17fd:	68 04 50 00 00       	push   $0x5004
    1802:	6a 01                	push   $0x1
    1804:	e8 d7 22 00 00       	call   3ae0 <printf>
    exit();
    1809:	e8 75 21 00 00       	call   3983 <exit>
    printf(1, "link lf1 lf2 failed\n");
    180e:	51                   	push   %ecx
    180f:	51                   	push   %ecx
    1810:	68 23 44 00 00       	push   $0x4423
    1815:	6a 01                	push   $0x1
    1817:	e8 c4 22 00 00       	call   3ae0 <printf>
    exit();
    181c:	e8 62 21 00 00       	call   3983 <exit>
    printf(1, "write lf1 failed\n");
    1821:	50                   	push   %eax
    1822:	50                   	push   %eax
    1823:	68 11 44 00 00       	push   $0x4411
    1828:	6a 01                	push   $0x1
    182a:	e8 b1 22 00 00       	call   3ae0 <printf>
    exit();
    182f:	e8 4f 21 00 00       	call   3983 <exit>
    1834:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    183b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    183f:	90                   	nop

00001840 <concreate>:
{
    1840:	f3 0f 1e fb          	endbr32 
    1844:	55                   	push   %ebp
    1845:	89 e5                	mov    %esp,%ebp
    1847:	57                   	push   %edi
    1848:	56                   	push   %esi
  for(i = 0; i < 40; i++){
    1849:	31 f6                	xor    %esi,%esi
{
    184b:	53                   	push   %ebx
    184c:	8d 5d ad             	lea    -0x53(%ebp),%ebx
    184f:	83 ec 64             	sub    $0x64,%esp
  printf(1, "concreate test\n");
    1852:	68 a1 44 00 00       	push   $0x44a1
    1857:	6a 01                	push   $0x1
    1859:	e8 82 22 00 00       	call   3ae0 <printf>
  file[0] = 'C';
    185e:	c6 45 ad 43          	movb   $0x43,-0x53(%ebp)
  file[2] = '\0';
    1862:	83 c4 10             	add    $0x10,%esp
    1865:	c6 45 af 00          	movb   $0x0,-0x51(%ebp)
  for(i = 0; i < 40; i++){
    1869:	eb 48                	jmp    18b3 <concreate+0x73>
    186b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    186f:	90                   	nop
    1870:	69 c6 ab aa aa aa    	imul   $0xaaaaaaab,%esi,%eax
    if(pid && (i % 3) == 1){
    1876:	3d ab aa aa aa       	cmp    $0xaaaaaaab,%eax
    187b:	0f 83 af 00 00 00    	jae    1930 <concreate+0xf0>
      fd = open(file, O_CREATE | O_RDWR);
    1881:	83 ec 08             	sub    $0x8,%esp
    1884:	68 02 02 00 00       	push   $0x202
    1889:	53                   	push   %ebx
    188a:	e8 34 21 00 00       	call   39c3 <open>
      if(fd < 0){
    188f:	83 c4 10             	add    $0x10,%esp
    1892:	85 c0                	test   %eax,%eax
    1894:	78 5f                	js     18f5 <concreate+0xb5>
      close(fd);
    1896:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < 40; i++){
    1899:	83 c6 01             	add    $0x1,%esi
      close(fd);
    189c:	50                   	push   %eax
    189d:	e8 09 21 00 00       	call   39ab <close>
    18a2:	83 c4 10             	add    $0x10,%esp
      wait();
    18a5:	e8 e1 20 00 00       	call   398b <wait>
  for(i = 0; i < 40; i++){
    18aa:	83 fe 28             	cmp    $0x28,%esi
    18ad:	0f 84 9f 00 00 00    	je     1952 <concreate+0x112>
    unlink(file);
    18b3:	83 ec 0c             	sub    $0xc,%esp
    file[1] = '0' + i;
    18b6:	8d 46 30             	lea    0x30(%esi),%eax
    unlink(file);
    18b9:	53                   	push   %ebx
    file[1] = '0' + i;
    18ba:	88 45 ae             	mov    %al,-0x52(%ebp)
    unlink(file);
    18bd:	e8 11 21 00 00       	call   39d3 <unlink>
    pid = fork();
    18c2:	e8 b4 20 00 00       	call   397b <fork>
    if(pid && (i % 3) == 1){
    18c7:	83 c4 10             	add    $0x10,%esp
    18ca:	85 c0                	test   %eax,%eax
    18cc:	75 a2                	jne    1870 <concreate+0x30>
      link("C0", file);
    18ce:	69 f6 cd cc cc cc    	imul   $0xcccccccd,%esi,%esi
    } else if(pid == 0 && (i % 5) == 1){
    18d4:	81 fe cd cc cc cc    	cmp    $0xcccccccd,%esi
    18da:	73 34                	jae    1910 <concreate+0xd0>
      fd = open(file, O_CREATE | O_RDWR);
    18dc:	83 ec 08             	sub    $0x8,%esp
    18df:	68 02 02 00 00       	push   $0x202
    18e4:	53                   	push   %ebx
    18e5:	e8 d9 20 00 00       	call   39c3 <open>
      if(fd < 0){
    18ea:	83 c4 10             	add    $0x10,%esp
    18ed:	85 c0                	test   %eax,%eax
    18ef:	0f 89 39 02 00 00    	jns    1b2e <concreate+0x2ee>
        printf(1, "concreate create %s failed\n", file);
    18f5:	83 ec 04             	sub    $0x4,%esp
    18f8:	53                   	push   %ebx
    18f9:	68 b4 44 00 00       	push   $0x44b4
    18fe:	6a 01                	push   $0x1
    1900:	e8 db 21 00 00       	call   3ae0 <printf>
        exit();
    1905:	e8 79 20 00 00       	call   3983 <exit>
    190a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      link("C0", file);
    1910:	83 ec 08             	sub    $0x8,%esp
    1913:	53                   	push   %ebx
    1914:	68 b1 44 00 00       	push   $0x44b1
    1919:	e8 c5 20 00 00       	call   39e3 <link>
    191e:	83 c4 10             	add    $0x10,%esp
      exit();
    1921:	e8 5d 20 00 00       	call   3983 <exit>
    1926:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    192d:	8d 76 00             	lea    0x0(%esi),%esi
      link("C0", file);
    1930:	83 ec 08             	sub    $0x8,%esp
  for(i = 0; i < 40; i++){
    1933:	83 c6 01             	add    $0x1,%esi
      link("C0", file);
    1936:	53                   	push   %ebx
    1937:	68 b1 44 00 00       	push   $0x44b1
    193c:	e8 a2 20 00 00       	call   39e3 <link>
    1941:	83 c4 10             	add    $0x10,%esp
      wait();
    1944:	e8 42 20 00 00       	call   398b <wait>
  for(i = 0; i < 40; i++){
    1949:	83 fe 28             	cmp    $0x28,%esi
    194c:	0f 85 61 ff ff ff    	jne    18b3 <concreate+0x73>
  memset(fa, 0, sizeof(fa));
    1952:	83 ec 04             	sub    $0x4,%esp
    1955:	8d 45 c0             	lea    -0x40(%ebp),%eax
    1958:	6a 28                	push   $0x28
    195a:	6a 00                	push   $0x0
    195c:	50                   	push   %eax
    195d:	e8 7e 1e 00 00       	call   37e0 <memset>
  fd = open(".", 0);
    1962:	5e                   	pop    %esi
    1963:	5f                   	pop    %edi
    1964:	6a 00                	push   $0x0
    1966:	68 be 46 00 00       	push   $0x46be
    196b:	8d 7d b0             	lea    -0x50(%ebp),%edi
    196e:	e8 50 20 00 00       	call   39c3 <open>
  n = 0;
    1973:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
  while(read(fd, &de, sizeof(de)) > 0){
    197a:	83 c4 10             	add    $0x10,%esp
  fd = open(".", 0);
    197d:	89 c6                	mov    %eax,%esi
  while(read(fd, &de, sizeof(de)) > 0){
    197f:	90                   	nop
    1980:	83 ec 04             	sub    $0x4,%esp
    1983:	6a 10                	push   $0x10
    1985:	57                   	push   %edi
    1986:	56                   	push   %esi
    1987:	e8 0f 20 00 00       	call   399b <read>
    198c:	83 c4 10             	add    $0x10,%esp
    198f:	85 c0                	test   %eax,%eax
    1991:	7e 3d                	jle    19d0 <concreate+0x190>
    if(de.inum == 0)
    1993:	66 83 7d b0 00       	cmpw   $0x0,-0x50(%ebp)
    1998:	74 e6                	je     1980 <concreate+0x140>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    199a:	80 7d b2 43          	cmpb   $0x43,-0x4e(%ebp)
    199e:	75 e0                	jne    1980 <concreate+0x140>
    19a0:	80 7d b4 00          	cmpb   $0x0,-0x4c(%ebp)
    19a4:	75 da                	jne    1980 <concreate+0x140>
      i = de.name[1] - '0';
    19a6:	0f be 45 b3          	movsbl -0x4d(%ebp),%eax
    19aa:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    19ad:	83 f8 27             	cmp    $0x27,%eax
    19b0:	0f 87 60 01 00 00    	ja     1b16 <concreate+0x2d6>
      if(fa[i]){
    19b6:	80 7c 05 c0 00       	cmpb   $0x0,-0x40(%ebp,%eax,1)
    19bb:	0f 85 3d 01 00 00    	jne    1afe <concreate+0x2be>
      n++;
    19c1:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
      fa[i] = 1;
    19c5:	c6 44 05 c0 01       	movb   $0x1,-0x40(%ebp,%eax,1)
      n++;
    19ca:	eb b4                	jmp    1980 <concreate+0x140>
    19cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  close(fd);
    19d0:	83 ec 0c             	sub    $0xc,%esp
    19d3:	56                   	push   %esi
    19d4:	e8 d2 1f 00 00       	call   39ab <close>
  if(n != 40){
    19d9:	83 c4 10             	add    $0x10,%esp
    19dc:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    19e0:	0f 85 05 01 00 00    	jne    1aeb <concreate+0x2ab>
  for(i = 0; i < 40; i++){
    19e6:	31 f6                	xor    %esi,%esi
    19e8:	eb 4c                	jmp    1a36 <concreate+0x1f6>
    19ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
       ((i % 3) == 1 && pid != 0)){
    19f0:	85 ff                	test   %edi,%edi
    19f2:	74 05                	je     19f9 <concreate+0x1b9>
    19f4:	83 f8 01             	cmp    $0x1,%eax
    19f7:	74 6c                	je     1a65 <concreate+0x225>
      unlink(file);
    19f9:	83 ec 0c             	sub    $0xc,%esp
    19fc:	53                   	push   %ebx
    19fd:	e8 d1 1f 00 00       	call   39d3 <unlink>
      unlink(file);
    1a02:	89 1c 24             	mov    %ebx,(%esp)
    1a05:	e8 c9 1f 00 00       	call   39d3 <unlink>
      unlink(file);
    1a0a:	89 1c 24             	mov    %ebx,(%esp)
    1a0d:	e8 c1 1f 00 00       	call   39d3 <unlink>
      unlink(file);
    1a12:	89 1c 24             	mov    %ebx,(%esp)
    1a15:	e8 b9 1f 00 00       	call   39d3 <unlink>
    1a1a:	83 c4 10             	add    $0x10,%esp
    if(pid == 0)
    1a1d:	85 ff                	test   %edi,%edi
    1a1f:	0f 84 fc fe ff ff    	je     1921 <concreate+0xe1>
      wait();
    1a25:	e8 61 1f 00 00       	call   398b <wait>
  for(i = 0; i < 40; i++){
    1a2a:	83 c6 01             	add    $0x1,%esi
    1a2d:	83 fe 28             	cmp    $0x28,%esi
    1a30:	0f 84 8a 00 00 00    	je     1ac0 <concreate+0x280>
    file[1] = '0' + i;
    1a36:	8d 46 30             	lea    0x30(%esi),%eax
    1a39:	88 45 ae             	mov    %al,-0x52(%ebp)
    pid = fork();
    1a3c:	e8 3a 1f 00 00       	call   397b <fork>
    1a41:	89 c7                	mov    %eax,%edi
    if(pid < 0){
    1a43:	85 c0                	test   %eax,%eax
    1a45:	0f 88 8c 00 00 00    	js     1ad7 <concreate+0x297>
    if(((i % 3) == 0 && pid == 0) ||
    1a4b:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
    1a50:	f7 e6                	mul    %esi
    1a52:	89 d0                	mov    %edx,%eax
    1a54:	83 e2 fe             	and    $0xfffffffe,%edx
    1a57:	d1 e8                	shr    %eax
    1a59:	01 c2                	add    %eax,%edx
    1a5b:	89 f0                	mov    %esi,%eax
    1a5d:	29 d0                	sub    %edx,%eax
    1a5f:	89 c1                	mov    %eax,%ecx
    1a61:	09 f9                	or     %edi,%ecx
    1a63:	75 8b                	jne    19f0 <concreate+0x1b0>
      close(open(file, 0));
    1a65:	83 ec 08             	sub    $0x8,%esp
    1a68:	6a 00                	push   $0x0
    1a6a:	53                   	push   %ebx
    1a6b:	e8 53 1f 00 00       	call   39c3 <open>
    1a70:	89 04 24             	mov    %eax,(%esp)
    1a73:	e8 33 1f 00 00       	call   39ab <close>
      close(open(file, 0));
    1a78:	58                   	pop    %eax
    1a79:	5a                   	pop    %edx
    1a7a:	6a 00                	push   $0x0
    1a7c:	53                   	push   %ebx
    1a7d:	e8 41 1f 00 00       	call   39c3 <open>
    1a82:	89 04 24             	mov    %eax,(%esp)
    1a85:	e8 21 1f 00 00       	call   39ab <close>
      close(open(file, 0));
    1a8a:	59                   	pop    %ecx
    1a8b:	58                   	pop    %eax
    1a8c:	6a 00                	push   $0x0
    1a8e:	53                   	push   %ebx
    1a8f:	e8 2f 1f 00 00       	call   39c3 <open>
    1a94:	89 04 24             	mov    %eax,(%esp)
    1a97:	e8 0f 1f 00 00       	call   39ab <close>
      close(open(file, 0));
    1a9c:	58                   	pop    %eax
    1a9d:	5a                   	pop    %edx
    1a9e:	6a 00                	push   $0x0
    1aa0:	53                   	push   %ebx
    1aa1:	e8 1d 1f 00 00       	call   39c3 <open>
    1aa6:	89 04 24             	mov    %eax,(%esp)
    1aa9:	e8 fd 1e 00 00       	call   39ab <close>
    1aae:	83 c4 10             	add    $0x10,%esp
    1ab1:	e9 67 ff ff ff       	jmp    1a1d <concreate+0x1dd>
    1ab6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1abd:	8d 76 00             	lea    0x0(%esi),%esi
  printf(1, "concreate ok\n");
    1ac0:	83 ec 08             	sub    $0x8,%esp
    1ac3:	68 06 45 00 00       	push   $0x4506
    1ac8:	6a 01                	push   $0x1
    1aca:	e8 11 20 00 00       	call   3ae0 <printf>
}
    1acf:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1ad2:	5b                   	pop    %ebx
    1ad3:	5e                   	pop    %esi
    1ad4:	5f                   	pop    %edi
    1ad5:	5d                   	pop    %ebp
    1ad6:	c3                   	ret    
      printf(1, "fork failed\n");
    1ad7:	83 ec 08             	sub    $0x8,%esp
    1ada:	68 89 4d 00 00       	push   $0x4d89
    1adf:	6a 01                	push   $0x1
    1ae1:	e8 fa 1f 00 00       	call   3ae0 <printf>
      exit();
    1ae6:	e8 98 1e 00 00       	call   3983 <exit>
    printf(1, "concreate not enough files in directory listing\n");
    1aeb:	51                   	push   %ecx
    1aec:	51                   	push   %ecx
    1aed:	68 50 50 00 00       	push   $0x5050
    1af2:	6a 01                	push   $0x1
    1af4:	e8 e7 1f 00 00       	call   3ae0 <printf>
    exit();
    1af9:	e8 85 1e 00 00       	call   3983 <exit>
        printf(1, "concreate duplicate file %s\n", de.name);
    1afe:	83 ec 04             	sub    $0x4,%esp
    1b01:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1b04:	50                   	push   %eax
    1b05:	68 e9 44 00 00       	push   $0x44e9
    1b0a:	6a 01                	push   $0x1
    1b0c:	e8 cf 1f 00 00       	call   3ae0 <printf>
        exit();
    1b11:	e8 6d 1e 00 00       	call   3983 <exit>
        printf(1, "concreate weird file %s\n", de.name);
    1b16:	83 ec 04             	sub    $0x4,%esp
    1b19:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1b1c:	50                   	push   %eax
    1b1d:	68 d0 44 00 00       	push   $0x44d0
    1b22:	6a 01                	push   $0x1
    1b24:	e8 b7 1f 00 00       	call   3ae0 <printf>
        exit();
    1b29:	e8 55 1e 00 00       	call   3983 <exit>
      close(fd);
    1b2e:	83 ec 0c             	sub    $0xc,%esp
    1b31:	50                   	push   %eax
    1b32:	e8 74 1e 00 00       	call   39ab <close>
    1b37:	83 c4 10             	add    $0x10,%esp
    1b3a:	e9 e2 fd ff ff       	jmp    1921 <concreate+0xe1>
    1b3f:	90                   	nop

00001b40 <linkunlink>:
{
    1b40:	f3 0f 1e fb          	endbr32 
    1b44:	55                   	push   %ebp
    1b45:	89 e5                	mov    %esp,%ebp
    1b47:	57                   	push   %edi
    1b48:	56                   	push   %esi
    1b49:	53                   	push   %ebx
    1b4a:	83 ec 24             	sub    $0x24,%esp
  printf(1, "linkunlink test\n");
    1b4d:	68 14 45 00 00       	push   $0x4514
    1b52:	6a 01                	push   $0x1
    1b54:	e8 87 1f 00 00       	call   3ae0 <printf>
  unlink("x");
    1b59:	c7 04 24 a1 47 00 00 	movl   $0x47a1,(%esp)
    1b60:	e8 6e 1e 00 00       	call   39d3 <unlink>
  pid = fork();
    1b65:	e8 11 1e 00 00       	call   397b <fork>
  if(pid < 0){
    1b6a:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    1b6d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pid < 0){
    1b70:	85 c0                	test   %eax,%eax
    1b72:	0f 88 b2 00 00 00    	js     1c2a <linkunlink+0xea>
  unsigned int x = (pid ? 1 : 97);
    1b78:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    1b7c:	bb 64 00 00 00       	mov    $0x64,%ebx
    if((x % 3) == 0){
    1b81:	be ab aa aa aa       	mov    $0xaaaaaaab,%esi
  unsigned int x = (pid ? 1 : 97);
    1b86:	19 ff                	sbb    %edi,%edi
    1b88:	83 e7 60             	and    $0x60,%edi
    1b8b:	83 c7 01             	add    $0x1,%edi
    1b8e:	eb 1a                	jmp    1baa <linkunlink+0x6a>
    } else if((x % 3) == 1){
    1b90:	83 f8 01             	cmp    $0x1,%eax
    1b93:	74 7b                	je     1c10 <linkunlink+0xd0>
      unlink("x");
    1b95:	83 ec 0c             	sub    $0xc,%esp
    1b98:	68 a1 47 00 00       	push   $0x47a1
    1b9d:	e8 31 1e 00 00       	call   39d3 <unlink>
    1ba2:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    1ba5:	83 eb 01             	sub    $0x1,%ebx
    1ba8:	74 41                	je     1beb <linkunlink+0xab>
    x = x * 1103515245 + 12345;
    1baa:	69 cf 6d 4e c6 41    	imul   $0x41c64e6d,%edi,%ecx
    1bb0:	8d b9 39 30 00 00    	lea    0x3039(%ecx),%edi
    if((x % 3) == 0){
    1bb6:	89 f8                	mov    %edi,%eax
    1bb8:	f7 e6                	mul    %esi
    1bba:	89 d0                	mov    %edx,%eax
    1bbc:	83 e2 fe             	and    $0xfffffffe,%edx
    1bbf:	d1 e8                	shr    %eax
    1bc1:	01 c2                	add    %eax,%edx
    1bc3:	89 f8                	mov    %edi,%eax
    1bc5:	29 d0                	sub    %edx,%eax
    1bc7:	75 c7                	jne    1b90 <linkunlink+0x50>
      close(open("x", O_RDWR | O_CREATE));
    1bc9:	83 ec 08             	sub    $0x8,%esp
    1bcc:	68 02 02 00 00       	push   $0x202
    1bd1:	68 a1 47 00 00       	push   $0x47a1
    1bd6:	e8 e8 1d 00 00       	call   39c3 <open>
    1bdb:	89 04 24             	mov    %eax,(%esp)
    1bde:	e8 c8 1d 00 00       	call   39ab <close>
    1be3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    1be6:	83 eb 01             	sub    $0x1,%ebx
    1be9:	75 bf                	jne    1baa <linkunlink+0x6a>
  if(pid)
    1beb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bee:	85 c0                	test   %eax,%eax
    1bf0:	74 4b                	je     1c3d <linkunlink+0xfd>
    wait();
    1bf2:	e8 94 1d 00 00       	call   398b <wait>
  printf(1, "linkunlink ok\n");
    1bf7:	83 ec 08             	sub    $0x8,%esp
    1bfa:	68 29 45 00 00       	push   $0x4529
    1bff:	6a 01                	push   $0x1
    1c01:	e8 da 1e 00 00       	call   3ae0 <printf>
}
    1c06:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1c09:	5b                   	pop    %ebx
    1c0a:	5e                   	pop    %esi
    1c0b:	5f                   	pop    %edi
    1c0c:	5d                   	pop    %ebp
    1c0d:	c3                   	ret    
    1c0e:	66 90                	xchg   %ax,%ax
      link("cat", "x");
    1c10:	83 ec 08             	sub    $0x8,%esp
    1c13:	68 a1 47 00 00       	push   $0x47a1
    1c18:	68 25 45 00 00       	push   $0x4525
    1c1d:	e8 c1 1d 00 00       	call   39e3 <link>
    1c22:	83 c4 10             	add    $0x10,%esp
    1c25:	e9 7b ff ff ff       	jmp    1ba5 <linkunlink+0x65>
    printf(1, "fork failed\n");
    1c2a:	52                   	push   %edx
    1c2b:	52                   	push   %edx
    1c2c:	68 89 4d 00 00       	push   $0x4d89
    1c31:	6a 01                	push   $0x1
    1c33:	e8 a8 1e 00 00       	call   3ae0 <printf>
    exit();
    1c38:	e8 46 1d 00 00       	call   3983 <exit>
    exit();
    1c3d:	e8 41 1d 00 00       	call   3983 <exit>
    1c42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1c49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001c50 <bigdir>:
{
    1c50:	f3 0f 1e fb          	endbr32 
    1c54:	55                   	push   %ebp
    1c55:	89 e5                	mov    %esp,%ebp
    1c57:	57                   	push   %edi
    1c58:	56                   	push   %esi
    1c59:	53                   	push   %ebx
    1c5a:	83 ec 24             	sub    $0x24,%esp
  printf(1, "bigdir test\n");
    1c5d:	68 38 45 00 00       	push   $0x4538
    1c62:	6a 01                	push   $0x1
    1c64:	e8 77 1e 00 00       	call   3ae0 <printf>
  unlink("bd");
    1c69:	c7 04 24 45 45 00 00 	movl   $0x4545,(%esp)
    1c70:	e8 5e 1d 00 00       	call   39d3 <unlink>
  fd = open("bd", O_CREATE);
    1c75:	5a                   	pop    %edx
    1c76:	59                   	pop    %ecx
    1c77:	68 00 02 00 00       	push   $0x200
    1c7c:	68 45 45 00 00       	push   $0x4545
    1c81:	e8 3d 1d 00 00       	call   39c3 <open>
  if(fd < 0){
    1c86:	83 c4 10             	add    $0x10,%esp
    1c89:	85 c0                	test   %eax,%eax
    1c8b:	0f 88 ea 00 00 00    	js     1d7b <bigdir+0x12b>
  close(fd);
    1c91:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < 500; i++){
    1c94:	31 f6                	xor    %esi,%esi
    1c96:	8d 7d de             	lea    -0x22(%ebp),%edi
  close(fd);
    1c99:	50                   	push   %eax
    1c9a:	e8 0c 1d 00 00       	call   39ab <close>
    1c9f:	83 c4 10             	add    $0x10,%esp
    1ca2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    name[1] = '0' + (i / 64);
    1ca8:	89 f0                	mov    %esi,%eax
    if(link("bd", name) != 0){
    1caa:	83 ec 08             	sub    $0x8,%esp
    name[0] = 'x';
    1cad:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    name[1] = '0' + (i / 64);
    1cb1:	c1 f8 06             	sar    $0x6,%eax
    if(link("bd", name) != 0){
    1cb4:	57                   	push   %edi
    name[1] = '0' + (i / 64);
    1cb5:	83 c0 30             	add    $0x30,%eax
    if(link("bd", name) != 0){
    1cb8:	68 45 45 00 00       	push   $0x4545
    name[1] = '0' + (i / 64);
    1cbd:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    1cc0:	89 f0                	mov    %esi,%eax
    1cc2:	83 e0 3f             	and    $0x3f,%eax
    name[3] = '\0';
    1cc5:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    name[2] = '0' + (i % 64);
    1cc9:	83 c0 30             	add    $0x30,%eax
    1ccc:	88 45 e0             	mov    %al,-0x20(%ebp)
    if(link("bd", name) != 0){
    1ccf:	e8 0f 1d 00 00       	call   39e3 <link>
    1cd4:	83 c4 10             	add    $0x10,%esp
    1cd7:	89 c3                	mov    %eax,%ebx
    1cd9:	85 c0                	test   %eax,%eax
    1cdb:	75 76                	jne    1d53 <bigdir+0x103>
  for(i = 0; i < 500; i++){
    1cdd:	83 c6 01             	add    $0x1,%esi
    1ce0:	81 fe f4 01 00 00    	cmp    $0x1f4,%esi
    1ce6:	75 c0                	jne    1ca8 <bigdir+0x58>
  unlink("bd");
    1ce8:	83 ec 0c             	sub    $0xc,%esp
    1ceb:	68 45 45 00 00       	push   $0x4545
    1cf0:	e8 de 1c 00 00       	call   39d3 <unlink>
    1cf5:	83 c4 10             	add    $0x10,%esp
    1cf8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1cff:	90                   	nop
    name[1] = '0' + (i / 64);
    1d00:	89 d8                	mov    %ebx,%eax
    if(unlink(name) != 0){
    1d02:	83 ec 0c             	sub    $0xc,%esp
    name[0] = 'x';
    1d05:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    name[1] = '0' + (i / 64);
    1d09:	c1 f8 06             	sar    $0x6,%eax
    if(unlink(name) != 0){
    1d0c:	57                   	push   %edi
    name[1] = '0' + (i / 64);
    1d0d:	83 c0 30             	add    $0x30,%eax
    name[3] = '\0';
    1d10:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    name[1] = '0' + (i / 64);
    1d14:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    1d17:	89 d8                	mov    %ebx,%eax
    1d19:	83 e0 3f             	and    $0x3f,%eax
    1d1c:	83 c0 30             	add    $0x30,%eax
    1d1f:	88 45 e0             	mov    %al,-0x20(%ebp)
    if(unlink(name) != 0){
    1d22:	e8 ac 1c 00 00       	call   39d3 <unlink>
    1d27:	83 c4 10             	add    $0x10,%esp
    1d2a:	85 c0                	test   %eax,%eax
    1d2c:	75 39                	jne    1d67 <bigdir+0x117>
  for(i = 0; i < 500; i++){
    1d2e:	83 c3 01             	add    $0x1,%ebx
    1d31:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1d37:	75 c7                	jne    1d00 <bigdir+0xb0>
  printf(1, "bigdir ok\n");
    1d39:	83 ec 08             	sub    $0x8,%esp
    1d3c:	68 87 45 00 00       	push   $0x4587
    1d41:	6a 01                	push   $0x1
    1d43:	e8 98 1d 00 00       	call   3ae0 <printf>
    1d48:	83 c4 10             	add    $0x10,%esp
}
    1d4b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1d4e:	5b                   	pop    %ebx
    1d4f:	5e                   	pop    %esi
    1d50:	5f                   	pop    %edi
    1d51:	5d                   	pop    %ebp
    1d52:	c3                   	ret    
      printf(1, "bigdir link failed\n");
    1d53:	83 ec 08             	sub    $0x8,%esp
    1d56:	68 5e 45 00 00       	push   $0x455e
    1d5b:	6a 01                	push   $0x1
    1d5d:	e8 7e 1d 00 00       	call   3ae0 <printf>
      exit();
    1d62:	e8 1c 1c 00 00       	call   3983 <exit>
      printf(1, "bigdir unlink failed");
    1d67:	83 ec 08             	sub    $0x8,%esp
    1d6a:	68 72 45 00 00       	push   $0x4572
    1d6f:	6a 01                	push   $0x1
    1d71:	e8 6a 1d 00 00       	call   3ae0 <printf>
      exit();
    1d76:	e8 08 1c 00 00       	call   3983 <exit>
    printf(1, "bigdir create failed\n");
    1d7b:	50                   	push   %eax
    1d7c:	50                   	push   %eax
    1d7d:	68 48 45 00 00       	push   $0x4548
    1d82:	6a 01                	push   $0x1
    1d84:	e8 57 1d 00 00       	call   3ae0 <printf>
    exit();
    1d89:	e8 f5 1b 00 00       	call   3983 <exit>
    1d8e:	66 90                	xchg   %ax,%ax

00001d90 <subdir>:
{
    1d90:	f3 0f 1e fb          	endbr32 
    1d94:	55                   	push   %ebp
    1d95:	89 e5                	mov    %esp,%ebp
    1d97:	53                   	push   %ebx
    1d98:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "subdir test\n");
    1d9b:	68 92 45 00 00       	push   $0x4592
    1da0:	6a 01                	push   $0x1
    1da2:	e8 39 1d 00 00       	call   3ae0 <printf>
  unlink("ff");
    1da7:	c7 04 24 1b 46 00 00 	movl   $0x461b,(%esp)
    1dae:	e8 20 1c 00 00       	call   39d3 <unlink>
  if(mkdir("dd") != 0){
    1db3:	c7 04 24 b8 46 00 00 	movl   $0x46b8,(%esp)
    1dba:	e8 2c 1c 00 00       	call   39eb <mkdir>
    1dbf:	83 c4 10             	add    $0x10,%esp
    1dc2:	85 c0                	test   %eax,%eax
    1dc4:	0f 85 b3 05 00 00    	jne    237d <subdir+0x5ed>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    1dca:	83 ec 08             	sub    $0x8,%esp
    1dcd:	68 02 02 00 00       	push   $0x202
    1dd2:	68 f1 45 00 00       	push   $0x45f1
    1dd7:	e8 e7 1b 00 00       	call   39c3 <open>
  if(fd < 0){
    1ddc:	83 c4 10             	add    $0x10,%esp
  fd = open("dd/ff", O_CREATE | O_RDWR);
    1ddf:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1de1:	85 c0                	test   %eax,%eax
    1de3:	0f 88 81 05 00 00    	js     236a <subdir+0x5da>
  write(fd, "ff", 2);
    1de9:	83 ec 04             	sub    $0x4,%esp
    1dec:	6a 02                	push   $0x2
    1dee:	68 1b 46 00 00       	push   $0x461b
    1df3:	50                   	push   %eax
    1df4:	e8 aa 1b 00 00       	call   39a3 <write>
  close(fd);
    1df9:	89 1c 24             	mov    %ebx,(%esp)
    1dfc:	e8 aa 1b 00 00       	call   39ab <close>
  if(unlink("dd") >= 0){
    1e01:	c7 04 24 b8 46 00 00 	movl   $0x46b8,(%esp)
    1e08:	e8 c6 1b 00 00       	call   39d3 <unlink>
    1e0d:	83 c4 10             	add    $0x10,%esp
    1e10:	85 c0                	test   %eax,%eax
    1e12:	0f 89 3f 05 00 00    	jns    2357 <subdir+0x5c7>
  if(mkdir("/dd/dd") != 0){
    1e18:	83 ec 0c             	sub    $0xc,%esp
    1e1b:	68 cc 45 00 00       	push   $0x45cc
    1e20:	e8 c6 1b 00 00       	call   39eb <mkdir>
    1e25:	83 c4 10             	add    $0x10,%esp
    1e28:	85 c0                	test   %eax,%eax
    1e2a:	0f 85 14 05 00 00    	jne    2344 <subdir+0x5b4>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1e30:	83 ec 08             	sub    $0x8,%esp
    1e33:	68 02 02 00 00       	push   $0x202
    1e38:	68 ee 45 00 00       	push   $0x45ee
    1e3d:	e8 81 1b 00 00       	call   39c3 <open>
  if(fd < 0){
    1e42:	83 c4 10             	add    $0x10,%esp
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1e45:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1e47:	85 c0                	test   %eax,%eax
    1e49:	0f 88 24 04 00 00    	js     2273 <subdir+0x4e3>
  write(fd, "FF", 2);
    1e4f:	83 ec 04             	sub    $0x4,%esp
    1e52:	6a 02                	push   $0x2
    1e54:	68 0f 46 00 00       	push   $0x460f
    1e59:	50                   	push   %eax
    1e5a:	e8 44 1b 00 00       	call   39a3 <write>
  close(fd);
    1e5f:	89 1c 24             	mov    %ebx,(%esp)
    1e62:	e8 44 1b 00 00       	call   39ab <close>
  fd = open("dd/dd/../ff", 0);
    1e67:	58                   	pop    %eax
    1e68:	5a                   	pop    %edx
    1e69:	6a 00                	push   $0x0
    1e6b:	68 12 46 00 00       	push   $0x4612
    1e70:	e8 4e 1b 00 00       	call   39c3 <open>
  if(fd < 0){
    1e75:	83 c4 10             	add    $0x10,%esp
  fd = open("dd/dd/../ff", 0);
    1e78:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1e7a:	85 c0                	test   %eax,%eax
    1e7c:	0f 88 de 03 00 00    	js     2260 <subdir+0x4d0>
  cc = read(fd, buf, sizeof(buf));
    1e82:	83 ec 04             	sub    $0x4,%esp
    1e85:	68 00 20 00 00       	push   $0x2000
    1e8a:	68 20 86 00 00       	push   $0x8620
    1e8f:	50                   	push   %eax
    1e90:	e8 06 1b 00 00       	call   399b <read>
  if(cc != 2 || buf[0] != 'f'){
    1e95:	83 c4 10             	add    $0x10,%esp
    1e98:	83 f8 02             	cmp    $0x2,%eax
    1e9b:	0f 85 3a 03 00 00    	jne    21db <subdir+0x44b>
    1ea1:	80 3d 20 86 00 00 66 	cmpb   $0x66,0x8620
    1ea8:	0f 85 2d 03 00 00    	jne    21db <subdir+0x44b>
  close(fd);
    1eae:	83 ec 0c             	sub    $0xc,%esp
    1eb1:	53                   	push   %ebx
    1eb2:	e8 f4 1a 00 00       	call   39ab <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    1eb7:	59                   	pop    %ecx
    1eb8:	5b                   	pop    %ebx
    1eb9:	68 52 46 00 00       	push   $0x4652
    1ebe:	68 ee 45 00 00       	push   $0x45ee
    1ec3:	e8 1b 1b 00 00       	call   39e3 <link>
    1ec8:	83 c4 10             	add    $0x10,%esp
    1ecb:	85 c0                	test   %eax,%eax
    1ecd:	0f 85 c6 03 00 00    	jne    2299 <subdir+0x509>
  if(unlink("dd/dd/ff") != 0){
    1ed3:	83 ec 0c             	sub    $0xc,%esp
    1ed6:	68 ee 45 00 00       	push   $0x45ee
    1edb:	e8 f3 1a 00 00       	call   39d3 <unlink>
    1ee0:	83 c4 10             	add    $0x10,%esp
    1ee3:	85 c0                	test   %eax,%eax
    1ee5:	0f 85 16 03 00 00    	jne    2201 <subdir+0x471>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1eeb:	83 ec 08             	sub    $0x8,%esp
    1eee:	6a 00                	push   $0x0
    1ef0:	68 ee 45 00 00       	push   $0x45ee
    1ef5:	e8 c9 1a 00 00       	call   39c3 <open>
    1efa:	83 c4 10             	add    $0x10,%esp
    1efd:	85 c0                	test   %eax,%eax
    1eff:	0f 89 2c 04 00 00    	jns    2331 <subdir+0x5a1>
  if(chdir("dd") != 0){
    1f05:	83 ec 0c             	sub    $0xc,%esp
    1f08:	68 b8 46 00 00       	push   $0x46b8
    1f0d:	e8 e1 1a 00 00       	call   39f3 <chdir>
    1f12:	83 c4 10             	add    $0x10,%esp
    1f15:	85 c0                	test   %eax,%eax
    1f17:	0f 85 01 04 00 00    	jne    231e <subdir+0x58e>
  if(chdir("dd/../../dd") != 0){
    1f1d:	83 ec 0c             	sub    $0xc,%esp
    1f20:	68 86 46 00 00       	push   $0x4686
    1f25:	e8 c9 1a 00 00       	call   39f3 <chdir>
    1f2a:	83 c4 10             	add    $0x10,%esp
    1f2d:	85 c0                	test   %eax,%eax
    1f2f:	0f 85 b9 02 00 00    	jne    21ee <subdir+0x45e>
  if(chdir("dd/../../../dd") != 0){
    1f35:	83 ec 0c             	sub    $0xc,%esp
    1f38:	68 ac 46 00 00       	push   $0x46ac
    1f3d:	e8 b1 1a 00 00       	call   39f3 <chdir>
    1f42:	83 c4 10             	add    $0x10,%esp
    1f45:	85 c0                	test   %eax,%eax
    1f47:	0f 85 a1 02 00 00    	jne    21ee <subdir+0x45e>
  if(chdir("./..") != 0){
    1f4d:	83 ec 0c             	sub    $0xc,%esp
    1f50:	68 bb 46 00 00       	push   $0x46bb
    1f55:	e8 99 1a 00 00       	call   39f3 <chdir>
    1f5a:	83 c4 10             	add    $0x10,%esp
    1f5d:	85 c0                	test   %eax,%eax
    1f5f:	0f 85 21 03 00 00    	jne    2286 <subdir+0x4f6>
  fd = open("dd/dd/ffff", 0);
    1f65:	83 ec 08             	sub    $0x8,%esp
    1f68:	6a 00                	push   $0x0
    1f6a:	68 52 46 00 00       	push   $0x4652
    1f6f:	e8 4f 1a 00 00       	call   39c3 <open>
  if(fd < 0){
    1f74:	83 c4 10             	add    $0x10,%esp
  fd = open("dd/dd/ffff", 0);
    1f77:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1f79:	85 c0                	test   %eax,%eax
    1f7b:	0f 88 e0 04 00 00    	js     2461 <subdir+0x6d1>
  if(read(fd, buf, sizeof(buf)) != 2){
    1f81:	83 ec 04             	sub    $0x4,%esp
    1f84:	68 00 20 00 00       	push   $0x2000
    1f89:	68 20 86 00 00       	push   $0x8620
    1f8e:	50                   	push   %eax
    1f8f:	e8 07 1a 00 00       	call   399b <read>
    1f94:	83 c4 10             	add    $0x10,%esp
    1f97:	83 f8 02             	cmp    $0x2,%eax
    1f9a:	0f 85 ae 04 00 00    	jne    244e <subdir+0x6be>
  close(fd);
    1fa0:	83 ec 0c             	sub    $0xc,%esp
    1fa3:	53                   	push   %ebx
    1fa4:	e8 02 1a 00 00       	call   39ab <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1fa9:	58                   	pop    %eax
    1faa:	5a                   	pop    %edx
    1fab:	6a 00                	push   $0x0
    1fad:	68 ee 45 00 00       	push   $0x45ee
    1fb2:	e8 0c 1a 00 00       	call   39c3 <open>
    1fb7:	83 c4 10             	add    $0x10,%esp
    1fba:	85 c0                	test   %eax,%eax
    1fbc:	0f 89 65 02 00 00    	jns    2227 <subdir+0x497>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    1fc2:	83 ec 08             	sub    $0x8,%esp
    1fc5:	68 02 02 00 00       	push   $0x202
    1fca:	68 06 47 00 00       	push   $0x4706
    1fcf:	e8 ef 19 00 00       	call   39c3 <open>
    1fd4:	83 c4 10             	add    $0x10,%esp
    1fd7:	85 c0                	test   %eax,%eax
    1fd9:	0f 89 35 02 00 00    	jns    2214 <subdir+0x484>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    1fdf:	83 ec 08             	sub    $0x8,%esp
    1fe2:	68 02 02 00 00       	push   $0x202
    1fe7:	68 2b 47 00 00       	push   $0x472b
    1fec:	e8 d2 19 00 00       	call   39c3 <open>
    1ff1:	83 c4 10             	add    $0x10,%esp
    1ff4:	85 c0                	test   %eax,%eax
    1ff6:	0f 89 0f 03 00 00    	jns    230b <subdir+0x57b>
  if(open("dd", O_CREATE) >= 0){
    1ffc:	83 ec 08             	sub    $0x8,%esp
    1fff:	68 00 02 00 00       	push   $0x200
    2004:	68 b8 46 00 00       	push   $0x46b8
    2009:	e8 b5 19 00 00       	call   39c3 <open>
    200e:	83 c4 10             	add    $0x10,%esp
    2011:	85 c0                	test   %eax,%eax
    2013:	0f 89 df 02 00 00    	jns    22f8 <subdir+0x568>
  if(open("dd", O_RDWR) >= 0){
    2019:	83 ec 08             	sub    $0x8,%esp
    201c:	6a 02                	push   $0x2
    201e:	68 b8 46 00 00       	push   $0x46b8
    2023:	e8 9b 19 00 00       	call   39c3 <open>
    2028:	83 c4 10             	add    $0x10,%esp
    202b:	85 c0                	test   %eax,%eax
    202d:	0f 89 b2 02 00 00    	jns    22e5 <subdir+0x555>
  if(open("dd", O_WRONLY) >= 0){
    2033:	83 ec 08             	sub    $0x8,%esp
    2036:	6a 01                	push   $0x1
    2038:	68 b8 46 00 00       	push   $0x46b8
    203d:	e8 81 19 00 00       	call   39c3 <open>
    2042:	83 c4 10             	add    $0x10,%esp
    2045:	85 c0                	test   %eax,%eax
    2047:	0f 89 85 02 00 00    	jns    22d2 <subdir+0x542>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    204d:	83 ec 08             	sub    $0x8,%esp
    2050:	68 9a 47 00 00       	push   $0x479a
    2055:	68 06 47 00 00       	push   $0x4706
    205a:	e8 84 19 00 00       	call   39e3 <link>
    205f:	83 c4 10             	add    $0x10,%esp
    2062:	85 c0                	test   %eax,%eax
    2064:	0f 84 55 02 00 00    	je     22bf <subdir+0x52f>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    206a:	83 ec 08             	sub    $0x8,%esp
    206d:	68 9a 47 00 00       	push   $0x479a
    2072:	68 2b 47 00 00       	push   $0x472b
    2077:	e8 67 19 00 00       	call   39e3 <link>
    207c:	83 c4 10             	add    $0x10,%esp
    207f:	85 c0                	test   %eax,%eax
    2081:	0f 84 25 02 00 00    	je     22ac <subdir+0x51c>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    2087:	83 ec 08             	sub    $0x8,%esp
    208a:	68 52 46 00 00       	push   $0x4652
    208f:	68 f1 45 00 00       	push   $0x45f1
    2094:	e8 4a 19 00 00       	call   39e3 <link>
    2099:	83 c4 10             	add    $0x10,%esp
    209c:	85 c0                	test   %eax,%eax
    209e:	0f 84 a9 01 00 00    	je     224d <subdir+0x4bd>
  if(mkdir("dd/ff/ff") == 0){
    20a4:	83 ec 0c             	sub    $0xc,%esp
    20a7:	68 06 47 00 00       	push   $0x4706
    20ac:	e8 3a 19 00 00       	call   39eb <mkdir>
    20b1:	83 c4 10             	add    $0x10,%esp
    20b4:	85 c0                	test   %eax,%eax
    20b6:	0f 84 7e 01 00 00    	je     223a <subdir+0x4aa>
  if(mkdir("dd/xx/ff") == 0){
    20bc:	83 ec 0c             	sub    $0xc,%esp
    20bf:	68 2b 47 00 00       	push   $0x472b
    20c4:	e8 22 19 00 00       	call   39eb <mkdir>
    20c9:	83 c4 10             	add    $0x10,%esp
    20cc:	85 c0                	test   %eax,%eax
    20ce:	0f 84 67 03 00 00    	je     243b <subdir+0x6ab>
  if(mkdir("dd/dd/ffff") == 0){
    20d4:	83 ec 0c             	sub    $0xc,%esp
    20d7:	68 52 46 00 00       	push   $0x4652
    20dc:	e8 0a 19 00 00       	call   39eb <mkdir>
    20e1:	83 c4 10             	add    $0x10,%esp
    20e4:	85 c0                	test   %eax,%eax
    20e6:	0f 84 3c 03 00 00    	je     2428 <subdir+0x698>
  if(unlink("dd/xx/ff") == 0){
    20ec:	83 ec 0c             	sub    $0xc,%esp
    20ef:	68 2b 47 00 00       	push   $0x472b
    20f4:	e8 da 18 00 00       	call   39d3 <unlink>
    20f9:	83 c4 10             	add    $0x10,%esp
    20fc:	85 c0                	test   %eax,%eax
    20fe:	0f 84 11 03 00 00    	je     2415 <subdir+0x685>
  if(unlink("dd/ff/ff") == 0){
    2104:	83 ec 0c             	sub    $0xc,%esp
    2107:	68 06 47 00 00       	push   $0x4706
    210c:	e8 c2 18 00 00       	call   39d3 <unlink>
    2111:	83 c4 10             	add    $0x10,%esp
    2114:	85 c0                	test   %eax,%eax
    2116:	0f 84 e6 02 00 00    	je     2402 <subdir+0x672>
  if(chdir("dd/ff") == 0){
    211c:	83 ec 0c             	sub    $0xc,%esp
    211f:	68 f1 45 00 00       	push   $0x45f1
    2124:	e8 ca 18 00 00       	call   39f3 <chdir>
    2129:	83 c4 10             	add    $0x10,%esp
    212c:	85 c0                	test   %eax,%eax
    212e:	0f 84 bb 02 00 00    	je     23ef <subdir+0x65f>
  if(chdir("dd/xx") == 0){
    2134:	83 ec 0c             	sub    $0xc,%esp
    2137:	68 9d 47 00 00       	push   $0x479d
    213c:	e8 b2 18 00 00       	call   39f3 <chdir>
    2141:	83 c4 10             	add    $0x10,%esp
    2144:	85 c0                	test   %eax,%eax
    2146:	0f 84 90 02 00 00    	je     23dc <subdir+0x64c>
  if(unlink("dd/dd/ffff") != 0){
    214c:	83 ec 0c             	sub    $0xc,%esp
    214f:	68 52 46 00 00       	push   $0x4652
    2154:	e8 7a 18 00 00       	call   39d3 <unlink>
    2159:	83 c4 10             	add    $0x10,%esp
    215c:	85 c0                	test   %eax,%eax
    215e:	0f 85 9d 00 00 00    	jne    2201 <subdir+0x471>
  if(unlink("dd/ff") != 0){
    2164:	83 ec 0c             	sub    $0xc,%esp
    2167:	68 f1 45 00 00       	push   $0x45f1
    216c:	e8 62 18 00 00       	call   39d3 <unlink>
    2171:	83 c4 10             	add    $0x10,%esp
    2174:	85 c0                	test   %eax,%eax
    2176:	0f 85 4d 02 00 00    	jne    23c9 <subdir+0x639>
  if(unlink("dd") == 0){
    217c:	83 ec 0c             	sub    $0xc,%esp
    217f:	68 b8 46 00 00       	push   $0x46b8
    2184:	e8 4a 18 00 00       	call   39d3 <unlink>
    2189:	83 c4 10             	add    $0x10,%esp
    218c:	85 c0                	test   %eax,%eax
    218e:	0f 84 22 02 00 00    	je     23b6 <subdir+0x626>
  if(unlink("dd/dd") < 0){
    2194:	83 ec 0c             	sub    $0xc,%esp
    2197:	68 cd 45 00 00       	push   $0x45cd
    219c:	e8 32 18 00 00       	call   39d3 <unlink>
    21a1:	83 c4 10             	add    $0x10,%esp
    21a4:	85 c0                	test   %eax,%eax
    21a6:	0f 88 f7 01 00 00    	js     23a3 <subdir+0x613>
  if(unlink("dd") < 0){
    21ac:	83 ec 0c             	sub    $0xc,%esp
    21af:	68 b8 46 00 00       	push   $0x46b8
    21b4:	e8 1a 18 00 00       	call   39d3 <unlink>
    21b9:	83 c4 10             	add    $0x10,%esp
    21bc:	85 c0                	test   %eax,%eax
    21be:	0f 88 cc 01 00 00    	js     2390 <subdir+0x600>
  printf(1, "subdir ok\n");
    21c4:	83 ec 08             	sub    $0x8,%esp
    21c7:	68 9a 48 00 00       	push   $0x489a
    21cc:	6a 01                	push   $0x1
    21ce:	e8 0d 19 00 00       	call   3ae0 <printf>
}
    21d3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    21d6:	83 c4 10             	add    $0x10,%esp
    21d9:	c9                   	leave  
    21da:	c3                   	ret    
    printf(1, "dd/dd/../ff wrong content\n");
    21db:	50                   	push   %eax
    21dc:	50                   	push   %eax
    21dd:	68 37 46 00 00       	push   $0x4637
    21e2:	6a 01                	push   $0x1
    21e4:	e8 f7 18 00 00       	call   3ae0 <printf>
    exit();
    21e9:	e8 95 17 00 00       	call   3983 <exit>
    printf(1, "chdir dd/../../dd failed\n");
    21ee:	50                   	push   %eax
    21ef:	50                   	push   %eax
    21f0:	68 92 46 00 00       	push   $0x4692
    21f5:	6a 01                	push   $0x1
    21f7:	e8 e4 18 00 00       	call   3ae0 <printf>
    exit();
    21fc:	e8 82 17 00 00       	call   3983 <exit>
    printf(1, "unlink dd/dd/ff failed\n");
    2201:	50                   	push   %eax
    2202:	50                   	push   %eax
    2203:	68 5d 46 00 00       	push   $0x465d
    2208:	6a 01                	push   $0x1
    220a:	e8 d1 18 00 00       	call   3ae0 <printf>
    exit();
    220f:	e8 6f 17 00 00       	call   3983 <exit>
    printf(1, "create dd/ff/ff succeeded!\n");
    2214:	51                   	push   %ecx
    2215:	51                   	push   %ecx
    2216:	68 0f 47 00 00       	push   $0x470f
    221b:	6a 01                	push   $0x1
    221d:	e8 be 18 00 00       	call   3ae0 <printf>
    exit();
    2222:	e8 5c 17 00 00       	call   3983 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    2227:	53                   	push   %ebx
    2228:	53                   	push   %ebx
    2229:	68 f4 50 00 00       	push   $0x50f4
    222e:	6a 01                	push   $0x1
    2230:	e8 ab 18 00 00       	call   3ae0 <printf>
    exit();
    2235:	e8 49 17 00 00       	call   3983 <exit>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    223a:	51                   	push   %ecx
    223b:	51                   	push   %ecx
    223c:	68 a3 47 00 00       	push   $0x47a3
    2241:	6a 01                	push   $0x1
    2243:	e8 98 18 00 00       	call   3ae0 <printf>
    exit();
    2248:	e8 36 17 00 00       	call   3983 <exit>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    224d:	53                   	push   %ebx
    224e:	53                   	push   %ebx
    224f:	68 64 51 00 00       	push   $0x5164
    2254:	6a 01                	push   $0x1
    2256:	e8 85 18 00 00       	call   3ae0 <printf>
    exit();
    225b:	e8 23 17 00 00       	call   3983 <exit>
    printf(1, "open dd/dd/../ff failed\n");
    2260:	50                   	push   %eax
    2261:	50                   	push   %eax
    2262:	68 1e 46 00 00       	push   $0x461e
    2267:	6a 01                	push   $0x1
    2269:	e8 72 18 00 00       	call   3ae0 <printf>
    exit();
    226e:	e8 10 17 00 00       	call   3983 <exit>
    printf(1, "create dd/dd/ff failed\n");
    2273:	51                   	push   %ecx
    2274:	51                   	push   %ecx
    2275:	68 f7 45 00 00       	push   $0x45f7
    227a:	6a 01                	push   $0x1
    227c:	e8 5f 18 00 00       	call   3ae0 <printf>
    exit();
    2281:	e8 fd 16 00 00       	call   3983 <exit>
    printf(1, "chdir ./.. failed\n");
    2286:	50                   	push   %eax
    2287:	50                   	push   %eax
    2288:	68 c0 46 00 00       	push   $0x46c0
    228d:	6a 01                	push   $0x1
    228f:	e8 4c 18 00 00       	call   3ae0 <printf>
    exit();
    2294:	e8 ea 16 00 00       	call   3983 <exit>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    2299:	52                   	push   %edx
    229a:	52                   	push   %edx
    229b:	68 ac 50 00 00       	push   $0x50ac
    22a0:	6a 01                	push   $0x1
    22a2:	e8 39 18 00 00       	call   3ae0 <printf>
    exit();
    22a7:	e8 d7 16 00 00       	call   3983 <exit>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    22ac:	50                   	push   %eax
    22ad:	50                   	push   %eax
    22ae:	68 40 51 00 00       	push   $0x5140
    22b3:	6a 01                	push   $0x1
    22b5:	e8 26 18 00 00       	call   3ae0 <printf>
    exit();
    22ba:	e8 c4 16 00 00       	call   3983 <exit>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    22bf:	50                   	push   %eax
    22c0:	50                   	push   %eax
    22c1:	68 1c 51 00 00       	push   $0x511c
    22c6:	6a 01                	push   $0x1
    22c8:	e8 13 18 00 00       	call   3ae0 <printf>
    exit();
    22cd:	e8 b1 16 00 00       	call   3983 <exit>
    printf(1, "open dd wronly succeeded!\n");
    22d2:	50                   	push   %eax
    22d3:	50                   	push   %eax
    22d4:	68 7f 47 00 00       	push   $0x477f
    22d9:	6a 01                	push   $0x1
    22db:	e8 00 18 00 00       	call   3ae0 <printf>
    exit();
    22e0:	e8 9e 16 00 00       	call   3983 <exit>
    printf(1, "open dd rdwr succeeded!\n");
    22e5:	50                   	push   %eax
    22e6:	50                   	push   %eax
    22e7:	68 66 47 00 00       	push   $0x4766
    22ec:	6a 01                	push   $0x1
    22ee:	e8 ed 17 00 00       	call   3ae0 <printf>
    exit();
    22f3:	e8 8b 16 00 00       	call   3983 <exit>
    printf(1, "create dd succeeded!\n");
    22f8:	50                   	push   %eax
    22f9:	50                   	push   %eax
    22fa:	68 50 47 00 00       	push   $0x4750
    22ff:	6a 01                	push   $0x1
    2301:	e8 da 17 00 00       	call   3ae0 <printf>
    exit();
    2306:	e8 78 16 00 00       	call   3983 <exit>
    printf(1, "create dd/xx/ff succeeded!\n");
    230b:	52                   	push   %edx
    230c:	52                   	push   %edx
    230d:	68 34 47 00 00       	push   $0x4734
    2312:	6a 01                	push   $0x1
    2314:	e8 c7 17 00 00       	call   3ae0 <printf>
    exit();
    2319:	e8 65 16 00 00       	call   3983 <exit>
    printf(1, "chdir dd failed\n");
    231e:	50                   	push   %eax
    231f:	50                   	push   %eax
    2320:	68 75 46 00 00       	push   $0x4675
    2325:	6a 01                	push   $0x1
    2327:	e8 b4 17 00 00       	call   3ae0 <printf>
    exit();
    232c:	e8 52 16 00 00       	call   3983 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    2331:	50                   	push   %eax
    2332:	50                   	push   %eax
    2333:	68 d0 50 00 00       	push   $0x50d0
    2338:	6a 01                	push   $0x1
    233a:	e8 a1 17 00 00       	call   3ae0 <printf>
    exit();
    233f:	e8 3f 16 00 00       	call   3983 <exit>
    printf(1, "subdir mkdir dd/dd failed\n");
    2344:	53                   	push   %ebx
    2345:	53                   	push   %ebx
    2346:	68 d3 45 00 00       	push   $0x45d3
    234b:	6a 01                	push   $0x1
    234d:	e8 8e 17 00 00       	call   3ae0 <printf>
    exit();
    2352:	e8 2c 16 00 00       	call   3983 <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    2357:	50                   	push   %eax
    2358:	50                   	push   %eax
    2359:	68 84 50 00 00       	push   $0x5084
    235e:	6a 01                	push   $0x1
    2360:	e8 7b 17 00 00       	call   3ae0 <printf>
    exit();
    2365:	e8 19 16 00 00       	call   3983 <exit>
    printf(1, "create dd/ff failed\n");
    236a:	50                   	push   %eax
    236b:	50                   	push   %eax
    236c:	68 b7 45 00 00       	push   $0x45b7
    2371:	6a 01                	push   $0x1
    2373:	e8 68 17 00 00       	call   3ae0 <printf>
    exit();
    2378:	e8 06 16 00 00       	call   3983 <exit>
    printf(1, "subdir mkdir dd failed\n");
    237d:	50                   	push   %eax
    237e:	50                   	push   %eax
    237f:	68 9f 45 00 00       	push   $0x459f
    2384:	6a 01                	push   $0x1
    2386:	e8 55 17 00 00       	call   3ae0 <printf>
    exit();
    238b:	e8 f3 15 00 00       	call   3983 <exit>
    printf(1, "unlink dd failed\n");
    2390:	50                   	push   %eax
    2391:	50                   	push   %eax
    2392:	68 88 48 00 00       	push   $0x4888
    2397:	6a 01                	push   $0x1
    2399:	e8 42 17 00 00       	call   3ae0 <printf>
    exit();
    239e:	e8 e0 15 00 00       	call   3983 <exit>
    printf(1, "unlink dd/dd failed\n");
    23a3:	52                   	push   %edx
    23a4:	52                   	push   %edx
    23a5:	68 73 48 00 00       	push   $0x4873
    23aa:	6a 01                	push   $0x1
    23ac:	e8 2f 17 00 00       	call   3ae0 <printf>
    exit();
    23b1:	e8 cd 15 00 00       	call   3983 <exit>
    printf(1, "unlink non-empty dd succeeded!\n");
    23b6:	51                   	push   %ecx
    23b7:	51                   	push   %ecx
    23b8:	68 88 51 00 00       	push   $0x5188
    23bd:	6a 01                	push   $0x1
    23bf:	e8 1c 17 00 00       	call   3ae0 <printf>
    exit();
    23c4:	e8 ba 15 00 00       	call   3983 <exit>
    printf(1, "unlink dd/ff failed\n");
    23c9:	53                   	push   %ebx
    23ca:	53                   	push   %ebx
    23cb:	68 5e 48 00 00       	push   $0x485e
    23d0:	6a 01                	push   $0x1
    23d2:	e8 09 17 00 00       	call   3ae0 <printf>
    exit();
    23d7:	e8 a7 15 00 00       	call   3983 <exit>
    printf(1, "chdir dd/xx succeeded!\n");
    23dc:	50                   	push   %eax
    23dd:	50                   	push   %eax
    23de:	68 46 48 00 00       	push   $0x4846
    23e3:	6a 01                	push   $0x1
    23e5:	e8 f6 16 00 00       	call   3ae0 <printf>
    exit();
    23ea:	e8 94 15 00 00       	call   3983 <exit>
    printf(1, "chdir dd/ff succeeded!\n");
    23ef:	50                   	push   %eax
    23f0:	50                   	push   %eax
    23f1:	68 2e 48 00 00       	push   $0x482e
    23f6:	6a 01                	push   $0x1
    23f8:	e8 e3 16 00 00       	call   3ae0 <printf>
    exit();
    23fd:	e8 81 15 00 00       	call   3983 <exit>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    2402:	50                   	push   %eax
    2403:	50                   	push   %eax
    2404:	68 12 48 00 00       	push   $0x4812
    2409:	6a 01                	push   $0x1
    240b:	e8 d0 16 00 00       	call   3ae0 <printf>
    exit();
    2410:	e8 6e 15 00 00       	call   3983 <exit>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    2415:	50                   	push   %eax
    2416:	50                   	push   %eax
    2417:	68 f6 47 00 00       	push   $0x47f6
    241c:	6a 01                	push   $0x1
    241e:	e8 bd 16 00 00       	call   3ae0 <printf>
    exit();
    2423:	e8 5b 15 00 00       	call   3983 <exit>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    2428:	50                   	push   %eax
    2429:	50                   	push   %eax
    242a:	68 d9 47 00 00       	push   $0x47d9
    242f:	6a 01                	push   $0x1
    2431:	e8 aa 16 00 00       	call   3ae0 <printf>
    exit();
    2436:	e8 48 15 00 00       	call   3983 <exit>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    243b:	52                   	push   %edx
    243c:	52                   	push   %edx
    243d:	68 be 47 00 00       	push   $0x47be
    2442:	6a 01                	push   $0x1
    2444:	e8 97 16 00 00       	call   3ae0 <printf>
    exit();
    2449:	e8 35 15 00 00       	call   3983 <exit>
    printf(1, "read dd/dd/ffff wrong len\n");
    244e:	51                   	push   %ecx
    244f:	51                   	push   %ecx
    2450:	68 eb 46 00 00       	push   $0x46eb
    2455:	6a 01                	push   $0x1
    2457:	e8 84 16 00 00       	call   3ae0 <printf>
    exit();
    245c:	e8 22 15 00 00       	call   3983 <exit>
    printf(1, "open dd/dd/ffff failed\n");
    2461:	53                   	push   %ebx
    2462:	53                   	push   %ebx
    2463:	68 d3 46 00 00       	push   $0x46d3
    2468:	6a 01                	push   $0x1
    246a:	e8 71 16 00 00       	call   3ae0 <printf>
    exit();
    246f:	e8 0f 15 00 00       	call   3983 <exit>
    2474:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    247b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    247f:	90                   	nop

00002480 <bigwrite>:
{
    2480:	f3 0f 1e fb          	endbr32 
    2484:	55                   	push   %ebp
    2485:	89 e5                	mov    %esp,%ebp
    2487:	56                   	push   %esi
    2488:	53                   	push   %ebx
  for(sz = 499; sz < 12*512; sz += 471){
    2489:	bb f3 01 00 00       	mov    $0x1f3,%ebx
  printf(1, "bigwrite test\n");
    248e:	83 ec 08             	sub    $0x8,%esp
    2491:	68 a5 48 00 00       	push   $0x48a5
    2496:	6a 01                	push   $0x1
    2498:	e8 43 16 00 00       	call   3ae0 <printf>
  unlink("bigwrite");
    249d:	c7 04 24 b4 48 00 00 	movl   $0x48b4,(%esp)
    24a4:	e8 2a 15 00 00       	call   39d3 <unlink>
    24a9:	83 c4 10             	add    $0x10,%esp
    24ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    fd = open("bigwrite", O_CREATE | O_RDWR);
    24b0:	83 ec 08             	sub    $0x8,%esp
    24b3:	68 02 02 00 00       	push   $0x202
    24b8:	68 b4 48 00 00       	push   $0x48b4
    24bd:	e8 01 15 00 00       	call   39c3 <open>
    if(fd < 0){
    24c2:	83 c4 10             	add    $0x10,%esp
    fd = open("bigwrite", O_CREATE | O_RDWR);
    24c5:	89 c6                	mov    %eax,%esi
    if(fd < 0){
    24c7:	85 c0                	test   %eax,%eax
    24c9:	78 7e                	js     2549 <bigwrite+0xc9>
      int cc = write(fd, buf, sz);
    24cb:	83 ec 04             	sub    $0x4,%esp
    24ce:	53                   	push   %ebx
    24cf:	68 20 86 00 00       	push   $0x8620
    24d4:	50                   	push   %eax
    24d5:	e8 c9 14 00 00       	call   39a3 <write>
      if(cc != sz){
    24da:	83 c4 10             	add    $0x10,%esp
    24dd:	39 d8                	cmp    %ebx,%eax
    24df:	75 55                	jne    2536 <bigwrite+0xb6>
      int cc = write(fd, buf, sz);
    24e1:	83 ec 04             	sub    $0x4,%esp
    24e4:	53                   	push   %ebx
    24e5:	68 20 86 00 00       	push   $0x8620
    24ea:	56                   	push   %esi
    24eb:	e8 b3 14 00 00       	call   39a3 <write>
      if(cc != sz){
    24f0:	83 c4 10             	add    $0x10,%esp
    24f3:	39 d8                	cmp    %ebx,%eax
    24f5:	75 3f                	jne    2536 <bigwrite+0xb6>
    close(fd);
    24f7:	83 ec 0c             	sub    $0xc,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    24fa:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
    close(fd);
    2500:	56                   	push   %esi
    2501:	e8 a5 14 00 00       	call   39ab <close>
    unlink("bigwrite");
    2506:	c7 04 24 b4 48 00 00 	movl   $0x48b4,(%esp)
    250d:	e8 c1 14 00 00       	call   39d3 <unlink>
  for(sz = 499; sz < 12*512; sz += 471){
    2512:	83 c4 10             	add    $0x10,%esp
    2515:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
    251b:	75 93                	jne    24b0 <bigwrite+0x30>
  printf(1, "bigwrite ok\n");
    251d:	83 ec 08             	sub    $0x8,%esp
    2520:	68 e7 48 00 00       	push   $0x48e7
    2525:	6a 01                	push   $0x1
    2527:	e8 b4 15 00 00       	call   3ae0 <printf>
}
    252c:	83 c4 10             	add    $0x10,%esp
    252f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    2532:	5b                   	pop    %ebx
    2533:	5e                   	pop    %esi
    2534:	5d                   	pop    %ebp
    2535:	c3                   	ret    
        printf(1, "write(%d) ret %d\n", sz, cc);
    2536:	50                   	push   %eax
    2537:	53                   	push   %ebx
    2538:	68 d5 48 00 00       	push   $0x48d5
    253d:	6a 01                	push   $0x1
    253f:	e8 9c 15 00 00       	call   3ae0 <printf>
        exit();
    2544:	e8 3a 14 00 00       	call   3983 <exit>
      printf(1, "cannot create bigwrite\n");
    2549:	83 ec 08             	sub    $0x8,%esp
    254c:	68 bd 48 00 00       	push   $0x48bd
    2551:	6a 01                	push   $0x1
    2553:	e8 88 15 00 00       	call   3ae0 <printf>
      exit();
    2558:	e8 26 14 00 00       	call   3983 <exit>
    255d:	8d 76 00             	lea    0x0(%esi),%esi

00002560 <bigfile>:
{
    2560:	f3 0f 1e fb          	endbr32 
    2564:	55                   	push   %ebp
    2565:	89 e5                	mov    %esp,%ebp
    2567:	57                   	push   %edi
    2568:	56                   	push   %esi
    2569:	53                   	push   %ebx
    256a:	83 ec 14             	sub    $0x14,%esp
  printf(1, "bigfile test\n");
    256d:	68 f4 48 00 00       	push   $0x48f4
    2572:	6a 01                	push   $0x1
    2574:	e8 67 15 00 00       	call   3ae0 <printf>
  unlink("bigfile");
    2579:	c7 04 24 10 49 00 00 	movl   $0x4910,(%esp)
    2580:	e8 4e 14 00 00       	call   39d3 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    2585:	58                   	pop    %eax
    2586:	5a                   	pop    %edx
    2587:	68 02 02 00 00       	push   $0x202
    258c:	68 10 49 00 00       	push   $0x4910
    2591:	e8 2d 14 00 00       	call   39c3 <open>
  if(fd < 0){
    2596:	83 c4 10             	add    $0x10,%esp
    2599:	85 c0                	test   %eax,%eax
    259b:	0f 88 5a 01 00 00    	js     26fb <bigfile+0x19b>
    25a1:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 20; i++){
    25a3:	31 db                	xor    %ebx,%ebx
    25a5:	8d 76 00             	lea    0x0(%esi),%esi
    memset(buf, i, 600);
    25a8:	83 ec 04             	sub    $0x4,%esp
    25ab:	68 58 02 00 00       	push   $0x258
    25b0:	53                   	push   %ebx
    25b1:	68 20 86 00 00       	push   $0x8620
    25b6:	e8 25 12 00 00       	call   37e0 <memset>
    if(write(fd, buf, 600) != 600){
    25bb:	83 c4 0c             	add    $0xc,%esp
    25be:	68 58 02 00 00       	push   $0x258
    25c3:	68 20 86 00 00       	push   $0x8620
    25c8:	56                   	push   %esi
    25c9:	e8 d5 13 00 00       	call   39a3 <write>
    25ce:	83 c4 10             	add    $0x10,%esp
    25d1:	3d 58 02 00 00       	cmp    $0x258,%eax
    25d6:	0f 85 f8 00 00 00    	jne    26d4 <bigfile+0x174>
  for(i = 0; i < 20; i++){
    25dc:	83 c3 01             	add    $0x1,%ebx
    25df:	83 fb 14             	cmp    $0x14,%ebx
    25e2:	75 c4                	jne    25a8 <bigfile+0x48>
  close(fd);
    25e4:	83 ec 0c             	sub    $0xc,%esp
    25e7:	56                   	push   %esi
    25e8:	e8 be 13 00 00       	call   39ab <close>
  fd = open("bigfile", 0);
    25ed:	5e                   	pop    %esi
    25ee:	5f                   	pop    %edi
    25ef:	6a 00                	push   $0x0
    25f1:	68 10 49 00 00       	push   $0x4910
    25f6:	e8 c8 13 00 00       	call   39c3 <open>
  if(fd < 0){
    25fb:	83 c4 10             	add    $0x10,%esp
  fd = open("bigfile", 0);
    25fe:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    2600:	85 c0                	test   %eax,%eax
    2602:	0f 88 e0 00 00 00    	js     26e8 <bigfile+0x188>
  total = 0;
    2608:	31 db                	xor    %ebx,%ebx
  for(i = 0; ; i++){
    260a:	31 ff                	xor    %edi,%edi
    260c:	eb 30                	jmp    263e <bigfile+0xde>
    260e:	66 90                	xchg   %ax,%ax
    if(cc != 300){
    2610:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    2615:	0f 85 91 00 00 00    	jne    26ac <bigfile+0x14c>
    if(buf[0] != i/2 || buf[299] != i/2){
    261b:	89 fa                	mov    %edi,%edx
    261d:	0f be 05 20 86 00 00 	movsbl 0x8620,%eax
    2624:	d1 fa                	sar    %edx
    2626:	39 d0                	cmp    %edx,%eax
    2628:	75 6e                	jne    2698 <bigfile+0x138>
    262a:	0f be 15 4b 87 00 00 	movsbl 0x874b,%edx
    2631:	39 d0                	cmp    %edx,%eax
    2633:	75 63                	jne    2698 <bigfile+0x138>
    total += cc;
    2635:	81 c3 2c 01 00 00    	add    $0x12c,%ebx
  for(i = 0; ; i++){
    263b:	83 c7 01             	add    $0x1,%edi
    cc = read(fd, buf, 300);
    263e:	83 ec 04             	sub    $0x4,%esp
    2641:	68 2c 01 00 00       	push   $0x12c
    2646:	68 20 86 00 00       	push   $0x8620
    264b:	56                   	push   %esi
    264c:	e8 4a 13 00 00       	call   399b <read>
    if(cc < 0){
    2651:	83 c4 10             	add    $0x10,%esp
    2654:	85 c0                	test   %eax,%eax
    2656:	78 68                	js     26c0 <bigfile+0x160>
    if(cc == 0)
    2658:	75 b6                	jne    2610 <bigfile+0xb0>
  close(fd);
    265a:	83 ec 0c             	sub    $0xc,%esp
    265d:	56                   	push   %esi
    265e:	e8 48 13 00 00       	call   39ab <close>
  if(total != 20*600){
    2663:	83 c4 10             	add    $0x10,%esp
    2666:	81 fb e0 2e 00 00    	cmp    $0x2ee0,%ebx
    266c:	0f 85 9c 00 00 00    	jne    270e <bigfile+0x1ae>
  unlink("bigfile");
    2672:	83 ec 0c             	sub    $0xc,%esp
    2675:	68 10 49 00 00       	push   $0x4910
    267a:	e8 54 13 00 00       	call   39d3 <unlink>
  printf(1, "bigfile test ok\n");
    267f:	58                   	pop    %eax
    2680:	5a                   	pop    %edx
    2681:	68 9f 49 00 00       	push   $0x499f
    2686:	6a 01                	push   $0x1
    2688:	e8 53 14 00 00       	call   3ae0 <printf>
}
    268d:	83 c4 10             	add    $0x10,%esp
    2690:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2693:	5b                   	pop    %ebx
    2694:	5e                   	pop    %esi
    2695:	5f                   	pop    %edi
    2696:	5d                   	pop    %ebp
    2697:	c3                   	ret    
      printf(1, "read bigfile wrong data\n");
    2698:	83 ec 08             	sub    $0x8,%esp
    269b:	68 6c 49 00 00       	push   $0x496c
    26a0:	6a 01                	push   $0x1
    26a2:	e8 39 14 00 00       	call   3ae0 <printf>
      exit();
    26a7:	e8 d7 12 00 00       	call   3983 <exit>
      printf(1, "short read bigfile\n");
    26ac:	83 ec 08             	sub    $0x8,%esp
    26af:	68 58 49 00 00       	push   $0x4958
    26b4:	6a 01                	push   $0x1
    26b6:	e8 25 14 00 00       	call   3ae0 <printf>
      exit();
    26bb:	e8 c3 12 00 00       	call   3983 <exit>
      printf(1, "read bigfile failed\n");
    26c0:	83 ec 08             	sub    $0x8,%esp
    26c3:	68 43 49 00 00       	push   $0x4943
    26c8:	6a 01                	push   $0x1
    26ca:	e8 11 14 00 00       	call   3ae0 <printf>
      exit();
    26cf:	e8 af 12 00 00       	call   3983 <exit>
      printf(1, "write bigfile failed\n");
    26d4:	83 ec 08             	sub    $0x8,%esp
    26d7:	68 18 49 00 00       	push   $0x4918
    26dc:	6a 01                	push   $0x1
    26de:	e8 fd 13 00 00       	call   3ae0 <printf>
      exit();
    26e3:	e8 9b 12 00 00       	call   3983 <exit>
    printf(1, "cannot open bigfile\n");
    26e8:	53                   	push   %ebx
    26e9:	53                   	push   %ebx
    26ea:	68 2e 49 00 00       	push   $0x492e
    26ef:	6a 01                	push   $0x1
    26f1:	e8 ea 13 00 00       	call   3ae0 <printf>
    exit();
    26f6:	e8 88 12 00 00       	call   3983 <exit>
    printf(1, "cannot create bigfile");
    26fb:	50                   	push   %eax
    26fc:	50                   	push   %eax
    26fd:	68 02 49 00 00       	push   $0x4902
    2702:	6a 01                	push   $0x1
    2704:	e8 d7 13 00 00       	call   3ae0 <printf>
    exit();
    2709:	e8 75 12 00 00       	call   3983 <exit>
    printf(1, "read bigfile wrong total\n");
    270e:	51                   	push   %ecx
    270f:	51                   	push   %ecx
    2710:	68 85 49 00 00       	push   $0x4985
    2715:	6a 01                	push   $0x1
    2717:	e8 c4 13 00 00       	call   3ae0 <printf>
    exit();
    271c:	e8 62 12 00 00       	call   3983 <exit>
    2721:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2728:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    272f:	90                   	nop

00002730 <fourteen>:
{
    2730:	f3 0f 1e fb          	endbr32 
    2734:	55                   	push   %ebp
    2735:	89 e5                	mov    %esp,%ebp
    2737:	83 ec 10             	sub    $0x10,%esp
  printf(1, "fourteen test\n");
    273a:	68 b0 49 00 00       	push   $0x49b0
    273f:	6a 01                	push   $0x1
    2741:	e8 9a 13 00 00       	call   3ae0 <printf>
  if(mkdir("12345678901234") != 0){
    2746:	c7 04 24 eb 49 00 00 	movl   $0x49eb,(%esp)
    274d:	e8 99 12 00 00       	call   39eb <mkdir>
    2752:	83 c4 10             	add    $0x10,%esp
    2755:	85 c0                	test   %eax,%eax
    2757:	0f 85 97 00 00 00    	jne    27f4 <fourteen+0xc4>
  if(mkdir("12345678901234/123456789012345") != 0){
    275d:	83 ec 0c             	sub    $0xc,%esp
    2760:	68 a8 51 00 00       	push   $0x51a8
    2765:	e8 81 12 00 00       	call   39eb <mkdir>
    276a:	83 c4 10             	add    $0x10,%esp
    276d:	85 c0                	test   %eax,%eax
    276f:	0f 85 de 00 00 00    	jne    2853 <fourteen+0x123>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    2775:	83 ec 08             	sub    $0x8,%esp
    2778:	68 00 02 00 00       	push   $0x200
    277d:	68 f8 51 00 00       	push   $0x51f8
    2782:	e8 3c 12 00 00       	call   39c3 <open>
  if(fd < 0){
    2787:	83 c4 10             	add    $0x10,%esp
    278a:	85 c0                	test   %eax,%eax
    278c:	0f 88 ae 00 00 00    	js     2840 <fourteen+0x110>
  close(fd);
    2792:	83 ec 0c             	sub    $0xc,%esp
    2795:	50                   	push   %eax
    2796:	e8 10 12 00 00       	call   39ab <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    279b:	58                   	pop    %eax
    279c:	5a                   	pop    %edx
    279d:	6a 00                	push   $0x0
    279f:	68 68 52 00 00       	push   $0x5268
    27a4:	e8 1a 12 00 00       	call   39c3 <open>
  if(fd < 0){
    27a9:	83 c4 10             	add    $0x10,%esp
    27ac:	85 c0                	test   %eax,%eax
    27ae:	78 7d                	js     282d <fourteen+0xfd>
  close(fd);
    27b0:	83 ec 0c             	sub    $0xc,%esp
    27b3:	50                   	push   %eax
    27b4:	e8 f2 11 00 00       	call   39ab <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    27b9:	c7 04 24 dc 49 00 00 	movl   $0x49dc,(%esp)
    27c0:	e8 26 12 00 00       	call   39eb <mkdir>
    27c5:	83 c4 10             	add    $0x10,%esp
    27c8:	85 c0                	test   %eax,%eax
    27ca:	74 4e                	je     281a <fourteen+0xea>
  if(mkdir("123456789012345/12345678901234") == 0){
    27cc:	83 ec 0c             	sub    $0xc,%esp
    27cf:	68 04 53 00 00       	push   $0x5304
    27d4:	e8 12 12 00 00       	call   39eb <mkdir>
    27d9:	83 c4 10             	add    $0x10,%esp
    27dc:	85 c0                	test   %eax,%eax
    27de:	74 27                	je     2807 <fourteen+0xd7>
  printf(1, "fourteen ok\n");
    27e0:	83 ec 08             	sub    $0x8,%esp
    27e3:	68 fa 49 00 00       	push   $0x49fa
    27e8:	6a 01                	push   $0x1
    27ea:	e8 f1 12 00 00       	call   3ae0 <printf>
}
    27ef:	83 c4 10             	add    $0x10,%esp
    27f2:	c9                   	leave  
    27f3:	c3                   	ret    
    printf(1, "mkdir 12345678901234 failed\n");
    27f4:	50                   	push   %eax
    27f5:	50                   	push   %eax
    27f6:	68 bf 49 00 00       	push   $0x49bf
    27fb:	6a 01                	push   $0x1
    27fd:	e8 de 12 00 00       	call   3ae0 <printf>
    exit();
    2802:	e8 7c 11 00 00       	call   3983 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    2807:	50                   	push   %eax
    2808:	50                   	push   %eax
    2809:	68 24 53 00 00       	push   $0x5324
    280e:	6a 01                	push   $0x1
    2810:	e8 cb 12 00 00       	call   3ae0 <printf>
    exit();
    2815:	e8 69 11 00 00       	call   3983 <exit>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    281a:	52                   	push   %edx
    281b:	52                   	push   %edx
    281c:	68 d4 52 00 00       	push   $0x52d4
    2821:	6a 01                	push   $0x1
    2823:	e8 b8 12 00 00       	call   3ae0 <printf>
    exit();
    2828:	e8 56 11 00 00       	call   3983 <exit>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    282d:	51                   	push   %ecx
    282e:	51                   	push   %ecx
    282f:	68 98 52 00 00       	push   $0x5298
    2834:	6a 01                	push   $0x1
    2836:	e8 a5 12 00 00       	call   3ae0 <printf>
    exit();
    283b:	e8 43 11 00 00       	call   3983 <exit>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    2840:	51                   	push   %ecx
    2841:	51                   	push   %ecx
    2842:	68 28 52 00 00       	push   $0x5228
    2847:	6a 01                	push   $0x1
    2849:	e8 92 12 00 00       	call   3ae0 <printf>
    exit();
    284e:	e8 30 11 00 00       	call   3983 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    2853:	50                   	push   %eax
    2854:	50                   	push   %eax
    2855:	68 c8 51 00 00       	push   $0x51c8
    285a:	6a 01                	push   $0x1
    285c:	e8 7f 12 00 00       	call   3ae0 <printf>
    exit();
    2861:	e8 1d 11 00 00       	call   3983 <exit>
    2866:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    286d:	8d 76 00             	lea    0x0(%esi),%esi

00002870 <rmdot>:
{
    2870:	f3 0f 1e fb          	endbr32 
    2874:	55                   	push   %ebp
    2875:	89 e5                	mov    %esp,%ebp
    2877:	83 ec 10             	sub    $0x10,%esp
  printf(1, "rmdot test\n");
    287a:	68 07 4a 00 00       	push   $0x4a07
    287f:	6a 01                	push   $0x1
    2881:	e8 5a 12 00 00       	call   3ae0 <printf>
  if(mkdir("dots") != 0){
    2886:	c7 04 24 13 4a 00 00 	movl   $0x4a13,(%esp)
    288d:	e8 59 11 00 00       	call   39eb <mkdir>
    2892:	83 c4 10             	add    $0x10,%esp
    2895:	85 c0                	test   %eax,%eax
    2897:	0f 85 b0 00 00 00    	jne    294d <rmdot+0xdd>
  if(chdir("dots") != 0){
    289d:	83 ec 0c             	sub    $0xc,%esp
    28a0:	68 13 4a 00 00       	push   $0x4a13
    28a5:	e8 49 11 00 00       	call   39f3 <chdir>
    28aa:	83 c4 10             	add    $0x10,%esp
    28ad:	85 c0                	test   %eax,%eax
    28af:	0f 85 1d 01 00 00    	jne    29d2 <rmdot+0x162>
  if(unlink(".") == 0){
    28b5:	83 ec 0c             	sub    $0xc,%esp
    28b8:	68 be 46 00 00       	push   $0x46be
    28bd:	e8 11 11 00 00       	call   39d3 <unlink>
    28c2:	83 c4 10             	add    $0x10,%esp
    28c5:	85 c0                	test   %eax,%eax
    28c7:	0f 84 f2 00 00 00    	je     29bf <rmdot+0x14f>
  if(unlink("..") == 0){
    28cd:	83 ec 0c             	sub    $0xc,%esp
    28d0:	68 bd 46 00 00       	push   $0x46bd
    28d5:	e8 f9 10 00 00       	call   39d3 <unlink>
    28da:	83 c4 10             	add    $0x10,%esp
    28dd:	85 c0                	test   %eax,%eax
    28df:	0f 84 c7 00 00 00    	je     29ac <rmdot+0x13c>
  if(chdir("/") != 0){
    28e5:	83 ec 0c             	sub    $0xc,%esp
    28e8:	68 91 3e 00 00       	push   $0x3e91
    28ed:	e8 01 11 00 00       	call   39f3 <chdir>
    28f2:	83 c4 10             	add    $0x10,%esp
    28f5:	85 c0                	test   %eax,%eax
    28f7:	0f 85 9c 00 00 00    	jne    2999 <rmdot+0x129>
  if(unlink("dots/.") == 0){
    28fd:	83 ec 0c             	sub    $0xc,%esp
    2900:	68 5b 4a 00 00       	push   $0x4a5b
    2905:	e8 c9 10 00 00       	call   39d3 <unlink>
    290a:	83 c4 10             	add    $0x10,%esp
    290d:	85 c0                	test   %eax,%eax
    290f:	74 75                	je     2986 <rmdot+0x116>
  if(unlink("dots/..") == 0){
    2911:	83 ec 0c             	sub    $0xc,%esp
    2914:	68 79 4a 00 00       	push   $0x4a79
    2919:	e8 b5 10 00 00       	call   39d3 <unlink>
    291e:	83 c4 10             	add    $0x10,%esp
    2921:	85 c0                	test   %eax,%eax
    2923:	74 4e                	je     2973 <rmdot+0x103>
  if(unlink("dots") != 0){
    2925:	83 ec 0c             	sub    $0xc,%esp
    2928:	68 13 4a 00 00       	push   $0x4a13
    292d:	e8 a1 10 00 00       	call   39d3 <unlink>
    2932:	83 c4 10             	add    $0x10,%esp
    2935:	85 c0                	test   %eax,%eax
    2937:	75 27                	jne    2960 <rmdot+0xf0>
  printf(1, "rmdot ok\n");
    2939:	83 ec 08             	sub    $0x8,%esp
    293c:	68 ae 4a 00 00       	push   $0x4aae
    2941:	6a 01                	push   $0x1
    2943:	e8 98 11 00 00       	call   3ae0 <printf>
}
    2948:	83 c4 10             	add    $0x10,%esp
    294b:	c9                   	leave  
    294c:	c3                   	ret    
    printf(1, "mkdir dots failed\n");
    294d:	50                   	push   %eax
    294e:	50                   	push   %eax
    294f:	68 18 4a 00 00       	push   $0x4a18
    2954:	6a 01                	push   $0x1
    2956:	e8 85 11 00 00       	call   3ae0 <printf>
    exit();
    295b:	e8 23 10 00 00       	call   3983 <exit>
    printf(1, "unlink dots failed!\n");
    2960:	50                   	push   %eax
    2961:	50                   	push   %eax
    2962:	68 99 4a 00 00       	push   $0x4a99
    2967:	6a 01                	push   $0x1
    2969:	e8 72 11 00 00       	call   3ae0 <printf>
    exit();
    296e:	e8 10 10 00 00       	call   3983 <exit>
    printf(1, "unlink dots/.. worked!\n");
    2973:	52                   	push   %edx
    2974:	52                   	push   %edx
    2975:	68 81 4a 00 00       	push   $0x4a81
    297a:	6a 01                	push   $0x1
    297c:	e8 5f 11 00 00       	call   3ae0 <printf>
    exit();
    2981:	e8 fd 0f 00 00       	call   3983 <exit>
    printf(1, "unlink dots/. worked!\n");
    2986:	51                   	push   %ecx
    2987:	51                   	push   %ecx
    2988:	68 62 4a 00 00       	push   $0x4a62
    298d:	6a 01                	push   $0x1
    298f:	e8 4c 11 00 00       	call   3ae0 <printf>
    exit();
    2994:	e8 ea 0f 00 00       	call   3983 <exit>
    printf(1, "chdir / failed\n");
    2999:	50                   	push   %eax
    299a:	50                   	push   %eax
    299b:	68 93 3e 00 00       	push   $0x3e93
    29a0:	6a 01                	push   $0x1
    29a2:	e8 39 11 00 00       	call   3ae0 <printf>
    exit();
    29a7:	e8 d7 0f 00 00       	call   3983 <exit>
    printf(1, "rm .. worked!\n");
    29ac:	50                   	push   %eax
    29ad:	50                   	push   %eax
    29ae:	68 4c 4a 00 00       	push   $0x4a4c
    29b3:	6a 01                	push   $0x1
    29b5:	e8 26 11 00 00       	call   3ae0 <printf>
    exit();
    29ba:	e8 c4 0f 00 00       	call   3983 <exit>
    printf(1, "rm . worked!\n");
    29bf:	50                   	push   %eax
    29c0:	50                   	push   %eax
    29c1:	68 3e 4a 00 00       	push   $0x4a3e
    29c6:	6a 01                	push   $0x1
    29c8:	e8 13 11 00 00       	call   3ae0 <printf>
    exit();
    29cd:	e8 b1 0f 00 00       	call   3983 <exit>
    printf(1, "chdir dots failed\n");
    29d2:	50                   	push   %eax
    29d3:	50                   	push   %eax
    29d4:	68 2b 4a 00 00       	push   $0x4a2b
    29d9:	6a 01                	push   $0x1
    29db:	e8 00 11 00 00       	call   3ae0 <printf>
    exit();
    29e0:	e8 9e 0f 00 00       	call   3983 <exit>
    29e5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    29ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000029f0 <dirfile>:
{
    29f0:	f3 0f 1e fb          	endbr32 
    29f4:	55                   	push   %ebp
    29f5:	89 e5                	mov    %esp,%ebp
    29f7:	53                   	push   %ebx
    29f8:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "dir vs file\n");
    29fb:	68 b8 4a 00 00       	push   $0x4ab8
    2a00:	6a 01                	push   $0x1
    2a02:	e8 d9 10 00 00       	call   3ae0 <printf>
  fd = open("dirfile", O_CREATE);
    2a07:	5b                   	pop    %ebx
    2a08:	58                   	pop    %eax
    2a09:	68 00 02 00 00       	push   $0x200
    2a0e:	68 c5 4a 00 00       	push   $0x4ac5
    2a13:	e8 ab 0f 00 00       	call   39c3 <open>
  if(fd < 0){
    2a18:	83 c4 10             	add    $0x10,%esp
    2a1b:	85 c0                	test   %eax,%eax
    2a1d:	0f 88 43 01 00 00    	js     2b66 <dirfile+0x176>
  close(fd);
    2a23:	83 ec 0c             	sub    $0xc,%esp
    2a26:	50                   	push   %eax
    2a27:	e8 7f 0f 00 00       	call   39ab <close>
  if(chdir("dirfile") == 0){
    2a2c:	c7 04 24 c5 4a 00 00 	movl   $0x4ac5,(%esp)
    2a33:	e8 bb 0f 00 00       	call   39f3 <chdir>
    2a38:	83 c4 10             	add    $0x10,%esp
    2a3b:	85 c0                	test   %eax,%eax
    2a3d:	0f 84 10 01 00 00    	je     2b53 <dirfile+0x163>
  fd = open("dirfile/xx", 0);
    2a43:	83 ec 08             	sub    $0x8,%esp
    2a46:	6a 00                	push   $0x0
    2a48:	68 fe 4a 00 00       	push   $0x4afe
    2a4d:	e8 71 0f 00 00       	call   39c3 <open>
  if(fd >= 0){
    2a52:	83 c4 10             	add    $0x10,%esp
    2a55:	85 c0                	test   %eax,%eax
    2a57:	0f 89 e3 00 00 00    	jns    2b40 <dirfile+0x150>
  fd = open("dirfile/xx", O_CREATE);
    2a5d:	83 ec 08             	sub    $0x8,%esp
    2a60:	68 00 02 00 00       	push   $0x200
    2a65:	68 fe 4a 00 00       	push   $0x4afe
    2a6a:	e8 54 0f 00 00       	call   39c3 <open>
  if(fd >= 0){
    2a6f:	83 c4 10             	add    $0x10,%esp
    2a72:	85 c0                	test   %eax,%eax
    2a74:	0f 89 c6 00 00 00    	jns    2b40 <dirfile+0x150>
  if(mkdir("dirfile/xx") == 0){
    2a7a:	83 ec 0c             	sub    $0xc,%esp
    2a7d:	68 fe 4a 00 00       	push   $0x4afe
    2a82:	e8 64 0f 00 00       	call   39eb <mkdir>
    2a87:	83 c4 10             	add    $0x10,%esp
    2a8a:	85 c0                	test   %eax,%eax
    2a8c:	0f 84 46 01 00 00    	je     2bd8 <dirfile+0x1e8>
  if(unlink("dirfile/xx") == 0){
    2a92:	83 ec 0c             	sub    $0xc,%esp
    2a95:	68 fe 4a 00 00       	push   $0x4afe
    2a9a:	e8 34 0f 00 00       	call   39d3 <unlink>
    2a9f:	83 c4 10             	add    $0x10,%esp
    2aa2:	85 c0                	test   %eax,%eax
    2aa4:	0f 84 1b 01 00 00    	je     2bc5 <dirfile+0x1d5>
  if(link("README", "dirfile/xx") == 0){
    2aaa:	83 ec 08             	sub    $0x8,%esp
    2aad:	68 fe 4a 00 00       	push   $0x4afe
    2ab2:	68 62 4b 00 00       	push   $0x4b62
    2ab7:	e8 27 0f 00 00       	call   39e3 <link>
    2abc:	83 c4 10             	add    $0x10,%esp
    2abf:	85 c0                	test   %eax,%eax
    2ac1:	0f 84 eb 00 00 00    	je     2bb2 <dirfile+0x1c2>
  if(unlink("dirfile") != 0){
    2ac7:	83 ec 0c             	sub    $0xc,%esp
    2aca:	68 c5 4a 00 00       	push   $0x4ac5
    2acf:	e8 ff 0e 00 00       	call   39d3 <unlink>
    2ad4:	83 c4 10             	add    $0x10,%esp
    2ad7:	85 c0                	test   %eax,%eax
    2ad9:	0f 85 c0 00 00 00    	jne    2b9f <dirfile+0x1af>
  fd = open(".", O_RDWR);
    2adf:	83 ec 08             	sub    $0x8,%esp
    2ae2:	6a 02                	push   $0x2
    2ae4:	68 be 46 00 00       	push   $0x46be
    2ae9:	e8 d5 0e 00 00       	call   39c3 <open>
  if(fd >= 0){
    2aee:	83 c4 10             	add    $0x10,%esp
    2af1:	85 c0                	test   %eax,%eax
    2af3:	0f 89 93 00 00 00    	jns    2b8c <dirfile+0x19c>
  fd = open(".", 0);
    2af9:	83 ec 08             	sub    $0x8,%esp
    2afc:	6a 00                	push   $0x0
    2afe:	68 be 46 00 00       	push   $0x46be
    2b03:	e8 bb 0e 00 00       	call   39c3 <open>
  if(write(fd, "x", 1) > 0){
    2b08:	83 c4 0c             	add    $0xc,%esp
    2b0b:	6a 01                	push   $0x1
  fd = open(".", 0);
    2b0d:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
    2b0f:	68 a1 47 00 00       	push   $0x47a1
    2b14:	50                   	push   %eax
    2b15:	e8 89 0e 00 00       	call   39a3 <write>
    2b1a:	83 c4 10             	add    $0x10,%esp
    2b1d:	85 c0                	test   %eax,%eax
    2b1f:	7f 58                	jg     2b79 <dirfile+0x189>
  close(fd);
    2b21:	83 ec 0c             	sub    $0xc,%esp
    2b24:	53                   	push   %ebx
    2b25:	e8 81 0e 00 00       	call   39ab <close>
  printf(1, "dir vs file OK\n");
    2b2a:	58                   	pop    %eax
    2b2b:	5a                   	pop    %edx
    2b2c:	68 95 4b 00 00       	push   $0x4b95
    2b31:	6a 01                	push   $0x1
    2b33:	e8 a8 0f 00 00       	call   3ae0 <printf>
}
    2b38:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2b3b:	83 c4 10             	add    $0x10,%esp
    2b3e:	c9                   	leave  
    2b3f:	c3                   	ret    
    printf(1, "create dirfile/xx succeeded!\n");
    2b40:	50                   	push   %eax
    2b41:	50                   	push   %eax
    2b42:	68 09 4b 00 00       	push   $0x4b09
    2b47:	6a 01                	push   $0x1
    2b49:	e8 92 0f 00 00       	call   3ae0 <printf>
    exit();
    2b4e:	e8 30 0e 00 00       	call   3983 <exit>
    printf(1, "chdir dirfile succeeded!\n");
    2b53:	52                   	push   %edx
    2b54:	52                   	push   %edx
    2b55:	68 e4 4a 00 00       	push   $0x4ae4
    2b5a:	6a 01                	push   $0x1
    2b5c:	e8 7f 0f 00 00       	call   3ae0 <printf>
    exit();
    2b61:	e8 1d 0e 00 00       	call   3983 <exit>
    printf(1, "create dirfile failed\n");
    2b66:	51                   	push   %ecx
    2b67:	51                   	push   %ecx
    2b68:	68 cd 4a 00 00       	push   $0x4acd
    2b6d:	6a 01                	push   $0x1
    2b6f:	e8 6c 0f 00 00       	call   3ae0 <printf>
    exit();
    2b74:	e8 0a 0e 00 00       	call   3983 <exit>
    printf(1, "write . succeeded!\n");
    2b79:	51                   	push   %ecx
    2b7a:	51                   	push   %ecx
    2b7b:	68 81 4b 00 00       	push   $0x4b81
    2b80:	6a 01                	push   $0x1
    2b82:	e8 59 0f 00 00       	call   3ae0 <printf>
    exit();
    2b87:	e8 f7 0d 00 00       	call   3983 <exit>
    printf(1, "open . for writing succeeded!\n");
    2b8c:	53                   	push   %ebx
    2b8d:	53                   	push   %ebx
    2b8e:	68 78 53 00 00       	push   $0x5378
    2b93:	6a 01                	push   $0x1
    2b95:	e8 46 0f 00 00       	call   3ae0 <printf>
    exit();
    2b9a:	e8 e4 0d 00 00       	call   3983 <exit>
    printf(1, "unlink dirfile failed!\n");
    2b9f:	50                   	push   %eax
    2ba0:	50                   	push   %eax
    2ba1:	68 69 4b 00 00       	push   $0x4b69
    2ba6:	6a 01                	push   $0x1
    2ba8:	e8 33 0f 00 00       	call   3ae0 <printf>
    exit();
    2bad:	e8 d1 0d 00 00       	call   3983 <exit>
    printf(1, "link to dirfile/xx succeeded!\n");
    2bb2:	50                   	push   %eax
    2bb3:	50                   	push   %eax
    2bb4:	68 58 53 00 00       	push   $0x5358
    2bb9:	6a 01                	push   $0x1
    2bbb:	e8 20 0f 00 00       	call   3ae0 <printf>
    exit();
    2bc0:	e8 be 0d 00 00       	call   3983 <exit>
    printf(1, "unlink dirfile/xx succeeded!\n");
    2bc5:	50                   	push   %eax
    2bc6:	50                   	push   %eax
    2bc7:	68 44 4b 00 00       	push   $0x4b44
    2bcc:	6a 01                	push   $0x1
    2bce:	e8 0d 0f 00 00       	call   3ae0 <printf>
    exit();
    2bd3:	e8 ab 0d 00 00       	call   3983 <exit>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    2bd8:	50                   	push   %eax
    2bd9:	50                   	push   %eax
    2bda:	68 27 4b 00 00       	push   $0x4b27
    2bdf:	6a 01                	push   $0x1
    2be1:	e8 fa 0e 00 00       	call   3ae0 <printf>
    exit();
    2be6:	e8 98 0d 00 00       	call   3983 <exit>
    2beb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2bef:	90                   	nop

00002bf0 <iref>:
{
    2bf0:	f3 0f 1e fb          	endbr32 
    2bf4:	55                   	push   %ebp
    2bf5:	89 e5                	mov    %esp,%ebp
    2bf7:	53                   	push   %ebx
  printf(1, "empty file name\n");
    2bf8:	bb 33 00 00 00       	mov    $0x33,%ebx
{
    2bfd:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "empty file name\n");
    2c00:	68 a5 4b 00 00       	push   $0x4ba5
    2c05:	6a 01                	push   $0x1
    2c07:	e8 d4 0e 00 00       	call   3ae0 <printf>
    2c0c:	83 c4 10             	add    $0x10,%esp
    2c0f:	90                   	nop
    if(mkdir("irefd") != 0){
    2c10:	83 ec 0c             	sub    $0xc,%esp
    2c13:	68 b6 4b 00 00       	push   $0x4bb6
    2c18:	e8 ce 0d 00 00       	call   39eb <mkdir>
    2c1d:	83 c4 10             	add    $0x10,%esp
    2c20:	85 c0                	test   %eax,%eax
    2c22:	0f 85 bb 00 00 00    	jne    2ce3 <iref+0xf3>
    if(chdir("irefd") != 0){
    2c28:	83 ec 0c             	sub    $0xc,%esp
    2c2b:	68 b6 4b 00 00       	push   $0x4bb6
    2c30:	e8 be 0d 00 00       	call   39f3 <chdir>
    2c35:	83 c4 10             	add    $0x10,%esp
    2c38:	85 c0                	test   %eax,%eax
    2c3a:	0f 85 b7 00 00 00    	jne    2cf7 <iref+0x107>
    mkdir("");
    2c40:	83 ec 0c             	sub    $0xc,%esp
    2c43:	68 6b 42 00 00       	push   $0x426b
    2c48:	e8 9e 0d 00 00       	call   39eb <mkdir>
    link("README", "");
    2c4d:	59                   	pop    %ecx
    2c4e:	58                   	pop    %eax
    2c4f:	68 6b 42 00 00       	push   $0x426b
    2c54:	68 62 4b 00 00       	push   $0x4b62
    2c59:	e8 85 0d 00 00       	call   39e3 <link>
    fd = open("", O_CREATE);
    2c5e:	58                   	pop    %eax
    2c5f:	5a                   	pop    %edx
    2c60:	68 00 02 00 00       	push   $0x200
    2c65:	68 6b 42 00 00       	push   $0x426b
    2c6a:	e8 54 0d 00 00       	call   39c3 <open>
    if(fd >= 0)
    2c6f:	83 c4 10             	add    $0x10,%esp
    2c72:	85 c0                	test   %eax,%eax
    2c74:	78 0c                	js     2c82 <iref+0x92>
      close(fd);
    2c76:	83 ec 0c             	sub    $0xc,%esp
    2c79:	50                   	push   %eax
    2c7a:	e8 2c 0d 00 00       	call   39ab <close>
    2c7f:	83 c4 10             	add    $0x10,%esp
    fd = open("xx", O_CREATE);
    2c82:	83 ec 08             	sub    $0x8,%esp
    2c85:	68 00 02 00 00       	push   $0x200
    2c8a:	68 a0 47 00 00       	push   $0x47a0
    2c8f:	e8 2f 0d 00 00       	call   39c3 <open>
    if(fd >= 0)
    2c94:	83 c4 10             	add    $0x10,%esp
    2c97:	85 c0                	test   %eax,%eax
    2c99:	78 0c                	js     2ca7 <iref+0xb7>
      close(fd);
    2c9b:	83 ec 0c             	sub    $0xc,%esp
    2c9e:	50                   	push   %eax
    2c9f:	e8 07 0d 00 00       	call   39ab <close>
    2ca4:	83 c4 10             	add    $0x10,%esp
    unlink("xx");
    2ca7:	83 ec 0c             	sub    $0xc,%esp
    2caa:	68 a0 47 00 00       	push   $0x47a0
    2caf:	e8 1f 0d 00 00       	call   39d3 <unlink>
  for(i = 0; i < 50 + 1; i++){
    2cb4:	83 c4 10             	add    $0x10,%esp
    2cb7:	83 eb 01             	sub    $0x1,%ebx
    2cba:	0f 85 50 ff ff ff    	jne    2c10 <iref+0x20>
  chdir("/");
    2cc0:	83 ec 0c             	sub    $0xc,%esp
    2cc3:	68 91 3e 00 00       	push   $0x3e91
    2cc8:	e8 26 0d 00 00       	call   39f3 <chdir>
  printf(1, "empty file name OK\n");
    2ccd:	58                   	pop    %eax
    2cce:	5a                   	pop    %edx
    2ccf:	68 e4 4b 00 00       	push   $0x4be4
    2cd4:	6a 01                	push   $0x1
    2cd6:	e8 05 0e 00 00       	call   3ae0 <printf>
}
    2cdb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2cde:	83 c4 10             	add    $0x10,%esp
    2ce1:	c9                   	leave  
    2ce2:	c3                   	ret    
      printf(1, "mkdir irefd failed\n");
    2ce3:	83 ec 08             	sub    $0x8,%esp
    2ce6:	68 bc 4b 00 00       	push   $0x4bbc
    2ceb:	6a 01                	push   $0x1
    2ced:	e8 ee 0d 00 00       	call   3ae0 <printf>
      exit();
    2cf2:	e8 8c 0c 00 00       	call   3983 <exit>
      printf(1, "chdir irefd failed\n");
    2cf7:	83 ec 08             	sub    $0x8,%esp
    2cfa:	68 d0 4b 00 00       	push   $0x4bd0
    2cff:	6a 01                	push   $0x1
    2d01:	e8 da 0d 00 00       	call   3ae0 <printf>
      exit();
    2d06:	e8 78 0c 00 00       	call   3983 <exit>
    2d0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2d0f:	90                   	nop

00002d10 <forktest>:
{
    2d10:	f3 0f 1e fb          	endbr32 
    2d14:	55                   	push   %ebp
    2d15:	89 e5                	mov    %esp,%ebp
    2d17:	53                   	push   %ebx
  for(n=0; n<1000; n++){
    2d18:	31 db                	xor    %ebx,%ebx
{
    2d1a:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "fork test\n");
    2d1d:	68 f8 4b 00 00       	push   $0x4bf8
    2d22:	6a 01                	push   $0x1
    2d24:	e8 b7 0d 00 00       	call   3ae0 <printf>
    2d29:	83 c4 10             	add    $0x10,%esp
    2d2c:	eb 0f                	jmp    2d3d <forktest+0x2d>
    2d2e:	66 90                	xchg   %ax,%ax
    if(pid == 0)
    2d30:	74 4a                	je     2d7c <forktest+0x6c>
  for(n=0; n<1000; n++){
    2d32:	83 c3 01             	add    $0x1,%ebx
    2d35:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    2d3b:	74 6b                	je     2da8 <forktest+0x98>
    pid = fork();
    2d3d:	e8 39 0c 00 00       	call   397b <fork>
    if(pid < 0)
    2d42:	85 c0                	test   %eax,%eax
    2d44:	79 ea                	jns    2d30 <forktest+0x20>
  for(; n > 0; n--){
    2d46:	85 db                	test   %ebx,%ebx
    2d48:	74 14                	je     2d5e <forktest+0x4e>
    2d4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(wait() < 0){
    2d50:	e8 36 0c 00 00       	call   398b <wait>
    2d55:	85 c0                	test   %eax,%eax
    2d57:	78 28                	js     2d81 <forktest+0x71>
  for(; n > 0; n--){
    2d59:	83 eb 01             	sub    $0x1,%ebx
    2d5c:	75 f2                	jne    2d50 <forktest+0x40>
  if(wait() != -1){
    2d5e:	e8 28 0c 00 00       	call   398b <wait>
    2d63:	83 f8 ff             	cmp    $0xffffffff,%eax
    2d66:	75 2d                	jne    2d95 <forktest+0x85>
  printf(1, "fork test OK\n");
    2d68:	83 ec 08             	sub    $0x8,%esp
    2d6b:	68 2a 4c 00 00       	push   $0x4c2a
    2d70:	6a 01                	push   $0x1
    2d72:	e8 69 0d 00 00       	call   3ae0 <printf>
}
    2d77:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2d7a:	c9                   	leave  
    2d7b:	c3                   	ret    
      exit();
    2d7c:	e8 02 0c 00 00       	call   3983 <exit>
      printf(1, "wait stopped early\n");
    2d81:	83 ec 08             	sub    $0x8,%esp
    2d84:	68 03 4c 00 00       	push   $0x4c03
    2d89:	6a 01                	push   $0x1
    2d8b:	e8 50 0d 00 00       	call   3ae0 <printf>
      exit();
    2d90:	e8 ee 0b 00 00       	call   3983 <exit>
    printf(1, "wait got too many\n");
    2d95:	52                   	push   %edx
    2d96:	52                   	push   %edx
    2d97:	68 17 4c 00 00       	push   $0x4c17
    2d9c:	6a 01                	push   $0x1
    2d9e:	e8 3d 0d 00 00       	call   3ae0 <printf>
    exit();
    2da3:	e8 db 0b 00 00       	call   3983 <exit>
    printf(1, "fork claimed to work 1000 times!\n");
    2da8:	50                   	push   %eax
    2da9:	50                   	push   %eax
    2daa:	68 98 53 00 00       	push   $0x5398
    2daf:	6a 01                	push   $0x1
    2db1:	e8 2a 0d 00 00       	call   3ae0 <printf>
    exit();
    2db6:	e8 c8 0b 00 00       	call   3983 <exit>
    2dbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2dbf:	90                   	nop

00002dc0 <sbrktest>:
{
    2dc0:	f3 0f 1e fb          	endbr32 
    2dc4:	55                   	push   %ebp
    2dc5:	89 e5                	mov    %esp,%ebp
    2dc7:	57                   	push   %edi
    2dc8:	56                   	push   %esi
  for(i = 0; i < 5000; i++){
    2dc9:	31 f6                	xor    %esi,%esi
{
    2dcb:	53                   	push   %ebx
    2dcc:	83 ec 64             	sub    $0x64,%esp
  printf(stdout, "sbrk test\n");
    2dcf:	68 38 4c 00 00       	push   $0x4c38
    2dd4:	ff 35 dc 5e 00 00    	pushl  0x5edc
    2dda:	e8 01 0d 00 00       	call   3ae0 <printf>
  oldbrk = sbrk(0);
    2ddf:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2de6:	e8 20 0c 00 00       	call   3a0b <sbrk>
  a = sbrk(0);
    2deb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  oldbrk = sbrk(0);
    2df2:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  a = sbrk(0);
    2df5:	e8 11 0c 00 00       	call   3a0b <sbrk>
    2dfa:	83 c4 10             	add    $0x10,%esp
    2dfd:	89 c3                	mov    %eax,%ebx
  for(i = 0; i < 5000; i++){
    2dff:	eb 09                	jmp    2e0a <sbrktest+0x4a>
    2e01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    a = b + 1;
    2e08:	89 c3                	mov    %eax,%ebx
    b = sbrk(1);
    2e0a:	83 ec 0c             	sub    $0xc,%esp
    2e0d:	6a 01                	push   $0x1
    2e0f:	e8 f7 0b 00 00       	call   3a0b <sbrk>
    if(b != a){
    2e14:	83 c4 10             	add    $0x10,%esp
    2e17:	39 d8                	cmp    %ebx,%eax
    2e19:	0f 85 94 02 00 00    	jne    30b3 <sbrktest+0x2f3>
  for(i = 0; i < 5000; i++){
    2e1f:	83 c6 01             	add    $0x1,%esi
    *b = 1;
    2e22:	c6 03 01             	movb   $0x1,(%ebx)
    a = b + 1;
    2e25:	8d 43 01             	lea    0x1(%ebx),%eax
  for(i = 0; i < 5000; i++){
    2e28:	81 fe 88 13 00 00    	cmp    $0x1388,%esi
    2e2e:	75 d8                	jne    2e08 <sbrktest+0x48>
  pid = fork();
    2e30:	e8 46 0b 00 00       	call   397b <fork>
    2e35:	89 c6                	mov    %eax,%esi
  if(pid < 0){
    2e37:	85 c0                	test   %eax,%eax
    2e39:	0f 88 fa 02 00 00    	js     3139 <sbrktest+0x379>
  c = sbrk(1);
    2e3f:	83 ec 0c             	sub    $0xc,%esp
  if(c != a + 1){
    2e42:	83 c3 02             	add    $0x2,%ebx
  c = sbrk(1);
    2e45:	6a 01                	push   $0x1
    2e47:	e8 bf 0b 00 00       	call   3a0b <sbrk>
  c = sbrk(1);
    2e4c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e53:	e8 b3 0b 00 00       	call   3a0b <sbrk>
  if(c != a + 1){
    2e58:	83 c4 10             	add    $0x10,%esp
    2e5b:	39 c3                	cmp    %eax,%ebx
    2e5d:	0f 85 33 03 00 00    	jne    3196 <sbrktest+0x3d6>
  if(pid == 0)
    2e63:	85 f6                	test   %esi,%esi
    2e65:	0f 84 26 03 00 00    	je     3191 <sbrktest+0x3d1>
  wait();
    2e6b:	e8 1b 0b 00 00       	call   398b <wait>
  a = sbrk(0);
    2e70:	83 ec 0c             	sub    $0xc,%esp
    2e73:	6a 00                	push   $0x0
    2e75:	e8 91 0b 00 00       	call   3a0b <sbrk>
    2e7a:	89 c3                	mov    %eax,%ebx
  amt = (BIG) - (uint)a;
    2e7c:	b8 00 00 40 06       	mov    $0x6400000,%eax
    2e81:	29 d8                	sub    %ebx,%eax
  p = sbrk(amt);
    2e83:	89 04 24             	mov    %eax,(%esp)
    2e86:	e8 80 0b 00 00       	call   3a0b <sbrk>
  if (p != a) {
    2e8b:	83 c4 10             	add    $0x10,%esp
    2e8e:	39 c3                	cmp    %eax,%ebx
    2e90:	0f 85 8c 02 00 00    	jne    3122 <sbrktest+0x362>
  a = sbrk(0);
    2e96:	83 ec 0c             	sub    $0xc,%esp
  *lastaddr = 99;
    2e99:	c6 05 ff ff 3f 06 63 	movb   $0x63,0x63fffff
  a = sbrk(0);
    2ea0:	6a 00                	push   $0x0
    2ea2:	e8 64 0b 00 00       	call   3a0b <sbrk>
  c = sbrk(-4096);
    2ea7:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
  a = sbrk(0);
    2eae:	89 c3                	mov    %eax,%ebx
  c = sbrk(-4096);
    2eb0:	e8 56 0b 00 00       	call   3a0b <sbrk>
  if(c == (char*)0xffffffff){
    2eb5:	83 c4 10             	add    $0x10,%esp
    2eb8:	83 f8 ff             	cmp    $0xffffffff,%eax
    2ebb:	0f 84 1a 03 00 00    	je     31db <sbrktest+0x41b>
  c = sbrk(0);
    2ec1:	83 ec 0c             	sub    $0xc,%esp
    2ec4:	6a 00                	push   $0x0
    2ec6:	e8 40 0b 00 00       	call   3a0b <sbrk>
  if(c != a - 4096){
    2ecb:	8d 93 00 f0 ff ff    	lea    -0x1000(%ebx),%edx
    2ed1:	83 c4 10             	add    $0x10,%esp
    2ed4:	39 d0                	cmp    %edx,%eax
    2ed6:	0f 85 e8 02 00 00    	jne    31c4 <sbrktest+0x404>
  a = sbrk(0);
    2edc:	83 ec 0c             	sub    $0xc,%esp
    2edf:	6a 00                	push   $0x0
    2ee1:	e8 25 0b 00 00       	call   3a0b <sbrk>
  c = sbrk(4096);
    2ee6:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  a = sbrk(0);
    2eed:	89 c3                	mov    %eax,%ebx
  c = sbrk(4096);
    2eef:	e8 17 0b 00 00       	call   3a0b <sbrk>
  if(c != a || sbrk(0) != a + 4096){
    2ef4:	83 c4 10             	add    $0x10,%esp
  c = sbrk(4096);
    2ef7:	89 c6                	mov    %eax,%esi
  if(c != a || sbrk(0) != a + 4096){
    2ef9:	39 c3                	cmp    %eax,%ebx
    2efb:	0f 85 ac 02 00 00    	jne    31ad <sbrktest+0x3ed>
    2f01:	83 ec 0c             	sub    $0xc,%esp
    2f04:	6a 00                	push   $0x0
    2f06:	e8 00 0b 00 00       	call   3a0b <sbrk>
    2f0b:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    2f11:	83 c4 10             	add    $0x10,%esp
    2f14:	39 c2                	cmp    %eax,%edx
    2f16:	0f 85 91 02 00 00    	jne    31ad <sbrktest+0x3ed>
  if(*lastaddr == 99){
    2f1c:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    2f23:	0f 84 27 02 00 00    	je     3150 <sbrktest+0x390>
  a = sbrk(0);
    2f29:	83 ec 0c             	sub    $0xc,%esp
    2f2c:	6a 00                	push   $0x0
    2f2e:	e8 d8 0a 00 00       	call   3a0b <sbrk>
  c = sbrk(-(sbrk(0) - oldbrk));
    2f33:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  a = sbrk(0);
    2f3a:	89 c3                	mov    %eax,%ebx
  c = sbrk(-(sbrk(0) - oldbrk));
    2f3c:	e8 ca 0a 00 00       	call   3a0b <sbrk>
    2f41:	89 c2                	mov    %eax,%edx
    2f43:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    2f46:	29 d0                	sub    %edx,%eax
    2f48:	89 04 24             	mov    %eax,(%esp)
    2f4b:	e8 bb 0a 00 00       	call   3a0b <sbrk>
  if(c != a){
    2f50:	83 c4 10             	add    $0x10,%esp
    2f53:	39 c3                	cmp    %eax,%ebx
    2f55:	0f 85 b0 01 00 00    	jne    310b <sbrktest+0x34b>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2f5b:	bb 00 00 00 80       	mov    $0x80000000,%ebx
    ppid = getpid();
    2f60:	e8 9e 0a 00 00       	call   3a03 <getpid>
    2f65:	89 c6                	mov    %eax,%esi
    pid = fork();
    2f67:	e8 0f 0a 00 00       	call   397b <fork>
    if(pid < 0){
    2f6c:	85 c0                	test   %eax,%eax
    2f6e:	0f 88 5d 01 00 00    	js     30d1 <sbrktest+0x311>
    if(pid == 0){
    2f74:	0f 84 6f 01 00 00    	je     30e9 <sbrktest+0x329>
    wait();
    2f7a:	e8 0c 0a 00 00       	call   398b <wait>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2f7f:	81 c3 50 c3 00 00    	add    $0xc350,%ebx
    2f85:	81 fb 80 84 1e 80    	cmp    $0x801e8480,%ebx
    2f8b:	75 d3                	jne    2f60 <sbrktest+0x1a0>
  if(pipe(fds) != 0){
    2f8d:	83 ec 0c             	sub    $0xc,%esp
    2f90:	8d 45 b8             	lea    -0x48(%ebp),%eax
    2f93:	50                   	push   %eax
    2f94:	e8 fa 09 00 00       	call   3993 <pipe>
    2f99:	83 c4 10             	add    $0x10,%esp
    2f9c:	85 c0                	test   %eax,%eax
    2f9e:	0f 85 da 01 00 00    	jne    317e <sbrktest+0x3be>
    2fa4:	8d 5d c0             	lea    -0x40(%ebp),%ebx
    2fa7:	8d 75 e8             	lea    -0x18(%ebp),%esi
    2faa:	89 df                	mov    %ebx,%edi
    2fac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((pids[i] = fork()) == 0){
    2fb0:	e8 c6 09 00 00       	call   397b <fork>
    2fb5:	89 07                	mov    %eax,(%edi)
    2fb7:	85 c0                	test   %eax,%eax
    2fb9:	0f 84 91 00 00 00    	je     3050 <sbrktest+0x290>
    if(pids[i] != -1)
    2fbf:	83 f8 ff             	cmp    $0xffffffff,%eax
    2fc2:	74 14                	je     2fd8 <sbrktest+0x218>
      read(fds[0], &scratch, 1);
    2fc4:	83 ec 04             	sub    $0x4,%esp
    2fc7:	8d 45 b7             	lea    -0x49(%ebp),%eax
    2fca:	6a 01                	push   $0x1
    2fcc:	50                   	push   %eax
    2fcd:	ff 75 b8             	pushl  -0x48(%ebp)
    2fd0:	e8 c6 09 00 00       	call   399b <read>
    2fd5:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2fd8:	83 c7 04             	add    $0x4,%edi
    2fdb:	39 f7                	cmp    %esi,%edi
    2fdd:	75 d1                	jne    2fb0 <sbrktest+0x1f0>
  c = sbrk(4096);
    2fdf:	83 ec 0c             	sub    $0xc,%esp
    2fe2:	68 00 10 00 00       	push   $0x1000
    2fe7:	e8 1f 0a 00 00       	call   3a0b <sbrk>
    2fec:	83 c4 10             	add    $0x10,%esp
    2fef:	89 c7                	mov    %eax,%edi
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2ff1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(pids[i] == -1)
    2ff8:	8b 03                	mov    (%ebx),%eax
    2ffa:	83 f8 ff             	cmp    $0xffffffff,%eax
    2ffd:	74 11                	je     3010 <sbrktest+0x250>
    kill(pids[i]);
    2fff:	83 ec 0c             	sub    $0xc,%esp
    3002:	50                   	push   %eax
    3003:	e8 ab 09 00 00       	call   39b3 <kill>
    wait();
    3008:	e8 7e 09 00 00       	call   398b <wait>
    300d:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3010:	83 c3 04             	add    $0x4,%ebx
    3013:	39 de                	cmp    %ebx,%esi
    3015:	75 e1                	jne    2ff8 <sbrktest+0x238>
  if(c == (char*)0xffffffff){
    3017:	83 ff ff             	cmp    $0xffffffff,%edi
    301a:	0f 84 47 01 00 00    	je     3167 <sbrktest+0x3a7>
  if(sbrk(0) > oldbrk)
    3020:	83 ec 0c             	sub    $0xc,%esp
    3023:	6a 00                	push   $0x0
    3025:	e8 e1 09 00 00       	call   3a0b <sbrk>
    302a:	83 c4 10             	add    $0x10,%esp
    302d:	39 45 a4             	cmp    %eax,-0x5c(%ebp)
    3030:	72 60                	jb     3092 <sbrktest+0x2d2>
  printf(stdout, "sbrk test OK\n");
    3032:	83 ec 08             	sub    $0x8,%esp
    3035:	68 e0 4c 00 00       	push   $0x4ce0
    303a:	ff 35 dc 5e 00 00    	pushl  0x5edc
    3040:	e8 9b 0a 00 00       	call   3ae0 <printf>
}
    3045:	83 c4 10             	add    $0x10,%esp
    3048:	8d 65 f4             	lea    -0xc(%ebp),%esp
    304b:	5b                   	pop    %ebx
    304c:	5e                   	pop    %esi
    304d:	5f                   	pop    %edi
    304e:	5d                   	pop    %ebp
    304f:	c3                   	ret    
      sbrk(BIG - (uint)sbrk(0));
    3050:	83 ec 0c             	sub    $0xc,%esp
    3053:	6a 00                	push   $0x0
    3055:	e8 b1 09 00 00       	call   3a0b <sbrk>
    305a:	89 c2                	mov    %eax,%edx
    305c:	b8 00 00 40 06       	mov    $0x6400000,%eax
    3061:	29 d0                	sub    %edx,%eax
    3063:	89 04 24             	mov    %eax,(%esp)
    3066:	e8 a0 09 00 00       	call   3a0b <sbrk>
      write(fds[1], "x", 1);
    306b:	83 c4 0c             	add    $0xc,%esp
    306e:	6a 01                	push   $0x1
    3070:	68 a1 47 00 00       	push   $0x47a1
    3075:	ff 75 bc             	pushl  -0x44(%ebp)
    3078:	e8 26 09 00 00       	call   39a3 <write>
    307d:	83 c4 10             	add    $0x10,%esp
      for(;;) sleep(1000);
    3080:	83 ec 0c             	sub    $0xc,%esp
    3083:	68 e8 03 00 00       	push   $0x3e8
    3088:	e8 86 09 00 00       	call   3a13 <sleep>
    308d:	83 c4 10             	add    $0x10,%esp
    3090:	eb ee                	jmp    3080 <sbrktest+0x2c0>
    sbrk(-(sbrk(0) - oldbrk));
    3092:	83 ec 0c             	sub    $0xc,%esp
    3095:	6a 00                	push   $0x0
    3097:	e8 6f 09 00 00       	call   3a0b <sbrk>
    309c:	89 c2                	mov    %eax,%edx
    309e:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    30a1:	29 d0                	sub    %edx,%eax
    30a3:	89 04 24             	mov    %eax,(%esp)
    30a6:	e8 60 09 00 00       	call   3a0b <sbrk>
    30ab:	83 c4 10             	add    $0x10,%esp
    30ae:	e9 7f ff ff ff       	jmp    3032 <sbrktest+0x272>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    30b3:	83 ec 0c             	sub    $0xc,%esp
    30b6:	50                   	push   %eax
    30b7:	53                   	push   %ebx
    30b8:	56                   	push   %esi
    30b9:	68 43 4c 00 00       	push   $0x4c43
    30be:	ff 35 dc 5e 00 00    	pushl  0x5edc
    30c4:	e8 17 0a 00 00       	call   3ae0 <printf>
      exit();
    30c9:	83 c4 20             	add    $0x20,%esp
    30cc:	e8 b2 08 00 00       	call   3983 <exit>
      printf(stdout, "fork failed\n");
    30d1:	83 ec 08             	sub    $0x8,%esp
    30d4:	68 89 4d 00 00       	push   $0x4d89
    30d9:	ff 35 dc 5e 00 00    	pushl  0x5edc
    30df:	e8 fc 09 00 00       	call   3ae0 <printf>
      exit();
    30e4:	e8 9a 08 00 00       	call   3983 <exit>
      printf(stdout, "oops could read %x = %x\n", a, *a);
    30e9:	0f be 03             	movsbl (%ebx),%eax
    30ec:	50                   	push   %eax
    30ed:	53                   	push   %ebx
    30ee:	68 ac 4c 00 00       	push   $0x4cac
    30f3:	ff 35 dc 5e 00 00    	pushl  0x5edc
    30f9:	e8 e2 09 00 00       	call   3ae0 <printf>
      kill(ppid);
    30fe:	89 34 24             	mov    %esi,(%esp)
    3101:	e8 ad 08 00 00       	call   39b3 <kill>
      exit();
    3106:	e8 78 08 00 00       	call   3983 <exit>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    310b:	50                   	push   %eax
    310c:	53                   	push   %ebx
    310d:	68 8c 54 00 00       	push   $0x548c
    3112:	ff 35 dc 5e 00 00    	pushl  0x5edc
    3118:	e8 c3 09 00 00       	call   3ae0 <printf>
    exit();
    311d:	e8 61 08 00 00       	call   3983 <exit>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    3122:	56                   	push   %esi
    3123:	56                   	push   %esi
    3124:	68 bc 53 00 00       	push   $0x53bc
    3129:	ff 35 dc 5e 00 00    	pushl  0x5edc
    312f:	e8 ac 09 00 00       	call   3ae0 <printf>
    exit();
    3134:	e8 4a 08 00 00       	call   3983 <exit>
    printf(stdout, "sbrk test fork failed\n");
    3139:	50                   	push   %eax
    313a:	50                   	push   %eax
    313b:	68 5e 4c 00 00       	push   $0x4c5e
    3140:	ff 35 dc 5e 00 00    	pushl  0x5edc
    3146:	e8 95 09 00 00       	call   3ae0 <printf>
    exit();
    314b:	e8 33 08 00 00       	call   3983 <exit>
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    3150:	51                   	push   %ecx
    3151:	51                   	push   %ecx
    3152:	68 5c 54 00 00       	push   $0x545c
    3157:	ff 35 dc 5e 00 00    	pushl  0x5edc
    315d:	e8 7e 09 00 00       	call   3ae0 <printf>
    exit();
    3162:	e8 1c 08 00 00       	call   3983 <exit>
    printf(stdout, "failed sbrk leaked memory\n");
    3167:	50                   	push   %eax
    3168:	50                   	push   %eax
    3169:	68 c5 4c 00 00       	push   $0x4cc5
    316e:	ff 35 dc 5e 00 00    	pushl  0x5edc
    3174:	e8 67 09 00 00       	call   3ae0 <printf>
    exit();
    3179:	e8 05 08 00 00       	call   3983 <exit>
    printf(1, "pipe() failed\n");
    317e:	52                   	push   %edx
    317f:	52                   	push   %edx
    3180:	68 81 41 00 00       	push   $0x4181
    3185:	6a 01                	push   $0x1
    3187:	e8 54 09 00 00       	call   3ae0 <printf>
    exit();
    318c:	e8 f2 07 00 00       	call   3983 <exit>
    exit();
    3191:	e8 ed 07 00 00       	call   3983 <exit>
    printf(stdout, "sbrk test failed post-fork\n");
    3196:	57                   	push   %edi
    3197:	57                   	push   %edi
    3198:	68 75 4c 00 00       	push   $0x4c75
    319d:	ff 35 dc 5e 00 00    	pushl  0x5edc
    31a3:	e8 38 09 00 00       	call   3ae0 <printf>
    exit();
    31a8:	e8 d6 07 00 00       	call   3983 <exit>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    31ad:	56                   	push   %esi
    31ae:	53                   	push   %ebx
    31af:	68 34 54 00 00       	push   $0x5434
    31b4:	ff 35 dc 5e 00 00    	pushl  0x5edc
    31ba:	e8 21 09 00 00       	call   3ae0 <printf>
    exit();
    31bf:	e8 bf 07 00 00       	call   3983 <exit>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    31c4:	50                   	push   %eax
    31c5:	53                   	push   %ebx
    31c6:	68 fc 53 00 00       	push   $0x53fc
    31cb:	ff 35 dc 5e 00 00    	pushl  0x5edc
    31d1:	e8 0a 09 00 00       	call   3ae0 <printf>
    exit();
    31d6:	e8 a8 07 00 00       	call   3983 <exit>
    printf(stdout, "sbrk could not deallocate\n");
    31db:	53                   	push   %ebx
    31dc:	53                   	push   %ebx
    31dd:	68 91 4c 00 00       	push   $0x4c91
    31e2:	ff 35 dc 5e 00 00    	pushl  0x5edc
    31e8:	e8 f3 08 00 00       	call   3ae0 <printf>
    exit();
    31ed:	e8 91 07 00 00       	call   3983 <exit>
    31f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    31f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003200 <validateint>:
{
    3200:	f3 0f 1e fb          	endbr32 
}
    3204:	c3                   	ret    
    3205:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    320c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003210 <validatetest>:
{
    3210:	f3 0f 1e fb          	endbr32 
    3214:	55                   	push   %ebp
    3215:	89 e5                	mov    %esp,%ebp
    3217:	56                   	push   %esi
  for(p = 0; p <= (uint)hi; p += 4096){
    3218:	31 f6                	xor    %esi,%esi
{
    321a:	53                   	push   %ebx
  printf(stdout, "validate test\n");
    321b:	83 ec 08             	sub    $0x8,%esp
    321e:	68 ee 4c 00 00       	push   $0x4cee
    3223:	ff 35 dc 5e 00 00    	pushl  0x5edc
    3229:	e8 b2 08 00 00       	call   3ae0 <printf>
    322e:	83 c4 10             	add    $0x10,%esp
    3231:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if((pid = fork()) == 0){
    3238:	e8 3e 07 00 00       	call   397b <fork>
    323d:	89 c3                	mov    %eax,%ebx
    323f:	85 c0                	test   %eax,%eax
    3241:	74 63                	je     32a6 <validatetest+0x96>
    sleep(0);
    3243:	83 ec 0c             	sub    $0xc,%esp
    3246:	6a 00                	push   $0x0
    3248:	e8 c6 07 00 00       	call   3a13 <sleep>
    sleep(0);
    324d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3254:	e8 ba 07 00 00       	call   3a13 <sleep>
    kill(pid);
    3259:	89 1c 24             	mov    %ebx,(%esp)
    325c:	e8 52 07 00 00       	call   39b3 <kill>
    wait();
    3261:	e8 25 07 00 00       	call   398b <wait>
    if(link("nosuchfile", (char*)p) != -1){
    3266:	58                   	pop    %eax
    3267:	5a                   	pop    %edx
    3268:	56                   	push   %esi
    3269:	68 fd 4c 00 00       	push   $0x4cfd
    326e:	e8 70 07 00 00       	call   39e3 <link>
    3273:	83 c4 10             	add    $0x10,%esp
    3276:	83 f8 ff             	cmp    $0xffffffff,%eax
    3279:	75 30                	jne    32ab <validatetest+0x9b>
  for(p = 0; p <= (uint)hi; p += 4096){
    327b:	81 c6 00 10 00 00    	add    $0x1000,%esi
    3281:	81 fe 00 40 11 00    	cmp    $0x114000,%esi
    3287:	75 af                	jne    3238 <validatetest+0x28>
  printf(stdout, "validate ok\n");
    3289:	83 ec 08             	sub    $0x8,%esp
    328c:	68 21 4d 00 00       	push   $0x4d21
    3291:	ff 35 dc 5e 00 00    	pushl  0x5edc
    3297:	e8 44 08 00 00       	call   3ae0 <printf>
}
    329c:	83 c4 10             	add    $0x10,%esp
    329f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    32a2:	5b                   	pop    %ebx
    32a3:	5e                   	pop    %esi
    32a4:	5d                   	pop    %ebp
    32a5:	c3                   	ret    
      exit();
    32a6:	e8 d8 06 00 00       	call   3983 <exit>
      printf(stdout, "link should not succeed\n");
    32ab:	83 ec 08             	sub    $0x8,%esp
    32ae:	68 08 4d 00 00       	push   $0x4d08
    32b3:	ff 35 dc 5e 00 00    	pushl  0x5edc
    32b9:	e8 22 08 00 00       	call   3ae0 <printf>
      exit();
    32be:	e8 c0 06 00 00       	call   3983 <exit>
    32c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    32ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000032d0 <bsstest>:
{
    32d0:	f3 0f 1e fb          	endbr32 
    32d4:	55                   	push   %ebp
    32d5:	89 e5                	mov    %esp,%ebp
    32d7:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "bss test\n");
    32da:	68 2e 4d 00 00       	push   $0x4d2e
    32df:	ff 35 dc 5e 00 00    	pushl  0x5edc
    32e5:	e8 f6 07 00 00       	call   3ae0 <printf>
    32ea:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(uninit); i++){
    32ed:	31 c0                	xor    %eax,%eax
    32ef:	90                   	nop
    if(uninit[i] != '\0'){
    32f0:	80 b8 00 5f 00 00 00 	cmpb   $0x0,0x5f00(%eax)
    32f7:	75 22                	jne    331b <bsstest+0x4b>
  for(i = 0; i < sizeof(uninit); i++){
    32f9:	83 c0 01             	add    $0x1,%eax
    32fc:	3d 10 27 00 00       	cmp    $0x2710,%eax
    3301:	75 ed                	jne    32f0 <bsstest+0x20>
  printf(stdout, "bss test ok\n");
    3303:	83 ec 08             	sub    $0x8,%esp
    3306:	68 49 4d 00 00       	push   $0x4d49
    330b:	ff 35 dc 5e 00 00    	pushl  0x5edc
    3311:	e8 ca 07 00 00       	call   3ae0 <printf>
}
    3316:	83 c4 10             	add    $0x10,%esp
    3319:	c9                   	leave  
    331a:	c3                   	ret    
      printf(stdout, "bss test failed\n");
    331b:	83 ec 08             	sub    $0x8,%esp
    331e:	68 38 4d 00 00       	push   $0x4d38
    3323:	ff 35 dc 5e 00 00    	pushl  0x5edc
    3329:	e8 b2 07 00 00       	call   3ae0 <printf>
      exit();
    332e:	e8 50 06 00 00       	call   3983 <exit>
    3333:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    333a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00003340 <bigargtest>:
{
    3340:	f3 0f 1e fb          	endbr32 
    3344:	55                   	push   %ebp
    3345:	89 e5                	mov    %esp,%ebp
    3347:	83 ec 14             	sub    $0x14,%esp
  unlink("bigarg-ok");
    334a:	68 56 4d 00 00       	push   $0x4d56
    334f:	e8 7f 06 00 00       	call   39d3 <unlink>
  pid = fork();
    3354:	e8 22 06 00 00       	call   397b <fork>
  if(pid == 0){
    3359:	83 c4 10             	add    $0x10,%esp
    335c:	85 c0                	test   %eax,%eax
    335e:	74 40                	je     33a0 <bigargtest+0x60>
  } else if(pid < 0){
    3360:	0f 88 c1 00 00 00    	js     3427 <bigargtest+0xe7>
  wait();
    3366:	e8 20 06 00 00       	call   398b <wait>
  fd = open("bigarg-ok", 0);
    336b:	83 ec 08             	sub    $0x8,%esp
    336e:	6a 00                	push   $0x0
    3370:	68 56 4d 00 00       	push   $0x4d56
    3375:	e8 49 06 00 00       	call   39c3 <open>
  if(fd < 0){
    337a:	83 c4 10             	add    $0x10,%esp
    337d:	85 c0                	test   %eax,%eax
    337f:	0f 88 8b 00 00 00    	js     3410 <bigargtest+0xd0>
  close(fd);
    3385:	83 ec 0c             	sub    $0xc,%esp
    3388:	50                   	push   %eax
    3389:	e8 1d 06 00 00       	call   39ab <close>
  unlink("bigarg-ok");
    338e:	c7 04 24 56 4d 00 00 	movl   $0x4d56,(%esp)
    3395:	e8 39 06 00 00       	call   39d3 <unlink>
}
    339a:	83 c4 10             	add    $0x10,%esp
    339d:	c9                   	leave  
    339e:	c3                   	ret    
    339f:	90                   	nop
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    33a0:	c7 04 85 20 a6 00 00 	movl   $0x54b0,0xa620(,%eax,4)
    33a7:	b0 54 00 00 
    for(i = 0; i < MAXARG-1; i++)
    33ab:	83 c0 01             	add    $0x1,%eax
    33ae:	83 f8 1f             	cmp    $0x1f,%eax
    33b1:	75 ed                	jne    33a0 <bigargtest+0x60>
    printf(stdout, "bigarg test\n");
    33b3:	51                   	push   %ecx
    33b4:	51                   	push   %ecx
    33b5:	68 60 4d 00 00       	push   $0x4d60
    33ba:	ff 35 dc 5e 00 00    	pushl  0x5edc
    args[MAXARG-1] = 0;
    33c0:	c7 05 9c a6 00 00 00 	movl   $0x0,0xa69c
    33c7:	00 00 00 
    printf(stdout, "bigarg test\n");
    33ca:	e8 11 07 00 00       	call   3ae0 <printf>
    exec("echo", args);
    33cf:	58                   	pop    %eax
    33d0:	5a                   	pop    %edx
    33d1:	68 20 a6 00 00       	push   $0xa620
    33d6:	68 2d 3f 00 00       	push   $0x3f2d
    33db:	e8 db 05 00 00       	call   39bb <exec>
    printf(stdout, "bigarg test ok\n");
    33e0:	59                   	pop    %ecx
    33e1:	58                   	pop    %eax
    33e2:	68 6d 4d 00 00       	push   $0x4d6d
    33e7:	ff 35 dc 5e 00 00    	pushl  0x5edc
    33ed:	e8 ee 06 00 00       	call   3ae0 <printf>
    fd = open("bigarg-ok", O_CREATE);
    33f2:	58                   	pop    %eax
    33f3:	5a                   	pop    %edx
    33f4:	68 00 02 00 00       	push   $0x200
    33f9:	68 56 4d 00 00       	push   $0x4d56
    33fe:	e8 c0 05 00 00       	call   39c3 <open>
    close(fd);
    3403:	89 04 24             	mov    %eax,(%esp)
    3406:	e8 a0 05 00 00       	call   39ab <close>
    exit();
    340b:	e8 73 05 00 00       	call   3983 <exit>
    printf(stdout, "bigarg test failed!\n");
    3410:	50                   	push   %eax
    3411:	50                   	push   %eax
    3412:	68 96 4d 00 00       	push   $0x4d96
    3417:	ff 35 dc 5e 00 00    	pushl  0x5edc
    341d:	e8 be 06 00 00       	call   3ae0 <printf>
    exit();
    3422:	e8 5c 05 00 00       	call   3983 <exit>
    printf(stdout, "bigargtest: fork failed\n");
    3427:	52                   	push   %edx
    3428:	52                   	push   %edx
    3429:	68 7d 4d 00 00       	push   $0x4d7d
    342e:	ff 35 dc 5e 00 00    	pushl  0x5edc
    3434:	e8 a7 06 00 00       	call   3ae0 <printf>
    exit();
    3439:	e8 45 05 00 00       	call   3983 <exit>
    343e:	66 90                	xchg   %ax,%ax

00003440 <fsfull>:
{
    3440:	f3 0f 1e fb          	endbr32 
    3444:	55                   	push   %ebp
    3445:	89 e5                	mov    %esp,%ebp
    3447:	57                   	push   %edi
    3448:	56                   	push   %esi
  for(nfiles = 0; ; nfiles++){
    3449:	31 f6                	xor    %esi,%esi
{
    344b:	53                   	push   %ebx
    344c:	83 ec 54             	sub    $0x54,%esp
  printf(1, "fsfull test\n");
    344f:	68 ab 4d 00 00       	push   $0x4dab
    3454:	6a 01                	push   $0x1
    3456:	e8 85 06 00 00       	call   3ae0 <printf>
    345b:	83 c4 10             	add    $0x10,%esp
    345e:	66 90                	xchg   %ax,%ax
    name[1] = '0' + nfiles / 1000;
    3460:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    3465:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    printf(1, "writing %s\n", name);
    346a:	83 ec 04             	sub    $0x4,%esp
    name[0] = 'f';
    346d:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    3471:	f7 e6                	mul    %esi
    name[5] = '\0';
    3473:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    name[1] = '0' + nfiles / 1000;
    3477:	c1 ea 06             	shr    $0x6,%edx
    347a:	8d 42 30             	lea    0x30(%edx),%eax
    347d:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3480:	69 c2 e8 03 00 00    	imul   $0x3e8,%edx,%eax
    3486:	89 f2                	mov    %esi,%edx
    3488:	29 c2                	sub    %eax,%edx
    348a:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    348f:	f7 e2                	mul    %edx
    name[3] = '0' + (nfiles % 100) / 10;
    3491:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    3496:	c1 ea 05             	shr    $0x5,%edx
    3499:	83 c2 30             	add    $0x30,%edx
    349c:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    349f:	f7 e6                	mul    %esi
    34a1:	c1 ea 05             	shr    $0x5,%edx
    34a4:	6b c2 64             	imul   $0x64,%edx,%eax
    34a7:	89 f2                	mov    %esi,%edx
    34a9:	29 c2                	sub    %eax,%edx
    34ab:	89 d0                	mov    %edx,%eax
    34ad:	f7 e1                	mul    %ecx
    name[4] = '0' + (nfiles % 10);
    34af:	89 f0                	mov    %esi,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    34b1:	c1 ea 03             	shr    $0x3,%edx
    34b4:	83 c2 30             	add    $0x30,%edx
    34b7:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    34ba:	f7 e1                	mul    %ecx
    34bc:	89 f0                	mov    %esi,%eax
    34be:	c1 ea 03             	shr    $0x3,%edx
    34c1:	8d 14 92             	lea    (%edx,%edx,4),%edx
    34c4:	01 d2                	add    %edx,%edx
    34c6:	29 d0                	sub    %edx,%eax
    34c8:	83 c0 30             	add    $0x30,%eax
    34cb:	88 45 ac             	mov    %al,-0x54(%ebp)
    printf(1, "writing %s\n", name);
    34ce:	8d 45 a8             	lea    -0x58(%ebp),%eax
    34d1:	50                   	push   %eax
    34d2:	68 b8 4d 00 00       	push   $0x4db8
    34d7:	6a 01                	push   $0x1
    34d9:	e8 02 06 00 00       	call   3ae0 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    34de:	58                   	pop    %eax
    34df:	8d 45 a8             	lea    -0x58(%ebp),%eax
    34e2:	5a                   	pop    %edx
    34e3:	68 02 02 00 00       	push   $0x202
    34e8:	50                   	push   %eax
    34e9:	e8 d5 04 00 00       	call   39c3 <open>
    if(fd < 0){
    34ee:	83 c4 10             	add    $0x10,%esp
    int fd = open(name, O_CREATE|O_RDWR);
    34f1:	89 c7                	mov    %eax,%edi
    if(fd < 0){
    34f3:	85 c0                	test   %eax,%eax
    34f5:	78 4f                	js     3546 <fsfull+0x106>
    int total = 0;
    34f7:	31 db                	xor    %ebx,%ebx
    34f9:	eb 07                	jmp    3502 <fsfull+0xc2>
    34fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    34ff:	90                   	nop
      total += cc;
    3500:	01 c3                	add    %eax,%ebx
      int cc = write(fd, buf, 512);
    3502:	83 ec 04             	sub    $0x4,%esp
    3505:	68 00 02 00 00       	push   $0x200
    350a:	68 20 86 00 00       	push   $0x8620
    350f:	57                   	push   %edi
    3510:	e8 8e 04 00 00       	call   39a3 <write>
      if(cc < 512)
    3515:	83 c4 10             	add    $0x10,%esp
    3518:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    351d:	7f e1                	jg     3500 <fsfull+0xc0>
    printf(1, "wrote %d bytes\n", total);
    351f:	83 ec 04             	sub    $0x4,%esp
    3522:	53                   	push   %ebx
    3523:	68 d4 4d 00 00       	push   $0x4dd4
    3528:	6a 01                	push   $0x1
    352a:	e8 b1 05 00 00       	call   3ae0 <printf>
    close(fd);
    352f:	89 3c 24             	mov    %edi,(%esp)
    3532:	e8 74 04 00 00       	call   39ab <close>
    if(total == 0)
    3537:	83 c4 10             	add    $0x10,%esp
    353a:	85 db                	test   %ebx,%ebx
    353c:	74 1e                	je     355c <fsfull+0x11c>
  for(nfiles = 0; ; nfiles++){
    353e:	83 c6 01             	add    $0x1,%esi
    3541:	e9 1a ff ff ff       	jmp    3460 <fsfull+0x20>
      printf(1, "open %s failed\n", name);
    3546:	83 ec 04             	sub    $0x4,%esp
    3549:	8d 45 a8             	lea    -0x58(%ebp),%eax
    354c:	50                   	push   %eax
    354d:	68 c4 4d 00 00       	push   $0x4dc4
    3552:	6a 01                	push   $0x1
    3554:	e8 87 05 00 00       	call   3ae0 <printf>
      break;
    3559:	83 c4 10             	add    $0x10,%esp
    name[1] = '0' + nfiles / 1000;
    355c:	bf d3 4d 62 10       	mov    $0x10624dd3,%edi
    name[2] = '0' + (nfiles % 1000) / 100;
    3561:	bb 1f 85 eb 51       	mov    $0x51eb851f,%ebx
    3566:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    356d:	8d 76 00             	lea    0x0(%esi),%esi
    name[1] = '0' + nfiles / 1000;
    3570:	89 f0                	mov    %esi,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    3572:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    unlink(name);
    3577:	83 ec 0c             	sub    $0xc,%esp
    name[0] = 'f';
    357a:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    357e:	f7 e7                	mul    %edi
    name[5] = '\0';
    3580:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    name[1] = '0' + nfiles / 1000;
    3584:	c1 ea 06             	shr    $0x6,%edx
    3587:	8d 42 30             	lea    0x30(%edx),%eax
    358a:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    358d:	69 c2 e8 03 00 00    	imul   $0x3e8,%edx,%eax
    3593:	89 f2                	mov    %esi,%edx
    3595:	29 c2                	sub    %eax,%edx
    3597:	89 d0                	mov    %edx,%eax
    3599:	f7 e3                	mul    %ebx
    name[3] = '0' + (nfiles % 100) / 10;
    359b:	89 f0                	mov    %esi,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    359d:	c1 ea 05             	shr    $0x5,%edx
    35a0:	83 c2 30             	add    $0x30,%edx
    35a3:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    35a6:	f7 e3                	mul    %ebx
    35a8:	c1 ea 05             	shr    $0x5,%edx
    35ab:	6b c2 64             	imul   $0x64,%edx,%eax
    35ae:	89 f2                	mov    %esi,%edx
    35b0:	29 c2                	sub    %eax,%edx
    35b2:	89 d0                	mov    %edx,%eax
    35b4:	f7 e1                	mul    %ecx
    name[4] = '0' + (nfiles % 10);
    35b6:	89 f0                	mov    %esi,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    35b8:	c1 ea 03             	shr    $0x3,%edx
    35bb:	83 c2 30             	add    $0x30,%edx
    35be:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    35c1:	f7 e1                	mul    %ecx
    35c3:	89 f0                	mov    %esi,%eax
    nfiles--;
    35c5:	83 ee 01             	sub    $0x1,%esi
    name[4] = '0' + (nfiles % 10);
    35c8:	c1 ea 03             	shr    $0x3,%edx
    35cb:	8d 14 92             	lea    (%edx,%edx,4),%edx
    35ce:	01 d2                	add    %edx,%edx
    35d0:	29 d0                	sub    %edx,%eax
    35d2:	83 c0 30             	add    $0x30,%eax
    35d5:	88 45 ac             	mov    %al,-0x54(%ebp)
    unlink(name);
    35d8:	8d 45 a8             	lea    -0x58(%ebp),%eax
    35db:	50                   	push   %eax
    35dc:	e8 f2 03 00 00       	call   39d3 <unlink>
  while(nfiles >= 0){
    35e1:	83 c4 10             	add    $0x10,%esp
    35e4:	83 fe ff             	cmp    $0xffffffff,%esi
    35e7:	75 87                	jne    3570 <fsfull+0x130>
  printf(1, "fsfull test finished\n");
    35e9:	83 ec 08             	sub    $0x8,%esp
    35ec:	68 e4 4d 00 00       	push   $0x4de4
    35f1:	6a 01                	push   $0x1
    35f3:	e8 e8 04 00 00       	call   3ae0 <printf>
}
    35f8:	83 c4 10             	add    $0x10,%esp
    35fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
    35fe:	5b                   	pop    %ebx
    35ff:	5e                   	pop    %esi
    3600:	5f                   	pop    %edi
    3601:	5d                   	pop    %ebp
    3602:	c3                   	ret    
    3603:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    360a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00003610 <uio>:
{
    3610:	f3 0f 1e fb          	endbr32 
    3614:	55                   	push   %ebp
    3615:	89 e5                	mov    %esp,%ebp
    3617:	83 ec 10             	sub    $0x10,%esp
  printf(1, "uio test\n");
    361a:	68 fa 4d 00 00       	push   $0x4dfa
    361f:	6a 01                	push   $0x1
    3621:	e8 ba 04 00 00       	call   3ae0 <printf>
  pid = fork();
    3626:	e8 50 03 00 00       	call   397b <fork>
  if(pid == 0){
    362b:	83 c4 10             	add    $0x10,%esp
    362e:	85 c0                	test   %eax,%eax
    3630:	74 1b                	je     364d <uio+0x3d>
  } else if(pid < 0){
    3632:	78 3d                	js     3671 <uio+0x61>
  wait();
    3634:	e8 52 03 00 00       	call   398b <wait>
  printf(1, "uio test done\n");
    3639:	83 ec 08             	sub    $0x8,%esp
    363c:	68 04 4e 00 00       	push   $0x4e04
    3641:	6a 01                	push   $0x1
    3643:	e8 98 04 00 00       	call   3ae0 <printf>
}
    3648:	83 c4 10             	add    $0x10,%esp
    364b:	c9                   	leave  
    364c:	c3                   	ret    
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    364d:	b8 09 00 00 00       	mov    $0x9,%eax
    3652:	ba 70 00 00 00       	mov    $0x70,%edx
    3657:	ee                   	out    %al,(%dx)
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    3658:	ba 71 00 00 00       	mov    $0x71,%edx
    365d:	ec                   	in     (%dx),%al
    printf(1, "uio: uio succeeded; test FAILED\n");
    365e:	52                   	push   %edx
    365f:	52                   	push   %edx
    3660:	68 90 55 00 00       	push   $0x5590
    3665:	6a 01                	push   $0x1
    3667:	e8 74 04 00 00       	call   3ae0 <printf>
    exit();
    366c:	e8 12 03 00 00       	call   3983 <exit>
    printf (1, "fork failed\n");
    3671:	50                   	push   %eax
    3672:	50                   	push   %eax
    3673:	68 89 4d 00 00       	push   $0x4d89
    3678:	6a 01                	push   $0x1
    367a:	e8 61 04 00 00       	call   3ae0 <printf>
    exit();
    367f:	e8 ff 02 00 00       	call   3983 <exit>
    3684:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    368b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    368f:	90                   	nop

00003690 <argptest>:
{
    3690:	f3 0f 1e fb          	endbr32 
    3694:	55                   	push   %ebp
    3695:	89 e5                	mov    %esp,%ebp
    3697:	53                   	push   %ebx
    3698:	83 ec 0c             	sub    $0xc,%esp
  fd = open("init", O_RDONLY);
    369b:	6a 00                	push   $0x0
    369d:	68 13 4e 00 00       	push   $0x4e13
    36a2:	e8 1c 03 00 00       	call   39c3 <open>
  if (fd < 0) {
    36a7:	83 c4 10             	add    $0x10,%esp
    36aa:	85 c0                	test   %eax,%eax
    36ac:	78 39                	js     36e7 <argptest+0x57>
  read(fd, sbrk(0) - 1, -1);
    36ae:	83 ec 0c             	sub    $0xc,%esp
    36b1:	89 c3                	mov    %eax,%ebx
    36b3:	6a 00                	push   $0x0
    36b5:	e8 51 03 00 00       	call   3a0b <sbrk>
    36ba:	83 c4 0c             	add    $0xc,%esp
    36bd:	83 e8 01             	sub    $0x1,%eax
    36c0:	6a ff                	push   $0xffffffff
    36c2:	50                   	push   %eax
    36c3:	53                   	push   %ebx
    36c4:	e8 d2 02 00 00       	call   399b <read>
  close(fd);
    36c9:	89 1c 24             	mov    %ebx,(%esp)
    36cc:	e8 da 02 00 00       	call   39ab <close>
  printf(1, "arg test passed\n");
    36d1:	58                   	pop    %eax
    36d2:	5a                   	pop    %edx
    36d3:	68 25 4e 00 00       	push   $0x4e25
    36d8:	6a 01                	push   $0x1
    36da:	e8 01 04 00 00       	call   3ae0 <printf>
}
    36df:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    36e2:	83 c4 10             	add    $0x10,%esp
    36e5:	c9                   	leave  
    36e6:	c3                   	ret    
    printf(2, "open failed\n");
    36e7:	51                   	push   %ecx
    36e8:	51                   	push   %ecx
    36e9:	68 18 4e 00 00       	push   $0x4e18
    36ee:	6a 02                	push   $0x2
    36f0:	e8 eb 03 00 00       	call   3ae0 <printf>
    exit();
    36f5:	e8 89 02 00 00       	call   3983 <exit>
    36fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00003700 <rand>:
{
    3700:	f3 0f 1e fb          	endbr32 
  randstate = randstate * 1664525 + 1013904223;
    3704:	69 05 d8 5e 00 00 0d 	imul   $0x19660d,0x5ed8,%eax
    370b:	66 19 00 
    370e:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    3713:	a3 d8 5e 00 00       	mov    %eax,0x5ed8
}
    3718:	c3                   	ret    
    3719:	66 90                	xchg   %ax,%ax
    371b:	66 90                	xchg   %ax,%ax
    371d:	66 90                	xchg   %ax,%ax
    371f:	90                   	nop

00003720 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    3720:	f3 0f 1e fb          	endbr32 
    3724:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3725:	31 c0                	xor    %eax,%eax
{
    3727:	89 e5                	mov    %esp,%ebp
    3729:	53                   	push   %ebx
    372a:	8b 4d 08             	mov    0x8(%ebp),%ecx
    372d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
    3730:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    3734:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    3737:	83 c0 01             	add    $0x1,%eax
    373a:	84 d2                	test   %dl,%dl
    373c:	75 f2                	jne    3730 <strcpy+0x10>
    ;
  return os;
}
    373e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3741:	89 c8                	mov    %ecx,%eax
    3743:	c9                   	leave  
    3744:	c3                   	ret    
    3745:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    374c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003750 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3750:	f3 0f 1e fb          	endbr32 
    3754:	55                   	push   %ebp
    3755:	89 e5                	mov    %esp,%ebp
    3757:	53                   	push   %ebx
    3758:	8b 4d 08             	mov    0x8(%ebp),%ecx
    375b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    375e:	0f b6 01             	movzbl (%ecx),%eax
    3761:	0f b6 1a             	movzbl (%edx),%ebx
    3764:	84 c0                	test   %al,%al
    3766:	75 19                	jne    3781 <strcmp+0x31>
    3768:	eb 26                	jmp    3790 <strcmp+0x40>
    376a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3770:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
    3774:	83 c1 01             	add    $0x1,%ecx
    3777:	83 c2 01             	add    $0x1,%edx
  return (uchar)*p - (uchar)*q;
    377a:	0f b6 1a             	movzbl (%edx),%ebx
  while(*p && *p == *q)
    377d:	84 c0                	test   %al,%al
    377f:	74 0f                	je     3790 <strcmp+0x40>
    3781:	38 d8                	cmp    %bl,%al
    3783:	74 eb                	je     3770 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    3785:	29 d8                	sub    %ebx,%eax
}
    3787:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    378a:	c9                   	leave  
    378b:	c3                   	ret    
    378c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3790:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    3792:	29 d8                	sub    %ebx,%eax
}
    3794:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3797:	c9                   	leave  
    3798:	c3                   	ret    
    3799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000037a0 <strlen>:

uint
strlen(const char *s)
{
    37a0:	f3 0f 1e fb          	endbr32 
    37a4:	55                   	push   %ebp
    37a5:	89 e5                	mov    %esp,%ebp
    37a7:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    37aa:	80 3a 00             	cmpb   $0x0,(%edx)
    37ad:	74 21                	je     37d0 <strlen+0x30>
    37af:	31 c0                	xor    %eax,%eax
    37b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    37b8:	83 c0 01             	add    $0x1,%eax
    37bb:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    37bf:	89 c1                	mov    %eax,%ecx
    37c1:	75 f5                	jne    37b8 <strlen+0x18>
    ;
  return n;
}
    37c3:	89 c8                	mov    %ecx,%eax
    37c5:	5d                   	pop    %ebp
    37c6:	c3                   	ret    
    37c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    37ce:	66 90                	xchg   %ax,%ax
  for(n = 0; s[n]; n++)
    37d0:	31 c9                	xor    %ecx,%ecx
}
    37d2:	5d                   	pop    %ebp
    37d3:	89 c8                	mov    %ecx,%eax
    37d5:	c3                   	ret    
    37d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    37dd:	8d 76 00             	lea    0x0(%esi),%esi

000037e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    37e0:	f3 0f 1e fb          	endbr32 
    37e4:	55                   	push   %ebp
    37e5:	89 e5                	mov    %esp,%ebp
    37e7:	57                   	push   %edi
    37e8:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    37eb:	8b 4d 10             	mov    0x10(%ebp),%ecx
    37ee:	8b 45 0c             	mov    0xc(%ebp),%eax
    37f1:	89 d7                	mov    %edx,%edi
    37f3:	fc                   	cld    
    37f4:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    37f6:	8b 7d fc             	mov    -0x4(%ebp),%edi
    37f9:	89 d0                	mov    %edx,%eax
    37fb:	c9                   	leave  
    37fc:	c3                   	ret    
    37fd:	8d 76 00             	lea    0x0(%esi),%esi

00003800 <strchr>:

char*
strchr(const char *s, char c)
{
    3800:	f3 0f 1e fb          	endbr32 
    3804:	55                   	push   %ebp
    3805:	89 e5                	mov    %esp,%ebp
    3807:	8b 45 08             	mov    0x8(%ebp),%eax
    380a:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    380e:	0f b6 10             	movzbl (%eax),%edx
    3811:	84 d2                	test   %dl,%dl
    3813:	75 16                	jne    382b <strchr+0x2b>
    3815:	eb 21                	jmp    3838 <strchr+0x38>
    3817:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    381e:	66 90                	xchg   %ax,%ax
    3820:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    3824:	83 c0 01             	add    $0x1,%eax
    3827:	84 d2                	test   %dl,%dl
    3829:	74 0d                	je     3838 <strchr+0x38>
    if(*s == c)
    382b:	38 d1                	cmp    %dl,%cl
    382d:	75 f1                	jne    3820 <strchr+0x20>
      return (char*)s;
  return 0;
}
    382f:	5d                   	pop    %ebp
    3830:	c3                   	ret    
    3831:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    3838:	31 c0                	xor    %eax,%eax
}
    383a:	5d                   	pop    %ebp
    383b:	c3                   	ret    
    383c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003840 <gets>:

char*
gets(char *buf, int max)
{
    3840:	f3 0f 1e fb          	endbr32 
    3844:	55                   	push   %ebp
    3845:	89 e5                	mov    %esp,%ebp
    3847:	57                   	push   %edi
    3848:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3849:	31 f6                	xor    %esi,%esi
{
    384b:	53                   	push   %ebx
    384c:	89 f3                	mov    %esi,%ebx
    384e:	83 ec 1c             	sub    $0x1c,%esp
    3851:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    3854:	eb 33                	jmp    3889 <gets+0x49>
    3856:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    385d:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    3860:	83 ec 04             	sub    $0x4,%esp
    3863:	8d 45 e7             	lea    -0x19(%ebp),%eax
    3866:	6a 01                	push   $0x1
    3868:	50                   	push   %eax
    3869:	6a 00                	push   $0x0
    386b:	e8 2b 01 00 00       	call   399b <read>
    if(cc < 1)
    3870:	83 c4 10             	add    $0x10,%esp
    3873:	85 c0                	test   %eax,%eax
    3875:	7e 1c                	jle    3893 <gets+0x53>
      break;
    buf[i++] = c;
    3877:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    if(c == '\n' || c == '\r')
    387b:	83 c7 01             	add    $0x1,%edi
    buf[i++] = c;
    387e:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    3881:	3c 0a                	cmp    $0xa,%al
    3883:	74 23                	je     38a8 <gets+0x68>
    3885:	3c 0d                	cmp    $0xd,%al
    3887:	74 1f                	je     38a8 <gets+0x68>
  for(i=0; i+1 < max; ){
    3889:	83 c3 01             	add    $0x1,%ebx
    buf[i++] = c;
    388c:	89 fe                	mov    %edi,%esi
  for(i=0; i+1 < max; ){
    388e:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    3891:	7c cd                	jl     3860 <gets+0x20>
    3893:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    3895:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    3898:	c6 03 00             	movb   $0x0,(%ebx)
}
    389b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    389e:	5b                   	pop    %ebx
    389f:	5e                   	pop    %esi
    38a0:	5f                   	pop    %edi
    38a1:	5d                   	pop    %ebp
    38a2:	c3                   	ret    
    38a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    38a7:	90                   	nop
  buf[i] = '\0';
    38a8:	8b 75 08             	mov    0x8(%ebp),%esi
}
    38ab:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    38ae:	01 de                	add    %ebx,%esi
    38b0:	89 f3                	mov    %esi,%ebx
    38b2:	c6 03 00             	movb   $0x0,(%ebx)
}
    38b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
    38b8:	5b                   	pop    %ebx
    38b9:	5e                   	pop    %esi
    38ba:	5f                   	pop    %edi
    38bb:	5d                   	pop    %ebp
    38bc:	c3                   	ret    
    38bd:	8d 76 00             	lea    0x0(%esi),%esi

000038c0 <stat>:

int
stat(const char *n, struct stat *st)
{
    38c0:	f3 0f 1e fb          	endbr32 
    38c4:	55                   	push   %ebp
    38c5:	89 e5                	mov    %esp,%ebp
    38c7:	56                   	push   %esi
    38c8:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    38c9:	83 ec 08             	sub    $0x8,%esp
    38cc:	6a 00                	push   $0x0
    38ce:	ff 75 08             	pushl  0x8(%ebp)
    38d1:	e8 ed 00 00 00       	call   39c3 <open>
  if(fd < 0)
    38d6:	83 c4 10             	add    $0x10,%esp
    38d9:	85 c0                	test   %eax,%eax
    38db:	78 2b                	js     3908 <stat+0x48>
    return -1;
  r = fstat(fd, st);
    38dd:	83 ec 08             	sub    $0x8,%esp
    38e0:	ff 75 0c             	pushl  0xc(%ebp)
    38e3:	89 c3                	mov    %eax,%ebx
    38e5:	50                   	push   %eax
    38e6:	e8 f0 00 00 00       	call   39db <fstat>
  close(fd);
    38eb:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    38ee:	89 c6                	mov    %eax,%esi
  close(fd);
    38f0:	e8 b6 00 00 00       	call   39ab <close>
  return r;
    38f5:	83 c4 10             	add    $0x10,%esp
}
    38f8:	8d 65 f8             	lea    -0x8(%ebp),%esp
    38fb:	89 f0                	mov    %esi,%eax
    38fd:	5b                   	pop    %ebx
    38fe:	5e                   	pop    %esi
    38ff:	5d                   	pop    %ebp
    3900:	c3                   	ret    
    3901:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
    3908:	be ff ff ff ff       	mov    $0xffffffff,%esi
    390d:	eb e9                	jmp    38f8 <stat+0x38>
    390f:	90                   	nop

00003910 <atoi>:

int
atoi(const char *s)
{
    3910:	f3 0f 1e fb          	endbr32 
    3914:	55                   	push   %ebp
    3915:	89 e5                	mov    %esp,%ebp
    3917:	53                   	push   %ebx
    3918:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    391b:	0f be 02             	movsbl (%edx),%eax
    391e:	8d 48 d0             	lea    -0x30(%eax),%ecx
    3921:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    3924:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    3929:	77 1a                	ja     3945 <atoi+0x35>
    392b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    392f:	90                   	nop
    n = n*10 + *s++ - '0';
    3930:	83 c2 01             	add    $0x1,%edx
    3933:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    3936:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    393a:	0f be 02             	movsbl (%edx),%eax
    393d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    3940:	80 fb 09             	cmp    $0x9,%bl
    3943:	76 eb                	jbe    3930 <atoi+0x20>
  return n;
}
    3945:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3948:	89 c8                	mov    %ecx,%eax
    394a:	c9                   	leave  
    394b:	c3                   	ret    
    394c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003950 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3950:	f3 0f 1e fb          	endbr32 
    3954:	55                   	push   %ebp
    3955:	89 e5                	mov    %esp,%ebp
    3957:	57                   	push   %edi
    3958:	8b 45 10             	mov    0x10(%ebp),%eax
    395b:	8b 55 08             	mov    0x8(%ebp),%edx
    395e:	56                   	push   %esi
    395f:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    3962:	85 c0                	test   %eax,%eax
    3964:	7e 0f                	jle    3975 <memmove+0x25>
    3966:	01 d0                	add    %edx,%eax
  dst = vdst;
    3968:	89 d7                	mov    %edx,%edi
    396a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
    3970:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    3971:	39 f8                	cmp    %edi,%eax
    3973:	75 fb                	jne    3970 <memmove+0x20>
  return vdst;
}
    3975:	5e                   	pop    %esi
    3976:	89 d0                	mov    %edx,%eax
    3978:	5f                   	pop    %edi
    3979:	5d                   	pop    %ebp
    397a:	c3                   	ret    

0000397b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    397b:	b8 01 00 00 00       	mov    $0x1,%eax
    3980:	cd 40                	int    $0x40
    3982:	c3                   	ret    

00003983 <exit>:
SYSCALL(exit)
    3983:	b8 02 00 00 00       	mov    $0x2,%eax
    3988:	cd 40                	int    $0x40
    398a:	c3                   	ret    

0000398b <wait>:
SYSCALL(wait)
    398b:	b8 03 00 00 00       	mov    $0x3,%eax
    3990:	cd 40                	int    $0x40
    3992:	c3                   	ret    

00003993 <pipe>:
SYSCALL(pipe)
    3993:	b8 04 00 00 00       	mov    $0x4,%eax
    3998:	cd 40                	int    $0x40
    399a:	c3                   	ret    

0000399b <read>:
SYSCALL(read)
    399b:	b8 05 00 00 00       	mov    $0x5,%eax
    39a0:	cd 40                	int    $0x40
    39a2:	c3                   	ret    

000039a3 <write>:
SYSCALL(write)
    39a3:	b8 10 00 00 00       	mov    $0x10,%eax
    39a8:	cd 40                	int    $0x40
    39aa:	c3                   	ret    

000039ab <close>:
SYSCALL(close)
    39ab:	b8 15 00 00 00       	mov    $0x15,%eax
    39b0:	cd 40                	int    $0x40
    39b2:	c3                   	ret    

000039b3 <kill>:
SYSCALL(kill)
    39b3:	b8 06 00 00 00       	mov    $0x6,%eax
    39b8:	cd 40                	int    $0x40
    39ba:	c3                   	ret    

000039bb <exec>:
SYSCALL(exec)
    39bb:	b8 07 00 00 00       	mov    $0x7,%eax
    39c0:	cd 40                	int    $0x40
    39c2:	c3                   	ret    

000039c3 <open>:
SYSCALL(open)
    39c3:	b8 0f 00 00 00       	mov    $0xf,%eax
    39c8:	cd 40                	int    $0x40
    39ca:	c3                   	ret    

000039cb <mknod>:
SYSCALL(mknod)
    39cb:	b8 11 00 00 00       	mov    $0x11,%eax
    39d0:	cd 40                	int    $0x40
    39d2:	c3                   	ret    

000039d3 <unlink>:
SYSCALL(unlink)
    39d3:	b8 12 00 00 00       	mov    $0x12,%eax
    39d8:	cd 40                	int    $0x40
    39da:	c3                   	ret    

000039db <fstat>:
SYSCALL(fstat)
    39db:	b8 08 00 00 00       	mov    $0x8,%eax
    39e0:	cd 40                	int    $0x40
    39e2:	c3                   	ret    

000039e3 <link>:
SYSCALL(link)
    39e3:	b8 13 00 00 00       	mov    $0x13,%eax
    39e8:	cd 40                	int    $0x40
    39ea:	c3                   	ret    

000039eb <mkdir>:
SYSCALL(mkdir)
    39eb:	b8 14 00 00 00       	mov    $0x14,%eax
    39f0:	cd 40                	int    $0x40
    39f2:	c3                   	ret    

000039f3 <chdir>:
SYSCALL(chdir)
    39f3:	b8 09 00 00 00       	mov    $0x9,%eax
    39f8:	cd 40                	int    $0x40
    39fa:	c3                   	ret    

000039fb <dup>:
SYSCALL(dup)
    39fb:	b8 0a 00 00 00       	mov    $0xa,%eax
    3a00:	cd 40                	int    $0x40
    3a02:	c3                   	ret    

00003a03 <getpid>:
SYSCALL(getpid)
    3a03:	b8 0b 00 00 00       	mov    $0xb,%eax
    3a08:	cd 40                	int    $0x40
    3a0a:	c3                   	ret    

00003a0b <sbrk>:
SYSCALL(sbrk)
    3a0b:	b8 0c 00 00 00       	mov    $0xc,%eax
    3a10:	cd 40                	int    $0x40
    3a12:	c3                   	ret    

00003a13 <sleep>:
SYSCALL(sleep)
    3a13:	b8 0d 00 00 00       	mov    $0xd,%eax
    3a18:	cd 40                	int    $0x40
    3a1a:	c3                   	ret    

00003a1b <uptime>:
SYSCALL(uptime)
    3a1b:	b8 0e 00 00 00       	mov    $0xe,%eax
    3a20:	cd 40                	int    $0x40
    3a22:	c3                   	ret    

00003a23 <getreadcount>:
SYSCALL(getreadcount)#new syscall
    3a23:	b8 16 00 00 00       	mov    $0x16,%eax
    3a28:	cd 40                	int    $0x40
    3a2a:	c3                   	ret    
    3a2b:	66 90                	xchg   %ax,%ax
    3a2d:	66 90                	xchg   %ax,%ax
    3a2f:	90                   	nop

00003a30 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3a30:	55                   	push   %ebp
    3a31:	89 e5                	mov    %esp,%ebp
    3a33:	57                   	push   %edi
    3a34:	56                   	push   %esi
    3a35:	53                   	push   %ebx
    3a36:	83 ec 3c             	sub    $0x3c,%esp
    3a39:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    3a3c:	89 d1                	mov    %edx,%ecx
{
    3a3e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    3a41:	85 d2                	test   %edx,%edx
    3a43:	0f 89 7f 00 00 00    	jns    3ac8 <printint+0x98>
    3a49:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    3a4d:	74 79                	je     3ac8 <printint+0x98>
    neg = 1;
    3a4f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    3a56:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    3a58:	31 db                	xor    %ebx,%ebx
    3a5a:	8d 75 d7             	lea    -0x29(%ebp),%esi
    3a5d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    3a60:	89 c8                	mov    %ecx,%eax
    3a62:	31 d2                	xor    %edx,%edx
    3a64:	89 cf                	mov    %ecx,%edi
    3a66:	f7 75 c4             	divl   -0x3c(%ebp)
    3a69:	0f b6 92 e8 55 00 00 	movzbl 0x55e8(%edx),%edx
    3a70:	89 45 c0             	mov    %eax,-0x40(%ebp)
    3a73:	89 d8                	mov    %ebx,%eax
    3a75:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    3a78:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    3a7b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    3a7e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    3a81:	76 dd                	jbe    3a60 <printint+0x30>
  if(neg)
    3a83:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    3a86:	85 c9                	test   %ecx,%ecx
    3a88:	74 0c                	je     3a96 <printint+0x66>
    buf[i++] = '-';
    3a8a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    3a8f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    3a91:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    3a96:	8b 7d b8             	mov    -0x48(%ebp),%edi
    3a99:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    3a9d:	eb 07                	jmp    3aa6 <printint+0x76>
    3a9f:	90                   	nop
    putc(fd, buf[i]);
    3aa0:	0f b6 13             	movzbl (%ebx),%edx
    3aa3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    3aa6:	83 ec 04             	sub    $0x4,%esp
    3aa9:	88 55 d7             	mov    %dl,-0x29(%ebp)
    3aac:	6a 01                	push   $0x1
    3aae:	56                   	push   %esi
    3aaf:	57                   	push   %edi
    3ab0:	e8 ee fe ff ff       	call   39a3 <write>
  while(--i >= 0)
    3ab5:	83 c4 10             	add    $0x10,%esp
    3ab8:	39 de                	cmp    %ebx,%esi
    3aba:	75 e4                	jne    3aa0 <printint+0x70>
}
    3abc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3abf:	5b                   	pop    %ebx
    3ac0:	5e                   	pop    %esi
    3ac1:	5f                   	pop    %edi
    3ac2:	5d                   	pop    %ebp
    3ac3:	c3                   	ret    
    3ac4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    3ac8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    3acf:	eb 87                	jmp    3a58 <printint+0x28>
    3ad1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3ad8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3adf:	90                   	nop

00003ae0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    3ae0:	f3 0f 1e fb          	endbr32 
    3ae4:	55                   	push   %ebp
    3ae5:	89 e5                	mov    %esp,%ebp
    3ae7:	57                   	push   %edi
    3ae8:	56                   	push   %esi
    3ae9:	53                   	push   %ebx
    3aea:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3aed:	8b 75 0c             	mov    0xc(%ebp),%esi
    3af0:	0f b6 1e             	movzbl (%esi),%ebx
    3af3:	84 db                	test   %bl,%bl
    3af5:	0f 84 b4 00 00 00    	je     3baf <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
    3afb:	8d 45 10             	lea    0x10(%ebp),%eax
    3afe:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    3b01:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    3b04:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
    3b06:	89 45 d0             	mov    %eax,-0x30(%ebp)
    3b09:	eb 33                	jmp    3b3e <printf+0x5e>
    3b0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3b0f:	90                   	nop
    3b10:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    3b13:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    3b18:	83 f8 25             	cmp    $0x25,%eax
    3b1b:	74 17                	je     3b34 <printf+0x54>
  write(fd, &c, 1);
    3b1d:	83 ec 04             	sub    $0x4,%esp
    3b20:	88 5d e7             	mov    %bl,-0x19(%ebp)
    3b23:	6a 01                	push   $0x1
    3b25:	57                   	push   %edi
    3b26:	ff 75 08             	pushl  0x8(%ebp)
    3b29:	e8 75 fe ff ff       	call   39a3 <write>
    3b2e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    3b31:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    3b34:	0f b6 1e             	movzbl (%esi),%ebx
    3b37:	83 c6 01             	add    $0x1,%esi
    3b3a:	84 db                	test   %bl,%bl
    3b3c:	74 71                	je     3baf <printf+0xcf>
    c = fmt[i] & 0xff;
    3b3e:	0f be cb             	movsbl %bl,%ecx
    3b41:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    3b44:	85 d2                	test   %edx,%edx
    3b46:	74 c8                	je     3b10 <printf+0x30>
      }
    } else if(state == '%'){
    3b48:	83 fa 25             	cmp    $0x25,%edx
    3b4b:	75 e7                	jne    3b34 <printf+0x54>
      if(c == 'd'){
    3b4d:	83 f8 64             	cmp    $0x64,%eax
    3b50:	0f 84 9a 00 00 00    	je     3bf0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    3b56:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    3b5c:	83 f9 70             	cmp    $0x70,%ecx
    3b5f:	74 5f                	je     3bc0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    3b61:	83 f8 73             	cmp    $0x73,%eax
    3b64:	0f 84 d6 00 00 00    	je     3c40 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3b6a:	83 f8 63             	cmp    $0x63,%eax
    3b6d:	0f 84 8d 00 00 00    	je     3c00 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    3b73:	83 f8 25             	cmp    $0x25,%eax
    3b76:	0f 84 b4 00 00 00    	je     3c30 <printf+0x150>
  write(fd, &c, 1);
    3b7c:	83 ec 04             	sub    $0x4,%esp
    3b7f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    3b83:	6a 01                	push   $0x1
    3b85:	57                   	push   %edi
    3b86:	ff 75 08             	pushl  0x8(%ebp)
    3b89:	e8 15 fe ff ff       	call   39a3 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    3b8e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    3b91:	83 c4 0c             	add    $0xc,%esp
    3b94:	6a 01                	push   $0x1
  for(i = 0; fmt[i]; i++){
    3b96:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    3b99:	57                   	push   %edi
    3b9a:	ff 75 08             	pushl  0x8(%ebp)
    3b9d:	e8 01 fe ff ff       	call   39a3 <write>
  for(i = 0; fmt[i]; i++){
    3ba2:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
    3ba6:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    3ba9:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    3bab:	84 db                	test   %bl,%bl
    3bad:	75 8f                	jne    3b3e <printf+0x5e>
    }
  }
}
    3baf:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3bb2:	5b                   	pop    %ebx
    3bb3:	5e                   	pop    %esi
    3bb4:	5f                   	pop    %edi
    3bb5:	5d                   	pop    %ebp
    3bb6:	c3                   	ret    
    3bb7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3bbe:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
    3bc0:	83 ec 0c             	sub    $0xc,%esp
    3bc3:	b9 10 00 00 00       	mov    $0x10,%ecx
    3bc8:	6a 00                	push   $0x0
    3bca:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    3bcd:	8b 45 08             	mov    0x8(%ebp),%eax
    3bd0:	8b 13                	mov    (%ebx),%edx
    3bd2:	e8 59 fe ff ff       	call   3a30 <printint>
        ap++;
    3bd7:	89 d8                	mov    %ebx,%eax
    3bd9:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3bdc:	31 d2                	xor    %edx,%edx
        ap++;
    3bde:	83 c0 04             	add    $0x4,%eax
    3be1:	89 45 d0             	mov    %eax,-0x30(%ebp)
    3be4:	e9 4b ff ff ff       	jmp    3b34 <printf+0x54>
    3be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
    3bf0:	83 ec 0c             	sub    $0xc,%esp
    3bf3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    3bf8:	6a 01                	push   $0x1
    3bfa:	eb ce                	jmp    3bca <printf+0xea>
    3bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
    3c00:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    3c03:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    3c06:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
    3c08:	6a 01                	push   $0x1
        ap++;
    3c0a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    3c0d:	57                   	push   %edi
    3c0e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
    3c11:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    3c14:	e8 8a fd ff ff       	call   39a3 <write>
        ap++;
    3c19:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    3c1c:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3c1f:	31 d2                	xor    %edx,%edx
    3c21:	e9 0e ff ff ff       	jmp    3b34 <printf+0x54>
    3c26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3c2d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
    3c30:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    3c33:	83 ec 04             	sub    $0x4,%esp
    3c36:	e9 59 ff ff ff       	jmp    3b94 <printf+0xb4>
    3c3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3c3f:	90                   	nop
        s = (char*)*ap;
    3c40:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3c43:	8b 18                	mov    (%eax),%ebx
        ap++;
    3c45:	83 c0 04             	add    $0x4,%eax
    3c48:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    3c4b:	85 db                	test   %ebx,%ebx
    3c4d:	74 17                	je     3c66 <printf+0x186>
        while(*s != 0){
    3c4f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    3c52:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    3c54:	84 c0                	test   %al,%al
    3c56:	0f 84 d8 fe ff ff    	je     3b34 <printf+0x54>
    3c5c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    3c5f:	89 de                	mov    %ebx,%esi
    3c61:	8b 5d 08             	mov    0x8(%ebp),%ebx
    3c64:	eb 1a                	jmp    3c80 <printf+0x1a0>
          s = "(null)";
    3c66:	bb de 55 00 00       	mov    $0x55de,%ebx
        while(*s != 0){
    3c6b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    3c6e:	b8 28 00 00 00       	mov    $0x28,%eax
    3c73:	89 de                	mov    %ebx,%esi
    3c75:	8b 5d 08             	mov    0x8(%ebp),%ebx
    3c78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3c7f:	90                   	nop
  write(fd, &c, 1);
    3c80:	83 ec 04             	sub    $0x4,%esp
          s++;
    3c83:	83 c6 01             	add    $0x1,%esi
    3c86:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    3c89:	6a 01                	push   $0x1
    3c8b:	57                   	push   %edi
    3c8c:	53                   	push   %ebx
    3c8d:	e8 11 fd ff ff       	call   39a3 <write>
        while(*s != 0){
    3c92:	0f b6 06             	movzbl (%esi),%eax
    3c95:	83 c4 10             	add    $0x10,%esp
    3c98:	84 c0                	test   %al,%al
    3c9a:	75 e4                	jne    3c80 <printf+0x1a0>
      state = 0;
    3c9c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    3c9f:	31 d2                	xor    %edx,%edx
    3ca1:	e9 8e fe ff ff       	jmp    3b34 <printf+0x54>
    3ca6:	66 90                	xchg   %ax,%ax
    3ca8:	66 90                	xchg   %ax,%ax
    3caa:	66 90                	xchg   %ax,%ax
    3cac:	66 90                	xchg   %ax,%ax
    3cae:	66 90                	xchg   %ax,%ax

00003cb0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3cb0:	f3 0f 1e fb          	endbr32 
    3cb4:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3cb5:	a1 a0 a6 00 00       	mov    0xa6a0,%eax
{
    3cba:	89 e5                	mov    %esp,%ebp
    3cbc:	57                   	push   %edi
    3cbd:	56                   	push   %esi
    3cbe:	53                   	push   %ebx
    3cbf:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    3cc2:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3cc5:	8d 76 00             	lea    0x0(%esi),%esi
    3cc8:	89 c2                	mov    %eax,%edx
    3cca:	8b 00                	mov    (%eax),%eax
    3ccc:	39 ca                	cmp    %ecx,%edx
    3cce:	73 30                	jae    3d00 <free+0x50>
    3cd0:	39 c1                	cmp    %eax,%ecx
    3cd2:	72 04                	jb     3cd8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3cd4:	39 c2                	cmp    %eax,%edx
    3cd6:	72 f0                	jb     3cc8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    3cd8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3cdb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    3cde:	39 f8                	cmp    %edi,%eax
    3ce0:	74 30                	je     3d12 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    3ce2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    3ce5:	8b 42 04             	mov    0x4(%edx),%eax
    3ce8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    3ceb:	39 f1                	cmp    %esi,%ecx
    3ced:	74 3a                	je     3d29 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    3cef:	89 0a                	mov    %ecx,(%edx)
  freep = p;
}
    3cf1:	5b                   	pop    %ebx
  freep = p;
    3cf2:	89 15 a0 a6 00 00    	mov    %edx,0xa6a0
}
    3cf8:	5e                   	pop    %esi
    3cf9:	5f                   	pop    %edi
    3cfa:	5d                   	pop    %ebp
    3cfb:	c3                   	ret    
    3cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3d00:	39 c2                	cmp    %eax,%edx
    3d02:	72 c4                	jb     3cc8 <free+0x18>
    3d04:	39 c1                	cmp    %eax,%ecx
    3d06:	73 c0                	jae    3cc8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    3d08:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3d0b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    3d0e:	39 f8                	cmp    %edi,%eax
    3d10:	75 d0                	jne    3ce2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    3d12:	03 70 04             	add    0x4(%eax),%esi
    3d15:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3d18:	8b 02                	mov    (%edx),%eax
    3d1a:	8b 00                	mov    (%eax),%eax
    3d1c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    3d1f:	8b 42 04             	mov    0x4(%edx),%eax
    3d22:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    3d25:	39 f1                	cmp    %esi,%ecx
    3d27:	75 c6                	jne    3cef <free+0x3f>
    p->s.size += bp->s.size;
    3d29:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    3d2c:	89 15 a0 a6 00 00    	mov    %edx,0xa6a0
    p->s.size += bp->s.size;
    3d32:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    3d35:	8b 43 f8             	mov    -0x8(%ebx),%eax
    3d38:	89 02                	mov    %eax,(%edx)
}
    3d3a:	5b                   	pop    %ebx
    3d3b:	5e                   	pop    %esi
    3d3c:	5f                   	pop    %edi
    3d3d:	5d                   	pop    %ebp
    3d3e:	c3                   	ret    
    3d3f:	90                   	nop

00003d40 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3d40:	f3 0f 1e fb          	endbr32 
    3d44:	55                   	push   %ebp
    3d45:	89 e5                	mov    %esp,%ebp
    3d47:	57                   	push   %edi
    3d48:	56                   	push   %esi
    3d49:	53                   	push   %ebx
    3d4a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3d4d:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    3d50:	8b 3d a0 a6 00 00    	mov    0xa6a0,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3d56:	8d 70 07             	lea    0x7(%eax),%esi
    3d59:	c1 ee 03             	shr    $0x3,%esi
    3d5c:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    3d5f:	85 ff                	test   %edi,%edi
    3d61:	0f 84 a9 00 00 00    	je     3e10 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3d67:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
    3d69:	8b 48 04             	mov    0x4(%eax),%ecx
    3d6c:	39 f1                	cmp    %esi,%ecx
    3d6e:	73 6d                	jae    3ddd <malloc+0x9d>
    3d70:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    3d76:	bb 00 10 00 00       	mov    $0x1000,%ebx
    3d7b:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    3d7e:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
    3d85:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    3d88:	eb 17                	jmp    3da1 <malloc+0x61>
    3d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3d90:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
    3d92:	8b 4a 04             	mov    0x4(%edx),%ecx
    3d95:	39 f1                	cmp    %esi,%ecx
    3d97:	73 4f                	jae    3de8 <malloc+0xa8>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3d99:	8b 3d a0 a6 00 00    	mov    0xa6a0,%edi
    3d9f:	89 d0                	mov    %edx,%eax
    3da1:	39 c7                	cmp    %eax,%edi
    3da3:	75 eb                	jne    3d90 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
    3da5:	83 ec 0c             	sub    $0xc,%esp
    3da8:	ff 75 e4             	pushl  -0x1c(%ebp)
    3dab:	e8 5b fc ff ff       	call   3a0b <sbrk>
  if(p == (char*)-1)
    3db0:	83 c4 10             	add    $0x10,%esp
    3db3:	83 f8 ff             	cmp    $0xffffffff,%eax
    3db6:	74 1b                	je     3dd3 <malloc+0x93>
  hp->s.size = nu;
    3db8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    3dbb:	83 ec 0c             	sub    $0xc,%esp
    3dbe:	83 c0 08             	add    $0x8,%eax
    3dc1:	50                   	push   %eax
    3dc2:	e8 e9 fe ff ff       	call   3cb0 <free>
  return freep;
    3dc7:	a1 a0 a6 00 00       	mov    0xa6a0,%eax
      if((p = morecore(nunits)) == 0)
    3dcc:	83 c4 10             	add    $0x10,%esp
    3dcf:	85 c0                	test   %eax,%eax
    3dd1:	75 bd                	jne    3d90 <malloc+0x50>
        return 0;
  }
}
    3dd3:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    3dd6:	31 c0                	xor    %eax,%eax
}
    3dd8:	5b                   	pop    %ebx
    3dd9:	5e                   	pop    %esi
    3dda:	5f                   	pop    %edi
    3ddb:	5d                   	pop    %ebp
    3ddc:	c3                   	ret    
    if(p->s.size >= nunits){
    3ddd:	89 c2                	mov    %eax,%edx
    3ddf:	89 f8                	mov    %edi,%eax
    3de1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    3de8:	39 ce                	cmp    %ecx,%esi
    3dea:	74 54                	je     3e40 <malloc+0x100>
        p->s.size -= nunits;
    3dec:	29 f1                	sub    %esi,%ecx
    3dee:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
    3df1:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
    3df4:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
    3df7:	a3 a0 a6 00 00       	mov    %eax,0xa6a0
}
    3dfc:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    3dff:	8d 42 08             	lea    0x8(%edx),%eax
}
    3e02:	5b                   	pop    %ebx
    3e03:	5e                   	pop    %esi
    3e04:	5f                   	pop    %edi
    3e05:	5d                   	pop    %ebp
    3e06:	c3                   	ret    
    3e07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3e0e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    3e10:	c7 05 a0 a6 00 00 a4 	movl   $0xa6a4,0xa6a0
    3e17:	a6 00 00 
    base.s.size = 0;
    3e1a:	bf a4 a6 00 00       	mov    $0xa6a4,%edi
    base.s.ptr = freep = prevp = &base;
    3e1f:	c7 05 a4 a6 00 00 a4 	movl   $0xa6a4,0xa6a4
    3e26:	a6 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3e29:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
    3e2b:	c7 05 a8 a6 00 00 00 	movl   $0x0,0xa6a8
    3e32:	00 00 00 
    if(p->s.size >= nunits){
    3e35:	e9 36 ff ff ff       	jmp    3d70 <malloc+0x30>
    3e3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    3e40:	8b 0a                	mov    (%edx),%ecx
    3e42:	89 08                	mov    %ecx,(%eax)
    3e44:	eb b1                	jmp    3df7 <malloc+0xb7>
