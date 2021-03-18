
_grep：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
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
  11:	57                   	push   %edi
  12:	56                   	push   %esi
  13:	53                   	push   %ebx
  14:	51                   	push   %ecx
  15:	83 ec 18             	sub    $0x18,%esp
  18:	8b 01                	mov    (%ecx),%eax
  1a:	8b 59 04             	mov    0x4(%ecx),%ebx
  1d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int fd, i;
  char *pattern;

  if(argc <= 1){
  20:	83 f8 01             	cmp    $0x1,%eax
  23:	7e 6b                	jle    90 <main+0x90>
    printf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];
  25:	8b 43 04             	mov    0x4(%ebx),%eax
  28:	83 c3 08             	add    $0x8,%ebx

  if(argc <= 2){
  2b:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
  2f:	be 02 00 00 00       	mov    $0x2,%esi
  pattern = argv[1];
  34:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(argc <= 2){
  37:	75 29                	jne    62 <main+0x62>
  39:	eb 68                	jmp    a3 <main+0xa3>
  3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  3f:	90                   	nop
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
  40:	83 ec 08             	sub    $0x8,%esp
  for(i = 2; i < argc; i++){
  43:	83 c6 01             	add    $0x1,%esi
  46:	83 c3 04             	add    $0x4,%ebx
    grep(pattern, fd);
  49:	50                   	push   %eax
  4a:	ff 75 e0             	pushl  -0x20(%ebp)
  4d:	e8 8e 01 00 00       	call   1e0 <grep>
    close(fd);
  52:	89 3c 24             	mov    %edi,(%esp)
  55:	e8 b1 05 00 00       	call   60b <close>
  for(i = 2; i < argc; i++){
  5a:	83 c4 10             	add    $0x10,%esp
  5d:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  60:	7e 29                	jle    8b <main+0x8b>
    if((fd = open(argv[i], 0)) < 0){
  62:	83 ec 08             	sub    $0x8,%esp
  65:	6a 00                	push   $0x0
  67:	ff 33                	pushl  (%ebx)
  69:	e8 b5 05 00 00       	call   623 <open>
  6e:	83 c4 10             	add    $0x10,%esp
  71:	89 c7                	mov    %eax,%edi
  73:	85 c0                	test   %eax,%eax
  75:	79 c9                	jns    40 <main+0x40>
      printf(1, "grep: cannot open %s\n", argv[i]);
  77:	50                   	push   %eax
  78:	ff 33                	pushl  (%ebx)
  7a:	68 b8 0a 00 00       	push   $0xab8
  7f:	6a 01                	push   $0x1
  81:	e8 ba 06 00 00       	call   740 <printf>
      exit();
  86:	e8 58 05 00 00       	call   5e3 <exit>
  }
  exit();
  8b:	e8 53 05 00 00       	call   5e3 <exit>
    printf(2, "usage: grep pattern [file ...]\n");
  90:	51                   	push   %ecx
  91:	51                   	push   %ecx
  92:	68 98 0a 00 00       	push   $0xa98
  97:	6a 02                	push   $0x2
  99:	e8 a2 06 00 00       	call   740 <printf>
    exit();
  9e:	e8 40 05 00 00       	call   5e3 <exit>
    grep(pattern, 0);
  a3:	52                   	push   %edx
  a4:	52                   	push   %edx
  a5:	6a 00                	push   $0x0
  a7:	50                   	push   %eax
  a8:	e8 33 01 00 00       	call   1e0 <grep>
    exit();
  ad:	e8 31 05 00 00       	call   5e3 <exit>
  b2:	66 90                	xchg   %ax,%ax
  b4:	66 90                	xchg   %ax,%ax
  b6:	66 90                	xchg   %ax,%ax
  b8:	66 90                	xchg   %ax,%ax
  ba:	66 90                	xchg   %ax,%ax
  bc:	66 90                	xchg   %ax,%ax
  be:	66 90                	xchg   %ax,%ax

000000c0 <matchhere>:
  return 0;
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  c0:	f3 0f 1e fb          	endbr32 
  c4:	55                   	push   %ebp
  c5:	89 e5                	mov    %esp,%ebp
  c7:	57                   	push   %edi
  c8:	56                   	push   %esi
  c9:	53                   	push   %ebx
  ca:	83 ec 0c             	sub    $0xc,%esp
  cd:	8b 75 08             	mov    0x8(%ebp),%esi
  d0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '\0')
  d3:	0f b6 06             	movzbl (%esi),%eax
  d6:	84 c0                	test   %al,%al
  d8:	75 29                	jne    103 <matchhere+0x43>
  da:	eb 7c                	jmp    158 <matchhere+0x98>
  dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 1;
  if(re[1] == '*')
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  e0:	0f b6 0b             	movzbl (%ebx),%ecx
  if(re[0] == '$' && re[1] == '\0')
  e3:	80 fa 24             	cmp    $0x24,%dl
  e6:	75 04                	jne    ec <matchhere+0x2c>
  e8:	84 c0                	test   %al,%al
  ea:	74 79                	je     165 <matchhere+0xa5>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  ec:	84 c9                	test   %cl,%cl
  ee:	74 58                	je     148 <matchhere+0x88>
  f0:	38 d1                	cmp    %dl,%cl
  f2:	74 05                	je     f9 <matchhere+0x39>
  f4:	80 fa 2e             	cmp    $0x2e,%dl
  f7:	75 4f                	jne    148 <matchhere+0x88>
    return matchhere(re+1, text+1);
  f9:	83 c3 01             	add    $0x1,%ebx
  fc:	83 c6 01             	add    $0x1,%esi
  if(re[0] == '\0')
  ff:	84 c0                	test   %al,%al
 101:	74 55                	je     158 <matchhere+0x98>
  if(re[1] == '*')
 103:	89 c2                	mov    %eax,%edx
 105:	0f b6 46 01          	movzbl 0x1(%esi),%eax
 109:	3c 2a                	cmp    $0x2a,%al
 10b:	75 d3                	jne    e0 <matchhere+0x20>
    return matchstar(re[0], re+2, text);
 10d:	83 c6 02             	add    $0x2,%esi
 110:	0f be fa             	movsbl %dl,%edi
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
 113:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 117:	90                   	nop
{
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
 118:	83 ec 08             	sub    $0x8,%esp
 11b:	53                   	push   %ebx
 11c:	56                   	push   %esi
 11d:	e8 9e ff ff ff       	call   c0 <matchhere>
 122:	83 c4 10             	add    $0x10,%esp
 125:	85 c0                	test   %eax,%eax
 127:	75 2f                	jne    158 <matchhere+0x98>
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
 129:	0f be 13             	movsbl (%ebx),%edx
 12c:	84 d2                	test   %dl,%dl
 12e:	74 0c                	je     13c <matchhere+0x7c>
 130:	83 c3 01             	add    $0x1,%ebx
 133:	83 ff 2e             	cmp    $0x2e,%edi
 136:	74 e0                	je     118 <matchhere+0x58>
 138:	39 fa                	cmp    %edi,%edx
 13a:	74 dc                	je     118 <matchhere+0x58>
}
 13c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 13f:	5b                   	pop    %ebx
 140:	5e                   	pop    %esi
 141:	5f                   	pop    %edi
 142:	5d                   	pop    %ebp
 143:	c3                   	ret    
 144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 148:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
 14b:	31 c0                	xor    %eax,%eax
}
 14d:	5b                   	pop    %ebx
 14e:	5e                   	pop    %esi
 14f:	5f                   	pop    %edi
 150:	5d                   	pop    %ebp
 151:	c3                   	ret    
 152:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 158:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 1;
 15b:	b8 01 00 00 00       	mov    $0x1,%eax
}
 160:	5b                   	pop    %ebx
 161:	5e                   	pop    %esi
 162:	5f                   	pop    %edi
 163:	5d                   	pop    %ebp
 164:	c3                   	ret    
    return *text == '\0';
 165:	31 c0                	xor    %eax,%eax
 167:	84 c9                	test   %cl,%cl
 169:	0f 94 c0             	sete   %al
 16c:	eb ce                	jmp    13c <matchhere+0x7c>
 16e:	66 90                	xchg   %ax,%ax

00000170 <match>:
{
 170:	f3 0f 1e fb          	endbr32 
 174:	55                   	push   %ebp
 175:	89 e5                	mov    %esp,%ebp
 177:	56                   	push   %esi
 178:	53                   	push   %ebx
 179:	8b 5d 08             	mov    0x8(%ebp),%ebx
 17c:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(re[0] == '^')
 17f:	80 3b 5e             	cmpb   $0x5e,(%ebx)
 182:	75 15                	jne    199 <match+0x29>
 184:	eb 3a                	jmp    1c0 <match+0x50>
 186:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 18d:	8d 76 00             	lea    0x0(%esi),%esi
  }while(*text++ != '\0');
 190:	83 c6 01             	add    $0x1,%esi
 193:	80 7e ff 00          	cmpb   $0x0,-0x1(%esi)
 197:	74 16                	je     1af <match+0x3f>
    if(matchhere(re, text))
 199:	83 ec 08             	sub    $0x8,%esp
 19c:	56                   	push   %esi
 19d:	53                   	push   %ebx
 19e:	e8 1d ff ff ff       	call   c0 <matchhere>
 1a3:	83 c4 10             	add    $0x10,%esp
 1a6:	85 c0                	test   %eax,%eax
 1a8:	74 e6                	je     190 <match+0x20>
      return 1;
 1aa:	b8 01 00 00 00       	mov    $0x1,%eax
}
 1af:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1b2:	5b                   	pop    %ebx
 1b3:	5e                   	pop    %esi
 1b4:	5d                   	pop    %ebp
 1b5:	c3                   	ret    
 1b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1bd:	8d 76 00             	lea    0x0(%esi),%esi
    return matchhere(re+1, text);
 1c0:	83 c3 01             	add    $0x1,%ebx
 1c3:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
 1c6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1c9:	5b                   	pop    %ebx
 1ca:	5e                   	pop    %esi
 1cb:	5d                   	pop    %ebp
    return matchhere(re+1, text);
 1cc:	e9 ef fe ff ff       	jmp    c0 <matchhere>
 1d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1df:	90                   	nop

000001e0 <grep>:
{
 1e0:	f3 0f 1e fb          	endbr32 
 1e4:	55                   	push   %ebp
 1e5:	89 e5                	mov    %esp,%ebp
 1e7:	57                   	push   %edi
 1e8:	56                   	push   %esi
 1e9:	53                   	push   %ebx
 1ea:	83 ec 1c             	sub    $0x1c,%esp
 1ed:	8b 7d 08             	mov    0x8(%ebp),%edi
  m = 0;
 1f0:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    return matchhere(re+1, text);
 1f7:	8d 47 01             	lea    0x1(%edi),%eax
 1fa:	89 45 d8             	mov    %eax,-0x28(%ebp)
 1fd:	8d 76 00             	lea    0x0(%esi),%esi
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 200:	8b 4d dc             	mov    -0x24(%ebp),%ecx
 203:	b8 ff 03 00 00       	mov    $0x3ff,%eax
 208:	83 ec 04             	sub    $0x4,%esp
 20b:	29 c8                	sub    %ecx,%eax
 20d:	50                   	push   %eax
 20e:	8d 81 80 0e 00 00    	lea    0xe80(%ecx),%eax
 214:	50                   	push   %eax
 215:	ff 75 0c             	pushl  0xc(%ebp)
 218:	e8 de 03 00 00       	call   5fb <read>
 21d:	83 c4 10             	add    $0x10,%esp
 220:	85 c0                	test   %eax,%eax
 222:	0f 8e e5 00 00 00    	jle    30d <grep+0x12d>
    m += n;
 228:	01 45 dc             	add    %eax,-0x24(%ebp)
 22b:	8b 4d dc             	mov    -0x24(%ebp),%ecx
    p = buf;
 22e:	c7 45 e4 80 0e 00 00 	movl   $0xe80,-0x1c(%ebp)
    buf[m] = '\0';
 235:	c6 81 80 0e 00 00 00 	movb   $0x0,0xe80(%ecx)
    while((q = strchr(p, '\n')) != 0){
 23c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 240:	83 ec 08             	sub    $0x8,%esp
 243:	6a 0a                	push   $0xa
 245:	ff 75 e4             	pushl  -0x1c(%ebp)
 248:	e8 13 02 00 00       	call   460 <strchr>
 24d:	83 c4 10             	add    $0x10,%esp
 250:	89 c3                	mov    %eax,%ebx
 252:	85 c0                	test   %eax,%eax
 254:	74 72                	je     2c8 <grep+0xe8>
      *q = 0;
 256:	c6 03 00             	movb   $0x0,(%ebx)
        write(1, p, q+1 - p);
 259:	8d 43 01             	lea    0x1(%ebx),%eax
  if(re[0] == '^')
 25c:	80 3f 5e             	cmpb   $0x5e,(%edi)
        write(1, p, q+1 - p);
 25f:	89 45 e0             	mov    %eax,-0x20(%ebp)
 262:	8b 75 e4             	mov    -0x1c(%ebp),%esi
  if(re[0] == '^')
 265:	75 12                	jne    279 <grep+0x99>
 267:	eb 47                	jmp    2b0 <grep+0xd0>
 269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }while(*text++ != '\0');
 270:	83 c6 01             	add    $0x1,%esi
 273:	80 7e ff 00          	cmpb   $0x0,-0x1(%esi)
 277:	74 2b                	je     2a4 <grep+0xc4>
    if(matchhere(re, text))
 279:	83 ec 08             	sub    $0x8,%esp
 27c:	56                   	push   %esi
 27d:	57                   	push   %edi
 27e:	e8 3d fe ff ff       	call   c0 <matchhere>
 283:	83 c4 10             	add    $0x10,%esp
 286:	85 c0                	test   %eax,%eax
 288:	74 e6                	je     270 <grep+0x90>
        write(1, p, q+1 - p);
 28a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 28d:	8b 45 e0             	mov    -0x20(%ebp),%eax
 290:	83 ec 04             	sub    $0x4,%esp
        *q = '\n';
 293:	c6 03 0a             	movb   $0xa,(%ebx)
        write(1, p, q+1 - p);
 296:	29 d0                	sub    %edx,%eax
 298:	50                   	push   %eax
 299:	52                   	push   %edx
 29a:	6a 01                	push   $0x1
 29c:	e8 62 03 00 00       	call   603 <write>
 2a1:	83 c4 10             	add    $0x10,%esp
      p = q+1;
 2a4:	8b 45 e0             	mov    -0x20(%ebp),%eax
 2a7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 2aa:	eb 94                	jmp    240 <grep+0x60>
 2ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return matchhere(re+1, text);
 2b0:	83 ec 08             	sub    $0x8,%esp
 2b3:	56                   	push   %esi
 2b4:	ff 75 d8             	pushl  -0x28(%ebp)
 2b7:	e8 04 fe ff ff       	call   c0 <matchhere>
 2bc:	83 c4 10             	add    $0x10,%esp
      if(match(pattern, p)){
 2bf:	85 c0                	test   %eax,%eax
 2c1:	74 e1                	je     2a4 <grep+0xc4>
 2c3:	eb c5                	jmp    28a <grep+0xaa>
 2c5:	8d 76 00             	lea    0x0(%esi),%esi
    if(p == buf)
 2c8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 2cb:	81 fa 80 0e 00 00    	cmp    $0xe80,%edx
 2d1:	74 2e                	je     301 <grep+0x121>
    if(m > 0){
 2d3:	8b 4d dc             	mov    -0x24(%ebp),%ecx
 2d6:	85 c9                	test   %ecx,%ecx
 2d8:	0f 8e 22 ff ff ff    	jle    200 <grep+0x20>
      m -= p - buf;
 2de:	89 d0                	mov    %edx,%eax
      memmove(buf, p, m);
 2e0:	83 ec 04             	sub    $0x4,%esp
      m -= p - buf;
 2e3:	2d 80 0e 00 00       	sub    $0xe80,%eax
 2e8:	29 c1                	sub    %eax,%ecx
      memmove(buf, p, m);
 2ea:	51                   	push   %ecx
 2eb:	52                   	push   %edx
 2ec:	68 80 0e 00 00       	push   $0xe80
      m -= p - buf;
 2f1:	89 4d dc             	mov    %ecx,-0x24(%ebp)
      memmove(buf, p, m);
 2f4:	e8 b7 02 00 00       	call   5b0 <memmove>
 2f9:	83 c4 10             	add    $0x10,%esp
 2fc:	e9 ff fe ff ff       	jmp    200 <grep+0x20>
      m = 0;
 301:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
 308:	e9 f3 fe ff ff       	jmp    200 <grep+0x20>
}
 30d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 310:	5b                   	pop    %ebx
 311:	5e                   	pop    %esi
 312:	5f                   	pop    %edi
 313:	5d                   	pop    %ebp
 314:	c3                   	ret    
 315:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 31c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000320 <matchstar>:
{
 320:	f3 0f 1e fb          	endbr32 
 324:	55                   	push   %ebp
 325:	89 e5                	mov    %esp,%ebp
 327:	57                   	push   %edi
 328:	56                   	push   %esi
 329:	53                   	push   %ebx
 32a:	83 ec 0c             	sub    $0xc,%esp
 32d:	8b 5d 08             	mov    0x8(%ebp),%ebx
 330:	8b 75 0c             	mov    0xc(%ebp),%esi
 333:	8b 7d 10             	mov    0x10(%ebp),%edi
 336:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 33d:	8d 76 00             	lea    0x0(%esi),%esi
    if(matchhere(re, text))
 340:	83 ec 08             	sub    $0x8,%esp
 343:	57                   	push   %edi
 344:	56                   	push   %esi
 345:	e8 76 fd ff ff       	call   c0 <matchhere>
 34a:	83 c4 10             	add    $0x10,%esp
 34d:	89 c2                	mov    %eax,%edx
 34f:	85 c0                	test   %eax,%eax
 351:	75 1d                	jne    370 <matchstar+0x50>
  }while(*text!='\0' && (*text++==c || c=='.'));
 353:	0f be 07             	movsbl (%edi),%eax
 356:	84 c0                	test   %al,%al
 358:	74 0c                	je     366 <matchstar+0x46>
 35a:	83 c7 01             	add    $0x1,%edi
 35d:	39 d8                	cmp    %ebx,%eax
 35f:	74 df                	je     340 <matchstar+0x20>
 361:	83 fb 2e             	cmp    $0x2e,%ebx
 364:	74 da                	je     340 <matchstar+0x20>
}
 366:	8d 65 f4             	lea    -0xc(%ebp),%esp
 369:	89 d0                	mov    %edx,%eax
 36b:	5b                   	pop    %ebx
 36c:	5e                   	pop    %esi
 36d:	5f                   	pop    %edi
 36e:	5d                   	pop    %ebp
 36f:	c3                   	ret    
 370:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 1;
 373:	ba 01 00 00 00       	mov    $0x1,%edx
}
 378:	5b                   	pop    %ebx
 379:	89 d0                	mov    %edx,%eax
 37b:	5e                   	pop    %esi
 37c:	5f                   	pop    %edi
 37d:	5d                   	pop    %ebp
 37e:	c3                   	ret    
 37f:	90                   	nop

00000380 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 380:	f3 0f 1e fb          	endbr32 
 384:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 385:	31 c0                	xor    %eax,%eax
{
 387:	89 e5                	mov    %esp,%ebp
 389:	53                   	push   %ebx
 38a:	8b 4d 08             	mov    0x8(%ebp),%ecx
 38d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
 390:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 394:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 397:	83 c0 01             	add    $0x1,%eax
 39a:	84 d2                	test   %dl,%dl
 39c:	75 f2                	jne    390 <strcpy+0x10>
    ;
  return os;
}
 39e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3a1:	89 c8                	mov    %ecx,%eax
 3a3:	c9                   	leave  
 3a4:	c3                   	ret    
 3a5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3b0:	f3 0f 1e fb          	endbr32 
 3b4:	55                   	push   %ebp
 3b5:	89 e5                	mov    %esp,%ebp
 3b7:	53                   	push   %ebx
 3b8:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 3be:	0f b6 01             	movzbl (%ecx),%eax
 3c1:	0f b6 1a             	movzbl (%edx),%ebx
 3c4:	84 c0                	test   %al,%al
 3c6:	75 19                	jne    3e1 <strcmp+0x31>
 3c8:	eb 26                	jmp    3f0 <strcmp+0x40>
 3ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3d0:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 3d4:	83 c1 01             	add    $0x1,%ecx
 3d7:	83 c2 01             	add    $0x1,%edx
  return (uchar)*p - (uchar)*q;
 3da:	0f b6 1a             	movzbl (%edx),%ebx
  while(*p && *p == *q)
 3dd:	84 c0                	test   %al,%al
 3df:	74 0f                	je     3f0 <strcmp+0x40>
 3e1:	38 d8                	cmp    %bl,%al
 3e3:	74 eb                	je     3d0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 3e5:	29 d8                	sub    %ebx,%eax
}
 3e7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3ea:	c9                   	leave  
 3eb:	c3                   	ret    
 3ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3f0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 3f2:	29 d8                	sub    %ebx,%eax
}
 3f4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3f7:	c9                   	leave  
 3f8:	c3                   	ret    
 3f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000400 <strlen>:

uint
strlen(const char *s)
{
 400:	f3 0f 1e fb          	endbr32 
 404:	55                   	push   %ebp
 405:	89 e5                	mov    %esp,%ebp
 407:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 40a:	80 3a 00             	cmpb   $0x0,(%edx)
 40d:	74 21                	je     430 <strlen+0x30>
 40f:	31 c0                	xor    %eax,%eax
 411:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 418:	83 c0 01             	add    $0x1,%eax
 41b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 41f:	89 c1                	mov    %eax,%ecx
 421:	75 f5                	jne    418 <strlen+0x18>
    ;
  return n;
}
 423:	89 c8                	mov    %ecx,%eax
 425:	5d                   	pop    %ebp
 426:	c3                   	ret    
 427:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 42e:	66 90                	xchg   %ax,%ax
  for(n = 0; s[n]; n++)
 430:	31 c9                	xor    %ecx,%ecx
}
 432:	5d                   	pop    %ebp
 433:	89 c8                	mov    %ecx,%eax
 435:	c3                   	ret    
 436:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 43d:	8d 76 00             	lea    0x0(%esi),%esi

00000440 <memset>:

void*
memset(void *dst, int c, uint n)
{
 440:	f3 0f 1e fb          	endbr32 
 444:	55                   	push   %ebp
 445:	89 e5                	mov    %esp,%ebp
 447:	57                   	push   %edi
 448:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 44b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 44e:	8b 45 0c             	mov    0xc(%ebp),%eax
 451:	89 d7                	mov    %edx,%edi
 453:	fc                   	cld    
 454:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 456:	8b 7d fc             	mov    -0x4(%ebp),%edi
 459:	89 d0                	mov    %edx,%eax
 45b:	c9                   	leave  
 45c:	c3                   	ret    
 45d:	8d 76 00             	lea    0x0(%esi),%esi

00000460 <strchr>:

char*
strchr(const char *s, char c)
{
 460:	f3 0f 1e fb          	endbr32 
 464:	55                   	push   %ebp
 465:	89 e5                	mov    %esp,%ebp
 467:	8b 45 08             	mov    0x8(%ebp),%eax
 46a:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 46e:	0f b6 10             	movzbl (%eax),%edx
 471:	84 d2                	test   %dl,%dl
 473:	75 16                	jne    48b <strchr+0x2b>
 475:	eb 21                	jmp    498 <strchr+0x38>
 477:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 47e:	66 90                	xchg   %ax,%ax
 480:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 484:	83 c0 01             	add    $0x1,%eax
 487:	84 d2                	test   %dl,%dl
 489:	74 0d                	je     498 <strchr+0x38>
    if(*s == c)
 48b:	38 d1                	cmp    %dl,%cl
 48d:	75 f1                	jne    480 <strchr+0x20>
      return (char*)s;
  return 0;
}
 48f:	5d                   	pop    %ebp
 490:	c3                   	ret    
 491:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 498:	31 c0                	xor    %eax,%eax
}
 49a:	5d                   	pop    %ebp
 49b:	c3                   	ret    
 49c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004a0 <gets>:

char*
gets(char *buf, int max)
{
 4a0:	f3 0f 1e fb          	endbr32 
 4a4:	55                   	push   %ebp
 4a5:	89 e5                	mov    %esp,%ebp
 4a7:	57                   	push   %edi
 4a8:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4a9:	31 f6                	xor    %esi,%esi
{
 4ab:	53                   	push   %ebx
 4ac:	89 f3                	mov    %esi,%ebx
 4ae:	83 ec 1c             	sub    $0x1c,%esp
 4b1:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 4b4:	eb 33                	jmp    4e9 <gets+0x49>
 4b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4bd:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 4c0:	83 ec 04             	sub    $0x4,%esp
 4c3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4c6:	6a 01                	push   $0x1
 4c8:	50                   	push   %eax
 4c9:	6a 00                	push   $0x0
 4cb:	e8 2b 01 00 00       	call   5fb <read>
    if(cc < 1)
 4d0:	83 c4 10             	add    $0x10,%esp
 4d3:	85 c0                	test   %eax,%eax
 4d5:	7e 1c                	jle    4f3 <gets+0x53>
      break;
    buf[i++] = c;
 4d7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    if(c == '\n' || c == '\r')
 4db:	83 c7 01             	add    $0x1,%edi
    buf[i++] = c;
 4de:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 4e1:	3c 0a                	cmp    $0xa,%al
 4e3:	74 23                	je     508 <gets+0x68>
 4e5:	3c 0d                	cmp    $0xd,%al
 4e7:	74 1f                	je     508 <gets+0x68>
  for(i=0; i+1 < max; ){
 4e9:	83 c3 01             	add    $0x1,%ebx
    buf[i++] = c;
 4ec:	89 fe                	mov    %edi,%esi
  for(i=0; i+1 < max; ){
 4ee:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 4f1:	7c cd                	jl     4c0 <gets+0x20>
 4f3:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 4f5:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 4f8:	c6 03 00             	movb   $0x0,(%ebx)
}
 4fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4fe:	5b                   	pop    %ebx
 4ff:	5e                   	pop    %esi
 500:	5f                   	pop    %edi
 501:	5d                   	pop    %ebp
 502:	c3                   	ret    
 503:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 507:	90                   	nop
  buf[i] = '\0';
 508:	8b 75 08             	mov    0x8(%ebp),%esi
}
 50b:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 50e:	01 de                	add    %ebx,%esi
 510:	89 f3                	mov    %esi,%ebx
 512:	c6 03 00             	movb   $0x0,(%ebx)
}
 515:	8d 65 f4             	lea    -0xc(%ebp),%esp
 518:	5b                   	pop    %ebx
 519:	5e                   	pop    %esi
 51a:	5f                   	pop    %edi
 51b:	5d                   	pop    %ebp
 51c:	c3                   	ret    
 51d:	8d 76 00             	lea    0x0(%esi),%esi

00000520 <stat>:

int
stat(const char *n, struct stat *st)
{
 520:	f3 0f 1e fb          	endbr32 
 524:	55                   	push   %ebp
 525:	89 e5                	mov    %esp,%ebp
 527:	56                   	push   %esi
 528:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 529:	83 ec 08             	sub    $0x8,%esp
 52c:	6a 00                	push   $0x0
 52e:	ff 75 08             	pushl  0x8(%ebp)
 531:	e8 ed 00 00 00       	call   623 <open>
  if(fd < 0)
 536:	83 c4 10             	add    $0x10,%esp
 539:	85 c0                	test   %eax,%eax
 53b:	78 2b                	js     568 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 53d:	83 ec 08             	sub    $0x8,%esp
 540:	ff 75 0c             	pushl  0xc(%ebp)
 543:	89 c3                	mov    %eax,%ebx
 545:	50                   	push   %eax
 546:	e8 f0 00 00 00       	call   63b <fstat>
  close(fd);
 54b:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 54e:	89 c6                	mov    %eax,%esi
  close(fd);
 550:	e8 b6 00 00 00       	call   60b <close>
  return r;
 555:	83 c4 10             	add    $0x10,%esp
}
 558:	8d 65 f8             	lea    -0x8(%ebp),%esp
 55b:	89 f0                	mov    %esi,%eax
 55d:	5b                   	pop    %ebx
 55e:	5e                   	pop    %esi
 55f:	5d                   	pop    %ebp
 560:	c3                   	ret    
 561:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 568:	be ff ff ff ff       	mov    $0xffffffff,%esi
 56d:	eb e9                	jmp    558 <stat+0x38>
 56f:	90                   	nop

00000570 <atoi>:

int
atoi(const char *s)
{
 570:	f3 0f 1e fb          	endbr32 
 574:	55                   	push   %ebp
 575:	89 e5                	mov    %esp,%ebp
 577:	53                   	push   %ebx
 578:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 57b:	0f be 02             	movsbl (%edx),%eax
 57e:	8d 48 d0             	lea    -0x30(%eax),%ecx
 581:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 584:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 589:	77 1a                	ja     5a5 <atoi+0x35>
 58b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 58f:	90                   	nop
    n = n*10 + *s++ - '0';
 590:	83 c2 01             	add    $0x1,%edx
 593:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 596:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 59a:	0f be 02             	movsbl (%edx),%eax
 59d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 5a0:	80 fb 09             	cmp    $0x9,%bl
 5a3:	76 eb                	jbe    590 <atoi+0x20>
  return n;
}
 5a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 5a8:	89 c8                	mov    %ecx,%eax
 5aa:	c9                   	leave  
 5ab:	c3                   	ret    
 5ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000005b0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 5b0:	f3 0f 1e fb          	endbr32 
 5b4:	55                   	push   %ebp
 5b5:	89 e5                	mov    %esp,%ebp
 5b7:	57                   	push   %edi
 5b8:	8b 45 10             	mov    0x10(%ebp),%eax
 5bb:	8b 55 08             	mov    0x8(%ebp),%edx
 5be:	56                   	push   %esi
 5bf:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5c2:	85 c0                	test   %eax,%eax
 5c4:	7e 0f                	jle    5d5 <memmove+0x25>
 5c6:	01 d0                	add    %edx,%eax
  dst = vdst;
 5c8:	89 d7                	mov    %edx,%edi
 5ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
 5d0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 5d1:	39 f8                	cmp    %edi,%eax
 5d3:	75 fb                	jne    5d0 <memmove+0x20>
  return vdst;
}
 5d5:	5e                   	pop    %esi
 5d6:	89 d0                	mov    %edx,%eax
 5d8:	5f                   	pop    %edi
 5d9:	5d                   	pop    %ebp
 5da:	c3                   	ret    

000005db <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5db:	b8 01 00 00 00       	mov    $0x1,%eax
 5e0:	cd 40                	int    $0x40
 5e2:	c3                   	ret    

000005e3 <exit>:
SYSCALL(exit)
 5e3:	b8 02 00 00 00       	mov    $0x2,%eax
 5e8:	cd 40                	int    $0x40
 5ea:	c3                   	ret    

000005eb <wait>:
SYSCALL(wait)
 5eb:	b8 03 00 00 00       	mov    $0x3,%eax
 5f0:	cd 40                	int    $0x40
 5f2:	c3                   	ret    

000005f3 <pipe>:
SYSCALL(pipe)
 5f3:	b8 04 00 00 00       	mov    $0x4,%eax
 5f8:	cd 40                	int    $0x40
 5fa:	c3                   	ret    

000005fb <read>:
SYSCALL(read)
 5fb:	b8 05 00 00 00       	mov    $0x5,%eax
 600:	cd 40                	int    $0x40
 602:	c3                   	ret    

00000603 <write>:
SYSCALL(write)
 603:	b8 10 00 00 00       	mov    $0x10,%eax
 608:	cd 40                	int    $0x40
 60a:	c3                   	ret    

0000060b <close>:
SYSCALL(close)
 60b:	b8 15 00 00 00       	mov    $0x15,%eax
 610:	cd 40                	int    $0x40
 612:	c3                   	ret    

00000613 <kill>:
SYSCALL(kill)
 613:	b8 06 00 00 00       	mov    $0x6,%eax
 618:	cd 40                	int    $0x40
 61a:	c3                   	ret    

0000061b <exec>:
SYSCALL(exec)
 61b:	b8 07 00 00 00       	mov    $0x7,%eax
 620:	cd 40                	int    $0x40
 622:	c3                   	ret    

00000623 <open>:
SYSCALL(open)
 623:	b8 0f 00 00 00       	mov    $0xf,%eax
 628:	cd 40                	int    $0x40
 62a:	c3                   	ret    

0000062b <mknod>:
SYSCALL(mknod)
 62b:	b8 11 00 00 00       	mov    $0x11,%eax
 630:	cd 40                	int    $0x40
 632:	c3                   	ret    

00000633 <unlink>:
SYSCALL(unlink)
 633:	b8 12 00 00 00       	mov    $0x12,%eax
 638:	cd 40                	int    $0x40
 63a:	c3                   	ret    

0000063b <fstat>:
SYSCALL(fstat)
 63b:	b8 08 00 00 00       	mov    $0x8,%eax
 640:	cd 40                	int    $0x40
 642:	c3                   	ret    

00000643 <link>:
SYSCALL(link)
 643:	b8 13 00 00 00       	mov    $0x13,%eax
 648:	cd 40                	int    $0x40
 64a:	c3                   	ret    

0000064b <mkdir>:
SYSCALL(mkdir)
 64b:	b8 14 00 00 00       	mov    $0x14,%eax
 650:	cd 40                	int    $0x40
 652:	c3                   	ret    

00000653 <chdir>:
SYSCALL(chdir)
 653:	b8 09 00 00 00       	mov    $0x9,%eax
 658:	cd 40                	int    $0x40
 65a:	c3                   	ret    

0000065b <dup>:
SYSCALL(dup)
 65b:	b8 0a 00 00 00       	mov    $0xa,%eax
 660:	cd 40                	int    $0x40
 662:	c3                   	ret    

00000663 <getpid>:
SYSCALL(getpid)
 663:	b8 0b 00 00 00       	mov    $0xb,%eax
 668:	cd 40                	int    $0x40
 66a:	c3                   	ret    

0000066b <sbrk>:
SYSCALL(sbrk)
 66b:	b8 0c 00 00 00       	mov    $0xc,%eax
 670:	cd 40                	int    $0x40
 672:	c3                   	ret    

00000673 <sleep>:
SYSCALL(sleep)
 673:	b8 0d 00 00 00       	mov    $0xd,%eax
 678:	cd 40                	int    $0x40
 67a:	c3                   	ret    

0000067b <uptime>:
SYSCALL(uptime)
 67b:	b8 0e 00 00 00       	mov    $0xe,%eax
 680:	cd 40                	int    $0x40
 682:	c3                   	ret    

00000683 <getreadcount>:
SYSCALL(getreadcount)#new syscall
 683:	b8 16 00 00 00       	mov    $0x16,%eax
 688:	cd 40                	int    $0x40
 68a:	c3                   	ret    
 68b:	66 90                	xchg   %ax,%ax
 68d:	66 90                	xchg   %ax,%ax
 68f:	90                   	nop

00000690 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 690:	55                   	push   %ebp
 691:	89 e5                	mov    %esp,%ebp
 693:	57                   	push   %edi
 694:	56                   	push   %esi
 695:	53                   	push   %ebx
 696:	83 ec 3c             	sub    $0x3c,%esp
 699:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 69c:	89 d1                	mov    %edx,%ecx
{
 69e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 6a1:	85 d2                	test   %edx,%edx
 6a3:	0f 89 7f 00 00 00    	jns    728 <printint+0x98>
 6a9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 6ad:	74 79                	je     728 <printint+0x98>
    neg = 1;
 6af:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 6b6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 6b8:	31 db                	xor    %ebx,%ebx
 6ba:	8d 75 d7             	lea    -0x29(%ebp),%esi
 6bd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 6c0:	89 c8                	mov    %ecx,%eax
 6c2:	31 d2                	xor    %edx,%edx
 6c4:	89 cf                	mov    %ecx,%edi
 6c6:	f7 75 c4             	divl   -0x3c(%ebp)
 6c9:	0f b6 92 d8 0a 00 00 	movzbl 0xad8(%edx),%edx
 6d0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 6d3:	89 d8                	mov    %ebx,%eax
 6d5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 6d8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 6db:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 6de:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 6e1:	76 dd                	jbe    6c0 <printint+0x30>
  if(neg)
 6e3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 6e6:	85 c9                	test   %ecx,%ecx
 6e8:	74 0c                	je     6f6 <printint+0x66>
    buf[i++] = '-';
 6ea:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 6ef:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 6f1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 6f6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 6f9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 6fd:	eb 07                	jmp    706 <printint+0x76>
 6ff:	90                   	nop
    putc(fd, buf[i]);
 700:	0f b6 13             	movzbl (%ebx),%edx
 703:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 706:	83 ec 04             	sub    $0x4,%esp
 709:	88 55 d7             	mov    %dl,-0x29(%ebp)
 70c:	6a 01                	push   $0x1
 70e:	56                   	push   %esi
 70f:	57                   	push   %edi
 710:	e8 ee fe ff ff       	call   603 <write>
  while(--i >= 0)
 715:	83 c4 10             	add    $0x10,%esp
 718:	39 de                	cmp    %ebx,%esi
 71a:	75 e4                	jne    700 <printint+0x70>
}
 71c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 71f:	5b                   	pop    %ebx
 720:	5e                   	pop    %esi
 721:	5f                   	pop    %edi
 722:	5d                   	pop    %ebp
 723:	c3                   	ret    
 724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 728:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 72f:	eb 87                	jmp    6b8 <printint+0x28>
 731:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 738:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 73f:	90                   	nop

00000740 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 740:	f3 0f 1e fb          	endbr32 
 744:	55                   	push   %ebp
 745:	89 e5                	mov    %esp,%ebp
 747:	57                   	push   %edi
 748:	56                   	push   %esi
 749:	53                   	push   %ebx
 74a:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 74d:	8b 75 0c             	mov    0xc(%ebp),%esi
 750:	0f b6 1e             	movzbl (%esi),%ebx
 753:	84 db                	test   %bl,%bl
 755:	0f 84 b9 00 00 00    	je     814 <printf+0xd4>
  ap = (uint*)(void*)&fmt + 1;
 75b:	8d 45 10             	lea    0x10(%ebp),%eax
 75e:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 761:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 764:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 766:	89 45 d0             	mov    %eax,-0x30(%ebp)
 769:	eb 33                	jmp    79e <printf+0x5e>
 76b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 76f:	90                   	nop
 770:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(c == '\r') continue;
    if(state == 0){
      if(c == '%'){
        state = '%';
 773:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 778:	83 f8 25             	cmp    $0x25,%eax
 77b:	74 17                	je     794 <printf+0x54>
  write(fd, &c, 1);
 77d:	83 ec 04             	sub    $0x4,%esp
 780:	88 5d e7             	mov    %bl,-0x19(%ebp)
 783:	6a 01                	push   $0x1
 785:	57                   	push   %edi
 786:	ff 75 08             	pushl  0x8(%ebp)
 789:	e8 75 fe ff ff       	call   603 <write>
 78e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 791:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 794:	0f b6 1e             	movzbl (%esi),%ebx
 797:	83 c6 01             	add    $0x1,%esi
 79a:	84 db                	test   %bl,%bl
 79c:	74 76                	je     814 <printf+0xd4>
    c = fmt[i] & 0xff;
 79e:	0f be cb             	movsbl %bl,%ecx
 7a1:	0f b6 c3             	movzbl %bl,%eax
    if(c == '\r') continue;
 7a4:	80 fb 0d             	cmp    $0xd,%bl
 7a7:	74 eb                	je     794 <printf+0x54>
    if(state == 0){
 7a9:	85 d2                	test   %edx,%edx
 7ab:	74 c3                	je     770 <printf+0x30>
      }
    } else if(state == '%'){
 7ad:	83 fa 25             	cmp    $0x25,%edx
 7b0:	75 e2                	jne    794 <printf+0x54>
      if(c == 'd'){
 7b2:	83 f8 64             	cmp    $0x64,%eax
 7b5:	0f 84 95 00 00 00    	je     850 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 7bb:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 7c1:	83 f9 70             	cmp    $0x70,%ecx
 7c4:	74 5a                	je     820 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 7c6:	83 f8 73             	cmp    $0x73,%eax
 7c9:	0f 84 91 00 00 00    	je     860 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7cf:	83 f8 63             	cmp    $0x63,%eax
 7d2:	0f 84 e8 00 00 00    	je     8c0 <printf+0x180>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 7d8:	83 f8 25             	cmp    $0x25,%eax
 7db:	0f 84 cf 00 00 00    	je     8b0 <printf+0x170>
  write(fd, &c, 1);
 7e1:	83 ec 04             	sub    $0x4,%esp
 7e4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 7e8:	6a 01                	push   $0x1
 7ea:	57                   	push   %edi
 7eb:	ff 75 08             	pushl  0x8(%ebp)
 7ee:	e8 10 fe ff ff       	call   603 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 7f3:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 7f6:	83 c4 0c             	add    $0xc,%esp
 7f9:	6a 01                	push   $0x1
  for(i = 0; fmt[i]; i++){
 7fb:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 7fe:	57                   	push   %edi
 7ff:	ff 75 08             	pushl  0x8(%ebp)
 802:	e8 fc fd ff ff       	call   603 <write>
  for(i = 0; fmt[i]; i++){
 807:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 80b:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 80e:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 810:	84 db                	test   %bl,%bl
 812:	75 8a                	jne    79e <printf+0x5e>
    }
  }
}
 814:	8d 65 f4             	lea    -0xc(%ebp),%esp
 817:	5b                   	pop    %ebx
 818:	5e                   	pop    %esi
 819:	5f                   	pop    %edi
 81a:	5d                   	pop    %ebp
 81b:	c3                   	ret    
 81c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 16, 0);
 820:	83 ec 0c             	sub    $0xc,%esp
 823:	b9 10 00 00 00       	mov    $0x10,%ecx
 828:	6a 00                	push   $0x0
 82a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 82d:	8b 45 08             	mov    0x8(%ebp),%eax
 830:	8b 13                	mov    (%ebx),%edx
 832:	e8 59 fe ff ff       	call   690 <printint>
        ap++;
 837:	89 d8                	mov    %ebx,%eax
 839:	83 c4 10             	add    $0x10,%esp
      state = 0;
 83c:	31 d2                	xor    %edx,%edx
        ap++;
 83e:	83 c0 04             	add    $0x4,%eax
 841:	89 45 d0             	mov    %eax,-0x30(%ebp)
 844:	e9 4b ff ff ff       	jmp    794 <printf+0x54>
 849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 850:	83 ec 0c             	sub    $0xc,%esp
 853:	b9 0a 00 00 00       	mov    $0xa,%ecx
 858:	6a 01                	push   $0x1
 85a:	eb ce                	jmp    82a <printf+0xea>
 85c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 860:	8b 45 d0             	mov    -0x30(%ebp),%eax
 863:	8b 18                	mov    (%eax),%ebx
        ap++;
 865:	83 c0 04             	add    $0x4,%eax
 868:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 86b:	85 db                	test   %ebx,%ebx
 86d:	74 77                	je     8e6 <printf+0x1a6>
        while(*s != 0){
 86f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 872:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 874:	84 c0                	test   %al,%al
 876:	0f 84 18 ff ff ff    	je     794 <printf+0x54>
 87c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 87f:	89 de                	mov    %ebx,%esi
 881:	8b 5d 08             	mov    0x8(%ebp),%ebx
 884:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 888:	83 ec 04             	sub    $0x4,%esp
          s++;
 88b:	83 c6 01             	add    $0x1,%esi
 88e:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 891:	6a 01                	push   $0x1
 893:	57                   	push   %edi
 894:	53                   	push   %ebx
 895:	e8 69 fd ff ff       	call   603 <write>
        while(*s != 0){
 89a:	0f b6 06             	movzbl (%esi),%eax
 89d:	83 c4 10             	add    $0x10,%esp
 8a0:	84 c0                	test   %al,%al
 8a2:	75 e4                	jne    888 <printf+0x148>
      state = 0;
 8a4:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 8a7:	31 d2                	xor    %edx,%edx
 8a9:	e9 e6 fe ff ff       	jmp    794 <printf+0x54>
 8ae:	66 90                	xchg   %ax,%ax
        putc(fd, c);
 8b0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 8b3:	83 ec 04             	sub    $0x4,%esp
 8b6:	e9 3e ff ff ff       	jmp    7f9 <printf+0xb9>
 8bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 8bf:	90                   	nop
        putc(fd, *ap);
 8c0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 8c3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 8c6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 8c8:	6a 01                	push   $0x1
        ap++;
 8ca:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 8cd:	57                   	push   %edi
 8ce:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 8d1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 8d4:	e8 2a fd ff ff       	call   603 <write>
        ap++;
 8d9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 8dc:	83 c4 10             	add    $0x10,%esp
      state = 0;
 8df:	31 d2                	xor    %edx,%edx
 8e1:	e9 ae fe ff ff       	jmp    794 <printf+0x54>
          s = "(null)";
 8e6:	bb ce 0a 00 00       	mov    $0xace,%ebx
        while(*s != 0){
 8eb:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 8ee:	b8 28 00 00 00       	mov    $0x28,%eax
 8f3:	89 de                	mov    %ebx,%esi
 8f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 8f8:	eb 8e                	jmp    888 <printf+0x148>
 8fa:	66 90                	xchg   %ax,%ax
 8fc:	66 90                	xchg   %ax,%ax
 8fe:	66 90                	xchg   %ax,%ax

00000900 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 900:	f3 0f 1e fb          	endbr32 
 904:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 905:	a1 80 12 00 00       	mov    0x1280,%eax
{
 90a:	89 e5                	mov    %esp,%ebp
 90c:	57                   	push   %edi
 90d:	56                   	push   %esi
 90e:	53                   	push   %ebx
 90f:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 912:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 915:	8d 76 00             	lea    0x0(%esi),%esi
 918:	89 c2                	mov    %eax,%edx
 91a:	8b 00                	mov    (%eax),%eax
 91c:	39 ca                	cmp    %ecx,%edx
 91e:	73 30                	jae    950 <free+0x50>
 920:	39 c1                	cmp    %eax,%ecx
 922:	72 04                	jb     928 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 924:	39 c2                	cmp    %eax,%edx
 926:	72 f0                	jb     918 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 928:	8b 73 fc             	mov    -0x4(%ebx),%esi
 92b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 92e:	39 f8                	cmp    %edi,%eax
 930:	74 30                	je     962 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 932:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 935:	8b 42 04             	mov    0x4(%edx),%eax
 938:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 93b:	39 f1                	cmp    %esi,%ecx
 93d:	74 3a                	je     979 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 93f:	89 0a                	mov    %ecx,(%edx)
  freep = p;
}
 941:	5b                   	pop    %ebx
  freep = p;
 942:	89 15 80 12 00 00    	mov    %edx,0x1280
}
 948:	5e                   	pop    %esi
 949:	5f                   	pop    %edi
 94a:	5d                   	pop    %ebp
 94b:	c3                   	ret    
 94c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 950:	39 c2                	cmp    %eax,%edx
 952:	72 c4                	jb     918 <free+0x18>
 954:	39 c1                	cmp    %eax,%ecx
 956:	73 c0                	jae    918 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 958:	8b 73 fc             	mov    -0x4(%ebx),%esi
 95b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 95e:	39 f8                	cmp    %edi,%eax
 960:	75 d0                	jne    932 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 962:	03 70 04             	add    0x4(%eax),%esi
 965:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 968:	8b 02                	mov    (%edx),%eax
 96a:	8b 00                	mov    (%eax),%eax
 96c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 96f:	8b 42 04             	mov    0x4(%edx),%eax
 972:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 975:	39 f1                	cmp    %esi,%ecx
 977:	75 c6                	jne    93f <free+0x3f>
    p->s.size += bp->s.size;
 979:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 97c:	89 15 80 12 00 00    	mov    %edx,0x1280
    p->s.size += bp->s.size;
 982:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 985:	8b 43 f8             	mov    -0x8(%ebx),%eax
 988:	89 02                	mov    %eax,(%edx)
}
 98a:	5b                   	pop    %ebx
 98b:	5e                   	pop    %esi
 98c:	5f                   	pop    %edi
 98d:	5d                   	pop    %ebp
 98e:	c3                   	ret    
 98f:	90                   	nop

00000990 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 990:	f3 0f 1e fb          	endbr32 
 994:	55                   	push   %ebp
 995:	89 e5                	mov    %esp,%ebp
 997:	57                   	push   %edi
 998:	56                   	push   %esi
 999:	53                   	push   %ebx
 99a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 99d:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 9a0:	8b 3d 80 12 00 00    	mov    0x1280,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9a6:	8d 70 07             	lea    0x7(%eax),%esi
 9a9:	c1 ee 03             	shr    $0x3,%esi
 9ac:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 9af:	85 ff                	test   %edi,%edi
 9b1:	0f 84 a9 00 00 00    	je     a60 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9b7:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 9b9:	8b 48 04             	mov    0x4(%eax),%ecx
 9bc:	39 f1                	cmp    %esi,%ecx
 9be:	73 6d                	jae    a2d <malloc+0x9d>
 9c0:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 9c6:	bb 00 10 00 00       	mov    $0x1000,%ebx
 9cb:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 9ce:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 9d5:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 9d8:	eb 17                	jmp    9f1 <malloc+0x61>
 9da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9e0:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 9e2:	8b 4a 04             	mov    0x4(%edx),%ecx
 9e5:	39 f1                	cmp    %esi,%ecx
 9e7:	73 4f                	jae    a38 <malloc+0xa8>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9e9:	8b 3d 80 12 00 00    	mov    0x1280,%edi
 9ef:	89 d0                	mov    %edx,%eax
 9f1:	39 c7                	cmp    %eax,%edi
 9f3:	75 eb                	jne    9e0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 9f5:	83 ec 0c             	sub    $0xc,%esp
 9f8:	ff 75 e4             	pushl  -0x1c(%ebp)
 9fb:	e8 6b fc ff ff       	call   66b <sbrk>
  if(p == (char*)-1)
 a00:	83 c4 10             	add    $0x10,%esp
 a03:	83 f8 ff             	cmp    $0xffffffff,%eax
 a06:	74 1b                	je     a23 <malloc+0x93>
  hp->s.size = nu;
 a08:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 a0b:	83 ec 0c             	sub    $0xc,%esp
 a0e:	83 c0 08             	add    $0x8,%eax
 a11:	50                   	push   %eax
 a12:	e8 e9 fe ff ff       	call   900 <free>
  return freep;
 a17:	a1 80 12 00 00       	mov    0x1280,%eax
      if((p = morecore(nunits)) == 0)
 a1c:	83 c4 10             	add    $0x10,%esp
 a1f:	85 c0                	test   %eax,%eax
 a21:	75 bd                	jne    9e0 <malloc+0x50>
        return 0;
  }
}
 a23:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 a26:	31 c0                	xor    %eax,%eax
}
 a28:	5b                   	pop    %ebx
 a29:	5e                   	pop    %esi
 a2a:	5f                   	pop    %edi
 a2b:	5d                   	pop    %ebp
 a2c:	c3                   	ret    
    if(p->s.size >= nunits){
 a2d:	89 c2                	mov    %eax,%edx
 a2f:	89 f8                	mov    %edi,%eax
 a31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 a38:	39 ce                	cmp    %ecx,%esi
 a3a:	74 54                	je     a90 <malloc+0x100>
        p->s.size -= nunits;
 a3c:	29 f1                	sub    %esi,%ecx
 a3e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 a41:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 a44:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 a47:	a3 80 12 00 00       	mov    %eax,0x1280
}
 a4c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 a4f:	8d 42 08             	lea    0x8(%edx),%eax
}
 a52:	5b                   	pop    %ebx
 a53:	5e                   	pop    %esi
 a54:	5f                   	pop    %edi
 a55:	5d                   	pop    %ebp
 a56:	c3                   	ret    
 a57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a5e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 a60:	c7 05 80 12 00 00 84 	movl   $0x1284,0x1280
 a67:	12 00 00 
    base.s.size = 0;
 a6a:	bf 84 12 00 00       	mov    $0x1284,%edi
    base.s.ptr = freep = prevp = &base;
 a6f:	c7 05 84 12 00 00 84 	movl   $0x1284,0x1284
 a76:	12 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a79:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 a7b:	c7 05 88 12 00 00 00 	movl   $0x0,0x1288
 a82:	00 00 00 
    if(p->s.size >= nunits){
 a85:	e9 36 ff ff ff       	jmp    9c0 <malloc+0x30>
 a8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 a90:	8b 0a                	mov    (%edx),%ecx
 a92:	89 08                	mov    %ecx,(%eax)
 a94:	eb b1                	jmp    a47 <malloc+0xb7>
