
_sh：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}

int
main(void)
{
       0:	f3 0f 1e fb          	endbr32 
       4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       8:	83 e4 f0             	and    $0xfffffff0,%esp
       b:	ff 71 fc             	pushl  -0x4(%ecx)
       e:	55                   	push   %ebp
       f:	89 e5                	mov    %esp,%ebp
      11:	51                   	push   %ecx
      12:	83 ec 04             	sub    $0x4,%esp
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
      15:	eb 12                	jmp    29 <main+0x29>
      17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      1e:	66 90                	xchg   %ax,%ax
    if(fd >= 3){
      20:	83 f8 02             	cmp    $0x2,%eax
      23:	0f 8f 91 00 00 00    	jg     ba <main+0xba>
  while((fd = open("console", O_RDWR)) >= 0){
      29:	83 ec 08             	sub    $0x8,%esp
      2c:	6a 02                	push   $0x2
      2e:	68 49 14 00 00       	push   $0x1449
      33:	e8 eb 0e 00 00       	call   f23 <open>
      38:	83 c4 10             	add    $0x10,%esp
      3b:	85 c0                	test   %eax,%eax
      3d:	79 e1                	jns    20 <main+0x20>
      3f:	eb 2e                	jmp    6f <main+0x6f>
      41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      48:	80 3d a2 1a 00 00 20 	cmpb   $0x20,0x1aa2
      4f:	0f 84 88 00 00 00    	je     dd <main+0xdd>
      55:	8d 76 00             	lea    0x0(%esi),%esi
int
fork1(void)
{
  int pid;

  pid = fork();
      58:	e8 7e 0e 00 00       	call   edb <fork>
  if(pid == -1)
      5d:	83 f8 ff             	cmp    $0xffffffff,%eax
      60:	0f 84 c1 00 00 00    	je     127 <main+0x127>
    if(fork1() == 0)
      66:	85 c0                	test   %eax,%eax
      68:	74 5e                	je     c8 <main+0xc8>
    wait();
      6a:	e8 7c 0e 00 00       	call   eeb <wait>
  printf(2, "$ ");
      6f:	83 ec 08             	sub    $0x8,%esp
      72:	68 a8 13 00 00       	push   $0x13a8
      77:	6a 02                	push   $0x2
      79:	e8 c2 0f 00 00       	call   1040 <printf>
  memset(buf, 0, nbuf);
      7e:	83 c4 0c             	add    $0xc,%esp
      81:	6a 64                	push   $0x64
      83:	6a 00                	push   $0x0
      85:	68 a0 1a 00 00       	push   $0x1aa0
      8a:	e8 b1 0c 00 00       	call   d40 <memset>
  gets(buf, nbuf);
      8f:	58                   	pop    %eax
      90:	5a                   	pop    %edx
      91:	6a 64                	push   $0x64
      93:	68 a0 1a 00 00       	push   $0x1aa0
      98:	e8 03 0d 00 00       	call   da0 <gets>
  if(buf[0] == 0) // EOF
      9d:	0f b6 05 a0 1a 00 00 	movzbl 0x1aa0,%eax
      a4:	83 c4 10             	add    $0x10,%esp
      a7:	84 c0                	test   %al,%al
      a9:	74 77                	je     122 <main+0x122>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      ab:	3c 63                	cmp    $0x63,%al
      ad:	75 a9                	jne    58 <main+0x58>
      af:	80 3d a1 1a 00 00 64 	cmpb   $0x64,0x1aa1
      b6:	75 a0                	jne    58 <main+0x58>
      b8:	eb 8e                	jmp    48 <main+0x48>
      close(fd);
      ba:	83 ec 0c             	sub    $0xc,%esp
      bd:	50                   	push   %eax
      be:	e8 48 0e 00 00       	call   f0b <close>
      break;
      c3:	83 c4 10             	add    $0x10,%esp
      c6:	eb a7                	jmp    6f <main+0x6f>
      runcmd(parsecmd(buf));
      c8:	83 ec 0c             	sub    $0xc,%esp
      cb:	68 a0 1a 00 00       	push   $0x1aa0
      d0:	e8 3b 0b 00 00       	call   c10 <parsecmd>
      d5:	89 04 24             	mov    %eax,(%esp)
      d8:	e8 03 01 00 00       	call   1e0 <runcmd>
      buf[strlen(buf)-1] = 0;  // chop \n
      dd:	83 ec 0c             	sub    $0xc,%esp
      e0:	68 a0 1a 00 00       	push   $0x1aa0
      e5:	e8 16 0c 00 00       	call   d00 <strlen>
      if(chdir(buf+3) < 0)
      ea:	c7 04 24 a3 1a 00 00 	movl   $0x1aa3,(%esp)
      buf[strlen(buf)-1] = 0;  // chop \n
      f1:	c6 80 9f 1a 00 00 00 	movb   $0x0,0x1a9f(%eax)
      if(chdir(buf+3) < 0)
      f8:	e8 56 0e 00 00       	call   f53 <chdir>
      fd:	83 c4 10             	add    $0x10,%esp
     100:	85 c0                	test   %eax,%eax
     102:	0f 89 67 ff ff ff    	jns    6f <main+0x6f>
        printf(2, "cannot cd %s\n", buf+3);
     108:	51                   	push   %ecx
     109:	68 a3 1a 00 00       	push   $0x1aa3
     10e:	68 51 14 00 00       	push   $0x1451
     113:	6a 02                	push   $0x2
     115:	e8 26 0f 00 00       	call   1040 <printf>
     11a:	83 c4 10             	add    $0x10,%esp
     11d:	e9 4d ff ff ff       	jmp    6f <main+0x6f>
  exit();
     122:	e8 bc 0d 00 00       	call   ee3 <exit>
    panic("fork");
     127:	83 ec 0c             	sub    $0xc,%esp
     12a:	68 ab 13 00 00       	push   $0x13ab
     12f:	e8 5c 00 00 00       	call   190 <panic>
     134:	66 90                	xchg   %ax,%ax
     136:	66 90                	xchg   %ax,%ax
     138:	66 90                	xchg   %ax,%ax
     13a:	66 90                	xchg   %ax,%ax
     13c:	66 90                	xchg   %ax,%ax
     13e:	66 90                	xchg   %ax,%ax

00000140 <getcmd>:
{
     140:	f3 0f 1e fb          	endbr32 
     144:	55                   	push   %ebp
     145:	89 e5                	mov    %esp,%ebp
     147:	56                   	push   %esi
     148:	53                   	push   %ebx
     149:	8b 75 0c             	mov    0xc(%ebp),%esi
     14c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  printf(2, "$ ");
     14f:	83 ec 08             	sub    $0x8,%esp
     152:	68 a8 13 00 00       	push   $0x13a8
     157:	6a 02                	push   $0x2
     159:	e8 e2 0e 00 00       	call   1040 <printf>
  memset(buf, 0, nbuf);
     15e:	83 c4 0c             	add    $0xc,%esp
     161:	56                   	push   %esi
     162:	6a 00                	push   $0x0
     164:	53                   	push   %ebx
     165:	e8 d6 0b 00 00       	call   d40 <memset>
  gets(buf, nbuf);
     16a:	58                   	pop    %eax
     16b:	5a                   	pop    %edx
     16c:	56                   	push   %esi
     16d:	53                   	push   %ebx
     16e:	e8 2d 0c 00 00       	call   da0 <gets>
  if(buf[0] == 0) // EOF
     173:	83 c4 10             	add    $0x10,%esp
     176:	31 c0                	xor    %eax,%eax
     178:	80 3b 00             	cmpb   $0x0,(%ebx)
     17b:	0f 94 c0             	sete   %al
}
     17e:	8d 65 f8             	lea    -0x8(%ebp),%esp
     181:	5b                   	pop    %ebx
  if(buf[0] == 0) // EOF
     182:	f7 d8                	neg    %eax
}
     184:	5e                   	pop    %esi
     185:	5d                   	pop    %ebp
     186:	c3                   	ret    
     187:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     18e:	66 90                	xchg   %ax,%ax

00000190 <panic>:
{
     190:	f3 0f 1e fb          	endbr32 
     194:	55                   	push   %ebp
     195:	89 e5                	mov    %esp,%ebp
     197:	83 ec 0c             	sub    $0xc,%esp
  printf(2, "%s\n", s);
     19a:	ff 75 08             	pushl  0x8(%ebp)
     19d:	68 45 14 00 00       	push   $0x1445
     1a2:	6a 02                	push   $0x2
     1a4:	e8 97 0e 00 00       	call   1040 <printf>
  exit();
     1a9:	e8 35 0d 00 00       	call   ee3 <exit>
     1ae:	66 90                	xchg   %ax,%ax

000001b0 <fork1>:
{
     1b0:	f3 0f 1e fb          	endbr32 
     1b4:	55                   	push   %ebp
     1b5:	89 e5                	mov    %esp,%ebp
     1b7:	83 ec 08             	sub    $0x8,%esp
  pid = fork();
     1ba:	e8 1c 0d 00 00       	call   edb <fork>
  if(pid == -1)
     1bf:	83 f8 ff             	cmp    $0xffffffff,%eax
     1c2:	74 02                	je     1c6 <fork1+0x16>
  return pid;
}
     1c4:	c9                   	leave  
     1c5:	c3                   	ret    
    panic("fork");
     1c6:	83 ec 0c             	sub    $0xc,%esp
     1c9:	68 ab 13 00 00       	push   $0x13ab
     1ce:	e8 bd ff ff ff       	call   190 <panic>
     1d3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     1da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001e0 <runcmd>:
{
     1e0:	f3 0f 1e fb          	endbr32 
     1e4:	55                   	push   %ebp
     1e5:	89 e5                	mov    %esp,%ebp
     1e7:	53                   	push   %ebx
     1e8:	83 ec 14             	sub    $0x14,%esp
     1eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     1ee:	85 db                	test   %ebx,%ebx
     1f0:	74 3e                	je     230 <runcmd+0x50>
  switch(cmd->type){
     1f2:	83 3b 05             	cmpl   $0x5,(%ebx)
     1f5:	0f 87 df 00 00 00    	ja     2da <runcmd+0xfa>
     1fb:	8b 03                	mov    (%ebx),%eax
     1fd:	3e ff 24 85 60 14 00 	notrack jmp *0x1460(,%eax,4)
     204:	00 
    if(ecmd->argv[0] == 0)
     205:	8b 43 04             	mov    0x4(%ebx),%eax
     208:	85 c0                	test   %eax,%eax
     20a:	74 24                	je     230 <runcmd+0x50>
    exec(ecmd->argv[0], ecmd->argv);
     20c:	8d 53 04             	lea    0x4(%ebx),%edx
     20f:	51                   	push   %ecx
     210:	51                   	push   %ecx
     211:	52                   	push   %edx
     212:	50                   	push   %eax
     213:	e8 03 0d 00 00       	call   f1b <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     218:	83 c4 0c             	add    $0xc,%esp
     21b:	ff 73 04             	pushl  0x4(%ebx)
     21e:	68 b7 13 00 00       	push   $0x13b7
     223:	6a 02                	push   $0x2
     225:	e8 16 0e 00 00       	call   1040 <printf>
    break;
     22a:	83 c4 10             	add    $0x10,%esp
     22d:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
     230:	e8 ae 0c 00 00       	call   ee3 <exit>
    if(fork1() == 0)
     235:	e8 76 ff ff ff       	call   1b0 <fork1>
     23a:	85 c0                	test   %eax,%eax
     23c:	75 f2                	jne    230 <runcmd+0x50>
     23e:	e9 8c 00 00 00       	jmp    2cf <runcmd+0xef>
    if(pipe(p) < 0)
     243:	83 ec 0c             	sub    $0xc,%esp
     246:	8d 45 f0             	lea    -0x10(%ebp),%eax
     249:	50                   	push   %eax
     24a:	e8 a4 0c 00 00       	call   ef3 <pipe>
     24f:	83 c4 10             	add    $0x10,%esp
     252:	85 c0                	test   %eax,%eax
     254:	0f 88 a2 00 00 00    	js     2fc <runcmd+0x11c>
    if(fork1() == 0){
     25a:	e8 51 ff ff ff       	call   1b0 <fork1>
     25f:	85 c0                	test   %eax,%eax
     261:	0f 84 a2 00 00 00    	je     309 <runcmd+0x129>
    if(fork1() == 0){
     267:	e8 44 ff ff ff       	call   1b0 <fork1>
     26c:	85 c0                	test   %eax,%eax
     26e:	0f 84 c3 00 00 00    	je     337 <runcmd+0x157>
    close(p[0]);
     274:	83 ec 0c             	sub    $0xc,%esp
     277:	ff 75 f0             	pushl  -0x10(%ebp)
     27a:	e8 8c 0c 00 00       	call   f0b <close>
    close(p[1]);
     27f:	58                   	pop    %eax
     280:	ff 75 f4             	pushl  -0xc(%ebp)
     283:	e8 83 0c 00 00       	call   f0b <close>
    wait();
     288:	e8 5e 0c 00 00       	call   eeb <wait>
    wait();
     28d:	e8 59 0c 00 00       	call   eeb <wait>
    break;
     292:	83 c4 10             	add    $0x10,%esp
     295:	eb 99                	jmp    230 <runcmd+0x50>
    if(fork1() == 0)
     297:	e8 14 ff ff ff       	call   1b0 <fork1>
     29c:	85 c0                	test   %eax,%eax
     29e:	74 2f                	je     2cf <runcmd+0xef>
    wait();
     2a0:	e8 46 0c 00 00       	call   eeb <wait>
    runcmd(lcmd->right);
     2a5:	83 ec 0c             	sub    $0xc,%esp
     2a8:	ff 73 08             	pushl  0x8(%ebx)
     2ab:	e8 30 ff ff ff       	call   1e0 <runcmd>
    close(rcmd->fd);
     2b0:	83 ec 0c             	sub    $0xc,%esp
     2b3:	ff 73 14             	pushl  0x14(%ebx)
     2b6:	e8 50 0c 00 00       	call   f0b <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     2bb:	58                   	pop    %eax
     2bc:	5a                   	pop    %edx
     2bd:	ff 73 10             	pushl  0x10(%ebx)
     2c0:	ff 73 08             	pushl  0x8(%ebx)
     2c3:	e8 5b 0c 00 00       	call   f23 <open>
     2c8:	83 c4 10             	add    $0x10,%esp
     2cb:	85 c0                	test   %eax,%eax
     2cd:	78 18                	js     2e7 <runcmd+0x107>
      runcmd(bcmd->cmd);
     2cf:	83 ec 0c             	sub    $0xc,%esp
     2d2:	ff 73 04             	pushl  0x4(%ebx)
     2d5:	e8 06 ff ff ff       	call   1e0 <runcmd>
    panic("runcmd");
     2da:	83 ec 0c             	sub    $0xc,%esp
     2dd:	68 b0 13 00 00       	push   $0x13b0
     2e2:	e8 a9 fe ff ff       	call   190 <panic>
      printf(2, "open %s failed\n", rcmd->file);
     2e7:	51                   	push   %ecx
     2e8:	ff 73 08             	pushl  0x8(%ebx)
     2eb:	68 c7 13 00 00       	push   $0x13c7
     2f0:	6a 02                	push   $0x2
     2f2:	e8 49 0d 00 00       	call   1040 <printf>
      exit();
     2f7:	e8 e7 0b 00 00       	call   ee3 <exit>
      panic("pipe");
     2fc:	83 ec 0c             	sub    $0xc,%esp
     2ff:	68 d7 13 00 00       	push   $0x13d7
     304:	e8 87 fe ff ff       	call   190 <panic>
      close(1);
     309:	83 ec 0c             	sub    $0xc,%esp
     30c:	6a 01                	push   $0x1
     30e:	e8 f8 0b 00 00       	call   f0b <close>
      dup(p[1]);
     313:	58                   	pop    %eax
     314:	ff 75 f4             	pushl  -0xc(%ebp)
     317:	e8 3f 0c 00 00       	call   f5b <dup>
      close(p[0]);
     31c:	58                   	pop    %eax
     31d:	ff 75 f0             	pushl  -0x10(%ebp)
     320:	e8 e6 0b 00 00       	call   f0b <close>
      close(p[1]);
     325:	58                   	pop    %eax
     326:	ff 75 f4             	pushl  -0xc(%ebp)
     329:	e8 dd 0b 00 00       	call   f0b <close>
      runcmd(pcmd->left);
     32e:	5a                   	pop    %edx
     32f:	ff 73 04             	pushl  0x4(%ebx)
     332:	e8 a9 fe ff ff       	call   1e0 <runcmd>
      close(0);
     337:	83 ec 0c             	sub    $0xc,%esp
     33a:	6a 00                	push   $0x0
     33c:	e8 ca 0b 00 00       	call   f0b <close>
      dup(p[0]);
     341:	5a                   	pop    %edx
     342:	ff 75 f0             	pushl  -0x10(%ebp)
     345:	e8 11 0c 00 00       	call   f5b <dup>
      close(p[0]);
     34a:	59                   	pop    %ecx
     34b:	ff 75 f0             	pushl  -0x10(%ebp)
     34e:	e8 b8 0b 00 00       	call   f0b <close>
      close(p[1]);
     353:	58                   	pop    %eax
     354:	ff 75 f4             	pushl  -0xc(%ebp)
     357:	e8 af 0b 00 00       	call   f0b <close>
      runcmd(pcmd->right);
     35c:	58                   	pop    %eax
     35d:	ff 73 08             	pushl  0x8(%ebx)
     360:	e8 7b fe ff ff       	call   1e0 <runcmd>
     365:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     36c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000370 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     370:	f3 0f 1e fb          	endbr32 
     374:	55                   	push   %ebp
     375:	89 e5                	mov    %esp,%ebp
     377:	53                   	push   %ebx
     378:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     37b:	6a 54                	push   $0x54
     37d:	e8 1e 0f 00 00       	call   12a0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     382:	83 c4 0c             	add    $0xc,%esp
     385:	6a 54                	push   $0x54
  cmd = malloc(sizeof(*cmd));
     387:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     389:	6a 00                	push   $0x0
     38b:	50                   	push   %eax
     38c:	e8 af 09 00 00       	call   d40 <memset>
  cmd->type = EXEC;
     391:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     397:	89 d8                	mov    %ebx,%eax
     399:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     39c:	c9                   	leave  
     39d:	c3                   	ret    
     39e:	66 90                	xchg   %ax,%ax

000003a0 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     3a0:	f3 0f 1e fb          	endbr32 
     3a4:	55                   	push   %ebp
     3a5:	89 e5                	mov    %esp,%ebp
     3a7:	53                   	push   %ebx
     3a8:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3ab:	6a 18                	push   $0x18
     3ad:	e8 ee 0e 00 00       	call   12a0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3b2:	83 c4 0c             	add    $0xc,%esp
     3b5:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     3b7:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3b9:	6a 00                	push   $0x0
     3bb:	50                   	push   %eax
     3bc:	e8 7f 09 00 00       	call   d40 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     3c1:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     3c4:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     3ca:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     3cd:	8b 45 0c             	mov    0xc(%ebp),%eax
     3d0:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     3d3:	8b 45 10             	mov    0x10(%ebp),%eax
     3d6:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     3d9:	8b 45 14             	mov    0x14(%ebp),%eax
     3dc:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     3df:	8b 45 18             	mov    0x18(%ebp),%eax
     3e2:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     3e5:	89 d8                	mov    %ebx,%eax
     3e7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     3ea:	c9                   	leave  
     3eb:	c3                   	ret    
     3ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003f0 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     3f0:	f3 0f 1e fb          	endbr32 
     3f4:	55                   	push   %ebp
     3f5:	89 e5                	mov    %esp,%ebp
     3f7:	53                   	push   %ebx
     3f8:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3fb:	6a 0c                	push   $0xc
     3fd:	e8 9e 0e 00 00       	call   12a0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     402:	83 c4 0c             	add    $0xc,%esp
     405:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     407:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     409:	6a 00                	push   $0x0
     40b:	50                   	push   %eax
     40c:	e8 2f 09 00 00       	call   d40 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     411:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
     414:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     41a:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     41d:	8b 45 0c             	mov    0xc(%ebp),%eax
     420:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     423:	89 d8                	mov    %ebx,%eax
     425:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     428:	c9                   	leave  
     429:	c3                   	ret    
     42a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000430 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     430:	f3 0f 1e fb          	endbr32 
     434:	55                   	push   %ebp
     435:	89 e5                	mov    %esp,%ebp
     437:	53                   	push   %ebx
     438:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     43b:	6a 0c                	push   $0xc
     43d:	e8 5e 0e 00 00       	call   12a0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     442:	83 c4 0c             	add    $0xc,%esp
     445:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     447:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     449:	6a 00                	push   $0x0
     44b:	50                   	push   %eax
     44c:	e8 ef 08 00 00       	call   d40 <memset>
  cmd->type = LIST;
  cmd->left = left;
     451:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
     454:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     45a:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     45d:	8b 45 0c             	mov    0xc(%ebp),%eax
     460:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     463:	89 d8                	mov    %ebx,%eax
     465:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     468:	c9                   	leave  
     469:	c3                   	ret    
     46a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000470 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     470:	f3 0f 1e fb          	endbr32 
     474:	55                   	push   %ebp
     475:	89 e5                	mov    %esp,%ebp
     477:	53                   	push   %ebx
     478:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     47b:	6a 08                	push   $0x8
     47d:	e8 1e 0e 00 00       	call   12a0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     482:	83 c4 0c             	add    $0xc,%esp
     485:	6a 08                	push   $0x8
  cmd = malloc(sizeof(*cmd));
     487:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     489:	6a 00                	push   $0x0
     48b:	50                   	push   %eax
     48c:	e8 af 08 00 00       	call   d40 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     491:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
     494:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     49a:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     49d:	89 d8                	mov    %ebx,%eax
     49f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     4a2:	c9                   	leave  
     4a3:	c3                   	ret    
     4a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     4ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     4af:	90                   	nop

000004b0 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     4b0:	f3 0f 1e fb          	endbr32 
     4b4:	55                   	push   %ebp
     4b5:	89 e5                	mov    %esp,%ebp
     4b7:	57                   	push   %edi
     4b8:	56                   	push   %esi
     4b9:	53                   	push   %ebx
     4ba:	83 ec 0c             	sub    $0xc,%esp
  char *s;
  int ret;

  s = *ps;
     4bd:	8b 45 08             	mov    0x8(%ebp),%eax
{
     4c0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     4c3:	8b 75 10             	mov    0x10(%ebp),%esi
  s = *ps;
     4c6:	8b 38                	mov    (%eax),%edi
  while(s < es && strchr(whitespace, *s))
     4c8:	39 df                	cmp    %ebx,%edi
     4ca:	72 0b                	jb     4d7 <gettoken+0x27>
     4cc:	eb 21                	jmp    4ef <gettoken+0x3f>
     4ce:	66 90                	xchg   %ax,%ax
    s++;
     4d0:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     4d3:	39 fb                	cmp    %edi,%ebx
     4d5:	74 18                	je     4ef <gettoken+0x3f>
     4d7:	0f be 07             	movsbl (%edi),%eax
     4da:	83 ec 08             	sub    $0x8,%esp
     4dd:	50                   	push   %eax
     4de:	68 98 1a 00 00       	push   $0x1a98
     4e3:	e8 78 08 00 00       	call   d60 <strchr>
     4e8:	83 c4 10             	add    $0x10,%esp
     4eb:	85 c0                	test   %eax,%eax
     4ed:	75 e1                	jne    4d0 <gettoken+0x20>
  if(q)
     4ef:	85 f6                	test   %esi,%esi
     4f1:	74 02                	je     4f5 <gettoken+0x45>
    *q = s;
     4f3:	89 3e                	mov    %edi,(%esi)
  ret = *s;
     4f5:	0f b6 07             	movzbl (%edi),%eax
  switch(*s){
     4f8:	3c 3c                	cmp    $0x3c,%al
     4fa:	0f 8f d0 00 00 00    	jg     5d0 <gettoken+0x120>
     500:	3c 3a                	cmp    $0x3a,%al
     502:	0f 8f b4 00 00 00    	jg     5bc <gettoken+0x10c>
     508:	84 c0                	test   %al,%al
     50a:	75 44                	jne    550 <gettoken+0xa0>
     50c:	31 f6                	xor    %esi,%esi
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     50e:	8b 55 14             	mov    0x14(%ebp),%edx
     511:	85 d2                	test   %edx,%edx
     513:	74 05                	je     51a <gettoken+0x6a>
    *eq = s;
     515:	8b 45 14             	mov    0x14(%ebp),%eax
     518:	89 38                	mov    %edi,(%eax)

  while(s < es && strchr(whitespace, *s))
     51a:	39 df                	cmp    %ebx,%edi
     51c:	72 09                	jb     527 <gettoken+0x77>
     51e:	eb 1f                	jmp    53f <gettoken+0x8f>
    s++;
     520:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     523:	39 fb                	cmp    %edi,%ebx
     525:	74 18                	je     53f <gettoken+0x8f>
     527:	0f be 07             	movsbl (%edi),%eax
     52a:	83 ec 08             	sub    $0x8,%esp
     52d:	50                   	push   %eax
     52e:	68 98 1a 00 00       	push   $0x1a98
     533:	e8 28 08 00 00       	call   d60 <strchr>
     538:	83 c4 10             	add    $0x10,%esp
     53b:	85 c0                	test   %eax,%eax
     53d:	75 e1                	jne    520 <gettoken+0x70>
  *ps = s;
     53f:	8b 45 08             	mov    0x8(%ebp),%eax
     542:	89 38                	mov    %edi,(%eax)
  return ret;
}
     544:	8d 65 f4             	lea    -0xc(%ebp),%esp
     547:	89 f0                	mov    %esi,%eax
     549:	5b                   	pop    %ebx
     54a:	5e                   	pop    %esi
     54b:	5f                   	pop    %edi
     54c:	5d                   	pop    %ebp
     54d:	c3                   	ret    
     54e:	66 90                	xchg   %ax,%ax
  switch(*s){
     550:	79 5e                	jns    5b0 <gettoken+0x100>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     552:	39 fb                	cmp    %edi,%ebx
     554:	77 34                	ja     58a <gettoken+0xda>
  if(eq)
     556:	8b 45 14             	mov    0x14(%ebp),%eax
     559:	be 61 00 00 00       	mov    $0x61,%esi
     55e:	85 c0                	test   %eax,%eax
     560:	75 b3                	jne    515 <gettoken+0x65>
     562:	eb db                	jmp    53f <gettoken+0x8f>
     564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     568:	0f be 07             	movsbl (%edi),%eax
     56b:	83 ec 08             	sub    $0x8,%esp
     56e:	50                   	push   %eax
     56f:	68 90 1a 00 00       	push   $0x1a90
     574:	e8 e7 07 00 00       	call   d60 <strchr>
     579:	83 c4 10             	add    $0x10,%esp
     57c:	85 c0                	test   %eax,%eax
     57e:	75 22                	jne    5a2 <gettoken+0xf2>
      s++;
     580:	83 c7 01             	add    $0x1,%edi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     583:	39 fb                	cmp    %edi,%ebx
     585:	74 cf                	je     556 <gettoken+0xa6>
     587:	0f b6 07             	movzbl (%edi),%eax
     58a:	83 ec 08             	sub    $0x8,%esp
     58d:	0f be f0             	movsbl %al,%esi
     590:	56                   	push   %esi
     591:	68 98 1a 00 00       	push   $0x1a98
     596:	e8 c5 07 00 00       	call   d60 <strchr>
     59b:	83 c4 10             	add    $0x10,%esp
     59e:	85 c0                	test   %eax,%eax
     5a0:	74 c6                	je     568 <gettoken+0xb8>
    ret = 'a';
     5a2:	be 61 00 00 00       	mov    $0x61,%esi
     5a7:	e9 62 ff ff ff       	jmp    50e <gettoken+0x5e>
     5ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     5b0:	3c 26                	cmp    $0x26,%al
     5b2:	74 08                	je     5bc <gettoken+0x10c>
     5b4:	8d 48 d8             	lea    -0x28(%eax),%ecx
     5b7:	80 f9 01             	cmp    $0x1,%cl
     5ba:	77 96                	ja     552 <gettoken+0xa2>
  ret = *s;
     5bc:	0f be f0             	movsbl %al,%esi
    s++;
     5bf:	83 c7 01             	add    $0x1,%edi
    break;
     5c2:	e9 47 ff ff ff       	jmp    50e <gettoken+0x5e>
     5c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     5ce:	66 90                	xchg   %ax,%ax
  switch(*s){
     5d0:	3c 3e                	cmp    $0x3e,%al
     5d2:	75 1c                	jne    5f0 <gettoken+0x140>
    if(*s == '>'){
     5d4:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
    s++;
     5d8:	8d 47 01             	lea    0x1(%edi),%eax
    if(*s == '>'){
     5db:	74 1c                	je     5f9 <gettoken+0x149>
    s++;
     5dd:	89 c7                	mov    %eax,%edi
     5df:	be 3e 00 00 00       	mov    $0x3e,%esi
     5e4:	e9 25 ff ff ff       	jmp    50e <gettoken+0x5e>
     5e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     5f0:	3c 7c                	cmp    $0x7c,%al
     5f2:	74 c8                	je     5bc <gettoken+0x10c>
     5f4:	e9 59 ff ff ff       	jmp    552 <gettoken+0xa2>
      s++;
     5f9:	83 c7 02             	add    $0x2,%edi
      ret = '+';
     5fc:	be 2b 00 00 00       	mov    $0x2b,%esi
     601:	e9 08 ff ff ff       	jmp    50e <gettoken+0x5e>
     606:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     60d:	8d 76 00             	lea    0x0(%esi),%esi

00000610 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     610:	f3 0f 1e fb          	endbr32 
     614:	55                   	push   %ebp
     615:	89 e5                	mov    %esp,%ebp
     617:	57                   	push   %edi
     618:	56                   	push   %esi
     619:	53                   	push   %ebx
     61a:	83 ec 0c             	sub    $0xc,%esp
     61d:	8b 7d 08             	mov    0x8(%ebp),%edi
     620:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     623:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     625:	39 f3                	cmp    %esi,%ebx
     627:	72 0e                	jb     637 <peek+0x27>
     629:	eb 24                	jmp    64f <peek+0x3f>
     62b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     62f:	90                   	nop
    s++;
     630:	83 c3 01             	add    $0x1,%ebx
  while(s < es && strchr(whitespace, *s))
     633:	39 de                	cmp    %ebx,%esi
     635:	74 18                	je     64f <peek+0x3f>
     637:	0f be 03             	movsbl (%ebx),%eax
     63a:	83 ec 08             	sub    $0x8,%esp
     63d:	50                   	push   %eax
     63e:	68 98 1a 00 00       	push   $0x1a98
     643:	e8 18 07 00 00       	call   d60 <strchr>
     648:	83 c4 10             	add    $0x10,%esp
     64b:	85 c0                	test   %eax,%eax
     64d:	75 e1                	jne    630 <peek+0x20>
  *ps = s;
     64f:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     651:	0f be 03             	movsbl (%ebx),%eax
     654:	31 d2                	xor    %edx,%edx
     656:	84 c0                	test   %al,%al
     658:	75 0e                	jne    668 <peek+0x58>
}
     65a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     65d:	89 d0                	mov    %edx,%eax
     65f:	5b                   	pop    %ebx
     660:	5e                   	pop    %esi
     661:	5f                   	pop    %edi
     662:	5d                   	pop    %ebp
     663:	c3                   	ret    
     664:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return *s && strchr(toks, *s);
     668:	83 ec 08             	sub    $0x8,%esp
     66b:	50                   	push   %eax
     66c:	ff 75 10             	pushl  0x10(%ebp)
     66f:	e8 ec 06 00 00       	call   d60 <strchr>
     674:	83 c4 10             	add    $0x10,%esp
     677:	31 d2                	xor    %edx,%edx
     679:	85 c0                	test   %eax,%eax
     67b:	0f 95 c2             	setne  %dl
}
     67e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     681:	5b                   	pop    %ebx
     682:	89 d0                	mov    %edx,%eax
     684:	5e                   	pop    %esi
     685:	5f                   	pop    %edi
     686:	5d                   	pop    %ebp
     687:	c3                   	ret    
     688:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     68f:	90                   	nop

00000690 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     690:	f3 0f 1e fb          	endbr32 
     694:	55                   	push   %ebp
     695:	89 e5                	mov    %esp,%ebp
     697:	57                   	push   %edi
     698:	56                   	push   %esi
     699:	53                   	push   %ebx
     69a:	83 ec 2c             	sub    $0x2c,%esp
     69d:	8b 75 0c             	mov    0xc(%ebp),%esi
     6a0:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     6a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     6a7:	90                   	nop
     6a8:	83 ec 04             	sub    $0x4,%esp
     6ab:	68 f9 13 00 00       	push   $0x13f9
     6b0:	53                   	push   %ebx
     6b1:	56                   	push   %esi
     6b2:	e8 59 ff ff ff       	call   610 <peek>
     6b7:	83 c4 10             	add    $0x10,%esp
     6ba:	85 c0                	test   %eax,%eax
     6bc:	0f 84 ee 00 00 00    	je     7b0 <parseredirs+0x120>
    tok = gettoken(ps, es, 0, 0);
     6c2:	6a 00                	push   $0x0
     6c4:	6a 00                	push   $0x0
     6c6:	53                   	push   %ebx
     6c7:	56                   	push   %esi
     6c8:	e8 e3 fd ff ff       	call   4b0 <gettoken>
     6cd:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     6cf:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     6d2:	50                   	push   %eax
     6d3:	8d 45 e0             	lea    -0x20(%ebp),%eax
     6d6:	50                   	push   %eax
     6d7:	53                   	push   %ebx
     6d8:	56                   	push   %esi
     6d9:	e8 d2 fd ff ff       	call   4b0 <gettoken>
     6de:	83 c4 20             	add    $0x20,%esp
     6e1:	83 f8 61             	cmp    $0x61,%eax
     6e4:	0f 85 d1 00 00 00    	jne    7bb <parseredirs+0x12b>
      panic("missing file for redirection");
    switch(tok){
     6ea:	83 ff 3c             	cmp    $0x3c,%edi
     6ed:	74 61                	je     750 <parseredirs+0xc0>
     6ef:	83 ff 3e             	cmp    $0x3e,%edi
     6f2:	74 05                	je     6f9 <parseredirs+0x69>
     6f4:	83 ff 2b             	cmp    $0x2b,%edi
     6f7:	75 af                	jne    6a8 <parseredirs+0x18>
  cmd = malloc(sizeof(*cmd));
     6f9:	83 ec 0c             	sub    $0xc,%esp
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     6fc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     6ff:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  cmd = malloc(sizeof(*cmd));
     702:	6a 18                	push   $0x18
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     704:	89 55 d0             	mov    %edx,-0x30(%ebp)
     707:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     70a:	e8 91 0b 00 00       	call   12a0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     70f:	83 c4 0c             	add    $0xc,%esp
     712:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     714:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     716:	6a 00                	push   $0x0
     718:	50                   	push   %eax
     719:	e8 22 06 00 00       	call   d40 <memset>
  cmd->type = REDIR;
     71e:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  cmd->cmd = subcmd;
     724:	8b 45 08             	mov    0x8(%ebp),%eax
      break;
     727:	83 c4 10             	add    $0x10,%esp
  cmd->cmd = subcmd;
     72a:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     72d:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     730:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     733:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->mode = mode;
     736:	c7 47 10 01 02 00 00 	movl   $0x201,0x10(%edi)
  cmd->efile = efile;
     73d:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->fd = fd;
     740:	c7 47 14 01 00 00 00 	movl   $0x1,0x14(%edi)
      break;
     747:	89 7d 08             	mov    %edi,0x8(%ebp)
     74a:	e9 59 ff ff ff       	jmp    6a8 <parseredirs+0x18>
     74f:	90                   	nop
  cmd = malloc(sizeof(*cmd));
     750:	83 ec 0c             	sub    $0xc,%esp
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     753:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     756:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  cmd = malloc(sizeof(*cmd));
     759:	6a 18                	push   $0x18
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     75b:	89 55 d0             	mov    %edx,-0x30(%ebp)
     75e:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     761:	e8 3a 0b 00 00       	call   12a0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     766:	83 c4 0c             	add    $0xc,%esp
     769:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     76b:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     76d:	6a 00                	push   $0x0
     76f:	50                   	push   %eax
     770:	e8 cb 05 00 00       	call   d40 <memset>
  cmd->cmd = subcmd;
     775:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->file = file;
     778:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      break;
     77b:	89 7d 08             	mov    %edi,0x8(%ebp)
  cmd->efile = efile;
     77e:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->type = REDIR;
     781:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
      break;
     787:	83 c4 10             	add    $0x10,%esp
  cmd->cmd = subcmd;
     78a:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     78d:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     790:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->mode = mode;
     793:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%edi)
  cmd->fd = fd;
     79a:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
      break;
     7a1:	e9 02 ff ff ff       	jmp    6a8 <parseredirs+0x18>
     7a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     7ad:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
  return cmd;
}
     7b0:	8b 45 08             	mov    0x8(%ebp),%eax
     7b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7b6:	5b                   	pop    %ebx
     7b7:	5e                   	pop    %esi
     7b8:	5f                   	pop    %edi
     7b9:	5d                   	pop    %ebp
     7ba:	c3                   	ret    
      panic("missing file for redirection");
     7bb:	83 ec 0c             	sub    $0xc,%esp
     7be:	68 dc 13 00 00       	push   $0x13dc
     7c3:	e8 c8 f9 ff ff       	call   190 <panic>
     7c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     7cf:	90                   	nop

000007d0 <parseexec.part.0>:
  cmd = parseredirs(cmd, ps, es);
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
     7d0:	55                   	push   %ebp
     7d1:	89 e5                	mov    %esp,%ebp
     7d3:	57                   	push   %edi
     7d4:	89 d7                	mov    %edx,%edi
     7d6:	56                   	push   %esi
     7d7:	89 c6                	mov    %eax,%esi
     7d9:	53                   	push   %ebx
     7da:	83 ec 38             	sub    $0x38,%esp
  cmd = malloc(sizeof(*cmd));
     7dd:	6a 54                	push   $0x54
     7df:	e8 bc 0a 00 00       	call   12a0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     7e4:	83 c4 0c             	add    $0xc,%esp
     7e7:	6a 54                	push   $0x54
  cmd = malloc(sizeof(*cmd));
     7e9:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     7eb:	6a 00                	push   $0x0
     7ed:	50                   	push   %eax
  cmd = malloc(sizeof(*cmd));
     7ee:	89 45 d0             	mov    %eax,-0x30(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     7f1:	e8 4a 05 00 00       	call   d40 <memset>

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     7f6:	83 c4 0c             	add    $0xc,%esp
  cmd->type = EXEC;
     7f9:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  ret = parseredirs(ret, ps, es);
     7ff:	57                   	push   %edi
     800:	56                   	push   %esi
     801:	53                   	push   %ebx
  argc = 0;
     802:	31 db                	xor    %ebx,%ebx
  ret = parseredirs(ret, ps, es);
     804:	e8 87 fe ff ff       	call   690 <parseredirs>
  while(!peek(ps, es, "|)&;")){
     809:	83 c4 10             	add    $0x10,%esp
  ret = parseredirs(ret, ps, es);
     80c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     80f:	eb 1a                	jmp    82b <parseexec.part.0+0x5b>
     811:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     818:	83 ec 04             	sub    $0x4,%esp
     81b:	57                   	push   %edi
     81c:	56                   	push   %esi
     81d:	ff 75 d4             	pushl  -0x2c(%ebp)
     820:	e8 6b fe ff ff       	call   690 <parseredirs>
     825:	83 c4 10             	add    $0x10,%esp
     828:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     82b:	83 ec 04             	sub    $0x4,%esp
     82e:	68 11 14 00 00       	push   $0x1411
     833:	57                   	push   %edi
     834:	56                   	push   %esi
     835:	e8 d6 fd ff ff       	call   610 <peek>
     83a:	83 c4 10             	add    $0x10,%esp
     83d:	85 c0                	test   %eax,%eax
     83f:	75 47                	jne    888 <parseexec.part.0+0xb8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     841:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     844:	50                   	push   %eax
     845:	8d 45 e0             	lea    -0x20(%ebp),%eax
     848:	50                   	push   %eax
     849:	57                   	push   %edi
     84a:	56                   	push   %esi
     84b:	e8 60 fc ff ff       	call   4b0 <gettoken>
     850:	83 c4 10             	add    $0x10,%esp
     853:	85 c0                	test   %eax,%eax
     855:	74 31                	je     888 <parseexec.part.0+0xb8>
    if(tok != 'a')
     857:	83 f8 61             	cmp    $0x61,%eax
     85a:	75 4a                	jne    8a6 <parseexec.part.0+0xd6>
    cmd->argv[argc] = q;
     85c:	8b 45 e0             	mov    -0x20(%ebp),%eax
     85f:	8b 4d d0             	mov    -0x30(%ebp),%ecx
     862:	89 44 99 04          	mov    %eax,0x4(%ecx,%ebx,4)
    cmd->eargv[argc] = eq;
     866:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     869:	89 44 99 2c          	mov    %eax,0x2c(%ecx,%ebx,4)
    argc++;
     86d:	83 c3 01             	add    $0x1,%ebx
    if(argc >= MAXARGS)
     870:	83 fb 0a             	cmp    $0xa,%ebx
     873:	75 a3                	jne    818 <parseexec.part.0+0x48>
      panic("too many args");
     875:	83 ec 0c             	sub    $0xc,%esp
     878:	68 03 14 00 00       	push   $0x1403
     87d:	e8 0e f9 ff ff       	call   190 <panic>
     882:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  cmd->argv[argc] = 0;
     888:	8b 45 d0             	mov    -0x30(%ebp),%eax
     88b:	c7 44 98 04 00 00 00 	movl   $0x0,0x4(%eax,%ebx,4)
     892:	00 
  cmd->eargv[argc] = 0;
     893:	c7 44 98 2c 00 00 00 	movl   $0x0,0x2c(%eax,%ebx,4)
     89a:	00 
  return ret;
}
     89b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     89e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8a1:	5b                   	pop    %ebx
     8a2:	5e                   	pop    %esi
     8a3:	5f                   	pop    %edi
     8a4:	5d                   	pop    %ebp
     8a5:	c3                   	ret    
      panic("syntax");
     8a6:	83 ec 0c             	sub    $0xc,%esp
     8a9:	68 fc 13 00 00       	push   $0x13fc
     8ae:	e8 dd f8 ff ff       	call   190 <panic>
     8b3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     8ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000008c0 <parseblock>:
{
     8c0:	f3 0f 1e fb          	endbr32 
     8c4:	55                   	push   %ebp
     8c5:	89 e5                	mov    %esp,%ebp
     8c7:	57                   	push   %edi
     8c8:	56                   	push   %esi
     8c9:	53                   	push   %ebx
     8ca:	83 ec 10             	sub    $0x10,%esp
     8cd:	8b 5d 08             	mov    0x8(%ebp),%ebx
     8d0:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
     8d3:	68 16 14 00 00       	push   $0x1416
     8d8:	56                   	push   %esi
     8d9:	53                   	push   %ebx
     8da:	e8 31 fd ff ff       	call   610 <peek>
     8df:	83 c4 10             	add    $0x10,%esp
     8e2:	85 c0                	test   %eax,%eax
     8e4:	74 4a                	je     930 <parseblock+0x70>
  gettoken(ps, es, 0, 0);
     8e6:	6a 00                	push   $0x0
     8e8:	6a 00                	push   $0x0
     8ea:	56                   	push   %esi
     8eb:	53                   	push   %ebx
     8ec:	e8 bf fb ff ff       	call   4b0 <gettoken>
  cmd = parseline(ps, es);
     8f1:	58                   	pop    %eax
     8f2:	5a                   	pop    %edx
     8f3:	56                   	push   %esi
     8f4:	53                   	push   %ebx
     8f5:	e8 16 01 00 00       	call   a10 <parseline>
  if(!peek(ps, es, ")"))
     8fa:	83 c4 0c             	add    $0xc,%esp
     8fd:	68 34 14 00 00       	push   $0x1434
  cmd = parseline(ps, es);
     902:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     904:	56                   	push   %esi
     905:	53                   	push   %ebx
     906:	e8 05 fd ff ff       	call   610 <peek>
     90b:	83 c4 10             	add    $0x10,%esp
     90e:	85 c0                	test   %eax,%eax
     910:	74 2b                	je     93d <parseblock+0x7d>
  gettoken(ps, es, 0, 0);
     912:	6a 00                	push   $0x0
     914:	6a 00                	push   $0x0
     916:	56                   	push   %esi
     917:	53                   	push   %ebx
     918:	e8 93 fb ff ff       	call   4b0 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     91d:	83 c4 0c             	add    $0xc,%esp
     920:	56                   	push   %esi
     921:	53                   	push   %ebx
     922:	57                   	push   %edi
     923:	e8 68 fd ff ff       	call   690 <parseredirs>
}
     928:	8d 65 f4             	lea    -0xc(%ebp),%esp
     92b:	5b                   	pop    %ebx
     92c:	5e                   	pop    %esi
     92d:	5f                   	pop    %edi
     92e:	5d                   	pop    %ebp
     92f:	c3                   	ret    
    panic("parseblock");
     930:	83 ec 0c             	sub    $0xc,%esp
     933:	68 18 14 00 00       	push   $0x1418
     938:	e8 53 f8 ff ff       	call   190 <panic>
    panic("syntax - missing )");
     93d:	83 ec 0c             	sub    $0xc,%esp
     940:	68 23 14 00 00       	push   $0x1423
     945:	e8 46 f8 ff ff       	call   190 <panic>
     94a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000950 <parsepipe>:
{
     950:	f3 0f 1e fb          	endbr32 
     954:	55                   	push   %ebp
     955:	89 e5                	mov    %esp,%ebp
     957:	57                   	push   %edi
     958:	56                   	push   %esi
     959:	53                   	push   %ebx
     95a:	83 ec 10             	sub    $0x10,%esp
     95d:	8b 75 08             	mov    0x8(%ebp),%esi
     960:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(peek(ps, es, "("))
     963:	68 16 14 00 00       	push   $0x1416
     968:	57                   	push   %edi
     969:	56                   	push   %esi
     96a:	e8 a1 fc ff ff       	call   610 <peek>
     96f:	83 c4 10             	add    $0x10,%esp
     972:	85 c0                	test   %eax,%eax
     974:	75 32                	jne    9a8 <parsepipe+0x58>
     976:	89 fa                	mov    %edi,%edx
     978:	89 f0                	mov    %esi,%eax
     97a:	e8 51 fe ff ff       	call   7d0 <parseexec.part.0>
     97f:	89 c3                	mov    %eax,%ebx
  if(peek(ps, es, "|")){
     981:	83 ec 04             	sub    $0x4,%esp
     984:	68 36 14 00 00       	push   $0x1436
     989:	57                   	push   %edi
     98a:	56                   	push   %esi
     98b:	e8 80 fc ff ff       	call   610 <peek>
     990:	83 c4 10             	add    $0x10,%esp
     993:	85 c0                	test   %eax,%eax
     995:	75 29                	jne    9c0 <parsepipe+0x70>
}
     997:	8d 65 f4             	lea    -0xc(%ebp),%esp
     99a:	89 d8                	mov    %ebx,%eax
     99c:	5b                   	pop    %ebx
     99d:	5e                   	pop    %esi
     99e:	5f                   	pop    %edi
     99f:	5d                   	pop    %ebp
     9a0:	c3                   	ret    
     9a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return parseblock(ps, es);
     9a8:	83 ec 08             	sub    $0x8,%esp
     9ab:	57                   	push   %edi
     9ac:	56                   	push   %esi
     9ad:	e8 0e ff ff ff       	call   8c0 <parseblock>
     9b2:	83 c4 10             	add    $0x10,%esp
     9b5:	89 c3                	mov    %eax,%ebx
     9b7:	eb c8                	jmp    981 <parsepipe+0x31>
     9b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    gettoken(ps, es, 0, 0);
     9c0:	6a 00                	push   $0x0
     9c2:	6a 00                	push   $0x0
     9c4:	57                   	push   %edi
     9c5:	56                   	push   %esi
     9c6:	e8 e5 fa ff ff       	call   4b0 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     9cb:	58                   	pop    %eax
     9cc:	5a                   	pop    %edx
     9cd:	57                   	push   %edi
     9ce:	56                   	push   %esi
     9cf:	e8 7c ff ff ff       	call   950 <parsepipe>
  cmd = malloc(sizeof(*cmd));
     9d4:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = pipecmd(cmd, parsepipe(ps, es));
     9db:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     9dd:	e8 be 08 00 00       	call   12a0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     9e2:	83 c4 0c             	add    $0xc,%esp
     9e5:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     9e7:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     9e9:	6a 00                	push   $0x0
     9eb:	50                   	push   %eax
     9ec:	e8 4f 03 00 00       	call   d40 <memset>
  cmd->left = left;
     9f1:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     9f4:	83 c4 10             	add    $0x10,%esp
     9f7:	89 f3                	mov    %esi,%ebx
  cmd->type = PIPE;
     9f9:	c7 06 03 00 00 00    	movl   $0x3,(%esi)
}
     9ff:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
     a01:	89 7e 08             	mov    %edi,0x8(%esi)
}
     a04:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a07:	5b                   	pop    %ebx
     a08:	5e                   	pop    %esi
     a09:	5f                   	pop    %edi
     a0a:	5d                   	pop    %ebp
     a0b:	c3                   	ret    
     a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a10 <parseline>:
{
     a10:	f3 0f 1e fb          	endbr32 
     a14:	55                   	push   %ebp
     a15:	89 e5                	mov    %esp,%ebp
     a17:	57                   	push   %edi
     a18:	56                   	push   %esi
     a19:	53                   	push   %ebx
     a1a:	83 ec 24             	sub    $0x24,%esp
     a1d:	8b 75 08             	mov    0x8(%ebp),%esi
     a20:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parsepipe(ps, es);
     a23:	57                   	push   %edi
     a24:	56                   	push   %esi
     a25:	e8 26 ff ff ff       	call   950 <parsepipe>
  while(peek(ps, es, "&")){
     a2a:	83 c4 10             	add    $0x10,%esp
  cmd = parsepipe(ps, es);
     a2d:	89 c3                	mov    %eax,%ebx
  while(peek(ps, es, "&")){
     a2f:	eb 3f                	jmp    a70 <parseline+0x60>
     a31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    gettoken(ps, es, 0, 0);
     a38:	6a 00                	push   $0x0
     a3a:	6a 00                	push   $0x0
     a3c:	57                   	push   %edi
     a3d:	56                   	push   %esi
     a3e:	e8 6d fa ff ff       	call   4b0 <gettoken>
  cmd = malloc(sizeof(*cmd));
     a43:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     a4a:	e8 51 08 00 00       	call   12a0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     a4f:	83 c4 0c             	add    $0xc,%esp
     a52:	6a 08                	push   $0x8
     a54:	6a 00                	push   $0x0
     a56:	50                   	push   %eax
     a57:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     a5a:	e8 e1 02 00 00       	call   d40 <memset>
  cmd->type = BACK;
     a5f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  cmd->cmd = subcmd;
     a62:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     a65:	c7 02 05 00 00 00    	movl   $0x5,(%edx)
  cmd->cmd = subcmd;
     a6b:	89 5a 04             	mov    %ebx,0x4(%edx)
     a6e:	89 d3                	mov    %edx,%ebx
  while(peek(ps, es, "&")){
     a70:	83 ec 04             	sub    $0x4,%esp
     a73:	68 38 14 00 00       	push   $0x1438
     a78:	57                   	push   %edi
     a79:	56                   	push   %esi
     a7a:	e8 91 fb ff ff       	call   610 <peek>
     a7f:	83 c4 10             	add    $0x10,%esp
     a82:	85 c0                	test   %eax,%eax
     a84:	75 b2                	jne    a38 <parseline+0x28>
  if(peek(ps, es, ";")){
     a86:	83 ec 04             	sub    $0x4,%esp
     a89:	68 14 14 00 00       	push   $0x1414
     a8e:	57                   	push   %edi
     a8f:	56                   	push   %esi
     a90:	e8 7b fb ff ff       	call   610 <peek>
     a95:	83 c4 10             	add    $0x10,%esp
     a98:	85 c0                	test   %eax,%eax
     a9a:	75 14                	jne    ab0 <parseline+0xa0>
}
     a9c:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a9f:	89 d8                	mov    %ebx,%eax
     aa1:	5b                   	pop    %ebx
     aa2:	5e                   	pop    %esi
     aa3:	5f                   	pop    %edi
     aa4:	5d                   	pop    %ebp
     aa5:	c3                   	ret    
     aa6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     aad:	8d 76 00             	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
     ab0:	6a 00                	push   $0x0
     ab2:	6a 00                	push   $0x0
     ab4:	57                   	push   %edi
     ab5:	56                   	push   %esi
     ab6:	e8 f5 f9 ff ff       	call   4b0 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     abb:	58                   	pop    %eax
     abc:	5a                   	pop    %edx
     abd:	57                   	push   %edi
     abe:	56                   	push   %esi
     abf:	e8 4c ff ff ff       	call   a10 <parseline>
  cmd = malloc(sizeof(*cmd));
     ac4:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = listcmd(cmd, parseline(ps, es));
     acb:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     acd:	e8 ce 07 00 00       	call   12a0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     ad2:	83 c4 0c             	add    $0xc,%esp
     ad5:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     ad7:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     ad9:	6a 00                	push   $0x0
     adb:	50                   	push   %eax
     adc:	e8 5f 02 00 00       	call   d40 <memset>
  cmd->left = left;
     ae1:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     ae4:	83 c4 10             	add    $0x10,%esp
     ae7:	89 f3                	mov    %esi,%ebx
  cmd->type = LIST;
     ae9:	c7 06 04 00 00 00    	movl   $0x4,(%esi)
}
     aef:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
     af1:	89 7e 08             	mov    %edi,0x8(%esi)
}
     af4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     af7:	5b                   	pop    %ebx
     af8:	5e                   	pop    %esi
     af9:	5f                   	pop    %edi
     afa:	5d                   	pop    %ebp
     afb:	c3                   	ret    
     afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000b00 <parseexec>:
{
     b00:	f3 0f 1e fb          	endbr32 
     b04:	55                   	push   %ebp
     b05:	89 e5                	mov    %esp,%ebp
     b07:	56                   	push   %esi
     b08:	53                   	push   %ebx
     b09:	8b 75 0c             	mov    0xc(%ebp),%esi
     b0c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(peek(ps, es, "("))
     b0f:	83 ec 04             	sub    $0x4,%esp
     b12:	68 16 14 00 00       	push   $0x1416
     b17:	56                   	push   %esi
     b18:	53                   	push   %ebx
     b19:	e8 f2 fa ff ff       	call   610 <peek>
     b1e:	83 c4 10             	add    $0x10,%esp
     b21:	85 c0                	test   %eax,%eax
     b23:	75 13                	jne    b38 <parseexec+0x38>
}
     b25:	8d 65 f8             	lea    -0x8(%ebp),%esp
     b28:	89 f2                	mov    %esi,%edx
     b2a:	89 d8                	mov    %ebx,%eax
     b2c:	5b                   	pop    %ebx
     b2d:	5e                   	pop    %esi
     b2e:	5d                   	pop    %ebp
     b2f:	e9 9c fc ff ff       	jmp    7d0 <parseexec.part.0>
     b34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return parseblock(ps, es);
     b38:	89 75 0c             	mov    %esi,0xc(%ebp)
     b3b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
     b3e:	8d 65 f8             	lea    -0x8(%ebp),%esp
     b41:	5b                   	pop    %ebx
     b42:	5e                   	pop    %esi
     b43:	5d                   	pop    %ebp
    return parseblock(ps, es);
     b44:	e9 77 fd ff ff       	jmp    8c0 <parseblock>
     b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000b50 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     b50:	f3 0f 1e fb          	endbr32 
     b54:	55                   	push   %ebp
     b55:	89 e5                	mov    %esp,%ebp
     b57:	53                   	push   %ebx
     b58:	83 ec 04             	sub    $0x4,%esp
     b5b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     b5e:	85 db                	test   %ebx,%ebx
     b60:	0f 84 9a 00 00 00    	je     c00 <nulterminate+0xb0>
    return 0;

  switch(cmd->type){
     b66:	83 3b 05             	cmpl   $0x5,(%ebx)
     b69:	77 6d                	ja     bd8 <nulterminate+0x88>
     b6b:	8b 03                	mov    (%ebx),%eax
     b6d:	3e ff 24 85 78 14 00 	notrack jmp *0x1478(,%eax,4)
     b74:	00 
     b75:	8d 76 00             	lea    0x0(%esi),%esi
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
     b78:	83 ec 0c             	sub    $0xc,%esp
     b7b:	ff 73 04             	pushl  0x4(%ebx)
     b7e:	e8 cd ff ff ff       	call   b50 <nulterminate>
    nulterminate(lcmd->right);
     b83:	58                   	pop    %eax
     b84:	ff 73 08             	pushl  0x8(%ebx)
     b87:	e8 c4 ff ff ff       	call   b50 <nulterminate>
    break;
     b8c:	83 c4 10             	add    $0x10,%esp
     b8f:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     b91:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b94:	c9                   	leave  
     b95:	c3                   	ret    
     b96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b9d:	8d 76 00             	lea    0x0(%esi),%esi
    nulterminate(bcmd->cmd);
     ba0:	83 ec 0c             	sub    $0xc,%esp
     ba3:	ff 73 04             	pushl  0x4(%ebx)
     ba6:	e8 a5 ff ff ff       	call   b50 <nulterminate>
    break;
     bab:	89 d8                	mov    %ebx,%eax
     bad:	83 c4 10             	add    $0x10,%esp
}
     bb0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bb3:	c9                   	leave  
     bb4:	c3                   	ret    
     bb5:	8d 76 00             	lea    0x0(%esi),%esi
    for(i=0; ecmd->argv[i]; i++)
     bb8:	8b 4b 04             	mov    0x4(%ebx),%ecx
     bbb:	8d 43 08             	lea    0x8(%ebx),%eax
     bbe:	85 c9                	test   %ecx,%ecx
     bc0:	74 16                	je     bd8 <nulterminate+0x88>
     bc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     bc8:	8b 50 24             	mov    0x24(%eax),%edx
    for(i=0; ecmd->argv[i]; i++)
     bcb:	83 c0 04             	add    $0x4,%eax
      *ecmd->eargv[i] = 0;
     bce:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     bd1:	8b 50 fc             	mov    -0x4(%eax),%edx
     bd4:	85 d2                	test   %edx,%edx
     bd6:	75 f0                	jne    bc8 <nulterminate+0x78>
  switch(cmd->type){
     bd8:	89 d8                	mov    %ebx,%eax
}
     bda:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bdd:	c9                   	leave  
     bde:	c3                   	ret    
     bdf:	90                   	nop
    nulterminate(rcmd->cmd);
     be0:	83 ec 0c             	sub    $0xc,%esp
     be3:	ff 73 04             	pushl  0x4(%ebx)
     be6:	e8 65 ff ff ff       	call   b50 <nulterminate>
    *rcmd->efile = 0;
     beb:	8b 43 0c             	mov    0xc(%ebx),%eax
    break;
     bee:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     bf1:	c6 00 00             	movb   $0x0,(%eax)
    break;
     bf4:	89 d8                	mov    %ebx,%eax
}
     bf6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bf9:	c9                   	leave  
     bfa:	c3                   	ret    
     bfb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     bff:	90                   	nop
    return 0;
     c00:	31 c0                	xor    %eax,%eax
     c02:	eb 8d                	jmp    b91 <nulterminate+0x41>
     c04:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     c0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c0f:	90                   	nop

00000c10 <parsecmd>:
{
     c10:	f3 0f 1e fb          	endbr32 
     c14:	55                   	push   %ebp
     c15:	89 e5                	mov    %esp,%ebp
     c17:	57                   	push   %edi
     c18:	56                   	push   %esi
  cmd = parseline(&s, es);
     c19:	8d 7d 08             	lea    0x8(%ebp),%edi
{
     c1c:	53                   	push   %ebx
     c1d:	83 ec 18             	sub    $0x18,%esp
  es = s + strlen(s);
     c20:	8b 5d 08             	mov    0x8(%ebp),%ebx
     c23:	53                   	push   %ebx
     c24:	e8 d7 00 00 00       	call   d00 <strlen>
  cmd = parseline(&s, es);
     c29:	59                   	pop    %ecx
     c2a:	5e                   	pop    %esi
  es = s + strlen(s);
     c2b:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     c2d:	53                   	push   %ebx
     c2e:	57                   	push   %edi
     c2f:	e8 dc fd ff ff       	call   a10 <parseline>
  peek(&s, es, "");
     c34:	83 c4 0c             	add    $0xc,%esp
     c37:	68 c6 13 00 00       	push   $0x13c6
  cmd = parseline(&s, es);
     c3c:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     c3e:	53                   	push   %ebx
     c3f:	57                   	push   %edi
     c40:	e8 cb f9 ff ff       	call   610 <peek>
  if(s != es){
     c45:	8b 45 08             	mov    0x8(%ebp),%eax
     c48:	83 c4 10             	add    $0x10,%esp
     c4b:	39 d8                	cmp    %ebx,%eax
     c4d:	75 13                	jne    c62 <parsecmd+0x52>
  nulterminate(cmd);
     c4f:	83 ec 0c             	sub    $0xc,%esp
     c52:	56                   	push   %esi
     c53:	e8 f8 fe ff ff       	call   b50 <nulterminate>
}
     c58:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c5b:	89 f0                	mov    %esi,%eax
     c5d:	5b                   	pop    %ebx
     c5e:	5e                   	pop    %esi
     c5f:	5f                   	pop    %edi
     c60:	5d                   	pop    %ebp
     c61:	c3                   	ret    
    printf(2, "leftovers: %s\n", s);
     c62:	52                   	push   %edx
     c63:	50                   	push   %eax
     c64:	68 3a 14 00 00       	push   $0x143a
     c69:	6a 02                	push   $0x2
     c6b:	e8 d0 03 00 00       	call   1040 <printf>
    panic("syntax");
     c70:	c7 04 24 fc 13 00 00 	movl   $0x13fc,(%esp)
     c77:	e8 14 f5 ff ff       	call   190 <panic>
     c7c:	66 90                	xchg   %ax,%ax
     c7e:	66 90                	xchg   %ax,%ax

00000c80 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     c80:	f3 0f 1e fb          	endbr32 
     c84:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     c85:	31 c0                	xor    %eax,%eax
{
     c87:	89 e5                	mov    %esp,%ebp
     c89:	53                   	push   %ebx
     c8a:	8b 4d 08             	mov    0x8(%ebp),%ecx
     c8d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
     c90:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
     c94:	88 14 01             	mov    %dl,(%ecx,%eax,1)
     c97:	83 c0 01             	add    $0x1,%eax
     c9a:	84 d2                	test   %dl,%dl
     c9c:	75 f2                	jne    c90 <strcpy+0x10>
    ;
  return os;
}
     c9e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ca1:	89 c8                	mov    %ecx,%eax
     ca3:	c9                   	leave  
     ca4:	c3                   	ret    
     ca5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000cb0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     cb0:	f3 0f 1e fb          	endbr32 
     cb4:	55                   	push   %ebp
     cb5:	89 e5                	mov    %esp,%ebp
     cb7:	53                   	push   %ebx
     cb8:	8b 4d 08             	mov    0x8(%ebp),%ecx
     cbb:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
     cbe:	0f b6 01             	movzbl (%ecx),%eax
     cc1:	0f b6 1a             	movzbl (%edx),%ebx
     cc4:	84 c0                	test   %al,%al
     cc6:	75 19                	jne    ce1 <strcmp+0x31>
     cc8:	eb 26                	jmp    cf0 <strcmp+0x40>
     cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     cd0:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
     cd4:	83 c1 01             	add    $0x1,%ecx
     cd7:	83 c2 01             	add    $0x1,%edx
  return (uchar)*p - (uchar)*q;
     cda:	0f b6 1a             	movzbl (%edx),%ebx
  while(*p && *p == *q)
     cdd:	84 c0                	test   %al,%al
     cdf:	74 0f                	je     cf0 <strcmp+0x40>
     ce1:	38 d8                	cmp    %bl,%al
     ce3:	74 eb                	je     cd0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
     ce5:	29 d8                	sub    %ebx,%eax
}
     ce7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     cea:	c9                   	leave  
     ceb:	c3                   	ret    
     cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     cf0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     cf2:	29 d8                	sub    %ebx,%eax
}
     cf4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     cf7:	c9                   	leave  
     cf8:	c3                   	ret    
     cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d00 <strlen>:

uint
strlen(const char *s)
{
     d00:	f3 0f 1e fb          	endbr32 
     d04:	55                   	push   %ebp
     d05:	89 e5                	mov    %esp,%ebp
     d07:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
     d0a:	80 3a 00             	cmpb   $0x0,(%edx)
     d0d:	74 21                	je     d30 <strlen+0x30>
     d0f:	31 c0                	xor    %eax,%eax
     d11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d18:	83 c0 01             	add    $0x1,%eax
     d1b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
     d1f:	89 c1                	mov    %eax,%ecx
     d21:	75 f5                	jne    d18 <strlen+0x18>
    ;
  return n;
}
     d23:	89 c8                	mov    %ecx,%eax
     d25:	5d                   	pop    %ebp
     d26:	c3                   	ret    
     d27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d2e:	66 90                	xchg   %ax,%ax
  for(n = 0; s[n]; n++)
     d30:	31 c9                	xor    %ecx,%ecx
}
     d32:	5d                   	pop    %ebp
     d33:	89 c8                	mov    %ecx,%eax
     d35:	c3                   	ret    
     d36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d3d:	8d 76 00             	lea    0x0(%esi),%esi

00000d40 <memset>:

void*
memset(void *dst, int c, uint n)
{
     d40:	f3 0f 1e fb          	endbr32 
     d44:	55                   	push   %ebp
     d45:	89 e5                	mov    %esp,%ebp
     d47:	57                   	push   %edi
     d48:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     d4b:	8b 4d 10             	mov    0x10(%ebp),%ecx
     d4e:	8b 45 0c             	mov    0xc(%ebp),%eax
     d51:	89 d7                	mov    %edx,%edi
     d53:	fc                   	cld    
     d54:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     d56:	8b 7d fc             	mov    -0x4(%ebp),%edi
     d59:	89 d0                	mov    %edx,%eax
     d5b:	c9                   	leave  
     d5c:	c3                   	ret    
     d5d:	8d 76 00             	lea    0x0(%esi),%esi

00000d60 <strchr>:

char*
strchr(const char *s, char c)
{
     d60:	f3 0f 1e fb          	endbr32 
     d64:	55                   	push   %ebp
     d65:	89 e5                	mov    %esp,%ebp
     d67:	8b 45 08             	mov    0x8(%ebp),%eax
     d6a:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     d6e:	0f b6 10             	movzbl (%eax),%edx
     d71:	84 d2                	test   %dl,%dl
     d73:	75 16                	jne    d8b <strchr+0x2b>
     d75:	eb 21                	jmp    d98 <strchr+0x38>
     d77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d7e:	66 90                	xchg   %ax,%ax
     d80:	0f b6 50 01          	movzbl 0x1(%eax),%edx
     d84:	83 c0 01             	add    $0x1,%eax
     d87:	84 d2                	test   %dl,%dl
     d89:	74 0d                	je     d98 <strchr+0x38>
    if(*s == c)
     d8b:	38 d1                	cmp    %dl,%cl
     d8d:	75 f1                	jne    d80 <strchr+0x20>
      return (char*)s;
  return 0;
}
     d8f:	5d                   	pop    %ebp
     d90:	c3                   	ret    
     d91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
     d98:	31 c0                	xor    %eax,%eax
}
     d9a:	5d                   	pop    %ebp
     d9b:	c3                   	ret    
     d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000da0 <gets>:

char*
gets(char *buf, int max)
{
     da0:	f3 0f 1e fb          	endbr32 
     da4:	55                   	push   %ebp
     da5:	89 e5                	mov    %esp,%ebp
     da7:	57                   	push   %edi
     da8:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     da9:	31 f6                	xor    %esi,%esi
{
     dab:	53                   	push   %ebx
     dac:	89 f3                	mov    %esi,%ebx
     dae:	83 ec 1c             	sub    $0x1c,%esp
     db1:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
     db4:	eb 33                	jmp    de9 <gets+0x49>
     db6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     dbd:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
     dc0:	83 ec 04             	sub    $0x4,%esp
     dc3:	8d 45 e7             	lea    -0x19(%ebp),%eax
     dc6:	6a 01                	push   $0x1
     dc8:	50                   	push   %eax
     dc9:	6a 00                	push   $0x0
     dcb:	e8 2b 01 00 00       	call   efb <read>
    if(cc < 1)
     dd0:	83 c4 10             	add    $0x10,%esp
     dd3:	85 c0                	test   %eax,%eax
     dd5:	7e 1c                	jle    df3 <gets+0x53>
      break;
    buf[i++] = c;
     dd7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    if(c == '\n' || c == '\r')
     ddb:	83 c7 01             	add    $0x1,%edi
    buf[i++] = c;
     dde:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
     de1:	3c 0a                	cmp    $0xa,%al
     de3:	74 23                	je     e08 <gets+0x68>
     de5:	3c 0d                	cmp    $0xd,%al
     de7:	74 1f                	je     e08 <gets+0x68>
  for(i=0; i+1 < max; ){
     de9:	83 c3 01             	add    $0x1,%ebx
    buf[i++] = c;
     dec:	89 fe                	mov    %edi,%esi
  for(i=0; i+1 < max; ){
     dee:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     df1:	7c cd                	jl     dc0 <gets+0x20>
     df3:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
     df5:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
     df8:	c6 03 00             	movb   $0x0,(%ebx)
}
     dfb:	8d 65 f4             	lea    -0xc(%ebp),%esp
     dfe:	5b                   	pop    %ebx
     dff:	5e                   	pop    %esi
     e00:	5f                   	pop    %edi
     e01:	5d                   	pop    %ebp
     e02:	c3                   	ret    
     e03:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e07:	90                   	nop
  buf[i] = '\0';
     e08:	8b 75 08             	mov    0x8(%ebp),%esi
}
     e0b:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
     e0e:	01 de                	add    %ebx,%esi
     e10:	89 f3                	mov    %esi,%ebx
     e12:	c6 03 00             	movb   $0x0,(%ebx)
}
     e15:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e18:	5b                   	pop    %ebx
     e19:	5e                   	pop    %esi
     e1a:	5f                   	pop    %edi
     e1b:	5d                   	pop    %ebp
     e1c:	c3                   	ret    
     e1d:	8d 76 00             	lea    0x0(%esi),%esi

00000e20 <stat>:

int
stat(const char *n, struct stat *st)
{
     e20:	f3 0f 1e fb          	endbr32 
     e24:	55                   	push   %ebp
     e25:	89 e5                	mov    %esp,%ebp
     e27:	56                   	push   %esi
     e28:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     e29:	83 ec 08             	sub    $0x8,%esp
     e2c:	6a 00                	push   $0x0
     e2e:	ff 75 08             	pushl  0x8(%ebp)
     e31:	e8 ed 00 00 00       	call   f23 <open>
  if(fd < 0)
     e36:	83 c4 10             	add    $0x10,%esp
     e39:	85 c0                	test   %eax,%eax
     e3b:	78 2b                	js     e68 <stat+0x48>
    return -1;
  r = fstat(fd, st);
     e3d:	83 ec 08             	sub    $0x8,%esp
     e40:	ff 75 0c             	pushl  0xc(%ebp)
     e43:	89 c3                	mov    %eax,%ebx
     e45:	50                   	push   %eax
     e46:	e8 f0 00 00 00       	call   f3b <fstat>
  close(fd);
     e4b:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     e4e:	89 c6                	mov    %eax,%esi
  close(fd);
     e50:	e8 b6 00 00 00       	call   f0b <close>
  return r;
     e55:	83 c4 10             	add    $0x10,%esp
}
     e58:	8d 65 f8             	lea    -0x8(%ebp),%esp
     e5b:	89 f0                	mov    %esi,%eax
     e5d:	5b                   	pop    %ebx
     e5e:	5e                   	pop    %esi
     e5f:	5d                   	pop    %ebp
     e60:	c3                   	ret    
     e61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
     e68:	be ff ff ff ff       	mov    $0xffffffff,%esi
     e6d:	eb e9                	jmp    e58 <stat+0x38>
     e6f:	90                   	nop

00000e70 <atoi>:

int
atoi(const char *s)
{
     e70:	f3 0f 1e fb          	endbr32 
     e74:	55                   	push   %ebp
     e75:	89 e5                	mov    %esp,%ebp
     e77:	53                   	push   %ebx
     e78:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     e7b:	0f be 02             	movsbl (%edx),%eax
     e7e:	8d 48 d0             	lea    -0x30(%eax),%ecx
     e81:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
     e84:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
     e89:	77 1a                	ja     ea5 <atoi+0x35>
     e8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e8f:	90                   	nop
    n = n*10 + *s++ - '0';
     e90:	83 c2 01             	add    $0x1,%edx
     e93:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
     e96:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
     e9a:	0f be 02             	movsbl (%edx),%eax
     e9d:	8d 58 d0             	lea    -0x30(%eax),%ebx
     ea0:	80 fb 09             	cmp    $0x9,%bl
     ea3:	76 eb                	jbe    e90 <atoi+0x20>
  return n;
}
     ea5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ea8:	89 c8                	mov    %ecx,%eax
     eaa:	c9                   	leave  
     eab:	c3                   	ret    
     eac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000eb0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     eb0:	f3 0f 1e fb          	endbr32 
     eb4:	55                   	push   %ebp
     eb5:	89 e5                	mov    %esp,%ebp
     eb7:	57                   	push   %edi
     eb8:	8b 45 10             	mov    0x10(%ebp),%eax
     ebb:	8b 55 08             	mov    0x8(%ebp),%edx
     ebe:	56                   	push   %esi
     ebf:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     ec2:	85 c0                	test   %eax,%eax
     ec4:	7e 0f                	jle    ed5 <memmove+0x25>
     ec6:	01 d0                	add    %edx,%eax
  dst = vdst;
     ec8:	89 d7                	mov    %edx,%edi
     eca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
     ed0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
     ed1:	39 f8                	cmp    %edi,%eax
     ed3:	75 fb                	jne    ed0 <memmove+0x20>
  return vdst;
}
     ed5:	5e                   	pop    %esi
     ed6:	89 d0                	mov    %edx,%eax
     ed8:	5f                   	pop    %edi
     ed9:	5d                   	pop    %ebp
     eda:	c3                   	ret    

00000edb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     edb:	b8 01 00 00 00       	mov    $0x1,%eax
     ee0:	cd 40                	int    $0x40
     ee2:	c3                   	ret    

00000ee3 <exit>:
SYSCALL(exit)
     ee3:	b8 02 00 00 00       	mov    $0x2,%eax
     ee8:	cd 40                	int    $0x40
     eea:	c3                   	ret    

00000eeb <wait>:
SYSCALL(wait)
     eeb:	b8 03 00 00 00       	mov    $0x3,%eax
     ef0:	cd 40                	int    $0x40
     ef2:	c3                   	ret    

00000ef3 <pipe>:
SYSCALL(pipe)
     ef3:	b8 04 00 00 00       	mov    $0x4,%eax
     ef8:	cd 40                	int    $0x40
     efa:	c3                   	ret    

00000efb <read>:
SYSCALL(read)
     efb:	b8 05 00 00 00       	mov    $0x5,%eax
     f00:	cd 40                	int    $0x40
     f02:	c3                   	ret    

00000f03 <write>:
SYSCALL(write)
     f03:	b8 10 00 00 00       	mov    $0x10,%eax
     f08:	cd 40                	int    $0x40
     f0a:	c3                   	ret    

00000f0b <close>:
SYSCALL(close)
     f0b:	b8 15 00 00 00       	mov    $0x15,%eax
     f10:	cd 40                	int    $0x40
     f12:	c3                   	ret    

00000f13 <kill>:
SYSCALL(kill)
     f13:	b8 06 00 00 00       	mov    $0x6,%eax
     f18:	cd 40                	int    $0x40
     f1a:	c3                   	ret    

00000f1b <exec>:
SYSCALL(exec)
     f1b:	b8 07 00 00 00       	mov    $0x7,%eax
     f20:	cd 40                	int    $0x40
     f22:	c3                   	ret    

00000f23 <open>:
SYSCALL(open)
     f23:	b8 0f 00 00 00       	mov    $0xf,%eax
     f28:	cd 40                	int    $0x40
     f2a:	c3                   	ret    

00000f2b <mknod>:
SYSCALL(mknod)
     f2b:	b8 11 00 00 00       	mov    $0x11,%eax
     f30:	cd 40                	int    $0x40
     f32:	c3                   	ret    

00000f33 <unlink>:
SYSCALL(unlink)
     f33:	b8 12 00 00 00       	mov    $0x12,%eax
     f38:	cd 40                	int    $0x40
     f3a:	c3                   	ret    

00000f3b <fstat>:
SYSCALL(fstat)
     f3b:	b8 08 00 00 00       	mov    $0x8,%eax
     f40:	cd 40                	int    $0x40
     f42:	c3                   	ret    

00000f43 <link>:
SYSCALL(link)
     f43:	b8 13 00 00 00       	mov    $0x13,%eax
     f48:	cd 40                	int    $0x40
     f4a:	c3                   	ret    

00000f4b <mkdir>:
SYSCALL(mkdir)
     f4b:	b8 14 00 00 00       	mov    $0x14,%eax
     f50:	cd 40                	int    $0x40
     f52:	c3                   	ret    

00000f53 <chdir>:
SYSCALL(chdir)
     f53:	b8 09 00 00 00       	mov    $0x9,%eax
     f58:	cd 40                	int    $0x40
     f5a:	c3                   	ret    

00000f5b <dup>:
SYSCALL(dup)
     f5b:	b8 0a 00 00 00       	mov    $0xa,%eax
     f60:	cd 40                	int    $0x40
     f62:	c3                   	ret    

00000f63 <getpid>:
SYSCALL(getpid)
     f63:	b8 0b 00 00 00       	mov    $0xb,%eax
     f68:	cd 40                	int    $0x40
     f6a:	c3                   	ret    

00000f6b <sbrk>:
SYSCALL(sbrk)
     f6b:	b8 0c 00 00 00       	mov    $0xc,%eax
     f70:	cd 40                	int    $0x40
     f72:	c3                   	ret    

00000f73 <sleep>:
SYSCALL(sleep)
     f73:	b8 0d 00 00 00       	mov    $0xd,%eax
     f78:	cd 40                	int    $0x40
     f7a:	c3                   	ret    

00000f7b <uptime>:
SYSCALL(uptime)
     f7b:	b8 0e 00 00 00       	mov    $0xe,%eax
     f80:	cd 40                	int    $0x40
     f82:	c3                   	ret    

00000f83 <getreadcount>:
SYSCALL(getreadcount)#new syscall
     f83:	b8 16 00 00 00       	mov    $0x16,%eax
     f88:	cd 40                	int    $0x40
     f8a:	c3                   	ret    
     f8b:	66 90                	xchg   %ax,%ax
     f8d:	66 90                	xchg   %ax,%ax
     f8f:	90                   	nop

00000f90 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     f90:	55                   	push   %ebp
     f91:	89 e5                	mov    %esp,%ebp
     f93:	57                   	push   %edi
     f94:	56                   	push   %esi
     f95:	53                   	push   %ebx
     f96:	83 ec 3c             	sub    $0x3c,%esp
     f99:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
     f9c:	89 d1                	mov    %edx,%ecx
{
     f9e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
     fa1:	85 d2                	test   %edx,%edx
     fa3:	0f 89 7f 00 00 00    	jns    1028 <printint+0x98>
     fa9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
     fad:	74 79                	je     1028 <printint+0x98>
    neg = 1;
     faf:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
     fb6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
     fb8:	31 db                	xor    %ebx,%ebx
     fba:	8d 75 d7             	lea    -0x29(%ebp),%esi
     fbd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
     fc0:	89 c8                	mov    %ecx,%eax
     fc2:	31 d2                	xor    %edx,%edx
     fc4:	89 cf                	mov    %ecx,%edi
     fc6:	f7 75 c4             	divl   -0x3c(%ebp)
     fc9:	0f b6 92 98 14 00 00 	movzbl 0x1498(%edx),%edx
     fd0:	89 45 c0             	mov    %eax,-0x40(%ebp)
     fd3:	89 d8                	mov    %ebx,%eax
     fd5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
     fd8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
     fdb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
     fde:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
     fe1:	76 dd                	jbe    fc0 <printint+0x30>
  if(neg)
     fe3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
     fe6:	85 c9                	test   %ecx,%ecx
     fe8:	74 0c                	je     ff6 <printint+0x66>
    buf[i++] = '-';
     fea:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
     fef:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
     ff1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
     ff6:	8b 7d b8             	mov    -0x48(%ebp),%edi
     ff9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
     ffd:	eb 07                	jmp    1006 <printint+0x76>
     fff:	90                   	nop
    putc(fd, buf[i]);
    1000:	0f b6 13             	movzbl (%ebx),%edx
    1003:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    1006:	83 ec 04             	sub    $0x4,%esp
    1009:	88 55 d7             	mov    %dl,-0x29(%ebp)
    100c:	6a 01                	push   $0x1
    100e:	56                   	push   %esi
    100f:	57                   	push   %edi
    1010:	e8 ee fe ff ff       	call   f03 <write>
  while(--i >= 0)
    1015:	83 c4 10             	add    $0x10,%esp
    1018:	39 de                	cmp    %ebx,%esi
    101a:	75 e4                	jne    1000 <printint+0x70>
}
    101c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    101f:	5b                   	pop    %ebx
    1020:	5e                   	pop    %esi
    1021:	5f                   	pop    %edi
    1022:	5d                   	pop    %ebp
    1023:	c3                   	ret    
    1024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    1028:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    102f:	eb 87                	jmp    fb8 <printint+0x28>
    1031:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1038:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    103f:	90                   	nop

00001040 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1040:	f3 0f 1e fb          	endbr32 
    1044:	55                   	push   %ebp
    1045:	89 e5                	mov    %esp,%ebp
    1047:	57                   	push   %edi
    1048:	56                   	push   %esi
    1049:	53                   	push   %ebx
    104a:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    104d:	8b 75 0c             	mov    0xc(%ebp),%esi
    1050:	0f b6 1e             	movzbl (%esi),%ebx
    1053:	84 db                	test   %bl,%bl
    1055:	0f 84 b4 00 00 00    	je     110f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
    105b:	8d 45 10             	lea    0x10(%ebp),%eax
    105e:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    1061:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    1064:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
    1066:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1069:	eb 33                	jmp    109e <printf+0x5e>
    106b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    106f:	90                   	nop
    1070:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    1073:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    1078:	83 f8 25             	cmp    $0x25,%eax
    107b:	74 17                	je     1094 <printf+0x54>
  write(fd, &c, 1);
    107d:	83 ec 04             	sub    $0x4,%esp
    1080:	88 5d e7             	mov    %bl,-0x19(%ebp)
    1083:	6a 01                	push   $0x1
    1085:	57                   	push   %edi
    1086:	ff 75 08             	pushl  0x8(%ebp)
    1089:	e8 75 fe ff ff       	call   f03 <write>
    108e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    1091:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    1094:	0f b6 1e             	movzbl (%esi),%ebx
    1097:	83 c6 01             	add    $0x1,%esi
    109a:	84 db                	test   %bl,%bl
    109c:	74 71                	je     110f <printf+0xcf>
    c = fmt[i] & 0xff;
    109e:	0f be cb             	movsbl %bl,%ecx
    10a1:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    10a4:	85 d2                	test   %edx,%edx
    10a6:	74 c8                	je     1070 <printf+0x30>
      }
    } else if(state == '%'){
    10a8:	83 fa 25             	cmp    $0x25,%edx
    10ab:	75 e7                	jne    1094 <printf+0x54>
      if(c == 'd'){
    10ad:	83 f8 64             	cmp    $0x64,%eax
    10b0:	0f 84 9a 00 00 00    	je     1150 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    10b6:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    10bc:	83 f9 70             	cmp    $0x70,%ecx
    10bf:	74 5f                	je     1120 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    10c1:	83 f8 73             	cmp    $0x73,%eax
    10c4:	0f 84 d6 00 00 00    	je     11a0 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    10ca:	83 f8 63             	cmp    $0x63,%eax
    10cd:	0f 84 8d 00 00 00    	je     1160 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    10d3:	83 f8 25             	cmp    $0x25,%eax
    10d6:	0f 84 b4 00 00 00    	je     1190 <printf+0x150>
  write(fd, &c, 1);
    10dc:	83 ec 04             	sub    $0x4,%esp
    10df:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    10e3:	6a 01                	push   $0x1
    10e5:	57                   	push   %edi
    10e6:	ff 75 08             	pushl  0x8(%ebp)
    10e9:	e8 15 fe ff ff       	call   f03 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    10ee:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    10f1:	83 c4 0c             	add    $0xc,%esp
    10f4:	6a 01                	push   $0x1
  for(i = 0; fmt[i]; i++){
    10f6:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    10f9:	57                   	push   %edi
    10fa:	ff 75 08             	pushl  0x8(%ebp)
    10fd:	e8 01 fe ff ff       	call   f03 <write>
  for(i = 0; fmt[i]; i++){
    1102:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
    1106:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    1109:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    110b:	84 db                	test   %bl,%bl
    110d:	75 8f                	jne    109e <printf+0x5e>
    }
  }
}
    110f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1112:	5b                   	pop    %ebx
    1113:	5e                   	pop    %esi
    1114:	5f                   	pop    %edi
    1115:	5d                   	pop    %ebp
    1116:	c3                   	ret    
    1117:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    111e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
    1120:	83 ec 0c             	sub    $0xc,%esp
    1123:	b9 10 00 00 00       	mov    $0x10,%ecx
    1128:	6a 00                	push   $0x0
    112a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    112d:	8b 45 08             	mov    0x8(%ebp),%eax
    1130:	8b 13                	mov    (%ebx),%edx
    1132:	e8 59 fe ff ff       	call   f90 <printint>
        ap++;
    1137:	89 d8                	mov    %ebx,%eax
    1139:	83 c4 10             	add    $0x10,%esp
      state = 0;
    113c:	31 d2                	xor    %edx,%edx
        ap++;
    113e:	83 c0 04             	add    $0x4,%eax
    1141:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1144:	e9 4b ff ff ff       	jmp    1094 <printf+0x54>
    1149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
    1150:	83 ec 0c             	sub    $0xc,%esp
    1153:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1158:	6a 01                	push   $0x1
    115a:	eb ce                	jmp    112a <printf+0xea>
    115c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
    1160:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    1163:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    1166:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
    1168:	6a 01                	push   $0x1
        ap++;
    116a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    116d:	57                   	push   %edi
    116e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
    1171:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1174:	e8 8a fd ff ff       	call   f03 <write>
        ap++;
    1179:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    117c:	83 c4 10             	add    $0x10,%esp
      state = 0;
    117f:	31 d2                	xor    %edx,%edx
    1181:	e9 0e ff ff ff       	jmp    1094 <printf+0x54>
    1186:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    118d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
    1190:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    1193:	83 ec 04             	sub    $0x4,%esp
    1196:	e9 59 ff ff ff       	jmp    10f4 <printf+0xb4>
    119b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    119f:	90                   	nop
        s = (char*)*ap;
    11a0:	8b 45 d0             	mov    -0x30(%ebp),%eax
    11a3:	8b 18                	mov    (%eax),%ebx
        ap++;
    11a5:	83 c0 04             	add    $0x4,%eax
    11a8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    11ab:	85 db                	test   %ebx,%ebx
    11ad:	74 17                	je     11c6 <printf+0x186>
        while(*s != 0){
    11af:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    11b2:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    11b4:	84 c0                	test   %al,%al
    11b6:	0f 84 d8 fe ff ff    	je     1094 <printf+0x54>
    11bc:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    11bf:	89 de                	mov    %ebx,%esi
    11c1:	8b 5d 08             	mov    0x8(%ebp),%ebx
    11c4:	eb 1a                	jmp    11e0 <printf+0x1a0>
          s = "(null)";
    11c6:	bb 90 14 00 00       	mov    $0x1490,%ebx
        while(*s != 0){
    11cb:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    11ce:	b8 28 00 00 00       	mov    $0x28,%eax
    11d3:	89 de                	mov    %ebx,%esi
    11d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
    11d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    11df:	90                   	nop
  write(fd, &c, 1);
    11e0:	83 ec 04             	sub    $0x4,%esp
          s++;
    11e3:	83 c6 01             	add    $0x1,%esi
    11e6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    11e9:	6a 01                	push   $0x1
    11eb:	57                   	push   %edi
    11ec:	53                   	push   %ebx
    11ed:	e8 11 fd ff ff       	call   f03 <write>
        while(*s != 0){
    11f2:	0f b6 06             	movzbl (%esi),%eax
    11f5:	83 c4 10             	add    $0x10,%esp
    11f8:	84 c0                	test   %al,%al
    11fa:	75 e4                	jne    11e0 <printf+0x1a0>
      state = 0;
    11fc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    11ff:	31 d2                	xor    %edx,%edx
    1201:	e9 8e fe ff ff       	jmp    1094 <printf+0x54>
    1206:	66 90                	xchg   %ax,%ax
    1208:	66 90                	xchg   %ax,%ax
    120a:	66 90                	xchg   %ax,%ax
    120c:	66 90                	xchg   %ax,%ax
    120e:	66 90                	xchg   %ax,%ax

00001210 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1210:	f3 0f 1e fb          	endbr32 
    1214:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1215:	a1 04 1b 00 00       	mov    0x1b04,%eax
{
    121a:	89 e5                	mov    %esp,%ebp
    121c:	57                   	push   %edi
    121d:	56                   	push   %esi
    121e:	53                   	push   %ebx
    121f:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    1222:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1225:	8d 76 00             	lea    0x0(%esi),%esi
    1228:	89 c2                	mov    %eax,%edx
    122a:	8b 00                	mov    (%eax),%eax
    122c:	39 ca                	cmp    %ecx,%edx
    122e:	73 30                	jae    1260 <free+0x50>
    1230:	39 c1                	cmp    %eax,%ecx
    1232:	72 04                	jb     1238 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1234:	39 c2                	cmp    %eax,%edx
    1236:	72 f0                	jb     1228 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1238:	8b 73 fc             	mov    -0x4(%ebx),%esi
    123b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    123e:	39 f8                	cmp    %edi,%eax
    1240:	74 30                	je     1272 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1242:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    1245:	8b 42 04             	mov    0x4(%edx),%eax
    1248:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    124b:	39 f1                	cmp    %esi,%ecx
    124d:	74 3a                	je     1289 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    124f:	89 0a                	mov    %ecx,(%edx)
  freep = p;
}
    1251:	5b                   	pop    %ebx
  freep = p;
    1252:	89 15 04 1b 00 00    	mov    %edx,0x1b04
}
    1258:	5e                   	pop    %esi
    1259:	5f                   	pop    %edi
    125a:	5d                   	pop    %ebp
    125b:	c3                   	ret    
    125c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1260:	39 c2                	cmp    %eax,%edx
    1262:	72 c4                	jb     1228 <free+0x18>
    1264:	39 c1                	cmp    %eax,%ecx
    1266:	73 c0                	jae    1228 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    1268:	8b 73 fc             	mov    -0x4(%ebx),%esi
    126b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    126e:	39 f8                	cmp    %edi,%eax
    1270:	75 d0                	jne    1242 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    1272:	03 70 04             	add    0x4(%eax),%esi
    1275:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1278:	8b 02                	mov    (%edx),%eax
    127a:	8b 00                	mov    (%eax),%eax
    127c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    127f:	8b 42 04             	mov    0x4(%edx),%eax
    1282:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    1285:	39 f1                	cmp    %esi,%ecx
    1287:	75 c6                	jne    124f <free+0x3f>
    p->s.size += bp->s.size;
    1289:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    128c:	89 15 04 1b 00 00    	mov    %edx,0x1b04
    p->s.size += bp->s.size;
    1292:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    1295:	8b 43 f8             	mov    -0x8(%ebx),%eax
    1298:	89 02                	mov    %eax,(%edx)
}
    129a:	5b                   	pop    %ebx
    129b:	5e                   	pop    %esi
    129c:	5f                   	pop    %edi
    129d:	5d                   	pop    %ebp
    129e:	c3                   	ret    
    129f:	90                   	nop

000012a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    12a0:	f3 0f 1e fb          	endbr32 
    12a4:	55                   	push   %ebp
    12a5:	89 e5                	mov    %esp,%ebp
    12a7:	57                   	push   %edi
    12a8:	56                   	push   %esi
    12a9:	53                   	push   %ebx
    12aa:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    12ad:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    12b0:	8b 3d 04 1b 00 00    	mov    0x1b04,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    12b6:	8d 70 07             	lea    0x7(%eax),%esi
    12b9:	c1 ee 03             	shr    $0x3,%esi
    12bc:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    12bf:	85 ff                	test   %edi,%edi
    12c1:	0f 84 a9 00 00 00    	je     1370 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    12c7:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
    12c9:	8b 48 04             	mov    0x4(%eax),%ecx
    12cc:	39 f1                	cmp    %esi,%ecx
    12ce:	73 6d                	jae    133d <malloc+0x9d>
    12d0:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    12d6:	bb 00 10 00 00       	mov    $0x1000,%ebx
    12db:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    12de:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
    12e5:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    12e8:	eb 17                	jmp    1301 <malloc+0x61>
    12ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    12f0:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
    12f2:	8b 4a 04             	mov    0x4(%edx),%ecx
    12f5:	39 f1                	cmp    %esi,%ecx
    12f7:	73 4f                	jae    1348 <malloc+0xa8>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    12f9:	8b 3d 04 1b 00 00    	mov    0x1b04,%edi
    12ff:	89 d0                	mov    %edx,%eax
    1301:	39 c7                	cmp    %eax,%edi
    1303:	75 eb                	jne    12f0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
    1305:	83 ec 0c             	sub    $0xc,%esp
    1308:	ff 75 e4             	pushl  -0x1c(%ebp)
    130b:	e8 5b fc ff ff       	call   f6b <sbrk>
  if(p == (char*)-1)
    1310:	83 c4 10             	add    $0x10,%esp
    1313:	83 f8 ff             	cmp    $0xffffffff,%eax
    1316:	74 1b                	je     1333 <malloc+0x93>
  hp->s.size = nu;
    1318:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    131b:	83 ec 0c             	sub    $0xc,%esp
    131e:	83 c0 08             	add    $0x8,%eax
    1321:	50                   	push   %eax
    1322:	e8 e9 fe ff ff       	call   1210 <free>
  return freep;
    1327:	a1 04 1b 00 00       	mov    0x1b04,%eax
      if((p = morecore(nunits)) == 0)
    132c:	83 c4 10             	add    $0x10,%esp
    132f:	85 c0                	test   %eax,%eax
    1331:	75 bd                	jne    12f0 <malloc+0x50>
        return 0;
  }
}
    1333:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    1336:	31 c0                	xor    %eax,%eax
}
    1338:	5b                   	pop    %ebx
    1339:	5e                   	pop    %esi
    133a:	5f                   	pop    %edi
    133b:	5d                   	pop    %ebp
    133c:	c3                   	ret    
    if(p->s.size >= nunits){
    133d:	89 c2                	mov    %eax,%edx
    133f:	89 f8                	mov    %edi,%eax
    1341:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    1348:	39 ce                	cmp    %ecx,%esi
    134a:	74 54                	je     13a0 <malloc+0x100>
        p->s.size -= nunits;
    134c:	29 f1                	sub    %esi,%ecx
    134e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
    1351:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
    1354:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
    1357:	a3 04 1b 00 00       	mov    %eax,0x1b04
}
    135c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    135f:	8d 42 08             	lea    0x8(%edx),%eax
}
    1362:	5b                   	pop    %ebx
    1363:	5e                   	pop    %esi
    1364:	5f                   	pop    %edi
    1365:	5d                   	pop    %ebp
    1366:	c3                   	ret    
    1367:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    136e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    1370:	c7 05 04 1b 00 00 08 	movl   $0x1b08,0x1b04
    1377:	1b 00 00 
    base.s.size = 0;
    137a:	bf 08 1b 00 00       	mov    $0x1b08,%edi
    base.s.ptr = freep = prevp = &base;
    137f:	c7 05 08 1b 00 00 08 	movl   $0x1b08,0x1b08
    1386:	1b 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1389:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
    138b:	c7 05 0c 1b 00 00 00 	movl   $0x0,0x1b0c
    1392:	00 00 00 
    if(p->s.size >= nunits){
    1395:	e9 36 ff ff ff       	jmp    12d0 <malloc+0x30>
    139a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    13a0:	8b 0a                	mov    (%edx),%ecx
    13a2:	89 08                	mov    %ecx,(%eax)
    13a4:	eb b1                	jmp    1357 <malloc+0xb7>
