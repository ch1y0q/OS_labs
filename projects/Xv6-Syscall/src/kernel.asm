
kernel：     文件格式 elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 30 55 11 80       	mov    $0x80115530,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 20 32 10 80       	mov    $0x80103220,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	f3 0f 1e fb          	endbr32 
80100044:	55                   	push   %ebp
80100045:	89 e5                	mov    %esp,%ebp
80100047:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100048:	bb 54 a5 10 80       	mov    $0x8010a554,%ebx
{
8010004d:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
80100050:	68 60 75 10 80       	push   $0x80107560
80100055:	68 20 a5 10 80       	push   $0x8010a520
8010005a:	e8 b1 45 00 00       	call   80104610 <initlock>
  bcache.head.next = &bcache.head;
8010005f:	83 c4 10             	add    $0x10,%esp
80100062:	b8 1c ec 10 80       	mov    $0x8010ec1c,%eax
  bcache.head.prev = &bcache.head;
80100067:	c7 05 6c ec 10 80 1c 	movl   $0x8010ec1c,0x8010ec6c
8010006e:	ec 10 80 
  bcache.head.next = &bcache.head;
80100071:	c7 05 70 ec 10 80 1c 	movl   $0x8010ec1c,0x8010ec70
80100078:	ec 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010007b:	eb 05                	jmp    80100082 <binit+0x42>
8010007d:	8d 76 00             	lea    0x0(%esi),%esi
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008b:	c7 43 50 1c ec 10 80 	movl   $0x8010ec1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 67 75 10 80       	push   $0x80107567
80100097:	50                   	push   %eax
80100098:	e8 33 44 00 00       	call   801044d0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 70 ec 10 80       	mov    0x8010ec70,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 ec 10 80    	mov    %ebx,0x8010ec70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb c0 e9 10 80    	cmp    $0x8010e9c0,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave  
801000c2:	c3                   	ret    
801000c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	f3 0f 1e fb          	endbr32 
801000d4:	55                   	push   %ebp
801000d5:	89 e5                	mov    %esp,%ebp
801000d7:	57                   	push   %edi
801000d8:	56                   	push   %esi
801000d9:	53                   	push   %ebx
801000da:	83 ec 18             	sub    $0x18,%esp
801000dd:	8b 75 08             	mov    0x8(%ebp),%esi
801000e0:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000e3:	68 20 a5 10 80       	push   $0x8010a520
801000e8:	e8 23 47 00 00       	call   80104810 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000ed:	8b 1d 70 ec 10 80    	mov    0x8010ec70,%ebx
801000f3:	83 c4 10             	add    $0x10,%esp
801000f6:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
801000fc:	75 0d                	jne    8010010b <bread+0x3b>
801000fe:	eb 20                	jmp    80100120 <bread+0x50>
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c ec 10 80    	mov    0x8010ec6c,%ebx
80100126:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
80100139:	74 63                	je     8010019e <bread+0xce>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 20 a5 10 80       	push   $0x8010a520
80100162:	e8 39 46 00 00       	call   801047a0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 9e 43 00 00       	call   80104510 <acquiresleep>
      return b;
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
    iderw(b);
  }
  return b;
}
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret    
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iderw(b);
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 cf 22 00 00       	call   80102460 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret    
  panic("bget: no buffers");
8010019e:	83 ec 0c             	sub    $0xc,%esp
801001a1:	68 6e 75 10 80       	push   $0x8010756e
801001a6:	e8 e5 01 00 00       	call   80100390 <panic>
801001ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001af:	90                   	nop

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	f3 0f 1e fb          	endbr32 
801001b4:	55                   	push   %ebp
801001b5:	89 e5                	mov    %esp,%ebp
801001b7:	53                   	push   %ebx
801001b8:	83 ec 10             	sub    $0x10,%esp
801001bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001be:	8d 43 0c             	lea    0xc(%ebx),%eax
801001c1:	50                   	push   %eax
801001c2:	e8 e9 43 00 00       	call   801045b0 <holdingsleep>
801001c7:	83 c4 10             	add    $0x10,%esp
801001ca:	85 c0                	test   %eax,%eax
801001cc:	74 0f                	je     801001dd <bwrite+0x2d>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ce:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001d1:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d7:	c9                   	leave  
  iderw(b);
801001d8:	e9 83 22 00 00       	jmp    80102460 <iderw>
    panic("bwrite");
801001dd:	83 ec 0c             	sub    $0xc,%esp
801001e0:	68 7f 75 10 80       	push   $0x8010757f
801001e5:	e8 a6 01 00 00       	call   80100390 <panic>
801001ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	f3 0f 1e fb          	endbr32 
801001f4:	55                   	push   %ebp
801001f5:	89 e5                	mov    %esp,%ebp
801001f7:	56                   	push   %esi
801001f8:	53                   	push   %ebx
801001f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001fc:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ff:	83 ec 0c             	sub    $0xc,%esp
80100202:	56                   	push   %esi
80100203:	e8 a8 43 00 00       	call   801045b0 <holdingsleep>
80100208:	83 c4 10             	add    $0x10,%esp
8010020b:	85 c0                	test   %eax,%eax
8010020d:	74 66                	je     80100275 <brelse+0x85>
    panic("brelse");

  releasesleep(&b->lock);
8010020f:	83 ec 0c             	sub    $0xc,%esp
80100212:	56                   	push   %esi
80100213:	e8 58 43 00 00       	call   80104570 <releasesleep>

  acquire(&bcache.lock);
80100218:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010021f:	e8 ec 45 00 00       	call   80104810 <acquire>
  b->refcnt--;
80100224:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100227:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
8010022a:	83 e8 01             	sub    $0x1,%eax
8010022d:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
80100230:	85 c0                	test   %eax,%eax
80100232:	75 2f                	jne    80100263 <brelse+0x73>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100234:	8b 43 54             	mov    0x54(%ebx),%eax
80100237:	8b 53 50             	mov    0x50(%ebx),%edx
8010023a:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
8010023d:	8b 43 50             	mov    0x50(%ebx),%eax
80100240:	8b 53 54             	mov    0x54(%ebx),%edx
80100243:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100246:	a1 70 ec 10 80       	mov    0x8010ec70,%eax
    b->prev = &bcache.head;
8010024b:	c7 43 50 1c ec 10 80 	movl   $0x8010ec1c,0x50(%ebx)
    b->next = bcache.head.next;
80100252:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100255:	a1 70 ec 10 80       	mov    0x8010ec70,%eax
8010025a:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
8010025d:	89 1d 70 ec 10 80    	mov    %ebx,0x8010ec70
  }
  
  release(&bcache.lock);
80100263:	c7 45 08 20 a5 10 80 	movl   $0x8010a520,0x8(%ebp)
}
8010026a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010026d:	5b                   	pop    %ebx
8010026e:	5e                   	pop    %esi
8010026f:	5d                   	pop    %ebp
  release(&bcache.lock);
80100270:	e9 2b 45 00 00       	jmp    801047a0 <release>
    panic("brelse");
80100275:	83 ec 0c             	sub    $0xc,%esp
80100278:	68 86 75 10 80       	push   $0x80107586
8010027d:	e8 0e 01 00 00       	call   80100390 <panic>
80100282:	66 90                	xchg   %ax,%ax
80100284:	66 90                	xchg   %ax,%ax
80100286:	66 90                	xchg   %ax,%ax
80100288:	66 90                	xchg   %ax,%ax
8010028a:	66 90                	xchg   %ax,%ax
8010028c:	66 90                	xchg   %ax,%ax
8010028e:	66 90                	xchg   %ax,%ax

80100290 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100290:	f3 0f 1e fb          	endbr32 
80100294:	55                   	push   %ebp
80100295:	89 e5                	mov    %esp,%ebp
80100297:	57                   	push   %edi
80100298:	56                   	push   %esi
80100299:	53                   	push   %ebx
8010029a:	83 ec 18             	sub    $0x18,%esp
8010029d:	8b 5d 10             	mov    0x10(%ebp),%ebx
801002a0:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
801002a3:	ff 75 08             	pushl  0x8(%ebp)
  target = n;
801002a6:	89 df                	mov    %ebx,%edi
  iunlock(ip);
801002a8:	e8 03 17 00 00       	call   801019b0 <iunlock>
  acquire(&cons.lock);
801002ad:	c7 04 24 20 ef 10 80 	movl   $0x8010ef20,(%esp)
801002b4:	e8 57 45 00 00       	call   80104810 <acquire>
  while(n > 0){
801002b9:	83 c4 10             	add    $0x10,%esp
801002bc:	85 db                	test   %ebx,%ebx
801002be:	0f 8e 98 00 00 00    	jle    8010035c <consoleread+0xcc>
    while(input.r == input.w){
801002c4:	a1 00 ef 10 80       	mov    0x8010ef00,%eax
801002c9:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
801002cf:	74 29                	je     801002fa <consoleread+0x6a>
801002d1:	eb 5d                	jmp    80100330 <consoleread+0xa0>
801002d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801002d7:	90                   	nop
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002d8:	83 ec 08             	sub    $0x8,%esp
801002db:	68 20 ef 10 80       	push   $0x8010ef20
801002e0:	68 00 ef 10 80       	push   $0x8010ef00
801002e5:	e8 66 3f 00 00       	call   80104250 <sleep>
    while(input.r == input.w){
801002ea:	a1 00 ef 10 80       	mov    0x8010ef00,%eax
801002ef:	83 c4 10             	add    $0x10,%esp
801002f2:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
801002f8:	75 36                	jne    80100330 <consoleread+0xa0>
      if(myproc()->killed){
801002fa:	e8 71 38 00 00       	call   80103b70 <myproc>
801002ff:	8b 48 24             	mov    0x24(%eax),%ecx
80100302:	85 c9                	test   %ecx,%ecx
80100304:	74 d2                	je     801002d8 <consoleread+0x48>
        release(&cons.lock);
80100306:	83 ec 0c             	sub    $0xc,%esp
80100309:	68 20 ef 10 80       	push   $0x8010ef20
8010030e:	e8 8d 44 00 00       	call   801047a0 <release>
        ilock(ip);
80100313:	5a                   	pop    %edx
80100314:	ff 75 08             	pushl  0x8(%ebp)
80100317:	e8 b4 15 00 00       	call   801018d0 <ilock>
        return -1;
8010031c:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
8010031f:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100322:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100327:	5b                   	pop    %ebx
80100328:	5e                   	pop    %esi
80100329:	5f                   	pop    %edi
8010032a:	5d                   	pop    %ebp
8010032b:	c3                   	ret    
8010032c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100330:	8d 50 01             	lea    0x1(%eax),%edx
80100333:	89 15 00 ef 10 80    	mov    %edx,0x8010ef00
80100339:	89 c2                	mov    %eax,%edx
8010033b:	83 e2 7f             	and    $0x7f,%edx
8010033e:	0f be 8a 80 ee 10 80 	movsbl -0x7fef1180(%edx),%ecx
    if(c == C('D')){  // EOF
80100345:	80 f9 04             	cmp    $0x4,%cl
80100348:	74 37                	je     80100381 <consoleread+0xf1>
    *dst++ = c;
8010034a:	83 c6 01             	add    $0x1,%esi
    --n;
8010034d:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
80100350:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
80100353:	83 f9 0a             	cmp    $0xa,%ecx
80100356:	0f 85 60 ff ff ff    	jne    801002bc <consoleread+0x2c>
  release(&cons.lock);
8010035c:	83 ec 0c             	sub    $0xc,%esp
8010035f:	68 20 ef 10 80       	push   $0x8010ef20
80100364:	e8 37 44 00 00       	call   801047a0 <release>
  ilock(ip);
80100369:	58                   	pop    %eax
8010036a:	ff 75 08             	pushl  0x8(%ebp)
8010036d:	e8 5e 15 00 00       	call   801018d0 <ilock>
  return target - n;
80100372:	89 f8                	mov    %edi,%eax
80100374:	83 c4 10             	add    $0x10,%esp
}
80100377:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
8010037a:	29 d8                	sub    %ebx,%eax
}
8010037c:	5b                   	pop    %ebx
8010037d:	5e                   	pop    %esi
8010037e:	5f                   	pop    %edi
8010037f:	5d                   	pop    %ebp
80100380:	c3                   	ret    
      if(n < target){
80100381:	39 fb                	cmp    %edi,%ebx
80100383:	73 d7                	jae    8010035c <consoleread+0xcc>
        input.r--;
80100385:	a3 00 ef 10 80       	mov    %eax,0x8010ef00
8010038a:	eb d0                	jmp    8010035c <consoleread+0xcc>
8010038c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100390 <panic>:
{
80100390:	f3 0f 1e fb          	endbr32 
80100394:	55                   	push   %ebp
80100395:	89 e5                	mov    %esp,%ebp
80100397:	56                   	push   %esi
80100398:	53                   	push   %ebx
80100399:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
8010039c:	fa                   	cli    
  cons.locking = 0;
8010039d:	c7 05 54 ef 10 80 00 	movl   $0x0,0x8010ef54
801003a4:	00 00 00 
  getcallerpcs(&s, pcs);
801003a7:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003aa:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003ad:	e8 ce 26 00 00       	call   80102a80 <lapicid>
801003b2:	83 ec 08             	sub    $0x8,%esp
801003b5:	50                   	push   %eax
801003b6:	68 8d 75 10 80       	push   $0x8010758d
801003bb:	e8 d0 02 00 00       	call   80100690 <cprintf>
  cprintf(s);
801003c0:	58                   	pop    %eax
801003c1:	ff 75 08             	pushl  0x8(%ebp)
801003c4:	e8 c7 02 00 00       	call   80100690 <cprintf>
  cprintf("\n");
801003c9:	c7 04 24 bb 7e 10 80 	movl   $0x80107ebb,(%esp)
801003d0:	e8 bb 02 00 00       	call   80100690 <cprintf>
  getcallerpcs(&s, pcs);
801003d5:	8d 45 08             	lea    0x8(%ebp),%eax
801003d8:	5a                   	pop    %edx
801003d9:	59                   	pop    %ecx
801003da:	53                   	push   %ebx
801003db:	50                   	push   %eax
801003dc:	e8 4f 42 00 00       	call   80104630 <getcallerpcs>
  for(i=0; i<10; i++)
801003e1:	83 c4 10             	add    $0x10,%esp
801003e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf(" %p", pcs[i]);
801003e8:	83 ec 08             	sub    $0x8,%esp
801003eb:	ff 33                	pushl  (%ebx)
  for(i=0; i<10; i++)
801003ed:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003f0:	68 a1 75 10 80       	push   $0x801075a1
801003f5:	e8 96 02 00 00       	call   80100690 <cprintf>
  for(i=0; i<10; i++)
801003fa:	83 c4 10             	add    $0x10,%esp
801003fd:	39 f3                	cmp    %esi,%ebx
801003ff:	75 e7                	jne    801003e8 <panic+0x58>
  panicked = 1; // freeze other CPU
80100401:	c7 05 58 ef 10 80 01 	movl   $0x1,0x8010ef58
80100408:	00 00 00 
  for(;;)
8010040b:	eb fe                	jmp    8010040b <panic+0x7b>
8010040d:	8d 76 00             	lea    0x0(%esi),%esi

80100410 <cgaputc>:
{
80100410:	55                   	push   %ebp
80100411:	89 c1                	mov    %eax,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100413:	b8 0e 00 00 00       	mov    $0xe,%eax
80100418:	89 e5                	mov    %esp,%ebp
8010041a:	57                   	push   %edi
8010041b:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100420:	56                   	push   %esi
80100421:	89 fa                	mov    %edi,%edx
80100423:	53                   	push   %ebx
80100424:	83 ec 1c             	sub    $0x1c,%esp
80100427:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100428:	be d5 03 00 00       	mov    $0x3d5,%esi
8010042d:	89 f2                	mov    %esi,%edx
8010042f:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100430:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100433:	89 fa                	mov    %edi,%edx
80100435:	c1 e0 08             	shl    $0x8,%eax
80100438:	89 c3                	mov    %eax,%ebx
8010043a:	b8 0f 00 00 00       	mov    $0xf,%eax
8010043f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100440:	89 f2                	mov    %esi,%edx
80100442:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100443:	0f b6 c0             	movzbl %al,%eax
80100446:	09 d8                	or     %ebx,%eax
  if(c == '\n')
80100448:	83 f9 0a             	cmp    $0xa,%ecx
8010044b:	0f 84 97 00 00 00    	je     801004e8 <cgaputc+0xd8>
  else if(c == BACKSPACE){
80100451:	81 f9 00 01 00 00    	cmp    $0x100,%ecx
80100457:	74 77                	je     801004d0 <cgaputc+0xc0>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100459:	0f b6 c9             	movzbl %cl,%ecx
8010045c:	8d 58 01             	lea    0x1(%eax),%ebx
8010045f:	80 cd 07             	or     $0x7,%ch
80100462:	66 89 8c 00 00 80 0b 	mov    %cx,-0x7ff48000(%eax,%eax,1)
80100469:	80 
  if(pos < 0 || pos > 25*80)
8010046a:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
80100470:	0f 8f cc 00 00 00    	jg     80100542 <cgaputc+0x132>
  if((pos/80) >= 24){  // Scroll up.
80100476:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
8010047c:	0f 8f 7e 00 00 00    	jg     80100500 <cgaputc+0xf0>
  outb(CRTPORT+1, pos>>8);
80100482:	0f b6 c7             	movzbl %bh,%eax
  outb(CRTPORT+1, pos);
80100485:	89 df                	mov    %ebx,%edi
  crt[pos] = ' ' | 0x0700;
80100487:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi
  outb(CRTPORT+1, pos>>8);
8010048e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100491:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100496:	b8 0e 00 00 00       	mov    $0xe,%eax
8010049b:	89 da                	mov    %ebx,%edx
8010049d:	ee                   	out    %al,(%dx)
8010049e:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801004a3:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
801004a7:	89 ca                	mov    %ecx,%edx
801004a9:	ee                   	out    %al,(%dx)
801004aa:	b8 0f 00 00 00       	mov    $0xf,%eax
801004af:	89 da                	mov    %ebx,%edx
801004b1:	ee                   	out    %al,(%dx)
801004b2:	89 f8                	mov    %edi,%eax
801004b4:	89 ca                	mov    %ecx,%edx
801004b6:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004b7:	b8 20 07 00 00       	mov    $0x720,%eax
801004bc:	66 89 06             	mov    %ax,(%esi)
}
801004bf:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004c2:	5b                   	pop    %ebx
801004c3:	5e                   	pop    %esi
801004c4:	5f                   	pop    %edi
801004c5:	5d                   	pop    %ebp
801004c6:	c3                   	ret    
801004c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801004ce:	66 90                	xchg   %ax,%ax
    if(pos > 0) --pos;
801004d0:	8d 58 ff             	lea    -0x1(%eax),%ebx
801004d3:	85 c0                	test   %eax,%eax
801004d5:	75 93                	jne    8010046a <cgaputc+0x5a>
801004d7:	c6 45 e4 00          	movb   $0x0,-0x1c(%ebp)
801004db:	be 00 80 0b 80       	mov    $0x800b8000,%esi
801004e0:	31 ff                	xor    %edi,%edi
801004e2:	eb ad                	jmp    80100491 <cgaputc+0x81>
801004e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pos += 80 - pos%80;
801004e8:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801004ed:	f7 e2                	mul    %edx
801004ef:	c1 ea 06             	shr    $0x6,%edx
801004f2:	8d 04 92             	lea    (%edx,%edx,4),%eax
801004f5:	c1 e0 04             	shl    $0x4,%eax
801004f8:	8d 58 50             	lea    0x50(%eax),%ebx
801004fb:	e9 6a ff ff ff       	jmp    8010046a <cgaputc+0x5a>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100500:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100503:	8d 7b b0             	lea    -0x50(%ebx),%edi
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100506:	8d b4 1b 60 7f 0b 80 	lea    -0x7ff480a0(%ebx,%ebx,1),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010050d:	68 60 0e 00 00       	push   $0xe60
80100512:	68 a0 80 0b 80       	push   $0x800b80a0
80100517:	68 00 80 0b 80       	push   $0x800b8000
8010051c:	e8 5f 44 00 00       	call   80104980 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100521:	b8 80 07 00 00       	mov    $0x780,%eax
80100526:	83 c4 0c             	add    $0xc,%esp
80100529:	29 f8                	sub    %edi,%eax
8010052b:	01 c0                	add    %eax,%eax
8010052d:	50                   	push   %eax
8010052e:	6a 00                	push   $0x0
80100530:	56                   	push   %esi
80100531:	e8 aa 43 00 00       	call   801048e0 <memset>
  outb(CRTPORT+1, pos);
80100536:	c6 45 e4 07          	movb   $0x7,-0x1c(%ebp)
8010053a:	83 c4 10             	add    $0x10,%esp
8010053d:	e9 4f ff ff ff       	jmp    80100491 <cgaputc+0x81>
    panic("pos under/overflow");
80100542:	83 ec 0c             	sub    $0xc,%esp
80100545:	68 a5 75 10 80       	push   $0x801075a5
8010054a:	e8 41 fe ff ff       	call   80100390 <panic>
8010054f:	90                   	nop

80100550 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100550:	f3 0f 1e fb          	endbr32 
80100554:	55                   	push   %ebp
80100555:	89 e5                	mov    %esp,%ebp
80100557:	57                   	push   %edi
80100558:	56                   	push   %esi
80100559:	53                   	push   %ebx
8010055a:	83 ec 28             	sub    $0x28,%esp
  int i;

  iunlock(ip);
8010055d:	ff 75 08             	pushl  0x8(%ebp)
{
80100560:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
80100563:	e8 48 14 00 00       	call   801019b0 <iunlock>
  acquire(&cons.lock);
80100568:	c7 04 24 20 ef 10 80 	movl   $0x8010ef20,(%esp)
8010056f:	e8 9c 42 00 00       	call   80104810 <acquire>
  for(i = 0; i < n; i++)
80100574:	83 c4 10             	add    $0x10,%esp
80100577:	85 f6                	test   %esi,%esi
80100579:	7e 36                	jle    801005b1 <consolewrite+0x61>
8010057b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010057e:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if(panicked){
80100581:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
80100587:	85 d2                	test   %edx,%edx
80100589:	74 05                	je     80100590 <consolewrite+0x40>
  asm volatile("cli");
8010058b:	fa                   	cli    
    for(;;)
8010058c:	eb fe                	jmp    8010058c <consolewrite+0x3c>
8010058e:	66 90                	xchg   %ax,%ax
    consputc(buf[i] & 0xff);
80100590:	0f b6 03             	movzbl (%ebx),%eax
    uartputc(c);
80100593:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < n; i++)
80100596:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100599:	50                   	push   %eax
8010059a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010059d:	e8 be 5a 00 00       	call   80106060 <uartputc>
  cgaputc(c);
801005a2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801005a5:	e8 66 fe ff ff       	call   80100410 <cgaputc>
  for(i = 0; i < n; i++)
801005aa:	83 c4 10             	add    $0x10,%esp
801005ad:	39 df                	cmp    %ebx,%edi
801005af:	75 d0                	jne    80100581 <consolewrite+0x31>
  release(&cons.lock);
801005b1:	83 ec 0c             	sub    $0xc,%esp
801005b4:	68 20 ef 10 80       	push   $0x8010ef20
801005b9:	e8 e2 41 00 00       	call   801047a0 <release>
  ilock(ip);
801005be:	58                   	pop    %eax
801005bf:	ff 75 08             	pushl  0x8(%ebp)
801005c2:	e8 09 13 00 00       	call   801018d0 <ilock>

  return n;
}
801005c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801005ca:	89 f0                	mov    %esi,%eax
801005cc:	5b                   	pop    %ebx
801005cd:	5e                   	pop    %esi
801005ce:	5f                   	pop    %edi
801005cf:	5d                   	pop    %ebp
801005d0:	c3                   	ret    
801005d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801005d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801005df:	90                   	nop

801005e0 <printint>:
{
801005e0:	55                   	push   %ebp
801005e1:	89 e5                	mov    %esp,%ebp
801005e3:	57                   	push   %edi
801005e4:	56                   	push   %esi
801005e5:	53                   	push   %ebx
801005e6:	83 ec 2c             	sub    $0x2c,%esp
801005e9:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801005ec:	89 4d d0             	mov    %ecx,-0x30(%ebp)
  if(sign && (sign = xx < 0))
801005ef:	85 c9                	test   %ecx,%ecx
801005f1:	74 04                	je     801005f7 <printint+0x17>
801005f3:	85 c0                	test   %eax,%eax
801005f5:	78 7e                	js     80100675 <printint+0x95>
    x = xx;
801005f7:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
801005fe:	89 c1                	mov    %eax,%ecx
  i = 0;
80100600:	31 db                	xor    %ebx,%ebx
80100602:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    buf[i++] = digits[x % base];
80100608:	89 c8                	mov    %ecx,%eax
8010060a:	31 d2                	xor    %edx,%edx
8010060c:	89 de                	mov    %ebx,%esi
8010060e:	89 cf                	mov    %ecx,%edi
80100610:	f7 75 d4             	divl   -0x2c(%ebp)
80100613:	8d 5b 01             	lea    0x1(%ebx),%ebx
80100616:	0f b6 92 d0 75 10 80 	movzbl -0x7fef8a30(%edx),%edx
  }while((x /= base) != 0);
8010061d:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
8010061f:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
80100623:	3b 7d d4             	cmp    -0x2c(%ebp),%edi
80100626:	73 e0                	jae    80100608 <printint+0x28>
  if(sign)
80100628:	8b 4d d0             	mov    -0x30(%ebp),%ecx
8010062b:	85 c9                	test   %ecx,%ecx
8010062d:	74 0c                	je     8010063b <printint+0x5b>
    buf[i++] = '-';
8010062f:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
80100634:	89 de                	mov    %ebx,%esi
    buf[i++] = '-';
80100636:	ba 2d 00 00 00       	mov    $0x2d,%edx
  while(--i >= 0)
8010063b:	8d 5c 35 d7          	lea    -0x29(%ebp,%esi,1),%ebx
  if(panicked){
8010063f:	a1 58 ef 10 80       	mov    0x8010ef58,%eax
80100644:	85 c0                	test   %eax,%eax
80100646:	74 08                	je     80100650 <printint+0x70>
80100648:	fa                   	cli    
    for(;;)
80100649:	eb fe                	jmp    80100649 <printint+0x69>
8010064b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010064f:	90                   	nop
    consputc(buf[i]);
80100650:	0f be f2             	movsbl %dl,%esi
    uartputc(c);
80100653:	83 ec 0c             	sub    $0xc,%esp
80100656:	56                   	push   %esi
80100657:	e8 04 5a 00 00       	call   80106060 <uartputc>
  cgaputc(c);
8010065c:	89 f0                	mov    %esi,%eax
8010065e:	e8 ad fd ff ff       	call   80100410 <cgaputc>
  while(--i >= 0)
80100663:	8d 45 d7             	lea    -0x29(%ebp),%eax
80100666:	83 c4 10             	add    $0x10,%esp
80100669:	39 c3                	cmp    %eax,%ebx
8010066b:	74 0e                	je     8010067b <printint+0x9b>
    consputc(buf[i]);
8010066d:	0f b6 13             	movzbl (%ebx),%edx
80100670:	83 eb 01             	sub    $0x1,%ebx
80100673:	eb ca                	jmp    8010063f <printint+0x5f>
    x = -xx;
80100675:	f7 d8                	neg    %eax
80100677:	89 c1                	mov    %eax,%ecx
80100679:	eb 85                	jmp    80100600 <printint+0x20>
}
8010067b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010067e:	5b                   	pop    %ebx
8010067f:	5e                   	pop    %esi
80100680:	5f                   	pop    %edi
80100681:	5d                   	pop    %ebp
80100682:	c3                   	ret    
80100683:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010068a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100690 <cprintf>:
{
80100690:	f3 0f 1e fb          	endbr32 
80100694:	55                   	push   %ebp
80100695:	89 e5                	mov    %esp,%ebp
80100697:	57                   	push   %edi
80100698:	56                   	push   %esi
80100699:	53                   	push   %ebx
8010069a:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
8010069d:	a1 54 ef 10 80       	mov    0x8010ef54,%eax
801006a2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(locking)
801006a5:	85 c0                	test   %eax,%eax
801006a7:	0f 85 33 01 00 00    	jne    801007e0 <cprintf+0x150>
  if (fmt == 0)
801006ad:	8b 75 08             	mov    0x8(%ebp),%esi
801006b0:	85 f6                	test   %esi,%esi
801006b2:	0f 84 3b 02 00 00    	je     801008f3 <cprintf+0x263>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006b8:	0f b6 06             	movzbl (%esi),%eax
  argp = (uint*)(void*)(&fmt + 1);
801006bb:	8d 7d 0c             	lea    0xc(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006be:	31 db                	xor    %ebx,%ebx
801006c0:	85 c0                	test   %eax,%eax
801006c2:	74 56                	je     8010071a <cprintf+0x8a>
    if(c != '%'){
801006c4:	83 f8 25             	cmp    $0x25,%eax
801006c7:	0f 85 d3 00 00 00    	jne    801007a0 <cprintf+0x110>
    c = fmt[++i] & 0xff;
801006cd:	83 c3 01             	add    $0x1,%ebx
801006d0:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
    if(c == 0)
801006d4:	85 d2                	test   %edx,%edx
801006d6:	74 42                	je     8010071a <cprintf+0x8a>
    switch(c){
801006d8:	83 fa 70             	cmp    $0x70,%edx
801006db:	0f 84 90 00 00 00    	je     80100771 <cprintf+0xe1>
801006e1:	7f 4d                	jg     80100730 <cprintf+0xa0>
801006e3:	83 fa 25             	cmp    $0x25,%edx
801006e6:	0f 84 44 01 00 00    	je     80100830 <cprintf+0x1a0>
801006ec:	83 fa 64             	cmp    $0x64,%edx
801006ef:	0f 85 00 01 00 00    	jne    801007f5 <cprintf+0x165>
      printint(*argp++, 10, 1);
801006f5:	8d 47 04             	lea    0x4(%edi),%eax
801006f8:	b9 01 00 00 00       	mov    $0x1,%ecx
801006fd:	ba 0a 00 00 00       	mov    $0xa,%edx
80100702:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100705:	8b 07                	mov    (%edi),%eax
80100707:	e8 d4 fe ff ff       	call   801005e0 <printint>
8010070c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010070f:	83 c3 01             	add    $0x1,%ebx
80100712:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100716:	85 c0                	test   %eax,%eax
80100718:	75 aa                	jne    801006c4 <cprintf+0x34>
  if(locking)
8010071a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010071d:	85 c0                	test   %eax,%eax
8010071f:	0f 85 b1 01 00 00    	jne    801008d6 <cprintf+0x246>
}
80100725:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100728:	5b                   	pop    %ebx
80100729:	5e                   	pop    %esi
8010072a:	5f                   	pop    %edi
8010072b:	5d                   	pop    %ebp
8010072c:	c3                   	ret    
8010072d:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
80100730:	83 fa 73             	cmp    $0x73,%edx
80100733:	75 33                	jne    80100768 <cprintf+0xd8>
      if((s = (char*)*argp++) == 0)
80100735:	8d 47 04             	lea    0x4(%edi),%eax
80100738:	8b 3f                	mov    (%edi),%edi
8010073a:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010073d:	85 ff                	test   %edi,%edi
8010073f:	0f 85 33 01 00 00    	jne    80100878 <cprintf+0x1e8>
        s = "(null)";
80100745:	bf b8 75 10 80       	mov    $0x801075b8,%edi
      for(; *s; s++)
8010074a:	89 5d dc             	mov    %ebx,-0x24(%ebp)
8010074d:	b8 28 00 00 00       	mov    $0x28,%eax
80100752:	89 fb                	mov    %edi,%ebx
  if(panicked){
80100754:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
8010075a:	85 d2                	test   %edx,%edx
8010075c:	0f 84 27 01 00 00    	je     80100889 <cprintf+0x1f9>
80100762:	fa                   	cli    
    for(;;)
80100763:	eb fe                	jmp    80100763 <cprintf+0xd3>
80100765:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
80100768:	83 fa 78             	cmp    $0x78,%edx
8010076b:	0f 85 84 00 00 00    	jne    801007f5 <cprintf+0x165>
      printint(*argp++, 16, 0);
80100771:	8d 47 04             	lea    0x4(%edi),%eax
80100774:	31 c9                	xor    %ecx,%ecx
80100776:	ba 10 00 00 00       	mov    $0x10,%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010077b:	83 c3 01             	add    $0x1,%ebx
      printint(*argp++, 16, 0);
8010077e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100781:	8b 07                	mov    (%edi),%eax
80100783:	e8 58 fe ff ff       	call   801005e0 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100788:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
      printint(*argp++, 16, 0);
8010078c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010078f:	85 c0                	test   %eax,%eax
80100791:	0f 85 2d ff ff ff    	jne    801006c4 <cprintf+0x34>
80100797:	eb 81                	jmp    8010071a <cprintf+0x8a>
80100799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(panicked){
801007a0:	8b 0d 58 ef 10 80    	mov    0x8010ef58,%ecx
801007a6:	85 c9                	test   %ecx,%ecx
801007a8:	74 06                	je     801007b0 <cprintf+0x120>
801007aa:	fa                   	cli    
    for(;;)
801007ab:	eb fe                	jmp    801007ab <cprintf+0x11b>
801007ad:	8d 76 00             	lea    0x0(%esi),%esi
    uartputc(c);
801007b0:	83 ec 0c             	sub    $0xc,%esp
801007b3:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007b6:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
801007b9:	50                   	push   %eax
801007ba:	e8 a1 58 00 00       	call   80106060 <uartputc>
  cgaputc(c);
801007bf:	8b 45 e0             	mov    -0x20(%ebp),%eax
801007c2:	e8 49 fc ff ff       	call   80100410 <cgaputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007c7:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
      continue;
801007cb:	83 c4 10             	add    $0x10,%esp
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007ce:	85 c0                	test   %eax,%eax
801007d0:	0f 85 ee fe ff ff    	jne    801006c4 <cprintf+0x34>
801007d6:	e9 3f ff ff ff       	jmp    8010071a <cprintf+0x8a>
801007db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801007df:	90                   	nop
    acquire(&cons.lock);
801007e0:	83 ec 0c             	sub    $0xc,%esp
801007e3:	68 20 ef 10 80       	push   $0x8010ef20
801007e8:	e8 23 40 00 00       	call   80104810 <acquire>
801007ed:	83 c4 10             	add    $0x10,%esp
801007f0:	e9 b8 fe ff ff       	jmp    801006ad <cprintf+0x1d>
  if(panicked){
801007f5:	8b 0d 58 ef 10 80    	mov    0x8010ef58,%ecx
801007fb:	85 c9                	test   %ecx,%ecx
801007fd:	75 71                	jne    80100870 <cprintf+0x1e0>
    uartputc(c);
801007ff:	83 ec 0c             	sub    $0xc,%esp
80100802:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100805:	6a 25                	push   $0x25
80100807:	e8 54 58 00 00       	call   80106060 <uartputc>
  cgaputc(c);
8010080c:	b8 25 00 00 00       	mov    $0x25,%eax
80100811:	e8 fa fb ff ff       	call   80100410 <cgaputc>
  if(panicked){
80100816:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
8010081c:	83 c4 10             	add    $0x10,%esp
8010081f:	85 d2                	test   %edx,%edx
80100821:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100824:	0f 84 8e 00 00 00    	je     801008b8 <cprintf+0x228>
8010082a:	fa                   	cli    
    for(;;)
8010082b:	eb fe                	jmp    8010082b <cprintf+0x19b>
8010082d:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
80100830:	a1 58 ef 10 80       	mov    0x8010ef58,%eax
80100835:	85 c0                	test   %eax,%eax
80100837:	74 07                	je     80100840 <cprintf+0x1b0>
80100839:	fa                   	cli    
    for(;;)
8010083a:	eb fe                	jmp    8010083a <cprintf+0x1aa>
8010083c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartputc(c);
80100840:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100843:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100846:	6a 25                	push   $0x25
80100848:	e8 13 58 00 00       	call   80106060 <uartputc>
  cgaputc(c);
8010084d:	b8 25 00 00 00       	mov    $0x25,%eax
80100852:	e8 b9 fb ff ff       	call   80100410 <cgaputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100857:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
}
8010085b:	83 c4 10             	add    $0x10,%esp
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010085e:	85 c0                	test   %eax,%eax
80100860:	0f 85 5e fe ff ff    	jne    801006c4 <cprintf+0x34>
80100866:	e9 af fe ff ff       	jmp    8010071a <cprintf+0x8a>
8010086b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010086f:	90                   	nop
80100870:	fa                   	cli    
    for(;;)
80100871:	eb fe                	jmp    80100871 <cprintf+0x1e1>
80100873:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100877:	90                   	nop
      for(; *s; s++)
80100878:	0f b6 07             	movzbl (%edi),%eax
8010087b:	84 c0                	test   %al,%al
8010087d:	74 6c                	je     801008eb <cprintf+0x25b>
8010087f:	89 5d dc             	mov    %ebx,-0x24(%ebp)
80100882:	89 fb                	mov    %edi,%ebx
80100884:	e9 cb fe ff ff       	jmp    80100754 <cprintf+0xc4>
    uartputc(c);
80100889:	83 ec 0c             	sub    $0xc,%esp
        consputc(*s);
8010088c:	0f be f8             	movsbl %al,%edi
      for(; *s; s++)
8010088f:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100892:	57                   	push   %edi
80100893:	e8 c8 57 00 00       	call   80106060 <uartputc>
  cgaputc(c);
80100898:	89 f8                	mov    %edi,%eax
8010089a:	e8 71 fb ff ff       	call   80100410 <cgaputc>
      for(; *s; s++)
8010089f:	0f b6 03             	movzbl (%ebx),%eax
801008a2:	83 c4 10             	add    $0x10,%esp
801008a5:	84 c0                	test   %al,%al
801008a7:	0f 85 a7 fe ff ff    	jne    80100754 <cprintf+0xc4>
      if((s = (char*)*argp++) == 0)
801008ad:	8b 5d dc             	mov    -0x24(%ebp),%ebx
801008b0:	8b 7d e0             	mov    -0x20(%ebp),%edi
801008b3:	e9 57 fe ff ff       	jmp    8010070f <cprintf+0x7f>
    uartputc(c);
801008b8:	83 ec 0c             	sub    $0xc,%esp
801008bb:	89 55 e0             	mov    %edx,-0x20(%ebp)
801008be:	52                   	push   %edx
801008bf:	e8 9c 57 00 00       	call   80106060 <uartputc>
  cgaputc(c);
801008c4:	8b 55 e0             	mov    -0x20(%ebp),%edx
801008c7:	89 d0                	mov    %edx,%eax
801008c9:	e8 42 fb ff ff       	call   80100410 <cgaputc>
}
801008ce:	83 c4 10             	add    $0x10,%esp
801008d1:	e9 39 fe ff ff       	jmp    8010070f <cprintf+0x7f>
    release(&cons.lock);
801008d6:	83 ec 0c             	sub    $0xc,%esp
801008d9:	68 20 ef 10 80       	push   $0x8010ef20
801008de:	e8 bd 3e 00 00       	call   801047a0 <release>
801008e3:	83 c4 10             	add    $0x10,%esp
}
801008e6:	e9 3a fe ff ff       	jmp    80100725 <cprintf+0x95>
      if((s = (char*)*argp++) == 0)
801008eb:	8b 7d e0             	mov    -0x20(%ebp),%edi
801008ee:	e9 1c fe ff ff       	jmp    8010070f <cprintf+0x7f>
    panic("null fmt");
801008f3:	83 ec 0c             	sub    $0xc,%esp
801008f6:	68 bf 75 10 80       	push   $0x801075bf
801008fb:	e8 90 fa ff ff       	call   80100390 <panic>

80100900 <consoleintr>:
{
80100900:	f3 0f 1e fb          	endbr32 
80100904:	55                   	push   %ebp
80100905:	89 e5                	mov    %esp,%ebp
80100907:	57                   	push   %edi
80100908:	56                   	push   %esi
80100909:	53                   	push   %ebx
  int c, doprocdump = 0;
8010090a:	31 db                	xor    %ebx,%ebx
{
8010090c:	83 ec 28             	sub    $0x28,%esp
8010090f:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&cons.lock);
80100912:	68 20 ef 10 80       	push   $0x8010ef20
80100917:	e8 f4 3e 00 00       	call   80104810 <acquire>
  while((c = getc()) >= 0){
8010091c:	83 c4 10             	add    $0x10,%esp
8010091f:	eb 1e                	jmp    8010093f <consoleintr+0x3f>
80100921:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100928:	83 f8 08             	cmp    $0x8,%eax
8010092b:	0f 84 0f 01 00 00    	je     80100a40 <consoleintr+0x140>
80100931:	83 f8 10             	cmp    $0x10,%eax
80100934:	0f 85 92 01 00 00    	jne    80100acc <consoleintr+0x1cc>
8010093a:	bb 01 00 00 00       	mov    $0x1,%ebx
  while((c = getc()) >= 0){
8010093f:	ff d6                	call   *%esi
80100941:	85 c0                	test   %eax,%eax
80100943:	0f 88 67 01 00 00    	js     80100ab0 <consoleintr+0x1b0>
    switch(c){
80100949:	83 f8 15             	cmp    $0x15,%eax
8010094c:	0f 84 b6 00 00 00    	je     80100a08 <consoleintr+0x108>
80100952:	7e d4                	jle    80100928 <consoleintr+0x28>
80100954:	83 f8 7f             	cmp    $0x7f,%eax
80100957:	0f 84 e3 00 00 00    	je     80100a40 <consoleintr+0x140>
      if(c != 0 && input.e-input.r < INPUT_BUF){
8010095d:	8b 15 08 ef 10 80    	mov    0x8010ef08,%edx
80100963:	89 d1                	mov    %edx,%ecx
80100965:	2b 0d 00 ef 10 80    	sub    0x8010ef00,%ecx
8010096b:	83 f9 7f             	cmp    $0x7f,%ecx
8010096e:	77 cf                	ja     8010093f <consoleintr+0x3f>
        input.buf[input.e++ % INPUT_BUF] = c;
80100970:	89 d1                	mov    %edx,%ecx
80100972:	83 c2 01             	add    $0x1,%edx
  if(panicked){
80100975:	8b 3d 58 ef 10 80    	mov    0x8010ef58,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
8010097b:	89 15 08 ef 10 80    	mov    %edx,0x8010ef08
80100981:	83 e1 7f             	and    $0x7f,%ecx
        c = (c == '\r') ? '\n' : c;
80100984:	83 f8 0d             	cmp    $0xd,%eax
80100987:	0f 84 93 01 00 00    	je     80100b20 <consoleintr+0x220>
        input.buf[input.e++ % INPUT_BUF] = c;
8010098d:	88 81 80 ee 10 80    	mov    %al,-0x7fef1180(%ecx)
  if(panicked){
80100993:	85 ff                	test   %edi,%edi
80100995:	0f 85 90 01 00 00    	jne    80100b2b <consoleintr+0x22b>
  if(c == BACKSPACE){
8010099b:	3d 00 01 00 00       	cmp    $0x100,%eax
801009a0:	0f 85 ab 01 00 00    	jne    80100b51 <consoleintr+0x251>
    uartputc('\b'); uartputc(' '); uartputc('\b');
801009a6:	83 ec 0c             	sub    $0xc,%esp
801009a9:	6a 08                	push   $0x8
801009ab:	e8 b0 56 00 00       	call   80106060 <uartputc>
801009b0:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801009b7:	e8 a4 56 00 00       	call   80106060 <uartputc>
801009bc:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801009c3:	e8 98 56 00 00       	call   80106060 <uartputc>
  cgaputc(c);
801009c8:	b8 00 01 00 00       	mov    $0x100,%eax
801009cd:	e8 3e fa ff ff       	call   80100410 <cgaputc>
801009d2:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801009d5:	a1 00 ef 10 80       	mov    0x8010ef00,%eax
801009da:	83 e8 80             	sub    $0xffffff80,%eax
801009dd:	39 05 08 ef 10 80    	cmp    %eax,0x8010ef08
801009e3:	0f 85 56 ff ff ff    	jne    8010093f <consoleintr+0x3f>
          wakeup(&input.r);
801009e9:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
801009ec:	a3 04 ef 10 80       	mov    %eax,0x8010ef04
          wakeup(&input.r);
801009f1:	68 00 ef 10 80       	push   $0x8010ef00
801009f6:	e8 15 39 00 00       	call   80104310 <wakeup>
801009fb:	83 c4 10             	add    $0x10,%esp
801009fe:	e9 3c ff ff ff       	jmp    8010093f <consoleintr+0x3f>
80100a03:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100a07:	90                   	nop
      while(input.e != input.w &&
80100a08:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
80100a0d:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
80100a13:	0f 84 26 ff ff ff    	je     8010093f <consoleintr+0x3f>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100a19:	83 e8 01             	sub    $0x1,%eax
80100a1c:	89 c2                	mov    %eax,%edx
80100a1e:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100a21:	80 ba 80 ee 10 80 0a 	cmpb   $0xa,-0x7fef1180(%edx)
80100a28:	0f 84 11 ff ff ff    	je     8010093f <consoleintr+0x3f>
  if(panicked){
80100a2e:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
        input.e--;
80100a34:	a3 08 ef 10 80       	mov    %eax,0x8010ef08
  if(panicked){
80100a39:	85 d2                	test   %edx,%edx
80100a3b:	74 2b                	je     80100a68 <consoleintr+0x168>
80100a3d:	fa                   	cli    
    for(;;)
80100a3e:	eb fe                	jmp    80100a3e <consoleintr+0x13e>
      if(input.e != input.w){
80100a40:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
80100a45:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
80100a4b:	0f 84 ee fe ff ff    	je     8010093f <consoleintr+0x3f>
        input.e--;
80100a51:	83 e8 01             	sub    $0x1,%eax
80100a54:	a3 08 ef 10 80       	mov    %eax,0x8010ef08
  if(panicked){
80100a59:	a1 58 ef 10 80       	mov    0x8010ef58,%eax
80100a5e:	85 c0                	test   %eax,%eax
80100a60:	74 7e                	je     80100ae0 <consoleintr+0x1e0>
80100a62:	fa                   	cli    
    for(;;)
80100a63:	eb fe                	jmp    80100a63 <consoleintr+0x163>
80100a65:	8d 76 00             	lea    0x0(%esi),%esi
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100a68:	83 ec 0c             	sub    $0xc,%esp
80100a6b:	6a 08                	push   $0x8
80100a6d:	e8 ee 55 00 00       	call   80106060 <uartputc>
80100a72:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100a79:	e8 e2 55 00 00       	call   80106060 <uartputc>
80100a7e:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100a85:	e8 d6 55 00 00       	call   80106060 <uartputc>
  cgaputc(c);
80100a8a:	b8 00 01 00 00       	mov    $0x100,%eax
80100a8f:	e8 7c f9 ff ff       	call   80100410 <cgaputc>
      while(input.e != input.w &&
80100a94:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
80100a99:	83 c4 10             	add    $0x10,%esp
80100a9c:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
80100aa2:	0f 85 71 ff ff ff    	jne    80100a19 <consoleintr+0x119>
80100aa8:	e9 92 fe ff ff       	jmp    8010093f <consoleintr+0x3f>
80100aad:	8d 76 00             	lea    0x0(%esi),%esi
  release(&cons.lock);
80100ab0:	83 ec 0c             	sub    $0xc,%esp
80100ab3:	68 20 ef 10 80       	push   $0x8010ef20
80100ab8:	e8 e3 3c 00 00       	call   801047a0 <release>
  if(doprocdump) {
80100abd:	83 c4 10             	add    $0x10,%esp
80100ac0:	85 db                	test   %ebx,%ebx
80100ac2:	75 50                	jne    80100b14 <consoleintr+0x214>
}
80100ac4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ac7:	5b                   	pop    %ebx
80100ac8:	5e                   	pop    %esi
80100ac9:	5f                   	pop    %edi
80100aca:	5d                   	pop    %ebp
80100acb:	c3                   	ret    
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100acc:	85 c0                	test   %eax,%eax
80100ace:	0f 84 6b fe ff ff    	je     8010093f <consoleintr+0x3f>
80100ad4:	e9 84 fe ff ff       	jmp    8010095d <consoleintr+0x5d>
80100ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100ae0:	83 ec 0c             	sub    $0xc,%esp
80100ae3:	6a 08                	push   $0x8
80100ae5:	e8 76 55 00 00       	call   80106060 <uartputc>
80100aea:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100af1:	e8 6a 55 00 00       	call   80106060 <uartputc>
80100af6:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100afd:	e8 5e 55 00 00       	call   80106060 <uartputc>
  cgaputc(c);
80100b02:	b8 00 01 00 00       	mov    $0x100,%eax
80100b07:	e8 04 f9 ff ff       	call   80100410 <cgaputc>
}
80100b0c:	83 c4 10             	add    $0x10,%esp
80100b0f:	e9 2b fe ff ff       	jmp    8010093f <consoleintr+0x3f>
}
80100b14:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100b17:	5b                   	pop    %ebx
80100b18:	5e                   	pop    %esi
80100b19:	5f                   	pop    %edi
80100b1a:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100b1b:	e9 e0 38 00 00       	jmp    80104400 <procdump>
        input.buf[input.e++ % INPUT_BUF] = c;
80100b20:	c6 81 80 ee 10 80 0a 	movb   $0xa,-0x7fef1180(%ecx)
  if(panicked){
80100b27:	85 ff                	test   %edi,%edi
80100b29:	74 05                	je     80100b30 <consoleintr+0x230>
80100b2b:	fa                   	cli    
    for(;;)
80100b2c:	eb fe                	jmp    80100b2c <consoleintr+0x22c>
80100b2e:	66 90                	xchg   %ax,%ax
    uartputc(c);
80100b30:	83 ec 0c             	sub    $0xc,%esp
80100b33:	6a 0a                	push   $0xa
80100b35:	e8 26 55 00 00       	call   80106060 <uartputc>
  cgaputc(c);
80100b3a:	b8 0a 00 00 00       	mov    $0xa,%eax
80100b3f:	e8 cc f8 ff ff       	call   80100410 <cgaputc>
          input.w = input.e;
80100b44:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
80100b49:	83 c4 10             	add    $0x10,%esp
80100b4c:	e9 98 fe ff ff       	jmp    801009e9 <consoleintr+0xe9>
    uartputc(c);
80100b51:	83 ec 0c             	sub    $0xc,%esp
80100b54:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100b57:	50                   	push   %eax
80100b58:	e8 03 55 00 00       	call   80106060 <uartputc>
  cgaputc(c);
80100b5d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100b60:	e8 ab f8 ff ff       	call   80100410 <cgaputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100b65:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100b68:	83 c4 10             	add    $0x10,%esp
80100b6b:	83 f8 0a             	cmp    $0xa,%eax
80100b6e:	74 09                	je     80100b79 <consoleintr+0x279>
80100b70:	83 f8 04             	cmp    $0x4,%eax
80100b73:	0f 85 5c fe ff ff    	jne    801009d5 <consoleintr+0xd5>
          input.w = input.e;
80100b79:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
80100b7e:	e9 66 fe ff ff       	jmp    801009e9 <consoleintr+0xe9>
80100b83:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100b90 <consoleinit>:

void
consoleinit(void)
{
80100b90:	f3 0f 1e fb          	endbr32 
80100b94:	55                   	push   %ebp
80100b95:	89 e5                	mov    %esp,%ebp
80100b97:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100b9a:	68 c8 75 10 80       	push   $0x801075c8
80100b9f:	68 20 ef 10 80       	push   $0x8010ef20
80100ba4:	e8 67 3a 00 00       	call   80104610 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100ba9:	58                   	pop    %eax
80100baa:	5a                   	pop    %edx
80100bab:	6a 00                	push   $0x0
80100bad:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100baf:	c7 05 0c f9 10 80 50 	movl   $0x80100550,0x8010f90c
80100bb6:	05 10 80 
  devsw[CONSOLE].read = consoleread;
80100bb9:	c7 05 08 f9 10 80 90 	movl   $0x80100290,0x8010f908
80100bc0:	02 10 80 
  cons.locking = 1;
80100bc3:	c7 05 54 ef 10 80 01 	movl   $0x1,0x8010ef54
80100bca:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100bcd:	e8 3e 1a 00 00       	call   80102610 <ioapicenable>
}
80100bd2:	83 c4 10             	add    $0x10,%esp
80100bd5:	c9                   	leave  
80100bd6:	c3                   	ret    
80100bd7:	66 90                	xchg   %ax,%ax
80100bd9:	66 90                	xchg   %ax,%ax
80100bdb:	66 90                	xchg   %ax,%ax
80100bdd:	66 90                	xchg   %ax,%ax
80100bdf:	90                   	nop

80100be0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100be0:	f3 0f 1e fb          	endbr32 
80100be4:	55                   	push   %ebp
80100be5:	89 e5                	mov    %esp,%ebp
80100be7:	57                   	push   %edi
80100be8:	56                   	push   %esi
80100be9:	53                   	push   %ebx
80100bea:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100bf0:	e8 7b 2f 00 00       	call   80103b70 <myproc>
80100bf5:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100bfb:	e8 10 23 00 00       	call   80102f10 <begin_op>

  if((ip = namei(path)) == 0){
80100c00:	83 ec 0c             	sub    $0xc,%esp
80100c03:	ff 75 08             	pushl  0x8(%ebp)
80100c06:	e8 05 16 00 00       	call   80102210 <namei>
80100c0b:	83 c4 10             	add    $0x10,%esp
80100c0e:	85 c0                	test   %eax,%eax
80100c10:	0f 84 fe 02 00 00    	je     80100f14 <exec+0x334>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100c16:	83 ec 0c             	sub    $0xc,%esp
80100c19:	89 c3                	mov    %eax,%ebx
80100c1b:	50                   	push   %eax
80100c1c:	e8 af 0c 00 00       	call   801018d0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100c21:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100c27:	6a 34                	push   $0x34
80100c29:	6a 00                	push   $0x0
80100c2b:	50                   	push   %eax
80100c2c:	53                   	push   %ebx
80100c2d:	e8 be 0f 00 00       	call   80101bf0 <readi>
80100c32:	83 c4 20             	add    $0x20,%esp
80100c35:	83 f8 34             	cmp    $0x34,%eax
80100c38:	74 26                	je     80100c60 <exec+0x80>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100c3a:	83 ec 0c             	sub    $0xc,%esp
80100c3d:	53                   	push   %ebx
80100c3e:	e8 1d 0f 00 00       	call   80101b60 <iunlockput>
    end_op();
80100c43:	e8 38 23 00 00       	call   80102f80 <end_op>
80100c48:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100c4b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100c50:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100c53:	5b                   	pop    %ebx
80100c54:	5e                   	pop    %esi
80100c55:	5f                   	pop    %edi
80100c56:	5d                   	pop    %ebp
80100c57:	c3                   	ret    
80100c58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100c5f:	90                   	nop
  if(elf.magic != ELF_MAGIC)
80100c60:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100c67:	45 4c 46 
80100c6a:	75 ce                	jne    80100c3a <exec+0x5a>
  if((pgdir = setupkvm()) == 0)
80100c6c:	e8 8f 65 00 00       	call   80107200 <setupkvm>
80100c71:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100c77:	85 c0                	test   %eax,%eax
80100c79:	74 bf                	je     80100c3a <exec+0x5a>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c7b:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100c82:	00 
80100c83:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100c89:	0f 84 a4 02 00 00    	je     80100f33 <exec+0x353>
  sz = 0;
80100c8f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100c96:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c99:	31 ff                	xor    %edi,%edi
80100c9b:	e9 86 00 00 00       	jmp    80100d26 <exec+0x146>
    if(ph.type != ELF_PROG_LOAD)
80100ca0:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100ca7:	75 6c                	jne    80100d15 <exec+0x135>
    if(ph.memsz < ph.filesz)
80100ca9:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100caf:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100cb5:	0f 82 87 00 00 00    	jb     80100d42 <exec+0x162>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100cbb:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100cc1:	72 7f                	jb     80100d42 <exec+0x162>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100cc3:	83 ec 04             	sub    $0x4,%esp
80100cc6:	50                   	push   %eax
80100cc7:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100ccd:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100cd3:	e8 48 63 00 00       	call   80107020 <allocuvm>
80100cd8:	83 c4 10             	add    $0x10,%esp
80100cdb:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100ce1:	85 c0                	test   %eax,%eax
80100ce3:	74 5d                	je     80100d42 <exec+0x162>
    if(ph.vaddr % PGSIZE != 0)
80100ce5:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100ceb:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100cf0:	75 50                	jne    80100d42 <exec+0x162>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100cf2:	83 ec 0c             	sub    $0xc,%esp
80100cf5:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100cfb:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100d01:	53                   	push   %ebx
80100d02:	50                   	push   %eax
80100d03:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100d09:	e8 22 62 00 00       	call   80106f30 <loaduvm>
80100d0e:	83 c4 20             	add    $0x20,%esp
80100d11:	85 c0                	test   %eax,%eax
80100d13:	78 2d                	js     80100d42 <exec+0x162>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d15:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100d1c:	83 c7 01             	add    $0x1,%edi
80100d1f:	83 c6 20             	add    $0x20,%esi
80100d22:	39 f8                	cmp    %edi,%eax
80100d24:	7e 3a                	jle    80100d60 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100d26:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100d2c:	6a 20                	push   $0x20
80100d2e:	56                   	push   %esi
80100d2f:	50                   	push   %eax
80100d30:	53                   	push   %ebx
80100d31:	e8 ba 0e 00 00       	call   80101bf0 <readi>
80100d36:	83 c4 10             	add    $0x10,%esp
80100d39:	83 f8 20             	cmp    $0x20,%eax
80100d3c:	0f 84 5e ff ff ff    	je     80100ca0 <exec+0xc0>
    freevm(pgdir);
80100d42:	83 ec 0c             	sub    $0xc,%esp
80100d45:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100d4b:	e8 30 64 00 00       	call   80107180 <freevm>
  if(ip){
80100d50:	83 c4 10             	add    $0x10,%esp
80100d53:	e9 e2 fe ff ff       	jmp    80100c3a <exec+0x5a>
80100d58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100d5f:	90                   	nop
  sz = PGROUNDUP(sz);
80100d60:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100d66:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100d6c:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100d72:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100d78:	83 ec 0c             	sub    $0xc,%esp
80100d7b:	53                   	push   %ebx
80100d7c:	e8 df 0d 00 00       	call   80101b60 <iunlockput>
  end_op();
80100d81:	e8 fa 21 00 00       	call   80102f80 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100d86:	83 c4 0c             	add    $0xc,%esp
80100d89:	56                   	push   %esi
80100d8a:	57                   	push   %edi
80100d8b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100d91:	57                   	push   %edi
80100d92:	e8 89 62 00 00       	call   80107020 <allocuvm>
80100d97:	83 c4 10             	add    $0x10,%esp
80100d9a:	89 c6                	mov    %eax,%esi
80100d9c:	85 c0                	test   %eax,%eax
80100d9e:	0f 84 94 00 00 00    	je     80100e38 <exec+0x258>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100da4:	83 ec 08             	sub    $0x8,%esp
80100da7:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
80100dad:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100daf:	50                   	push   %eax
80100db0:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
80100db1:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100db3:	e8 e8 64 00 00       	call   801072a0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100db8:	8b 45 0c             	mov    0xc(%ebp),%eax
80100dbb:	83 c4 10             	add    $0x10,%esp
80100dbe:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100dc4:	8b 00                	mov    (%eax),%eax
80100dc6:	85 c0                	test   %eax,%eax
80100dc8:	0f 84 8b 00 00 00    	je     80100e59 <exec+0x279>
80100dce:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80100dd4:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100dda:	eb 23                	jmp    80100dff <exec+0x21f>
80100ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100de0:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100de3:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100dea:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100ded:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100df3:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100df6:	85 c0                	test   %eax,%eax
80100df8:	74 59                	je     80100e53 <exec+0x273>
    if(argc >= MAXARG)
80100dfa:	83 ff 20             	cmp    $0x20,%edi
80100dfd:	74 39                	je     80100e38 <exec+0x258>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100dff:	83 ec 0c             	sub    $0xc,%esp
80100e02:	50                   	push   %eax
80100e03:	e8 d8 3c 00 00       	call   80104ae0 <strlen>
80100e08:	f7 d0                	not    %eax
80100e0a:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100e0c:	58                   	pop    %eax
80100e0d:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100e10:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100e13:	ff 34 b8             	pushl  (%eax,%edi,4)
80100e16:	e8 c5 3c 00 00       	call   80104ae0 <strlen>
80100e1b:	83 c0 01             	add    $0x1,%eax
80100e1e:	50                   	push   %eax
80100e1f:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e22:	ff 34 b8             	pushl  (%eax,%edi,4)
80100e25:	53                   	push   %ebx
80100e26:	56                   	push   %esi
80100e27:	e8 44 66 00 00       	call   80107470 <copyout>
80100e2c:	83 c4 20             	add    $0x20,%esp
80100e2f:	85 c0                	test   %eax,%eax
80100e31:	79 ad                	jns    80100de0 <exec+0x200>
80100e33:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e37:	90                   	nop
    freevm(pgdir);
80100e38:	83 ec 0c             	sub    $0xc,%esp
80100e3b:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100e41:	e8 3a 63 00 00       	call   80107180 <freevm>
80100e46:	83 c4 10             	add    $0x10,%esp
  return -1;
80100e49:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100e4e:	e9 fd fd ff ff       	jmp    80100c50 <exec+0x70>
80100e53:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e59:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100e60:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100e62:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100e69:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e6d:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100e6f:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
80100e72:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
80100e78:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e7a:	50                   	push   %eax
80100e7b:	52                   	push   %edx
80100e7c:	53                   	push   %ebx
80100e7d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80100e83:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100e8a:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e8d:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e93:	e8 d8 65 00 00       	call   80107470 <copyout>
80100e98:	83 c4 10             	add    $0x10,%esp
80100e9b:	85 c0                	test   %eax,%eax
80100e9d:	78 99                	js     80100e38 <exec+0x258>
  for(last=s=path; *s; s++)
80100e9f:	8b 45 08             	mov    0x8(%ebp),%eax
80100ea2:	8b 55 08             	mov    0x8(%ebp),%edx
80100ea5:	0f b6 00             	movzbl (%eax),%eax
80100ea8:	84 c0                	test   %al,%al
80100eaa:	74 13                	je     80100ebf <exec+0x2df>
80100eac:	89 d1                	mov    %edx,%ecx
80100eae:	66 90                	xchg   %ax,%ax
      last = s+1;
80100eb0:	83 c1 01             	add    $0x1,%ecx
80100eb3:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100eb5:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80100eb8:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100ebb:	84 c0                	test   %al,%al
80100ebd:	75 f1                	jne    80100eb0 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100ebf:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80100ec5:	83 ec 04             	sub    $0x4,%esp
80100ec8:	6a 10                	push   $0x10
80100eca:	89 f8                	mov    %edi,%eax
80100ecc:	52                   	push   %edx
80100ecd:	83 c0 6c             	add    $0x6c,%eax
80100ed0:	50                   	push   %eax
80100ed1:	e8 ca 3b 00 00       	call   80104aa0 <safestrcpy>
  curproc->pgdir = pgdir;
80100ed6:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100edc:	89 f8                	mov    %edi,%eax
80100ede:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
80100ee1:	89 30                	mov    %esi,(%eax)
  curproc->pgdir = pgdir;
80100ee3:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80100ee6:	89 c1                	mov    %eax,%ecx
80100ee8:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100eee:	8b 40 18             	mov    0x18(%eax),%eax
80100ef1:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100ef4:	8b 41 18             	mov    0x18(%ecx),%eax
80100ef7:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100efa:	89 0c 24             	mov    %ecx,(%esp)
80100efd:	e8 9e 5e 00 00       	call   80106da0 <switchuvm>
  freevm(oldpgdir);
80100f02:	89 3c 24             	mov    %edi,(%esp)
80100f05:	e8 76 62 00 00       	call   80107180 <freevm>
  return 0;
80100f0a:	83 c4 10             	add    $0x10,%esp
80100f0d:	31 c0                	xor    %eax,%eax
80100f0f:	e9 3c fd ff ff       	jmp    80100c50 <exec+0x70>
    end_op();
80100f14:	e8 67 20 00 00       	call   80102f80 <end_op>
    cprintf("exec: fail\n");
80100f19:	83 ec 0c             	sub    $0xc,%esp
80100f1c:	68 e1 75 10 80       	push   $0x801075e1
80100f21:	e8 6a f7 ff ff       	call   80100690 <cprintf>
    return -1;
80100f26:	83 c4 10             	add    $0x10,%esp
80100f29:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f2e:	e9 1d fd ff ff       	jmp    80100c50 <exec+0x70>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100f33:	31 ff                	xor    %edi,%edi
80100f35:	be 00 20 00 00       	mov    $0x2000,%esi
80100f3a:	e9 39 fe ff ff       	jmp    80100d78 <exec+0x198>
80100f3f:	90                   	nop

80100f40 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100f40:	f3 0f 1e fb          	endbr32 
80100f44:	55                   	push   %ebp
80100f45:	89 e5                	mov    %esp,%ebp
80100f47:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100f4a:	68 ed 75 10 80       	push   $0x801075ed
80100f4f:	68 60 ef 10 80       	push   $0x8010ef60
80100f54:	e8 b7 36 00 00       	call   80104610 <initlock>
}
80100f59:	83 c4 10             	add    $0x10,%esp
80100f5c:	c9                   	leave  
80100f5d:	c3                   	ret    
80100f5e:	66 90                	xchg   %ax,%ax

80100f60 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100f60:	f3 0f 1e fb          	endbr32 
80100f64:	55                   	push   %ebp
80100f65:	89 e5                	mov    %esp,%ebp
80100f67:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f68:	bb 94 ef 10 80       	mov    $0x8010ef94,%ebx
{
80100f6d:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100f70:	68 60 ef 10 80       	push   $0x8010ef60
80100f75:	e8 96 38 00 00       	call   80104810 <acquire>
80100f7a:	83 c4 10             	add    $0x10,%esp
80100f7d:	eb 0c                	jmp    80100f8b <filealloc+0x2b>
80100f7f:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f80:	83 c3 18             	add    $0x18,%ebx
80100f83:	81 fb f4 f8 10 80    	cmp    $0x8010f8f4,%ebx
80100f89:	74 25                	je     80100fb0 <filealloc+0x50>
    if(f->ref == 0){
80100f8b:	8b 43 04             	mov    0x4(%ebx),%eax
80100f8e:	85 c0                	test   %eax,%eax
80100f90:	75 ee                	jne    80100f80 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100f92:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100f95:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100f9c:	68 60 ef 10 80       	push   $0x8010ef60
80100fa1:	e8 fa 37 00 00       	call   801047a0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100fa6:	89 d8                	mov    %ebx,%eax
      return f;
80100fa8:	83 c4 10             	add    $0x10,%esp
}
80100fab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100fae:	c9                   	leave  
80100faf:	c3                   	ret    
  release(&ftable.lock);
80100fb0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100fb3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100fb5:	68 60 ef 10 80       	push   $0x8010ef60
80100fba:	e8 e1 37 00 00       	call   801047a0 <release>
}
80100fbf:	89 d8                	mov    %ebx,%eax
  return 0;
80100fc1:	83 c4 10             	add    $0x10,%esp
}
80100fc4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100fc7:	c9                   	leave  
80100fc8:	c3                   	ret    
80100fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100fd0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100fd0:	f3 0f 1e fb          	endbr32 
80100fd4:	55                   	push   %ebp
80100fd5:	89 e5                	mov    %esp,%ebp
80100fd7:	53                   	push   %ebx
80100fd8:	83 ec 10             	sub    $0x10,%esp
80100fdb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100fde:	68 60 ef 10 80       	push   $0x8010ef60
80100fe3:	e8 28 38 00 00       	call   80104810 <acquire>
  if(f->ref < 1)
80100fe8:	8b 43 04             	mov    0x4(%ebx),%eax
80100feb:	83 c4 10             	add    $0x10,%esp
80100fee:	85 c0                	test   %eax,%eax
80100ff0:	7e 1a                	jle    8010100c <filedup+0x3c>
    panic("filedup");
  f->ref++;
80100ff2:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100ff5:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100ff8:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100ffb:	68 60 ef 10 80       	push   $0x8010ef60
80101000:	e8 9b 37 00 00       	call   801047a0 <release>
  return f;
}
80101005:	89 d8                	mov    %ebx,%eax
80101007:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010100a:	c9                   	leave  
8010100b:	c3                   	ret    
    panic("filedup");
8010100c:	83 ec 0c             	sub    $0xc,%esp
8010100f:	68 f4 75 10 80       	push   $0x801075f4
80101014:	e8 77 f3 ff ff       	call   80100390 <panic>
80101019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101020 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101020:	f3 0f 1e fb          	endbr32 
80101024:	55                   	push   %ebp
80101025:	89 e5                	mov    %esp,%ebp
80101027:	57                   	push   %edi
80101028:	56                   	push   %esi
80101029:	53                   	push   %ebx
8010102a:	83 ec 28             	sub    $0x28,%esp
8010102d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80101030:	68 60 ef 10 80       	push   $0x8010ef60
80101035:	e8 d6 37 00 00       	call   80104810 <acquire>
  if(f->ref < 1)
8010103a:	8b 53 04             	mov    0x4(%ebx),%edx
8010103d:	83 c4 10             	add    $0x10,%esp
80101040:	85 d2                	test   %edx,%edx
80101042:	0f 8e a1 00 00 00    	jle    801010e9 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80101048:	83 ea 01             	sub    $0x1,%edx
8010104b:	89 53 04             	mov    %edx,0x4(%ebx)
8010104e:	75 40                	jne    80101090 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80101050:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101054:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80101057:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80101059:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
8010105f:	8b 73 0c             	mov    0xc(%ebx),%esi
80101062:	88 45 e7             	mov    %al,-0x19(%ebp)
80101065:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80101068:	68 60 ef 10 80       	push   $0x8010ef60
  ff = *f;
8010106d:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80101070:	e8 2b 37 00 00       	call   801047a0 <release>

  if(ff.type == FD_PIPE)
80101075:	83 c4 10             	add    $0x10,%esp
80101078:	83 ff 01             	cmp    $0x1,%edi
8010107b:	74 53                	je     801010d0 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
8010107d:	83 ff 02             	cmp    $0x2,%edi
80101080:	74 26                	je     801010a8 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80101082:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101085:	5b                   	pop    %ebx
80101086:	5e                   	pop    %esi
80101087:	5f                   	pop    %edi
80101088:	5d                   	pop    %ebp
80101089:	c3                   	ret    
8010108a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&ftable.lock);
80101090:	c7 45 08 60 ef 10 80 	movl   $0x8010ef60,0x8(%ebp)
}
80101097:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010109a:	5b                   	pop    %ebx
8010109b:	5e                   	pop    %esi
8010109c:	5f                   	pop    %edi
8010109d:	5d                   	pop    %ebp
    release(&ftable.lock);
8010109e:	e9 fd 36 00 00       	jmp    801047a0 <release>
801010a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801010a7:	90                   	nop
    begin_op();
801010a8:	e8 63 1e 00 00       	call   80102f10 <begin_op>
    iput(ff.ip);
801010ad:	83 ec 0c             	sub    $0xc,%esp
801010b0:	ff 75 e0             	pushl  -0x20(%ebp)
801010b3:	e8 48 09 00 00       	call   80101a00 <iput>
    end_op();
801010b8:	83 c4 10             	add    $0x10,%esp
}
801010bb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010be:	5b                   	pop    %ebx
801010bf:	5e                   	pop    %esi
801010c0:	5f                   	pop    %edi
801010c1:	5d                   	pop    %ebp
    end_op();
801010c2:	e9 b9 1e 00 00       	jmp    80102f80 <end_op>
801010c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801010ce:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
801010d0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
801010d4:	83 ec 08             	sub    $0x8,%esp
801010d7:	53                   	push   %ebx
801010d8:	56                   	push   %esi
801010d9:	e8 32 26 00 00       	call   80103710 <pipeclose>
801010de:	83 c4 10             	add    $0x10,%esp
}
801010e1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010e4:	5b                   	pop    %ebx
801010e5:	5e                   	pop    %esi
801010e6:	5f                   	pop    %edi
801010e7:	5d                   	pop    %ebp
801010e8:	c3                   	ret    
    panic("fileclose");
801010e9:	83 ec 0c             	sub    $0xc,%esp
801010ec:	68 fc 75 10 80       	push   $0x801075fc
801010f1:	e8 9a f2 ff ff       	call   80100390 <panic>
801010f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801010fd:	8d 76 00             	lea    0x0(%esi),%esi

80101100 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101100:	f3 0f 1e fb          	endbr32 
80101104:	55                   	push   %ebp
80101105:	89 e5                	mov    %esp,%ebp
80101107:	53                   	push   %ebx
80101108:	83 ec 04             	sub    $0x4,%esp
8010110b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010110e:	83 3b 02             	cmpl   $0x2,(%ebx)
80101111:	75 2d                	jne    80101140 <filestat+0x40>
    ilock(f->ip);
80101113:	83 ec 0c             	sub    $0xc,%esp
80101116:	ff 73 10             	pushl  0x10(%ebx)
80101119:	e8 b2 07 00 00       	call   801018d0 <ilock>
    stati(f->ip, st);
8010111e:	58                   	pop    %eax
8010111f:	5a                   	pop    %edx
80101120:	ff 75 0c             	pushl  0xc(%ebp)
80101123:	ff 73 10             	pushl  0x10(%ebx)
80101126:	e8 95 0a 00 00       	call   80101bc0 <stati>
    iunlock(f->ip);
8010112b:	59                   	pop    %ecx
8010112c:	ff 73 10             	pushl  0x10(%ebx)
8010112f:	e8 7c 08 00 00       	call   801019b0 <iunlock>
    return 0;
  }
  return -1;
}
80101134:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80101137:	83 c4 10             	add    $0x10,%esp
8010113a:	31 c0                	xor    %eax,%eax
}
8010113c:	c9                   	leave  
8010113d:	c3                   	ret    
8010113e:	66 90                	xchg   %ax,%ax
80101140:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80101143:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101148:	c9                   	leave  
80101149:	c3                   	ret    
8010114a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101150 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101150:	f3 0f 1e fb          	endbr32 
80101154:	55                   	push   %ebp
80101155:	89 e5                	mov    %esp,%ebp
80101157:	57                   	push   %edi
80101158:	56                   	push   %esi
80101159:	53                   	push   %ebx
8010115a:	83 ec 0c             	sub    $0xc,%esp
8010115d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101160:	8b 75 0c             	mov    0xc(%ebp),%esi
80101163:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101166:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
8010116a:	74 64                	je     801011d0 <fileread+0x80>
    return -1;
  if(f->type == FD_PIPE)
8010116c:	8b 03                	mov    (%ebx),%eax
8010116e:	83 f8 01             	cmp    $0x1,%eax
80101171:	74 45                	je     801011b8 <fileread+0x68>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101173:	83 f8 02             	cmp    $0x2,%eax
80101176:	75 5f                	jne    801011d7 <fileread+0x87>
    ilock(f->ip);
80101178:	83 ec 0c             	sub    $0xc,%esp
8010117b:	ff 73 10             	pushl  0x10(%ebx)
8010117e:	e8 4d 07 00 00       	call   801018d0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101183:	57                   	push   %edi
80101184:	ff 73 14             	pushl  0x14(%ebx)
80101187:	56                   	push   %esi
80101188:	ff 73 10             	pushl  0x10(%ebx)
8010118b:	e8 60 0a 00 00       	call   80101bf0 <readi>
80101190:	83 c4 20             	add    $0x20,%esp
80101193:	89 c6                	mov    %eax,%esi
80101195:	85 c0                	test   %eax,%eax
80101197:	7e 03                	jle    8010119c <fileread+0x4c>
      f->off += r;
80101199:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
8010119c:	83 ec 0c             	sub    $0xc,%esp
8010119f:	ff 73 10             	pushl  0x10(%ebx)
801011a2:	e8 09 08 00 00       	call   801019b0 <iunlock>
    return r;
801011a7:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
801011aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011ad:	89 f0                	mov    %esi,%eax
801011af:	5b                   	pop    %ebx
801011b0:	5e                   	pop    %esi
801011b1:	5f                   	pop    %edi
801011b2:	5d                   	pop    %ebp
801011b3:	c3                   	ret    
801011b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return piperead(f->pipe, addr, n);
801011b8:	8b 43 0c             	mov    0xc(%ebx),%eax
801011bb:	89 45 08             	mov    %eax,0x8(%ebp)
}
801011be:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011c1:	5b                   	pop    %ebx
801011c2:	5e                   	pop    %esi
801011c3:	5f                   	pop    %edi
801011c4:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
801011c5:	e9 e6 26 00 00       	jmp    801038b0 <piperead>
801011ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801011d0:	be ff ff ff ff       	mov    $0xffffffff,%esi
801011d5:	eb d3                	jmp    801011aa <fileread+0x5a>
  panic("fileread");
801011d7:	83 ec 0c             	sub    $0xc,%esp
801011da:	68 06 76 10 80       	push   $0x80107606
801011df:	e8 ac f1 ff ff       	call   80100390 <panic>
801011e4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801011eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801011ef:	90                   	nop

801011f0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801011f0:	f3 0f 1e fb          	endbr32 
801011f4:	55                   	push   %ebp
801011f5:	89 e5                	mov    %esp,%ebp
801011f7:	57                   	push   %edi
801011f8:	56                   	push   %esi
801011f9:	53                   	push   %ebx
801011fa:	83 ec 1c             	sub    $0x1c,%esp
801011fd:	8b 45 0c             	mov    0xc(%ebp),%eax
80101200:	8b 75 08             	mov    0x8(%ebp),%esi
80101203:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101206:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101209:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
8010120d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
80101210:	0f 84 c1 00 00 00    	je     801012d7 <filewrite+0xe7>
    return -1;
  if(f->type == FD_PIPE)
80101216:	8b 06                	mov    (%esi),%eax
80101218:	83 f8 01             	cmp    $0x1,%eax
8010121b:	0f 84 c3 00 00 00    	je     801012e4 <filewrite+0xf4>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101221:	83 f8 02             	cmp    $0x2,%eax
80101224:	0f 85 cc 00 00 00    	jne    801012f6 <filewrite+0x106>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
8010122a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
8010122d:	31 ff                	xor    %edi,%edi
    while(i < n){
8010122f:	85 c0                	test   %eax,%eax
80101231:	7f 34                	jg     80101267 <filewrite+0x77>
80101233:	e9 98 00 00 00       	jmp    801012d0 <filewrite+0xe0>
80101238:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010123f:	90                   	nop
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101240:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
80101243:	83 ec 0c             	sub    $0xc,%esp
80101246:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101249:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
8010124c:	e8 5f 07 00 00       	call   801019b0 <iunlock>
      end_op();
80101251:	e8 2a 1d 00 00       	call   80102f80 <end_op>

      if(r < 0)
        break;
      if(r != n1)
80101256:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101259:	83 c4 10             	add    $0x10,%esp
8010125c:	39 c3                	cmp    %eax,%ebx
8010125e:	75 60                	jne    801012c0 <filewrite+0xd0>
        panic("short filewrite");
      i += r;
80101260:	01 df                	add    %ebx,%edi
    while(i < n){
80101262:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101265:	7e 69                	jle    801012d0 <filewrite+0xe0>
      int n1 = n - i;
80101267:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010126a:	b8 00 06 00 00       	mov    $0x600,%eax
8010126f:	29 fb                	sub    %edi,%ebx
      if(n1 > max)
80101271:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101277:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
8010127a:	e8 91 1c 00 00       	call   80102f10 <begin_op>
      ilock(f->ip);
8010127f:	83 ec 0c             	sub    $0xc,%esp
80101282:	ff 76 10             	pushl  0x10(%esi)
80101285:	e8 46 06 00 00       	call   801018d0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010128a:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010128d:	53                   	push   %ebx
8010128e:	ff 76 14             	pushl  0x14(%esi)
80101291:	01 f8                	add    %edi,%eax
80101293:	50                   	push   %eax
80101294:	ff 76 10             	pushl  0x10(%esi)
80101297:	e8 54 0a 00 00       	call   80101cf0 <writei>
8010129c:	83 c4 20             	add    $0x20,%esp
8010129f:	85 c0                	test   %eax,%eax
801012a1:	7f 9d                	jg     80101240 <filewrite+0x50>
      iunlock(f->ip);
801012a3:	83 ec 0c             	sub    $0xc,%esp
801012a6:	ff 76 10             	pushl  0x10(%esi)
801012a9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801012ac:	e8 ff 06 00 00       	call   801019b0 <iunlock>
      end_op();
801012b1:	e8 ca 1c 00 00       	call   80102f80 <end_op>
      if(r < 0)
801012b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801012b9:	83 c4 10             	add    $0x10,%esp
801012bc:	85 c0                	test   %eax,%eax
801012be:	75 17                	jne    801012d7 <filewrite+0xe7>
        panic("short filewrite");
801012c0:	83 ec 0c             	sub    $0xc,%esp
801012c3:	68 0f 76 10 80       	push   $0x8010760f
801012c8:	e8 c3 f0 ff ff       	call   80100390 <panic>
801012cd:	8d 76 00             	lea    0x0(%esi),%esi
    }
    return i == n ? n : -1;
801012d0:	89 f8                	mov    %edi,%eax
801012d2:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
801012d5:	74 05                	je     801012dc <filewrite+0xec>
801012d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
801012dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012df:	5b                   	pop    %ebx
801012e0:	5e                   	pop    %esi
801012e1:	5f                   	pop    %edi
801012e2:	5d                   	pop    %ebp
801012e3:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
801012e4:	8b 46 0c             	mov    0xc(%esi),%eax
801012e7:	89 45 08             	mov    %eax,0x8(%ebp)
}
801012ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012ed:	5b                   	pop    %ebx
801012ee:	5e                   	pop    %esi
801012ef:	5f                   	pop    %edi
801012f0:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801012f1:	e9 ba 24 00 00       	jmp    801037b0 <pipewrite>
  panic("filewrite");
801012f6:	83 ec 0c             	sub    $0xc,%esp
801012f9:	68 15 76 10 80       	push   $0x80107615
801012fe:	e8 8d f0 ff ff       	call   80100390 <panic>
80101303:	66 90                	xchg   %ax,%ax
80101305:	66 90                	xchg   %ax,%ax
80101307:	66 90                	xchg   %ax,%ax
80101309:	66 90                	xchg   %ax,%ax
8010130b:	66 90                	xchg   %ax,%ax
8010130d:	66 90                	xchg   %ax,%ax
8010130f:	90                   	nop

80101310 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101310:	55                   	push   %ebp
80101311:	89 c1                	mov    %eax,%ecx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101313:	89 d0                	mov    %edx,%eax
80101315:	c1 e8 0c             	shr    $0xc,%eax
80101318:	03 05 cc 15 11 80    	add    0x801115cc,%eax
{
8010131e:	89 e5                	mov    %esp,%ebp
80101320:	56                   	push   %esi
80101321:	53                   	push   %ebx
80101322:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101324:	83 ec 08             	sub    $0x8,%esp
80101327:	50                   	push   %eax
80101328:	51                   	push   %ecx
80101329:	e8 a2 ed ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010132e:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80101330:	c1 fb 03             	sar    $0x3,%ebx
80101333:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
80101336:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
80101338:	83 e1 07             	and    $0x7,%ecx
8010133b:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
80101340:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
80101346:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
80101348:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
8010134d:	85 c1                	test   %eax,%ecx
8010134f:	74 23                	je     80101374 <bfree+0x64>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101351:	f7 d0                	not    %eax
  log_write(bp);
80101353:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101356:	21 c8                	and    %ecx,%eax
80101358:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010135c:	56                   	push   %esi
8010135d:	e8 8e 1d 00 00       	call   801030f0 <log_write>
  brelse(bp);
80101362:	89 34 24             	mov    %esi,(%esp)
80101365:	e8 86 ee ff ff       	call   801001f0 <brelse>
}
8010136a:	83 c4 10             	add    $0x10,%esp
8010136d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101370:	5b                   	pop    %ebx
80101371:	5e                   	pop    %esi
80101372:	5d                   	pop    %ebp
80101373:	c3                   	ret    
    panic("freeing free block");
80101374:	83 ec 0c             	sub    $0xc,%esp
80101377:	68 1f 76 10 80       	push   $0x8010761f
8010137c:	e8 0f f0 ff ff       	call   80100390 <panic>
80101381:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101388:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010138f:	90                   	nop

80101390 <balloc>:
{
80101390:	55                   	push   %ebp
80101391:	89 e5                	mov    %esp,%ebp
80101393:	57                   	push   %edi
80101394:	56                   	push   %esi
80101395:	53                   	push   %ebx
80101396:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
80101399:	8b 0d b4 15 11 80    	mov    0x801115b4,%ecx
{
8010139f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801013a2:	85 c9                	test   %ecx,%ecx
801013a4:	0f 84 87 00 00 00    	je     80101431 <balloc+0xa1>
801013aa:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801013b1:	8b 75 dc             	mov    -0x24(%ebp),%esi
801013b4:	83 ec 08             	sub    $0x8,%esp
801013b7:	89 f0                	mov    %esi,%eax
801013b9:	c1 f8 0c             	sar    $0xc,%eax
801013bc:	03 05 cc 15 11 80    	add    0x801115cc,%eax
801013c2:	50                   	push   %eax
801013c3:	ff 75 d8             	pushl  -0x28(%ebp)
801013c6:	e8 05 ed ff ff       	call   801000d0 <bread>
801013cb:	83 c4 10             	add    $0x10,%esp
801013ce:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801013d1:	a1 b4 15 11 80       	mov    0x801115b4,%eax
801013d6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801013d9:	31 c0                	xor    %eax,%eax
801013db:	eb 2f                	jmp    8010140c <balloc+0x7c>
801013dd:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801013e0:	89 c1                	mov    %eax,%ecx
801013e2:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801013e7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
801013ea:	83 e1 07             	and    $0x7,%ecx
801013ed:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801013ef:	89 c1                	mov    %eax,%ecx
801013f1:	c1 f9 03             	sar    $0x3,%ecx
801013f4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
801013f9:	89 fa                	mov    %edi,%edx
801013fb:	85 df                	test   %ebx,%edi
801013fd:	74 41                	je     80101440 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801013ff:	83 c0 01             	add    $0x1,%eax
80101402:	83 c6 01             	add    $0x1,%esi
80101405:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010140a:	74 05                	je     80101411 <balloc+0x81>
8010140c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010140f:	77 cf                	ja     801013e0 <balloc+0x50>
    brelse(bp);
80101411:	83 ec 0c             	sub    $0xc,%esp
80101414:	ff 75 e4             	pushl  -0x1c(%ebp)
80101417:	e8 d4 ed ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010141c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101423:	83 c4 10             	add    $0x10,%esp
80101426:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101429:	39 05 b4 15 11 80    	cmp    %eax,0x801115b4
8010142f:	77 80                	ja     801013b1 <balloc+0x21>
  panic("balloc: out of blocks");
80101431:	83 ec 0c             	sub    $0xc,%esp
80101434:	68 32 76 10 80       	push   $0x80107632
80101439:	e8 52 ef ff ff       	call   80100390 <panic>
8010143e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101440:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101443:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101446:	09 da                	or     %ebx,%edx
80101448:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010144c:	57                   	push   %edi
8010144d:	e8 9e 1c 00 00       	call   801030f0 <log_write>
        brelse(bp);
80101452:	89 3c 24             	mov    %edi,(%esp)
80101455:	e8 96 ed ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
8010145a:	58                   	pop    %eax
8010145b:	5a                   	pop    %edx
8010145c:	56                   	push   %esi
8010145d:	ff 75 d8             	pushl  -0x28(%ebp)
80101460:	e8 6b ec ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101465:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101468:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
8010146a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010146d:	68 00 02 00 00       	push   $0x200
80101472:	6a 00                	push   $0x0
80101474:	50                   	push   %eax
80101475:	e8 66 34 00 00       	call   801048e0 <memset>
  log_write(bp);
8010147a:	89 1c 24             	mov    %ebx,(%esp)
8010147d:	e8 6e 1c 00 00       	call   801030f0 <log_write>
  brelse(bp);
80101482:	89 1c 24             	mov    %ebx,(%esp)
80101485:	e8 66 ed ff ff       	call   801001f0 <brelse>
}
8010148a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010148d:	89 f0                	mov    %esi,%eax
8010148f:	5b                   	pop    %ebx
80101490:	5e                   	pop    %esi
80101491:	5f                   	pop    %edi
80101492:	5d                   	pop    %ebp
80101493:	c3                   	ret    
80101494:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010149b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010149f:	90                   	nop

801014a0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801014a0:	55                   	push   %ebp
801014a1:	89 e5                	mov    %esp,%ebp
801014a3:	57                   	push   %edi
801014a4:	89 c7                	mov    %eax,%edi
801014a6:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801014a7:	31 f6                	xor    %esi,%esi
{
801014a9:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801014aa:	bb 94 f9 10 80       	mov    $0x8010f994,%ebx
{
801014af:	83 ec 28             	sub    $0x28,%esp
801014b2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801014b5:	68 60 f9 10 80       	push   $0x8010f960
801014ba:	e8 51 33 00 00       	call   80104810 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801014bf:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
801014c2:	83 c4 10             	add    $0x10,%esp
801014c5:	eb 1b                	jmp    801014e2 <iget+0x42>
801014c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801014ce:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801014d0:	39 3b                	cmp    %edi,(%ebx)
801014d2:	74 6c                	je     80101540 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801014d4:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014da:	81 fb b4 15 11 80    	cmp    $0x801115b4,%ebx
801014e0:	73 26                	jae    80101508 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801014e2:	8b 43 08             	mov    0x8(%ebx),%eax
801014e5:	85 c0                	test   %eax,%eax
801014e7:	7f e7                	jg     801014d0 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801014e9:	85 f6                	test   %esi,%esi
801014eb:	75 e7                	jne    801014d4 <iget+0x34>
801014ed:	89 d9                	mov    %ebx,%ecx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801014ef:	81 c3 90 00 00 00    	add    $0x90,%ebx
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801014f5:	85 c0                	test   %eax,%eax
801014f7:	75 6e                	jne    80101567 <iget+0xc7>
801014f9:	89 ce                	mov    %ecx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801014fb:	81 fb b4 15 11 80    	cmp    $0x801115b4,%ebx
80101501:	72 df                	jb     801014e2 <iget+0x42>
80101503:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101507:	90                   	nop
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101508:	85 f6                	test   %esi,%esi
8010150a:	74 73                	je     8010157f <iget+0xdf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
8010150c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
8010150f:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101511:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
80101514:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
8010151b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
80101522:	68 60 f9 10 80       	push   $0x8010f960
80101527:	e8 74 32 00 00       	call   801047a0 <release>

  return ip;
8010152c:	83 c4 10             	add    $0x10,%esp
}
8010152f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101532:	89 f0                	mov    %esi,%eax
80101534:	5b                   	pop    %ebx
80101535:	5e                   	pop    %esi
80101536:	5f                   	pop    %edi
80101537:	5d                   	pop    %ebp
80101538:	c3                   	ret    
80101539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101540:	39 53 04             	cmp    %edx,0x4(%ebx)
80101543:	75 8f                	jne    801014d4 <iget+0x34>
      release(&icache.lock);
80101545:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101548:	83 c0 01             	add    $0x1,%eax
      return ip;
8010154b:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
8010154d:	68 60 f9 10 80       	push   $0x8010f960
      ip->ref++;
80101552:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80101555:	e8 46 32 00 00       	call   801047a0 <release>
      return ip;
8010155a:	83 c4 10             	add    $0x10,%esp
}
8010155d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101560:	89 f0                	mov    %esi,%eax
80101562:	5b                   	pop    %ebx
80101563:	5e                   	pop    %esi
80101564:	5f                   	pop    %edi
80101565:	5d                   	pop    %ebp
80101566:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101567:	81 fb b4 15 11 80    	cmp    $0x801115b4,%ebx
8010156d:	73 10                	jae    8010157f <iget+0xdf>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010156f:	8b 43 08             	mov    0x8(%ebx),%eax
80101572:	85 c0                	test   %eax,%eax
80101574:	0f 8f 56 ff ff ff    	jg     801014d0 <iget+0x30>
8010157a:	e9 6e ff ff ff       	jmp    801014ed <iget+0x4d>
    panic("iget: no inodes");
8010157f:	83 ec 0c             	sub    $0xc,%esp
80101582:	68 48 76 10 80       	push   $0x80107648
80101587:	e8 04 ee ff ff       	call   80100390 <panic>
8010158c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101590 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101590:	55                   	push   %ebp
80101591:	89 e5                	mov    %esp,%ebp
80101593:	57                   	push   %edi
80101594:	56                   	push   %esi
80101595:	89 c6                	mov    %eax,%esi
80101597:	53                   	push   %ebx
80101598:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010159b:	83 fa 0b             	cmp    $0xb,%edx
8010159e:	0f 86 8c 00 00 00    	jbe    80101630 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801015a4:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
801015a7:	83 fb 7f             	cmp    $0x7f,%ebx
801015aa:	0f 87 a2 00 00 00    	ja     80101652 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801015b0:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
      ip->addrs[bn] = addr = balloc(ip->dev);
801015b6:	8b 16                	mov    (%esi),%edx
    if((addr = ip->addrs[NDIRECT]) == 0)
801015b8:	85 c0                	test   %eax,%eax
801015ba:	74 5c                	je     80101618 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801015bc:	83 ec 08             	sub    $0x8,%esp
801015bf:	50                   	push   %eax
801015c0:	52                   	push   %edx
801015c1:	e8 0a eb ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801015c6:	83 c4 10             	add    $0x10,%esp
801015c9:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
801015cd:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
801015cf:	8b 3b                	mov    (%ebx),%edi
801015d1:	85 ff                	test   %edi,%edi
801015d3:	74 1b                	je     801015f0 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
801015d5:	83 ec 0c             	sub    $0xc,%esp
801015d8:	52                   	push   %edx
801015d9:	e8 12 ec ff ff       	call   801001f0 <brelse>
801015de:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
801015e1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801015e4:	89 f8                	mov    %edi,%eax
801015e6:	5b                   	pop    %ebx
801015e7:	5e                   	pop    %esi
801015e8:	5f                   	pop    %edi
801015e9:	5d                   	pop    %ebp
801015ea:	c3                   	ret    
801015eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801015ef:	90                   	nop
801015f0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
801015f3:	8b 06                	mov    (%esi),%eax
801015f5:	e8 96 fd ff ff       	call   80101390 <balloc>
      log_write(bp);
801015fa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801015fd:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101600:	89 03                	mov    %eax,(%ebx)
80101602:	89 c7                	mov    %eax,%edi
      log_write(bp);
80101604:	52                   	push   %edx
80101605:	e8 e6 1a 00 00       	call   801030f0 <log_write>
8010160a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010160d:	83 c4 10             	add    $0x10,%esp
80101610:	eb c3                	jmp    801015d5 <bmap+0x45>
80101612:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101618:	89 d0                	mov    %edx,%eax
8010161a:	e8 71 fd ff ff       	call   80101390 <balloc>
    bp = bread(ip->dev, addr);
8010161f:	8b 16                	mov    (%esi),%edx
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101621:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101627:	eb 93                	jmp    801015bc <bmap+0x2c>
80101629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if((addr = ip->addrs[bn]) == 0)
80101630:	8d 5a 14             	lea    0x14(%edx),%ebx
80101633:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
80101637:	85 ff                	test   %edi,%edi
80101639:	75 a6                	jne    801015e1 <bmap+0x51>
      ip->addrs[bn] = addr = balloc(ip->dev);
8010163b:	8b 00                	mov    (%eax),%eax
8010163d:	e8 4e fd ff ff       	call   80101390 <balloc>
80101642:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80101646:	89 c7                	mov    %eax,%edi
}
80101648:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010164b:	5b                   	pop    %ebx
8010164c:	89 f8                	mov    %edi,%eax
8010164e:	5e                   	pop    %esi
8010164f:	5f                   	pop    %edi
80101650:	5d                   	pop    %ebp
80101651:	c3                   	ret    
  panic("bmap: out of range");
80101652:	83 ec 0c             	sub    $0xc,%esp
80101655:	68 58 76 10 80       	push   $0x80107658
8010165a:	e8 31 ed ff ff       	call   80100390 <panic>
8010165f:	90                   	nop

80101660 <readsb>:
{
80101660:	f3 0f 1e fb          	endbr32 
80101664:	55                   	push   %ebp
80101665:	89 e5                	mov    %esp,%ebp
80101667:	56                   	push   %esi
80101668:	53                   	push   %ebx
80101669:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
8010166c:	83 ec 08             	sub    $0x8,%esp
8010166f:	6a 01                	push   $0x1
80101671:	ff 75 08             	pushl  0x8(%ebp)
80101674:	e8 57 ea ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101679:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
8010167c:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010167e:	8d 40 5c             	lea    0x5c(%eax),%eax
80101681:	6a 1c                	push   $0x1c
80101683:	50                   	push   %eax
80101684:	56                   	push   %esi
80101685:	e8 f6 32 00 00       	call   80104980 <memmove>
  brelse(bp);
8010168a:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010168d:	83 c4 10             	add    $0x10,%esp
}
80101690:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101693:	5b                   	pop    %ebx
80101694:	5e                   	pop    %esi
80101695:	5d                   	pop    %ebp
  brelse(bp);
80101696:	e9 55 eb ff ff       	jmp    801001f0 <brelse>
8010169b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010169f:	90                   	nop

801016a0 <iinit>:
{
801016a0:	f3 0f 1e fb          	endbr32 
801016a4:	55                   	push   %ebp
801016a5:	89 e5                	mov    %esp,%ebp
801016a7:	53                   	push   %ebx
801016a8:	bb a0 f9 10 80       	mov    $0x8010f9a0,%ebx
801016ad:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
801016b0:	68 6b 76 10 80       	push   $0x8010766b
801016b5:	68 60 f9 10 80       	push   $0x8010f960
801016ba:	e8 51 2f 00 00       	call   80104610 <initlock>
  for(i = 0; i < NINODE; i++) {
801016bf:	83 c4 10             	add    $0x10,%esp
801016c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    initsleeplock(&icache.inode[i].lock, "inode");
801016c8:	83 ec 08             	sub    $0x8,%esp
801016cb:	68 72 76 10 80       	push   $0x80107672
801016d0:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
801016d1:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
801016d7:	e8 f4 2d 00 00       	call   801044d0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801016dc:	83 c4 10             	add    $0x10,%esp
801016df:	81 fb c0 15 11 80    	cmp    $0x801115c0,%ebx
801016e5:	75 e1                	jne    801016c8 <iinit+0x28>
  bp = bread(dev, 1);
801016e7:	83 ec 08             	sub    $0x8,%esp
801016ea:	6a 01                	push   $0x1
801016ec:	ff 75 08             	pushl  0x8(%ebp)
801016ef:	e8 dc e9 ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801016f4:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801016f7:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801016f9:	8d 40 5c             	lea    0x5c(%eax),%eax
801016fc:	6a 1c                	push   $0x1c
801016fe:	50                   	push   %eax
801016ff:	68 b4 15 11 80       	push   $0x801115b4
80101704:	e8 77 32 00 00       	call   80104980 <memmove>
  brelse(bp);
80101709:	89 1c 24             	mov    %ebx,(%esp)
8010170c:	e8 df ea ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101711:	ff 35 cc 15 11 80    	pushl  0x801115cc
80101717:	ff 35 c8 15 11 80    	pushl  0x801115c8
8010171d:	ff 35 c4 15 11 80    	pushl  0x801115c4
80101723:	ff 35 c0 15 11 80    	pushl  0x801115c0
80101729:	ff 35 bc 15 11 80    	pushl  0x801115bc
8010172f:	ff 35 b8 15 11 80    	pushl  0x801115b8
80101735:	ff 35 b4 15 11 80    	pushl  0x801115b4
8010173b:	68 d8 76 10 80       	push   $0x801076d8
80101740:	e8 4b ef ff ff       	call   80100690 <cprintf>
}
80101745:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101748:	83 c4 30             	add    $0x30,%esp
8010174b:	c9                   	leave  
8010174c:	c3                   	ret    
8010174d:	8d 76 00             	lea    0x0(%esi),%esi

80101750 <ialloc>:
{
80101750:	f3 0f 1e fb          	endbr32 
80101754:	55                   	push   %ebp
80101755:	89 e5                	mov    %esp,%ebp
80101757:	57                   	push   %edi
80101758:	56                   	push   %esi
80101759:	53                   	push   %ebx
8010175a:	83 ec 1c             	sub    $0x1c,%esp
8010175d:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
80101760:	83 3d bc 15 11 80 01 	cmpl   $0x1,0x801115bc
{
80101767:	8b 75 08             	mov    0x8(%ebp),%esi
8010176a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
8010176d:	0f 86 8d 00 00 00    	jbe    80101800 <ialloc+0xb0>
80101773:	bf 01 00 00 00       	mov    $0x1,%edi
80101778:	eb 1d                	jmp    80101797 <ialloc+0x47>
8010177a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    brelse(bp);
80101780:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101783:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80101786:	53                   	push   %ebx
80101787:	e8 64 ea ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010178c:	83 c4 10             	add    $0x10,%esp
8010178f:	3b 3d bc 15 11 80    	cmp    0x801115bc,%edi
80101795:	73 69                	jae    80101800 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101797:	89 f8                	mov    %edi,%eax
80101799:	83 ec 08             	sub    $0x8,%esp
8010179c:	c1 e8 03             	shr    $0x3,%eax
8010179f:	03 05 c8 15 11 80    	add    0x801115c8,%eax
801017a5:	50                   	push   %eax
801017a6:	56                   	push   %esi
801017a7:	e8 24 e9 ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
801017ac:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
801017af:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
801017b1:	89 f8                	mov    %edi,%eax
801017b3:	83 e0 07             	and    $0x7,%eax
801017b6:	c1 e0 06             	shl    $0x6,%eax
801017b9:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801017bd:	66 83 39 00          	cmpw   $0x0,(%ecx)
801017c1:	75 bd                	jne    80101780 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801017c3:	83 ec 04             	sub    $0x4,%esp
801017c6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801017c9:	6a 40                	push   $0x40
801017cb:	6a 00                	push   $0x0
801017cd:	51                   	push   %ecx
801017ce:	e8 0d 31 00 00       	call   801048e0 <memset>
      dip->type = type;
801017d3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801017d7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801017da:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801017dd:	89 1c 24             	mov    %ebx,(%esp)
801017e0:	e8 0b 19 00 00       	call   801030f0 <log_write>
      brelse(bp);
801017e5:	89 1c 24             	mov    %ebx,(%esp)
801017e8:	e8 03 ea ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
801017ed:	83 c4 10             	add    $0x10,%esp
}
801017f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801017f3:	89 fa                	mov    %edi,%edx
}
801017f5:	5b                   	pop    %ebx
      return iget(dev, inum);
801017f6:	89 f0                	mov    %esi,%eax
}
801017f8:	5e                   	pop    %esi
801017f9:	5f                   	pop    %edi
801017fa:	5d                   	pop    %ebp
      return iget(dev, inum);
801017fb:	e9 a0 fc ff ff       	jmp    801014a0 <iget>
  panic("ialloc: no inodes");
80101800:	83 ec 0c             	sub    $0xc,%esp
80101803:	68 78 76 10 80       	push   $0x80107678
80101808:	e8 83 eb ff ff       	call   80100390 <panic>
8010180d:	8d 76 00             	lea    0x0(%esi),%esi

80101810 <iupdate>:
{
80101810:	f3 0f 1e fb          	endbr32 
80101814:	55                   	push   %ebp
80101815:	89 e5                	mov    %esp,%ebp
80101817:	56                   	push   %esi
80101818:	53                   	push   %ebx
80101819:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010181c:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010181f:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101822:	83 ec 08             	sub    $0x8,%esp
80101825:	c1 e8 03             	shr    $0x3,%eax
80101828:	03 05 c8 15 11 80    	add    0x801115c8,%eax
8010182e:	50                   	push   %eax
8010182f:	ff 73 a4             	pushl  -0x5c(%ebx)
80101832:	e8 99 e8 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80101837:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010183b:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010183e:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101840:	8b 43 a8             	mov    -0x58(%ebx),%eax
80101843:	83 e0 07             	and    $0x7,%eax
80101846:	c1 e0 06             	shl    $0x6,%eax
80101849:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
8010184d:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101850:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101854:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101857:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
8010185b:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010185f:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
80101863:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101867:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
8010186b:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010186e:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101871:	6a 34                	push   $0x34
80101873:	53                   	push   %ebx
80101874:	50                   	push   %eax
80101875:	e8 06 31 00 00       	call   80104980 <memmove>
  log_write(bp);
8010187a:	89 34 24             	mov    %esi,(%esp)
8010187d:	e8 6e 18 00 00       	call   801030f0 <log_write>
  brelse(bp);
80101882:	89 75 08             	mov    %esi,0x8(%ebp)
80101885:	83 c4 10             	add    $0x10,%esp
}
80101888:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010188b:	5b                   	pop    %ebx
8010188c:	5e                   	pop    %esi
8010188d:	5d                   	pop    %ebp
  brelse(bp);
8010188e:	e9 5d e9 ff ff       	jmp    801001f0 <brelse>
80101893:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010189a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801018a0 <idup>:
{
801018a0:	f3 0f 1e fb          	endbr32 
801018a4:	55                   	push   %ebp
801018a5:	89 e5                	mov    %esp,%ebp
801018a7:	53                   	push   %ebx
801018a8:	83 ec 10             	sub    $0x10,%esp
801018ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801018ae:	68 60 f9 10 80       	push   $0x8010f960
801018b3:	e8 58 2f 00 00       	call   80104810 <acquire>
  ip->ref++;
801018b8:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801018bc:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
801018c3:	e8 d8 2e 00 00       	call   801047a0 <release>
}
801018c8:	89 d8                	mov    %ebx,%eax
801018ca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801018cd:	c9                   	leave  
801018ce:	c3                   	ret    
801018cf:	90                   	nop

801018d0 <ilock>:
{
801018d0:	f3 0f 1e fb          	endbr32 
801018d4:	55                   	push   %ebp
801018d5:	89 e5                	mov    %esp,%ebp
801018d7:	56                   	push   %esi
801018d8:	53                   	push   %ebx
801018d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801018dc:	85 db                	test   %ebx,%ebx
801018de:	0f 84 b3 00 00 00    	je     80101997 <ilock+0xc7>
801018e4:	8b 53 08             	mov    0x8(%ebx),%edx
801018e7:	85 d2                	test   %edx,%edx
801018e9:	0f 8e a8 00 00 00    	jle    80101997 <ilock+0xc7>
  acquiresleep(&ip->lock);
801018ef:	83 ec 0c             	sub    $0xc,%esp
801018f2:	8d 43 0c             	lea    0xc(%ebx),%eax
801018f5:	50                   	push   %eax
801018f6:	e8 15 2c 00 00       	call   80104510 <acquiresleep>
  if(ip->valid == 0){
801018fb:	8b 43 4c             	mov    0x4c(%ebx),%eax
801018fe:	83 c4 10             	add    $0x10,%esp
80101901:	85 c0                	test   %eax,%eax
80101903:	74 0b                	je     80101910 <ilock+0x40>
}
80101905:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101908:	5b                   	pop    %ebx
80101909:	5e                   	pop    %esi
8010190a:	5d                   	pop    %ebp
8010190b:	c3                   	ret    
8010190c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101910:	8b 43 04             	mov    0x4(%ebx),%eax
80101913:	83 ec 08             	sub    $0x8,%esp
80101916:	c1 e8 03             	shr    $0x3,%eax
80101919:	03 05 c8 15 11 80    	add    0x801115c8,%eax
8010191f:	50                   	push   %eax
80101920:	ff 33                	pushl  (%ebx)
80101922:	e8 a9 e7 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101927:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010192a:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010192c:	8b 43 04             	mov    0x4(%ebx),%eax
8010192f:	83 e0 07             	and    $0x7,%eax
80101932:	c1 e0 06             	shl    $0x6,%eax
80101935:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101939:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010193c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010193f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101943:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101947:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010194b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010194f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101953:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101957:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010195b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010195e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101961:	6a 34                	push   $0x34
80101963:	50                   	push   %eax
80101964:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101967:	50                   	push   %eax
80101968:	e8 13 30 00 00       	call   80104980 <memmove>
    brelse(bp);
8010196d:	89 34 24             	mov    %esi,(%esp)
80101970:	e8 7b e8 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80101975:	83 c4 10             	add    $0x10,%esp
80101978:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010197d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101984:	0f 85 7b ff ff ff    	jne    80101905 <ilock+0x35>
      panic("ilock: no type");
8010198a:	83 ec 0c             	sub    $0xc,%esp
8010198d:	68 90 76 10 80       	push   $0x80107690
80101992:	e8 f9 e9 ff ff       	call   80100390 <panic>
    panic("ilock");
80101997:	83 ec 0c             	sub    $0xc,%esp
8010199a:	68 8a 76 10 80       	push   $0x8010768a
8010199f:	e8 ec e9 ff ff       	call   80100390 <panic>
801019a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801019af:	90                   	nop

801019b0 <iunlock>:
{
801019b0:	f3 0f 1e fb          	endbr32 
801019b4:	55                   	push   %ebp
801019b5:	89 e5                	mov    %esp,%ebp
801019b7:	56                   	push   %esi
801019b8:	53                   	push   %ebx
801019b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801019bc:	85 db                	test   %ebx,%ebx
801019be:	74 28                	je     801019e8 <iunlock+0x38>
801019c0:	83 ec 0c             	sub    $0xc,%esp
801019c3:	8d 73 0c             	lea    0xc(%ebx),%esi
801019c6:	56                   	push   %esi
801019c7:	e8 e4 2b 00 00       	call   801045b0 <holdingsleep>
801019cc:	83 c4 10             	add    $0x10,%esp
801019cf:	85 c0                	test   %eax,%eax
801019d1:	74 15                	je     801019e8 <iunlock+0x38>
801019d3:	8b 43 08             	mov    0x8(%ebx),%eax
801019d6:	85 c0                	test   %eax,%eax
801019d8:	7e 0e                	jle    801019e8 <iunlock+0x38>
  releasesleep(&ip->lock);
801019da:	89 75 08             	mov    %esi,0x8(%ebp)
}
801019dd:	8d 65 f8             	lea    -0x8(%ebp),%esp
801019e0:	5b                   	pop    %ebx
801019e1:	5e                   	pop    %esi
801019e2:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801019e3:	e9 88 2b 00 00       	jmp    80104570 <releasesleep>
    panic("iunlock");
801019e8:	83 ec 0c             	sub    $0xc,%esp
801019eb:	68 9f 76 10 80       	push   $0x8010769f
801019f0:	e8 9b e9 ff ff       	call   80100390 <panic>
801019f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101a00 <iput>:
{
80101a00:	f3 0f 1e fb          	endbr32 
80101a04:	55                   	push   %ebp
80101a05:	89 e5                	mov    %esp,%ebp
80101a07:	57                   	push   %edi
80101a08:	56                   	push   %esi
80101a09:	53                   	push   %ebx
80101a0a:	83 ec 28             	sub    $0x28,%esp
80101a0d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
80101a10:	8d 7b 0c             	lea    0xc(%ebx),%edi
80101a13:	57                   	push   %edi
80101a14:	e8 f7 2a 00 00       	call   80104510 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101a19:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101a1c:	83 c4 10             	add    $0x10,%esp
80101a1f:	85 d2                	test   %edx,%edx
80101a21:	74 07                	je     80101a2a <iput+0x2a>
80101a23:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101a28:	74 36                	je     80101a60 <iput+0x60>
  releasesleep(&ip->lock);
80101a2a:	83 ec 0c             	sub    $0xc,%esp
80101a2d:	57                   	push   %edi
80101a2e:	e8 3d 2b 00 00       	call   80104570 <releasesleep>
  acquire(&icache.lock);
80101a33:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
80101a3a:	e8 d1 2d 00 00       	call   80104810 <acquire>
  ip->ref--;
80101a3f:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101a43:	83 c4 10             	add    $0x10,%esp
80101a46:	c7 45 08 60 f9 10 80 	movl   $0x8010f960,0x8(%ebp)
}
80101a4d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a50:	5b                   	pop    %ebx
80101a51:	5e                   	pop    %esi
80101a52:	5f                   	pop    %edi
80101a53:	5d                   	pop    %ebp
  release(&icache.lock);
80101a54:	e9 47 2d 00 00       	jmp    801047a0 <release>
80101a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&icache.lock);
80101a60:	83 ec 0c             	sub    $0xc,%esp
80101a63:	68 60 f9 10 80       	push   $0x8010f960
80101a68:	e8 a3 2d 00 00       	call   80104810 <acquire>
    int r = ip->ref;
80101a6d:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101a70:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
80101a77:	e8 24 2d 00 00       	call   801047a0 <release>
    if(r == 1){
80101a7c:	83 c4 10             	add    $0x10,%esp
80101a7f:	83 fe 01             	cmp    $0x1,%esi
80101a82:	75 a6                	jne    80101a2a <iput+0x2a>
80101a84:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101a8a:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101a8d:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101a90:	89 cf                	mov    %ecx,%edi
80101a92:	eb 0b                	jmp    80101a9f <iput+0x9f>
80101a94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101a98:	83 c6 04             	add    $0x4,%esi
80101a9b:	39 fe                	cmp    %edi,%esi
80101a9d:	74 19                	je     80101ab8 <iput+0xb8>
    if(ip->addrs[i]){
80101a9f:	8b 16                	mov    (%esi),%edx
80101aa1:	85 d2                	test   %edx,%edx
80101aa3:	74 f3                	je     80101a98 <iput+0x98>
      bfree(ip->dev, ip->addrs[i]);
80101aa5:	8b 03                	mov    (%ebx),%eax
80101aa7:	e8 64 f8 ff ff       	call   80101310 <bfree>
      ip->addrs[i] = 0;
80101aac:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80101ab2:	eb e4                	jmp    80101a98 <iput+0x98>
80101ab4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101ab8:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101abe:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101ac1:	85 c0                	test   %eax,%eax
80101ac3:	75 2d                	jne    80101af2 <iput+0xf2>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101ac5:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101ac8:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101acf:	53                   	push   %ebx
80101ad0:	e8 3b fd ff ff       	call   80101810 <iupdate>
      ip->type = 0;
80101ad5:	31 c0                	xor    %eax,%eax
80101ad7:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101adb:	89 1c 24             	mov    %ebx,(%esp)
80101ade:	e8 2d fd ff ff       	call   80101810 <iupdate>
      ip->valid = 0;
80101ae3:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101aea:	83 c4 10             	add    $0x10,%esp
80101aed:	e9 38 ff ff ff       	jmp    80101a2a <iput+0x2a>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101af2:	83 ec 08             	sub    $0x8,%esp
80101af5:	50                   	push   %eax
80101af6:	ff 33                	pushl  (%ebx)
80101af8:	e8 d3 e5 ff ff       	call   801000d0 <bread>
80101afd:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101b00:	83 c4 10             	add    $0x10,%esp
80101b03:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101b09:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101b0c:	8d 70 5c             	lea    0x5c(%eax),%esi
80101b0f:	89 cf                	mov    %ecx,%edi
80101b11:	eb 0c                	jmp    80101b1f <iput+0x11f>
80101b13:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b17:	90                   	nop
80101b18:	83 c6 04             	add    $0x4,%esi
80101b1b:	39 f7                	cmp    %esi,%edi
80101b1d:	74 0f                	je     80101b2e <iput+0x12e>
      if(a[j])
80101b1f:	8b 16                	mov    (%esi),%edx
80101b21:	85 d2                	test   %edx,%edx
80101b23:	74 f3                	je     80101b18 <iput+0x118>
        bfree(ip->dev, a[j]);
80101b25:	8b 03                	mov    (%ebx),%eax
80101b27:	e8 e4 f7 ff ff       	call   80101310 <bfree>
80101b2c:	eb ea                	jmp    80101b18 <iput+0x118>
    brelse(bp);
80101b2e:	83 ec 0c             	sub    $0xc,%esp
80101b31:	ff 75 e4             	pushl  -0x1c(%ebp)
80101b34:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101b37:	e8 b4 e6 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101b3c:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101b42:	8b 03                	mov    (%ebx),%eax
80101b44:	e8 c7 f7 ff ff       	call   80101310 <bfree>
    ip->addrs[NDIRECT] = 0;
80101b49:	83 c4 10             	add    $0x10,%esp
80101b4c:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101b53:	00 00 00 
80101b56:	e9 6a ff ff ff       	jmp    80101ac5 <iput+0xc5>
80101b5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b5f:	90                   	nop

80101b60 <iunlockput>:
{
80101b60:	f3 0f 1e fb          	endbr32 
80101b64:	55                   	push   %ebp
80101b65:	89 e5                	mov    %esp,%ebp
80101b67:	56                   	push   %esi
80101b68:	53                   	push   %ebx
80101b69:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101b6c:	85 db                	test   %ebx,%ebx
80101b6e:	74 34                	je     80101ba4 <iunlockput+0x44>
80101b70:	83 ec 0c             	sub    $0xc,%esp
80101b73:	8d 73 0c             	lea    0xc(%ebx),%esi
80101b76:	56                   	push   %esi
80101b77:	e8 34 2a 00 00       	call   801045b0 <holdingsleep>
80101b7c:	83 c4 10             	add    $0x10,%esp
80101b7f:	85 c0                	test   %eax,%eax
80101b81:	74 21                	je     80101ba4 <iunlockput+0x44>
80101b83:	8b 43 08             	mov    0x8(%ebx),%eax
80101b86:	85 c0                	test   %eax,%eax
80101b88:	7e 1a                	jle    80101ba4 <iunlockput+0x44>
  releasesleep(&ip->lock);
80101b8a:	83 ec 0c             	sub    $0xc,%esp
80101b8d:	56                   	push   %esi
80101b8e:	e8 dd 29 00 00       	call   80104570 <releasesleep>
  iput(ip);
80101b93:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101b96:	83 c4 10             	add    $0x10,%esp
}
80101b99:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101b9c:	5b                   	pop    %ebx
80101b9d:	5e                   	pop    %esi
80101b9e:	5d                   	pop    %ebp
  iput(ip);
80101b9f:	e9 5c fe ff ff       	jmp    80101a00 <iput>
    panic("iunlock");
80101ba4:	83 ec 0c             	sub    $0xc,%esp
80101ba7:	68 9f 76 10 80       	push   $0x8010769f
80101bac:	e8 df e7 ff ff       	call   80100390 <panic>
80101bb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101bb8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101bbf:	90                   	nop

80101bc0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101bc0:	f3 0f 1e fb          	endbr32 
80101bc4:	55                   	push   %ebp
80101bc5:	89 e5                	mov    %esp,%ebp
80101bc7:	8b 55 08             	mov    0x8(%ebp),%edx
80101bca:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101bcd:	8b 0a                	mov    (%edx),%ecx
80101bcf:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101bd2:	8b 4a 04             	mov    0x4(%edx),%ecx
80101bd5:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101bd8:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101bdc:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101bdf:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101be3:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101be7:	8b 52 58             	mov    0x58(%edx),%edx
80101bea:	89 50 10             	mov    %edx,0x10(%eax)
}
80101bed:	5d                   	pop    %ebp
80101bee:	c3                   	ret    
80101bef:	90                   	nop

80101bf0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101bf0:	f3 0f 1e fb          	endbr32 
80101bf4:	55                   	push   %ebp
80101bf5:	89 e5                	mov    %esp,%ebp
80101bf7:	57                   	push   %edi
80101bf8:	56                   	push   %esi
80101bf9:	53                   	push   %ebx
80101bfa:	83 ec 1c             	sub    $0x1c,%esp
80101bfd:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101c00:	8b 45 08             	mov    0x8(%ebp),%eax
80101c03:	8b 75 10             	mov    0x10(%ebp),%esi
80101c06:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101c09:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101c0c:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101c11:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101c14:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101c17:	0f 84 a3 00 00 00    	je     80101cc0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101c1d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c20:	8b 40 58             	mov    0x58(%eax),%eax
80101c23:	39 c6                	cmp    %eax,%esi
80101c25:	0f 87 b6 00 00 00    	ja     80101ce1 <readi+0xf1>
80101c2b:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101c2e:	31 c9                	xor    %ecx,%ecx
80101c30:	89 da                	mov    %ebx,%edx
80101c32:	01 f2                	add    %esi,%edx
80101c34:	0f 92 c1             	setb   %cl
80101c37:	89 cf                	mov    %ecx,%edi
80101c39:	0f 82 a2 00 00 00    	jb     80101ce1 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101c3f:	89 c1                	mov    %eax,%ecx
80101c41:	29 f1                	sub    %esi,%ecx
80101c43:	39 d0                	cmp    %edx,%eax
80101c45:	0f 43 cb             	cmovae %ebx,%ecx
80101c48:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101c4b:	85 c9                	test   %ecx,%ecx
80101c4d:	74 63                	je     80101cb2 <readi+0xc2>
80101c4f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c50:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101c53:	89 f2                	mov    %esi,%edx
80101c55:	c1 ea 09             	shr    $0x9,%edx
80101c58:	89 d8                	mov    %ebx,%eax
80101c5a:	e8 31 f9 ff ff       	call   80101590 <bmap>
80101c5f:	83 ec 08             	sub    $0x8,%esp
80101c62:	50                   	push   %eax
80101c63:	ff 33                	pushl  (%ebx)
80101c65:	e8 66 e4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101c6a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101c6d:	b9 00 02 00 00       	mov    $0x200,%ecx
80101c72:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c75:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101c77:	89 f0                	mov    %esi,%eax
80101c79:	25 ff 01 00 00       	and    $0x1ff,%eax
80101c7e:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101c80:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101c83:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101c85:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101c89:	39 d9                	cmp    %ebx,%ecx
80101c8b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101c8e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101c8f:	01 df                	add    %ebx,%edi
80101c91:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101c93:	50                   	push   %eax
80101c94:	ff 75 e0             	pushl  -0x20(%ebp)
80101c97:	e8 e4 2c 00 00       	call   80104980 <memmove>
    brelse(bp);
80101c9c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101c9f:	89 14 24             	mov    %edx,(%esp)
80101ca2:	e8 49 e5 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ca7:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101caa:	83 c4 10             	add    $0x10,%esp
80101cad:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101cb0:	77 9e                	ja     80101c50 <readi+0x60>
  }
  return n;
80101cb2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101cb5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cb8:	5b                   	pop    %ebx
80101cb9:	5e                   	pop    %esi
80101cba:	5f                   	pop    %edi
80101cbb:	5d                   	pop    %ebp
80101cbc:	c3                   	ret    
80101cbd:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101cc0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101cc4:	66 83 f8 09          	cmp    $0x9,%ax
80101cc8:	77 17                	ja     80101ce1 <readi+0xf1>
80101cca:	8b 04 c5 00 f9 10 80 	mov    -0x7fef0700(,%eax,8),%eax
80101cd1:	85 c0                	test   %eax,%eax
80101cd3:	74 0c                	je     80101ce1 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101cd5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101cd8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cdb:	5b                   	pop    %ebx
80101cdc:	5e                   	pop    %esi
80101cdd:	5f                   	pop    %edi
80101cde:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101cdf:	ff e0                	jmp    *%eax
      return -1;
80101ce1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ce6:	eb cd                	jmp    80101cb5 <readi+0xc5>
80101ce8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101cef:	90                   	nop

80101cf0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101cf0:	f3 0f 1e fb          	endbr32 
80101cf4:	55                   	push   %ebp
80101cf5:	89 e5                	mov    %esp,%ebp
80101cf7:	57                   	push   %edi
80101cf8:	56                   	push   %esi
80101cf9:	53                   	push   %ebx
80101cfa:	83 ec 1c             	sub    $0x1c,%esp
80101cfd:	8b 45 08             	mov    0x8(%ebp),%eax
80101d00:	8b 75 0c             	mov    0xc(%ebp),%esi
80101d03:	8b 55 14             	mov    0x14(%ebp),%edx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101d06:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101d0b:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101d0e:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101d11:	8b 75 10             	mov    0x10(%ebp),%esi
80101d14:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(ip->type == T_DEV){
80101d17:	0f 84 bb 00 00 00    	je     80101dd8 <writei+0xe8>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101d1d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101d20:	3b 70 58             	cmp    0x58(%eax),%esi
80101d23:	0f 87 eb 00 00 00    	ja     80101e14 <writei+0x124>
80101d29:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101d2c:	31 d2                	xor    %edx,%edx
80101d2e:	89 f8                	mov    %edi,%eax
80101d30:	01 f0                	add    %esi,%eax
80101d32:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101d35:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101d3a:	0f 87 d4 00 00 00    	ja     80101e14 <writei+0x124>
80101d40:	85 d2                	test   %edx,%edx
80101d42:	0f 85 cc 00 00 00    	jne    80101e14 <writei+0x124>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101d48:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101d4f:	85 ff                	test   %edi,%edi
80101d51:	74 76                	je     80101dc9 <writei+0xd9>
80101d53:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d57:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101d58:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101d5b:	89 f2                	mov    %esi,%edx
80101d5d:	c1 ea 09             	shr    $0x9,%edx
80101d60:	89 f8                	mov    %edi,%eax
80101d62:	e8 29 f8 ff ff       	call   80101590 <bmap>
80101d67:	83 ec 08             	sub    $0x8,%esp
80101d6a:	50                   	push   %eax
80101d6b:	ff 37                	pushl  (%edi)
80101d6d:	e8 5e e3 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101d72:	b9 00 02 00 00       	mov    $0x200,%ecx
80101d77:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101d7a:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101d7d:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101d7f:	89 f0                	mov    %esi,%eax
80101d81:	83 c4 0c             	add    $0xc,%esp
80101d84:	25 ff 01 00 00       	and    $0x1ff,%eax
80101d89:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101d8b:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101d8f:	39 d9                	cmp    %ebx,%ecx
80101d91:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101d94:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101d95:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101d97:	ff 75 dc             	pushl  -0x24(%ebp)
80101d9a:	50                   	push   %eax
80101d9b:	e8 e0 2b 00 00       	call   80104980 <memmove>
    log_write(bp);
80101da0:	89 3c 24             	mov    %edi,(%esp)
80101da3:	e8 48 13 00 00       	call   801030f0 <log_write>
    brelse(bp);
80101da8:	89 3c 24             	mov    %edi,(%esp)
80101dab:	e8 40 e4 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101db0:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101db3:	83 c4 10             	add    $0x10,%esp
80101db6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101db9:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101dbc:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101dbf:	77 97                	ja     80101d58 <writei+0x68>
  }

  if(n > 0 && off > ip->size){
80101dc1:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101dc4:	3b 70 58             	cmp    0x58(%eax),%esi
80101dc7:	77 37                	ja     80101e00 <writei+0x110>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101dc9:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101dcc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dcf:	5b                   	pop    %ebx
80101dd0:	5e                   	pop    %esi
80101dd1:	5f                   	pop    %edi
80101dd2:	5d                   	pop    %ebp
80101dd3:	c3                   	ret    
80101dd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101dd8:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101ddc:	66 83 f8 09          	cmp    $0x9,%ax
80101de0:	77 32                	ja     80101e14 <writei+0x124>
80101de2:	8b 04 c5 04 f9 10 80 	mov    -0x7fef06fc(,%eax,8),%eax
80101de9:	85 c0                	test   %eax,%eax
80101deb:	74 27                	je     80101e14 <writei+0x124>
    return devsw[ip->major].write(ip, src, n);
80101ded:	89 55 10             	mov    %edx,0x10(%ebp)
}
80101df0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101df3:	5b                   	pop    %ebx
80101df4:	5e                   	pop    %esi
80101df5:	5f                   	pop    %edi
80101df6:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101df7:	ff e0                	jmp    *%eax
80101df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101e00:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101e03:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101e06:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101e09:	50                   	push   %eax
80101e0a:	e8 01 fa ff ff       	call   80101810 <iupdate>
80101e0f:	83 c4 10             	add    $0x10,%esp
80101e12:	eb b5                	jmp    80101dc9 <writei+0xd9>
      return -1;
80101e14:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101e19:	eb b1                	jmp    80101dcc <writei+0xdc>
80101e1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101e1f:	90                   	nop

80101e20 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101e20:	f3 0f 1e fb          	endbr32 
80101e24:	55                   	push   %ebp
80101e25:	89 e5                	mov    %esp,%ebp
80101e27:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101e2a:	6a 0e                	push   $0xe
80101e2c:	ff 75 0c             	pushl  0xc(%ebp)
80101e2f:	ff 75 08             	pushl  0x8(%ebp)
80101e32:	e8 b9 2b 00 00       	call   801049f0 <strncmp>
}
80101e37:	c9                   	leave  
80101e38:	c3                   	ret    
80101e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101e40 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101e40:	f3 0f 1e fb          	endbr32 
80101e44:	55                   	push   %ebp
80101e45:	89 e5                	mov    %esp,%ebp
80101e47:	57                   	push   %edi
80101e48:	56                   	push   %esi
80101e49:	53                   	push   %ebx
80101e4a:	83 ec 1c             	sub    $0x1c,%esp
80101e4d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101e50:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101e55:	0f 85 89 00 00 00    	jne    80101ee4 <dirlookup+0xa4>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101e5b:	8b 53 58             	mov    0x58(%ebx),%edx
80101e5e:	31 ff                	xor    %edi,%edi
80101e60:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e63:	85 d2                	test   %edx,%edx
80101e65:	74 42                	je     80101ea9 <dirlookup+0x69>
80101e67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e6e:	66 90                	xchg   %ax,%ax
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e70:	6a 10                	push   $0x10
80101e72:	57                   	push   %edi
80101e73:	56                   	push   %esi
80101e74:	53                   	push   %ebx
80101e75:	e8 76 fd ff ff       	call   80101bf0 <readi>
80101e7a:	83 c4 10             	add    $0x10,%esp
80101e7d:	83 f8 10             	cmp    $0x10,%eax
80101e80:	75 55                	jne    80101ed7 <dirlookup+0x97>
      panic("dirlookup read");
    if(de.inum == 0)
80101e82:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e87:	74 18                	je     80101ea1 <dirlookup+0x61>
  return strncmp(s, t, DIRSIZ);
80101e89:	83 ec 04             	sub    $0x4,%esp
80101e8c:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e8f:	6a 0e                	push   $0xe
80101e91:	50                   	push   %eax
80101e92:	ff 75 0c             	pushl  0xc(%ebp)
80101e95:	e8 56 2b 00 00       	call   801049f0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101e9a:	83 c4 10             	add    $0x10,%esp
80101e9d:	85 c0                	test   %eax,%eax
80101e9f:	74 17                	je     80101eb8 <dirlookup+0x78>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101ea1:	83 c7 10             	add    $0x10,%edi
80101ea4:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101ea7:	72 c7                	jb     80101e70 <dirlookup+0x30>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101ea9:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101eac:	31 c0                	xor    %eax,%eax
}
80101eae:	5b                   	pop    %ebx
80101eaf:	5e                   	pop    %esi
80101eb0:	5f                   	pop    %edi
80101eb1:	5d                   	pop    %ebp
80101eb2:	c3                   	ret    
80101eb3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101eb7:	90                   	nop
      if(poff)
80101eb8:	8b 45 10             	mov    0x10(%ebp),%eax
80101ebb:	85 c0                	test   %eax,%eax
80101ebd:	74 05                	je     80101ec4 <dirlookup+0x84>
        *poff = off;
80101ebf:	8b 45 10             	mov    0x10(%ebp),%eax
80101ec2:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101ec4:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101ec8:	8b 03                	mov    (%ebx),%eax
80101eca:	e8 d1 f5 ff ff       	call   801014a0 <iget>
}
80101ecf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ed2:	5b                   	pop    %ebx
80101ed3:	5e                   	pop    %esi
80101ed4:	5f                   	pop    %edi
80101ed5:	5d                   	pop    %ebp
80101ed6:	c3                   	ret    
      panic("dirlookup read");
80101ed7:	83 ec 0c             	sub    $0xc,%esp
80101eda:	68 b9 76 10 80       	push   $0x801076b9
80101edf:	e8 ac e4 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101ee4:	83 ec 0c             	sub    $0xc,%esp
80101ee7:	68 a7 76 10 80       	push   $0x801076a7
80101eec:	e8 9f e4 ff ff       	call   80100390 <panic>
80101ef1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ef8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101eff:	90                   	nop

80101f00 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101f00:	55                   	push   %ebp
80101f01:	89 e5                	mov    %esp,%ebp
80101f03:	57                   	push   %edi
80101f04:	56                   	push   %esi
80101f05:	53                   	push   %ebx
80101f06:	89 c3                	mov    %eax,%ebx
80101f08:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101f0b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101f0e:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101f11:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80101f14:	0f 84 64 01 00 00    	je     8010207e <namex+0x17e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101f1a:	e8 51 1c 00 00       	call   80103b70 <myproc>
  acquire(&icache.lock);
80101f1f:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101f22:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101f25:	68 60 f9 10 80       	push   $0x8010f960
80101f2a:	e8 e1 28 00 00       	call   80104810 <acquire>
  ip->ref++;
80101f2f:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101f33:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
80101f3a:	e8 61 28 00 00       	call   801047a0 <release>
80101f3f:	83 c4 10             	add    $0x10,%esp
80101f42:	eb 07                	jmp    80101f4b <namex+0x4b>
80101f44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101f48:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101f4b:	0f b6 03             	movzbl (%ebx),%eax
80101f4e:	3c 2f                	cmp    $0x2f,%al
80101f50:	74 f6                	je     80101f48 <namex+0x48>
  if(*path == 0)
80101f52:	84 c0                	test   %al,%al
80101f54:	0f 84 06 01 00 00    	je     80102060 <namex+0x160>
  while(*path != '/' && *path != 0)
80101f5a:	0f b6 03             	movzbl (%ebx),%eax
80101f5d:	84 c0                	test   %al,%al
80101f5f:	0f 84 10 01 00 00    	je     80102075 <namex+0x175>
80101f65:	89 df                	mov    %ebx,%edi
80101f67:	3c 2f                	cmp    $0x2f,%al
80101f69:	0f 84 06 01 00 00    	je     80102075 <namex+0x175>
80101f6f:	90                   	nop
80101f70:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80101f74:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80101f77:	3c 2f                	cmp    $0x2f,%al
80101f79:	74 04                	je     80101f7f <namex+0x7f>
80101f7b:	84 c0                	test   %al,%al
80101f7d:	75 f1                	jne    80101f70 <namex+0x70>
  len = path - s;
80101f7f:	89 f8                	mov    %edi,%eax
80101f81:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80101f83:	83 f8 0d             	cmp    $0xd,%eax
80101f86:	0f 8e ac 00 00 00    	jle    80102038 <namex+0x138>
    memmove(name, s, DIRSIZ);
80101f8c:	83 ec 04             	sub    $0x4,%esp
80101f8f:	6a 0e                	push   $0xe
80101f91:	53                   	push   %ebx
    path++;
80101f92:	89 fb                	mov    %edi,%ebx
    memmove(name, s, DIRSIZ);
80101f94:	ff 75 e4             	pushl  -0x1c(%ebp)
80101f97:	e8 e4 29 00 00       	call   80104980 <memmove>
80101f9c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101f9f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101fa2:	75 0c                	jne    80101fb0 <namex+0xb0>
80101fa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101fa8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101fab:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101fae:	74 f8                	je     80101fa8 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101fb0:	83 ec 0c             	sub    $0xc,%esp
80101fb3:	56                   	push   %esi
80101fb4:	e8 17 f9 ff ff       	call   801018d0 <ilock>
    if(ip->type != T_DIR){
80101fb9:	83 c4 10             	add    $0x10,%esp
80101fbc:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101fc1:	0f 85 cd 00 00 00    	jne    80102094 <namex+0x194>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101fc7:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101fca:	85 c0                	test   %eax,%eax
80101fcc:	74 09                	je     80101fd7 <namex+0xd7>
80101fce:	80 3b 00             	cmpb   $0x0,(%ebx)
80101fd1:	0f 84 22 01 00 00    	je     801020f9 <namex+0x1f9>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101fd7:	83 ec 04             	sub    $0x4,%esp
80101fda:	6a 00                	push   $0x0
80101fdc:	ff 75 e4             	pushl  -0x1c(%ebp)
80101fdf:	56                   	push   %esi
80101fe0:	e8 5b fe ff ff       	call   80101e40 <dirlookup>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101fe5:	8d 56 0c             	lea    0xc(%esi),%edx
    if((next = dirlookup(ip, name, 0)) == 0){
80101fe8:	83 c4 10             	add    $0x10,%esp
80101feb:	89 c7                	mov    %eax,%edi
80101fed:	85 c0                	test   %eax,%eax
80101fef:	0f 84 e1 00 00 00    	je     801020d6 <namex+0x1d6>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101ff5:	83 ec 0c             	sub    $0xc,%esp
80101ff8:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101ffb:	52                   	push   %edx
80101ffc:	e8 af 25 00 00       	call   801045b0 <holdingsleep>
80102001:	83 c4 10             	add    $0x10,%esp
80102004:	85 c0                	test   %eax,%eax
80102006:	0f 84 30 01 00 00    	je     8010213c <namex+0x23c>
8010200c:	8b 56 08             	mov    0x8(%esi),%edx
8010200f:	85 d2                	test   %edx,%edx
80102011:	0f 8e 25 01 00 00    	jle    8010213c <namex+0x23c>
  releasesleep(&ip->lock);
80102017:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010201a:	83 ec 0c             	sub    $0xc,%esp
8010201d:	52                   	push   %edx
8010201e:	e8 4d 25 00 00       	call   80104570 <releasesleep>
  iput(ip);
80102023:	89 34 24             	mov    %esi,(%esp)
80102026:	89 fe                	mov    %edi,%esi
80102028:	e8 d3 f9 ff ff       	call   80101a00 <iput>
8010202d:	83 c4 10             	add    $0x10,%esp
80102030:	e9 16 ff ff ff       	jmp    80101f4b <namex+0x4b>
80102035:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80102038:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010203b:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    memmove(name, s, len);
8010203e:	83 ec 04             	sub    $0x4,%esp
80102041:	89 55 e0             	mov    %edx,-0x20(%ebp)
80102044:	50                   	push   %eax
80102045:	53                   	push   %ebx
    name[len] = 0;
80102046:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80102048:	ff 75 e4             	pushl  -0x1c(%ebp)
8010204b:	e8 30 29 00 00       	call   80104980 <memmove>
    name[len] = 0;
80102050:	8b 55 e0             	mov    -0x20(%ebp),%edx
80102053:	83 c4 10             	add    $0x10,%esp
80102056:	c6 02 00             	movb   $0x0,(%edx)
80102059:	e9 41 ff ff ff       	jmp    80101f9f <namex+0x9f>
8010205e:	66 90                	xchg   %ax,%ax
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80102060:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102063:	85 c0                	test   %eax,%eax
80102065:	0f 85 be 00 00 00    	jne    80102129 <namex+0x229>
    iput(ip);
    return 0;
  }
  return ip;
}
8010206b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010206e:	89 f0                	mov    %esi,%eax
80102070:	5b                   	pop    %ebx
80102071:	5e                   	pop    %esi
80102072:	5f                   	pop    %edi
80102073:	5d                   	pop    %ebp
80102074:	c3                   	ret    
  while(*path != '/' && *path != 0)
80102075:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102078:	89 df                	mov    %ebx,%edi
8010207a:	31 c0                	xor    %eax,%eax
8010207c:	eb c0                	jmp    8010203e <namex+0x13e>
    ip = iget(ROOTDEV, ROOTINO);
8010207e:	ba 01 00 00 00       	mov    $0x1,%edx
80102083:	b8 01 00 00 00       	mov    $0x1,%eax
80102088:	e8 13 f4 ff ff       	call   801014a0 <iget>
8010208d:	89 c6                	mov    %eax,%esi
8010208f:	e9 b7 fe ff ff       	jmp    80101f4b <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102094:	83 ec 0c             	sub    $0xc,%esp
80102097:	8d 5e 0c             	lea    0xc(%esi),%ebx
8010209a:	53                   	push   %ebx
8010209b:	e8 10 25 00 00       	call   801045b0 <holdingsleep>
801020a0:	83 c4 10             	add    $0x10,%esp
801020a3:	85 c0                	test   %eax,%eax
801020a5:	0f 84 91 00 00 00    	je     8010213c <namex+0x23c>
801020ab:	8b 46 08             	mov    0x8(%esi),%eax
801020ae:	85 c0                	test   %eax,%eax
801020b0:	0f 8e 86 00 00 00    	jle    8010213c <namex+0x23c>
  releasesleep(&ip->lock);
801020b6:	83 ec 0c             	sub    $0xc,%esp
801020b9:	53                   	push   %ebx
801020ba:	e8 b1 24 00 00       	call   80104570 <releasesleep>
  iput(ip);
801020bf:	89 34 24             	mov    %esi,(%esp)
      return 0;
801020c2:	31 f6                	xor    %esi,%esi
  iput(ip);
801020c4:	e8 37 f9 ff ff       	call   80101a00 <iput>
      return 0;
801020c9:	83 c4 10             	add    $0x10,%esp
}
801020cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020cf:	89 f0                	mov    %esi,%eax
801020d1:	5b                   	pop    %ebx
801020d2:	5e                   	pop    %esi
801020d3:	5f                   	pop    %edi
801020d4:	5d                   	pop    %ebp
801020d5:	c3                   	ret    
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801020d6:	83 ec 0c             	sub    $0xc,%esp
801020d9:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801020dc:	52                   	push   %edx
801020dd:	e8 ce 24 00 00       	call   801045b0 <holdingsleep>
801020e2:	83 c4 10             	add    $0x10,%esp
801020e5:	85 c0                	test   %eax,%eax
801020e7:	74 53                	je     8010213c <namex+0x23c>
801020e9:	8b 4e 08             	mov    0x8(%esi),%ecx
801020ec:	85 c9                	test   %ecx,%ecx
801020ee:	7e 4c                	jle    8010213c <namex+0x23c>
  releasesleep(&ip->lock);
801020f0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801020f3:	83 ec 0c             	sub    $0xc,%esp
801020f6:	52                   	push   %edx
801020f7:	eb c1                	jmp    801020ba <namex+0x1ba>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801020f9:	83 ec 0c             	sub    $0xc,%esp
801020fc:	8d 5e 0c             	lea    0xc(%esi),%ebx
801020ff:	53                   	push   %ebx
80102100:	e8 ab 24 00 00       	call   801045b0 <holdingsleep>
80102105:	83 c4 10             	add    $0x10,%esp
80102108:	85 c0                	test   %eax,%eax
8010210a:	74 30                	je     8010213c <namex+0x23c>
8010210c:	8b 7e 08             	mov    0x8(%esi),%edi
8010210f:	85 ff                	test   %edi,%edi
80102111:	7e 29                	jle    8010213c <namex+0x23c>
  releasesleep(&ip->lock);
80102113:	83 ec 0c             	sub    $0xc,%esp
80102116:	53                   	push   %ebx
80102117:	e8 54 24 00 00       	call   80104570 <releasesleep>
}
8010211c:	83 c4 10             	add    $0x10,%esp
}
8010211f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102122:	89 f0                	mov    %esi,%eax
80102124:	5b                   	pop    %ebx
80102125:	5e                   	pop    %esi
80102126:	5f                   	pop    %edi
80102127:	5d                   	pop    %ebp
80102128:	c3                   	ret    
    iput(ip);
80102129:	83 ec 0c             	sub    $0xc,%esp
8010212c:	56                   	push   %esi
    return 0;
8010212d:	31 f6                	xor    %esi,%esi
    iput(ip);
8010212f:	e8 cc f8 ff ff       	call   80101a00 <iput>
    return 0;
80102134:	83 c4 10             	add    $0x10,%esp
80102137:	e9 2f ff ff ff       	jmp    8010206b <namex+0x16b>
    panic("iunlock");
8010213c:	83 ec 0c             	sub    $0xc,%esp
8010213f:	68 9f 76 10 80       	push   $0x8010769f
80102144:	e8 47 e2 ff ff       	call   80100390 <panic>
80102149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102150 <dirlink>:
{
80102150:	f3 0f 1e fb          	endbr32 
80102154:	55                   	push   %ebp
80102155:	89 e5                	mov    %esp,%ebp
80102157:	57                   	push   %edi
80102158:	56                   	push   %esi
80102159:	53                   	push   %ebx
8010215a:	83 ec 20             	sub    $0x20,%esp
8010215d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80102160:	6a 00                	push   $0x0
80102162:	ff 75 0c             	pushl  0xc(%ebp)
80102165:	53                   	push   %ebx
80102166:	e8 d5 fc ff ff       	call   80101e40 <dirlookup>
8010216b:	83 c4 10             	add    $0x10,%esp
8010216e:	85 c0                	test   %eax,%eax
80102170:	75 6b                	jne    801021dd <dirlink+0x8d>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102172:	8b 7b 58             	mov    0x58(%ebx),%edi
80102175:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102178:	85 ff                	test   %edi,%edi
8010217a:	74 2d                	je     801021a9 <dirlink+0x59>
8010217c:	31 ff                	xor    %edi,%edi
8010217e:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102181:	eb 0d                	jmp    80102190 <dirlink+0x40>
80102183:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102187:	90                   	nop
80102188:	83 c7 10             	add    $0x10,%edi
8010218b:	3b 7b 58             	cmp    0x58(%ebx),%edi
8010218e:	73 19                	jae    801021a9 <dirlink+0x59>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102190:	6a 10                	push   $0x10
80102192:	57                   	push   %edi
80102193:	56                   	push   %esi
80102194:	53                   	push   %ebx
80102195:	e8 56 fa ff ff       	call   80101bf0 <readi>
8010219a:	83 c4 10             	add    $0x10,%esp
8010219d:	83 f8 10             	cmp    $0x10,%eax
801021a0:	75 4e                	jne    801021f0 <dirlink+0xa0>
    if(de.inum == 0)
801021a2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801021a7:	75 df                	jne    80102188 <dirlink+0x38>
  strncpy(de.name, name, DIRSIZ);
801021a9:	83 ec 04             	sub    $0x4,%esp
801021ac:	8d 45 da             	lea    -0x26(%ebp),%eax
801021af:	6a 0e                	push   $0xe
801021b1:	ff 75 0c             	pushl  0xc(%ebp)
801021b4:	50                   	push   %eax
801021b5:	e8 86 28 00 00       	call   80104a40 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801021ba:	6a 10                	push   $0x10
  de.inum = inum;
801021bc:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801021bf:	57                   	push   %edi
801021c0:	56                   	push   %esi
801021c1:	53                   	push   %ebx
  de.inum = inum;
801021c2:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801021c6:	e8 25 fb ff ff       	call   80101cf0 <writei>
801021cb:	83 c4 20             	add    $0x20,%esp
801021ce:	83 f8 10             	cmp    $0x10,%eax
801021d1:	75 2a                	jne    801021fd <dirlink+0xad>
  return 0;
801021d3:	31 c0                	xor    %eax,%eax
}
801021d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021d8:	5b                   	pop    %ebx
801021d9:	5e                   	pop    %esi
801021da:	5f                   	pop    %edi
801021db:	5d                   	pop    %ebp
801021dc:	c3                   	ret    
    iput(ip);
801021dd:	83 ec 0c             	sub    $0xc,%esp
801021e0:	50                   	push   %eax
801021e1:	e8 1a f8 ff ff       	call   80101a00 <iput>
    return -1;
801021e6:	83 c4 10             	add    $0x10,%esp
801021e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801021ee:	eb e5                	jmp    801021d5 <dirlink+0x85>
      panic("dirlink read");
801021f0:	83 ec 0c             	sub    $0xc,%esp
801021f3:	68 c8 76 10 80       	push   $0x801076c8
801021f8:	e8 93 e1 ff ff       	call   80100390 <panic>
    panic("dirlink");
801021fd:	83 ec 0c             	sub    $0xc,%esp
80102200:	68 a2 7c 10 80       	push   $0x80107ca2
80102205:	e8 86 e1 ff ff       	call   80100390 <panic>
8010220a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102210 <namei>:

struct inode*
namei(char *path)
{
80102210:	f3 0f 1e fb          	endbr32 
80102214:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102215:	31 d2                	xor    %edx,%edx
{
80102217:	89 e5                	mov    %esp,%ebp
80102219:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
8010221c:	8b 45 08             	mov    0x8(%ebp),%eax
8010221f:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80102222:	e8 d9 fc ff ff       	call   80101f00 <namex>
}
80102227:	c9                   	leave  
80102228:	c3                   	ret    
80102229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102230 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102230:	f3 0f 1e fb          	endbr32 
80102234:	55                   	push   %ebp
  return namex(path, 1, name);
80102235:	ba 01 00 00 00       	mov    $0x1,%edx
{
8010223a:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
8010223c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010223f:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102242:	5d                   	pop    %ebp
  return namex(path, 1, name);
80102243:	e9 b8 fc ff ff       	jmp    80101f00 <namex>
80102248:	66 90                	xchg   %ax,%ax
8010224a:	66 90                	xchg   %ax,%ax
8010224c:	66 90                	xchg   %ax,%ax
8010224e:	66 90                	xchg   %ax,%ax

80102250 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102250:	55                   	push   %ebp
80102251:	89 e5                	mov    %esp,%ebp
80102253:	57                   	push   %edi
80102254:	56                   	push   %esi
80102255:	53                   	push   %ebx
80102256:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102259:	85 c0                	test   %eax,%eax
8010225b:	0f 84 b4 00 00 00    	je     80102315 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102261:	8b 70 08             	mov    0x8(%eax),%esi
80102264:	89 c3                	mov    %eax,%ebx
80102266:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
8010226c:	0f 87 96 00 00 00    	ja     80102308 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102272:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102277:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010227e:	66 90                	xchg   %ax,%ax
80102280:	89 ca                	mov    %ecx,%edx
80102282:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102283:	83 e0 c0             	and    $0xffffffc0,%eax
80102286:	3c 40                	cmp    $0x40,%al
80102288:	75 f6                	jne    80102280 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010228a:	31 ff                	xor    %edi,%edi
8010228c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102291:	89 f8                	mov    %edi,%eax
80102293:	ee                   	out    %al,(%dx)
80102294:	b8 01 00 00 00       	mov    $0x1,%eax
80102299:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010229e:	ee                   	out    %al,(%dx)
8010229f:	ba f3 01 00 00       	mov    $0x1f3,%edx
801022a4:	89 f0                	mov    %esi,%eax
801022a6:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
801022a7:	89 f0                	mov    %esi,%eax
801022a9:	ba f4 01 00 00       	mov    $0x1f4,%edx
801022ae:	c1 f8 08             	sar    $0x8,%eax
801022b1:	ee                   	out    %al,(%dx)
801022b2:	ba f5 01 00 00       	mov    $0x1f5,%edx
801022b7:	89 f8                	mov    %edi,%eax
801022b9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
801022ba:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
801022be:	ba f6 01 00 00       	mov    $0x1f6,%edx
801022c3:	c1 e0 04             	shl    $0x4,%eax
801022c6:	83 e0 10             	and    $0x10,%eax
801022c9:	83 c8 e0             	or     $0xffffffe0,%eax
801022cc:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
801022cd:	f6 03 04             	testb  $0x4,(%ebx)
801022d0:	75 16                	jne    801022e8 <idestart+0x98>
801022d2:	b8 20 00 00 00       	mov    $0x20,%eax
801022d7:	89 ca                	mov    %ecx,%edx
801022d9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
801022da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801022dd:	5b                   	pop    %ebx
801022de:	5e                   	pop    %esi
801022df:	5f                   	pop    %edi
801022e0:	5d                   	pop    %ebp
801022e1:	c3                   	ret    
801022e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801022e8:	b8 30 00 00 00       	mov    $0x30,%eax
801022ed:	89 ca                	mov    %ecx,%edx
801022ef:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
801022f0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
801022f5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801022f8:	ba f0 01 00 00       	mov    $0x1f0,%edx
801022fd:	fc                   	cld    
801022fe:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102300:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102303:	5b                   	pop    %ebx
80102304:	5e                   	pop    %esi
80102305:	5f                   	pop    %edi
80102306:	5d                   	pop    %ebp
80102307:	c3                   	ret    
    panic("incorrect blockno");
80102308:	83 ec 0c             	sub    $0xc,%esp
8010230b:	68 34 77 10 80       	push   $0x80107734
80102310:	e8 7b e0 ff ff       	call   80100390 <panic>
    panic("idestart");
80102315:	83 ec 0c             	sub    $0xc,%esp
80102318:	68 2b 77 10 80       	push   $0x8010772b
8010231d:	e8 6e e0 ff ff       	call   80100390 <panic>
80102322:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102330 <ideinit>:
{
80102330:	f3 0f 1e fb          	endbr32 
80102334:	55                   	push   %ebp
80102335:	89 e5                	mov    %esp,%ebp
80102337:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
8010233a:	68 46 77 10 80       	push   $0x80107746
8010233f:	68 00 16 11 80       	push   $0x80111600
80102344:	e8 c7 22 00 00       	call   80104610 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102349:	58                   	pop    %eax
8010234a:	a1 84 17 11 80       	mov    0x80111784,%eax
8010234f:	5a                   	pop    %edx
80102350:	83 e8 01             	sub    $0x1,%eax
80102353:	50                   	push   %eax
80102354:	6a 0e                	push   $0xe
80102356:	e8 b5 02 00 00       	call   80102610 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
8010235b:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010235e:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102363:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102367:	90                   	nop
80102368:	ec                   	in     (%dx),%al
80102369:	83 e0 c0             	and    $0xffffffc0,%eax
8010236c:	3c 40                	cmp    $0x40,%al
8010236e:	75 f8                	jne    80102368 <ideinit+0x38>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102370:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102375:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010237a:	ee                   	out    %al,(%dx)
8010237b:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102380:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102385:	eb 0e                	jmp    80102395 <ideinit+0x65>
80102387:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010238e:	66 90                	xchg   %ax,%ax
  for(i=0; i<1000; i++){
80102390:	83 e9 01             	sub    $0x1,%ecx
80102393:	74 0f                	je     801023a4 <ideinit+0x74>
80102395:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102396:	84 c0                	test   %al,%al
80102398:	74 f6                	je     80102390 <ideinit+0x60>
      havedisk1 = 1;
8010239a:	c7 05 e0 15 11 80 01 	movl   $0x1,0x801115e0
801023a1:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801023a4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801023a9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801023ae:	ee                   	out    %al,(%dx)
}
801023af:	c9                   	leave  
801023b0:	c3                   	ret    
801023b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801023b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801023bf:	90                   	nop

801023c0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801023c0:	f3 0f 1e fb          	endbr32 
801023c4:	55                   	push   %ebp
801023c5:	89 e5                	mov    %esp,%ebp
801023c7:	57                   	push   %edi
801023c8:	56                   	push   %esi
801023c9:	53                   	push   %ebx
801023ca:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801023cd:	68 00 16 11 80       	push   $0x80111600
801023d2:	e8 39 24 00 00       	call   80104810 <acquire>

  if((b = idequeue) == 0){
801023d7:	8b 1d e4 15 11 80    	mov    0x801115e4,%ebx
801023dd:	83 c4 10             	add    $0x10,%esp
801023e0:	85 db                	test   %ebx,%ebx
801023e2:	74 5f                	je     80102443 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801023e4:	8b 43 58             	mov    0x58(%ebx),%eax
801023e7:	a3 e4 15 11 80       	mov    %eax,0x801115e4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801023ec:	8b 33                	mov    (%ebx),%esi
801023ee:	f7 c6 04 00 00 00    	test   $0x4,%esi
801023f4:	75 2b                	jne    80102421 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801023f6:	ba f7 01 00 00       	mov    $0x1f7,%edx
801023fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801023ff:	90                   	nop
80102400:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102401:	89 c1                	mov    %eax,%ecx
80102403:	83 e1 c0             	and    $0xffffffc0,%ecx
80102406:	80 f9 40             	cmp    $0x40,%cl
80102409:	75 f5                	jne    80102400 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010240b:	a8 21                	test   $0x21,%al
8010240d:	75 12                	jne    80102421 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010240f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102412:	b9 80 00 00 00       	mov    $0x80,%ecx
80102417:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010241c:	fc                   	cld    
8010241d:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
8010241f:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
80102421:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102424:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102427:	83 ce 02             	or     $0x2,%esi
8010242a:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010242c:	53                   	push   %ebx
8010242d:	e8 de 1e 00 00       	call   80104310 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102432:	a1 e4 15 11 80       	mov    0x801115e4,%eax
80102437:	83 c4 10             	add    $0x10,%esp
8010243a:	85 c0                	test   %eax,%eax
8010243c:	74 05                	je     80102443 <ideintr+0x83>
    idestart(idequeue);
8010243e:	e8 0d fe ff ff       	call   80102250 <idestart>
    release(&idelock);
80102443:	83 ec 0c             	sub    $0xc,%esp
80102446:	68 00 16 11 80       	push   $0x80111600
8010244b:	e8 50 23 00 00       	call   801047a0 <release>

  release(&idelock);
}
80102450:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102453:	5b                   	pop    %ebx
80102454:	5e                   	pop    %esi
80102455:	5f                   	pop    %edi
80102456:	5d                   	pop    %ebp
80102457:	c3                   	ret    
80102458:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010245f:	90                   	nop

80102460 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102460:	f3 0f 1e fb          	endbr32 
80102464:	55                   	push   %ebp
80102465:	89 e5                	mov    %esp,%ebp
80102467:	53                   	push   %ebx
80102468:	83 ec 10             	sub    $0x10,%esp
8010246b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010246e:	8d 43 0c             	lea    0xc(%ebx),%eax
80102471:	50                   	push   %eax
80102472:	e8 39 21 00 00       	call   801045b0 <holdingsleep>
80102477:	83 c4 10             	add    $0x10,%esp
8010247a:	85 c0                	test   %eax,%eax
8010247c:	0f 84 cf 00 00 00    	je     80102551 <iderw+0xf1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102482:	8b 03                	mov    (%ebx),%eax
80102484:	83 e0 06             	and    $0x6,%eax
80102487:	83 f8 02             	cmp    $0x2,%eax
8010248a:	0f 84 b4 00 00 00    	je     80102544 <iderw+0xe4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
80102490:	8b 53 04             	mov    0x4(%ebx),%edx
80102493:	85 d2                	test   %edx,%edx
80102495:	74 0d                	je     801024a4 <iderw+0x44>
80102497:	a1 e0 15 11 80       	mov    0x801115e0,%eax
8010249c:	85 c0                	test   %eax,%eax
8010249e:	0f 84 93 00 00 00    	je     80102537 <iderw+0xd7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801024a4:	83 ec 0c             	sub    $0xc,%esp
801024a7:	68 00 16 11 80       	push   $0x80111600
801024ac:	e8 5f 23 00 00       	call   80104810 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801024b1:	a1 e4 15 11 80       	mov    0x801115e4,%eax
  b->qnext = 0;
801024b6:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801024bd:	83 c4 10             	add    $0x10,%esp
801024c0:	85 c0                	test   %eax,%eax
801024c2:	74 6c                	je     80102530 <iderw+0xd0>
801024c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024c8:	89 c2                	mov    %eax,%edx
801024ca:	8b 40 58             	mov    0x58(%eax),%eax
801024cd:	85 c0                	test   %eax,%eax
801024cf:	75 f7                	jne    801024c8 <iderw+0x68>
801024d1:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801024d4:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801024d6:	39 1d e4 15 11 80    	cmp    %ebx,0x801115e4
801024dc:	74 42                	je     80102520 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801024de:	8b 03                	mov    (%ebx),%eax
801024e0:	83 e0 06             	and    $0x6,%eax
801024e3:	83 f8 02             	cmp    $0x2,%eax
801024e6:	74 23                	je     8010250b <iderw+0xab>
801024e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801024ef:	90                   	nop
    sleep(b, &idelock);
801024f0:	83 ec 08             	sub    $0x8,%esp
801024f3:	68 00 16 11 80       	push   $0x80111600
801024f8:	53                   	push   %ebx
801024f9:	e8 52 1d 00 00       	call   80104250 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801024fe:	8b 03                	mov    (%ebx),%eax
80102500:	83 c4 10             	add    $0x10,%esp
80102503:	83 e0 06             	and    $0x6,%eax
80102506:	83 f8 02             	cmp    $0x2,%eax
80102509:	75 e5                	jne    801024f0 <iderw+0x90>
  }


  release(&idelock);
8010250b:	c7 45 08 00 16 11 80 	movl   $0x80111600,0x8(%ebp)
}
80102512:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102515:	c9                   	leave  
  release(&idelock);
80102516:	e9 85 22 00 00       	jmp    801047a0 <release>
8010251b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010251f:	90                   	nop
    idestart(b);
80102520:	89 d8                	mov    %ebx,%eax
80102522:	e8 29 fd ff ff       	call   80102250 <idestart>
80102527:	eb b5                	jmp    801024de <iderw+0x7e>
80102529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102530:	ba e4 15 11 80       	mov    $0x801115e4,%edx
80102535:	eb 9d                	jmp    801024d4 <iderw+0x74>
    panic("iderw: ide disk 1 not present");
80102537:	83 ec 0c             	sub    $0xc,%esp
8010253a:	68 75 77 10 80       	push   $0x80107775
8010253f:	e8 4c de ff ff       	call   80100390 <panic>
    panic("iderw: nothing to do");
80102544:	83 ec 0c             	sub    $0xc,%esp
80102547:	68 60 77 10 80       	push   $0x80107760
8010254c:	e8 3f de ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102551:	83 ec 0c             	sub    $0xc,%esp
80102554:	68 4a 77 10 80       	push   $0x8010774a
80102559:	e8 32 de ff ff       	call   80100390 <panic>
8010255e:	66 90                	xchg   %ax,%ax

80102560 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102560:	f3 0f 1e fb          	endbr32 
80102564:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102565:	c7 05 34 16 11 80 00 	movl   $0xfec00000,0x80111634
8010256c:	00 c0 fe 
{
8010256f:	89 e5                	mov    %esp,%ebp
80102571:	56                   	push   %esi
80102572:	53                   	push   %ebx
  ioapic->reg = reg;
80102573:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
8010257a:	00 00 00 
  return ioapic->data;
8010257d:	8b 15 34 16 11 80    	mov    0x80111634,%edx
80102583:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102586:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
8010258c:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102592:	0f b6 15 80 17 11 80 	movzbl 0x80111780,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102599:	c1 ee 10             	shr    $0x10,%esi
8010259c:	89 f0                	mov    %esi,%eax
8010259e:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
801025a1:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
801025a4:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
801025a7:	39 c2                	cmp    %eax,%edx
801025a9:	74 16                	je     801025c1 <ioapicinit+0x61>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801025ab:	83 ec 0c             	sub    $0xc,%esp
801025ae:	68 94 77 10 80       	push   $0x80107794
801025b3:	e8 d8 e0 ff ff       	call   80100690 <cprintf>
  ioapic->reg = reg;
801025b8:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
801025be:	83 c4 10             	add    $0x10,%esp
801025c1:	83 c6 21             	add    $0x21,%esi
{
801025c4:	ba 10 00 00 00       	mov    $0x10,%edx
801025c9:	b8 20 00 00 00       	mov    $0x20,%eax
801025ce:	66 90                	xchg   %ax,%ax
  ioapic->reg = reg;
801025d0:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801025d2:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
801025d4:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
  for(i = 0; i <= maxintr; i++){
801025da:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801025dd:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
801025e3:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
801025e6:	8d 5a 01             	lea    0x1(%edx),%ebx
  for(i = 0; i <= maxintr; i++){
801025e9:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
801025ec:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
801025ee:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
801025f4:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
801025fb:	39 f0                	cmp    %esi,%eax
801025fd:	75 d1                	jne    801025d0 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801025ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102602:	5b                   	pop    %ebx
80102603:	5e                   	pop    %esi
80102604:	5d                   	pop    %ebp
80102605:	c3                   	ret    
80102606:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010260d:	8d 76 00             	lea    0x0(%esi),%esi

80102610 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102610:	f3 0f 1e fb          	endbr32 
80102614:	55                   	push   %ebp
  ioapic->reg = reg;
80102615:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
{
8010261b:	89 e5                	mov    %esp,%ebp
8010261d:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102620:	8d 50 20             	lea    0x20(%eax),%edx
80102623:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102627:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102629:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010262f:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102632:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102635:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102638:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
8010263a:	a1 34 16 11 80       	mov    0x80111634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010263f:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
80102642:	89 50 10             	mov    %edx,0x10(%eax)
}
80102645:	5d                   	pop    %ebp
80102646:	c3                   	ret    
80102647:	66 90                	xchg   %ax,%ax
80102649:	66 90                	xchg   %ax,%ax
8010264b:	66 90                	xchg   %ax,%ax
8010264d:	66 90                	xchg   %ax,%ax
8010264f:	90                   	nop

80102650 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102650:	f3 0f 1e fb          	endbr32 
80102654:	55                   	push   %ebp
80102655:	89 e5                	mov    %esp,%ebp
80102657:	53                   	push   %ebx
80102658:	83 ec 04             	sub    $0x4,%esp
8010265b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010265e:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102664:	75 7a                	jne    801026e0 <kfree+0x90>
80102666:	81 fb 30 55 11 80    	cmp    $0x80115530,%ebx
8010266c:	72 72                	jb     801026e0 <kfree+0x90>
8010266e:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102674:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102679:	77 65                	ja     801026e0 <kfree+0x90>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
8010267b:	83 ec 04             	sub    $0x4,%esp
8010267e:	68 00 10 00 00       	push   $0x1000
80102683:	6a 01                	push   $0x1
80102685:	53                   	push   %ebx
80102686:	e8 55 22 00 00       	call   801048e0 <memset>

  if(kmem.use_lock)
8010268b:	8b 15 74 16 11 80    	mov    0x80111674,%edx
80102691:	83 c4 10             	add    $0x10,%esp
80102694:	85 d2                	test   %edx,%edx
80102696:	75 20                	jne    801026b8 <kfree+0x68>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102698:	a1 78 16 11 80       	mov    0x80111678,%eax
8010269d:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010269f:	a1 74 16 11 80       	mov    0x80111674,%eax
  kmem.freelist = r;
801026a4:	89 1d 78 16 11 80    	mov    %ebx,0x80111678
  if(kmem.use_lock)
801026aa:	85 c0                	test   %eax,%eax
801026ac:	75 22                	jne    801026d0 <kfree+0x80>
    release(&kmem.lock);
}
801026ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801026b1:	c9                   	leave  
801026b2:	c3                   	ret    
801026b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801026b7:	90                   	nop
    acquire(&kmem.lock);
801026b8:	83 ec 0c             	sub    $0xc,%esp
801026bb:	68 40 16 11 80       	push   $0x80111640
801026c0:	e8 4b 21 00 00       	call   80104810 <acquire>
801026c5:	83 c4 10             	add    $0x10,%esp
801026c8:	eb ce                	jmp    80102698 <kfree+0x48>
801026ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
801026d0:	c7 45 08 40 16 11 80 	movl   $0x80111640,0x8(%ebp)
}
801026d7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801026da:	c9                   	leave  
    release(&kmem.lock);
801026db:	e9 c0 20 00 00       	jmp    801047a0 <release>
    panic("kfree");
801026e0:	83 ec 0c             	sub    $0xc,%esp
801026e3:	68 c6 77 10 80       	push   $0x801077c6
801026e8:	e8 a3 dc ff ff       	call   80100390 <panic>
801026ed:	8d 76 00             	lea    0x0(%esi),%esi

801026f0 <freerange>:
{
801026f0:	f3 0f 1e fb          	endbr32 
801026f4:	55                   	push   %ebp
801026f5:	89 e5                	mov    %esp,%ebp
801026f7:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
801026f8:	8b 45 08             	mov    0x8(%ebp),%eax
{
801026fb:	8b 75 0c             	mov    0xc(%ebp),%esi
801026fe:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801026ff:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102705:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010270b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102711:	39 de                	cmp    %ebx,%esi
80102713:	72 1f                	jb     80102734 <freerange+0x44>
80102715:	8d 76 00             	lea    0x0(%esi),%esi
    kfree(p);
80102718:	83 ec 0c             	sub    $0xc,%esp
8010271b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102721:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102727:	50                   	push   %eax
80102728:	e8 23 ff ff ff       	call   80102650 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010272d:	83 c4 10             	add    $0x10,%esp
80102730:	39 f3                	cmp    %esi,%ebx
80102732:	76 e4                	jbe    80102718 <freerange+0x28>
}
80102734:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102737:	5b                   	pop    %ebx
80102738:	5e                   	pop    %esi
80102739:	5d                   	pop    %ebp
8010273a:	c3                   	ret    
8010273b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010273f:	90                   	nop

80102740 <kinit2>:
{
80102740:	f3 0f 1e fb          	endbr32 
80102744:	55                   	push   %ebp
80102745:	89 e5                	mov    %esp,%ebp
80102747:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102748:	8b 45 08             	mov    0x8(%ebp),%eax
{
8010274b:	8b 75 0c             	mov    0xc(%ebp),%esi
8010274e:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
8010274f:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102755:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010275b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102761:	39 de                	cmp    %ebx,%esi
80102763:	72 1f                	jb     80102784 <kinit2+0x44>
80102765:	8d 76 00             	lea    0x0(%esi),%esi
    kfree(p);
80102768:	83 ec 0c             	sub    $0xc,%esp
8010276b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102771:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102777:	50                   	push   %eax
80102778:	e8 d3 fe ff ff       	call   80102650 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010277d:	83 c4 10             	add    $0x10,%esp
80102780:	39 de                	cmp    %ebx,%esi
80102782:	73 e4                	jae    80102768 <kinit2+0x28>
  kmem.use_lock = 1;
80102784:	c7 05 74 16 11 80 01 	movl   $0x1,0x80111674
8010278b:	00 00 00 
}
8010278e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102791:	5b                   	pop    %ebx
80102792:	5e                   	pop    %esi
80102793:	5d                   	pop    %ebp
80102794:	c3                   	ret    
80102795:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010279c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801027a0 <kinit1>:
{
801027a0:	f3 0f 1e fb          	endbr32 
801027a4:	55                   	push   %ebp
801027a5:	89 e5                	mov    %esp,%ebp
801027a7:	56                   	push   %esi
801027a8:	53                   	push   %ebx
801027a9:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801027ac:	83 ec 08             	sub    $0x8,%esp
801027af:	68 cc 77 10 80       	push   $0x801077cc
801027b4:	68 40 16 11 80       	push   $0x80111640
801027b9:	e8 52 1e 00 00       	call   80104610 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
801027be:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027c1:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
801027c4:	c7 05 74 16 11 80 00 	movl   $0x0,0x80111674
801027cb:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
801027ce:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801027d4:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027da:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801027e0:	39 de                	cmp    %ebx,%esi
801027e2:	72 20                	jb     80102804 <kinit1+0x64>
801027e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801027e8:	83 ec 0c             	sub    $0xc,%esp
801027eb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027f1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801027f7:	50                   	push   %eax
801027f8:	e8 53 fe ff ff       	call   80102650 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027fd:	83 c4 10             	add    $0x10,%esp
80102800:	39 de                	cmp    %ebx,%esi
80102802:	73 e4                	jae    801027e8 <kinit1+0x48>
}
80102804:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102807:	5b                   	pop    %ebx
80102808:	5e                   	pop    %esi
80102809:	5d                   	pop    %ebp
8010280a:	c3                   	ret    
8010280b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010280f:	90                   	nop

80102810 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102810:	f3 0f 1e fb          	endbr32 
  struct run *r;

  if(kmem.use_lock)
80102814:	a1 74 16 11 80       	mov    0x80111674,%eax
80102819:	85 c0                	test   %eax,%eax
8010281b:	75 1b                	jne    80102838 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
8010281d:	a1 78 16 11 80       	mov    0x80111678,%eax
  if(r)
80102822:	85 c0                	test   %eax,%eax
80102824:	74 0a                	je     80102830 <kalloc+0x20>
    kmem.freelist = r->next;
80102826:	8b 10                	mov    (%eax),%edx
80102828:	89 15 78 16 11 80    	mov    %edx,0x80111678
  if(kmem.use_lock)
8010282e:	c3                   	ret    
8010282f:	90                   	nop
    release(&kmem.lock);
  return (char*)r;
}
80102830:	c3                   	ret    
80102831:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
80102838:	55                   	push   %ebp
80102839:	89 e5                	mov    %esp,%ebp
8010283b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
8010283e:	68 40 16 11 80       	push   $0x80111640
80102843:	e8 c8 1f 00 00       	call   80104810 <acquire>
  r = kmem.freelist;
80102848:	a1 78 16 11 80       	mov    0x80111678,%eax
  if(kmem.use_lock)
8010284d:	8b 15 74 16 11 80    	mov    0x80111674,%edx
  if(r)
80102853:	83 c4 10             	add    $0x10,%esp
80102856:	85 c0                	test   %eax,%eax
80102858:	74 08                	je     80102862 <kalloc+0x52>
    kmem.freelist = r->next;
8010285a:	8b 08                	mov    (%eax),%ecx
8010285c:	89 0d 78 16 11 80    	mov    %ecx,0x80111678
  if(kmem.use_lock)
80102862:	85 d2                	test   %edx,%edx
80102864:	74 16                	je     8010287c <kalloc+0x6c>
    release(&kmem.lock);
80102866:	83 ec 0c             	sub    $0xc,%esp
80102869:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010286c:	68 40 16 11 80       	push   $0x80111640
80102871:	e8 2a 1f 00 00       	call   801047a0 <release>
  return (char*)r;
80102876:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102879:	83 c4 10             	add    $0x10,%esp
}
8010287c:	c9                   	leave  
8010287d:	c3                   	ret    
8010287e:	66 90                	xchg   %ax,%ax

80102880 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102880:	f3 0f 1e fb          	endbr32 
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102884:	ba 64 00 00 00       	mov    $0x64,%edx
80102889:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
8010288a:	a8 01                	test   $0x1,%al
8010288c:	0f 84 c6 00 00 00    	je     80102958 <kbdgetc+0xd8>
{
80102892:	55                   	push   %ebp
80102893:	ba 60 00 00 00       	mov    $0x60,%edx
80102898:	89 e5                	mov    %esp,%ebp
8010289a:	53                   	push   %ebx
8010289b:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
8010289c:	8b 1d 7c 16 11 80    	mov    0x8011167c,%ebx
  data = inb(KBDATAP);
801028a2:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
801028a5:	3c e0                	cmp    $0xe0,%al
801028a7:	74 57                	je     80102900 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801028a9:	89 da                	mov    %ebx,%edx
801028ab:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
801028ae:	84 c0                	test   %al,%al
801028b0:	78 5e                	js     80102910 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
801028b2:	85 d2                	test   %edx,%edx
801028b4:	74 09                	je     801028bf <kbdgetc+0x3f>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801028b6:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
801028b9:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
801028bc:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
801028bf:	0f b6 91 00 79 10 80 	movzbl -0x7fef8700(%ecx),%edx
  shift ^= togglecode[data];
801028c6:	0f b6 81 00 78 10 80 	movzbl -0x7fef8800(%ecx),%eax
  shift |= shiftcode[data];
801028cd:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
801028cf:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
801028d1:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
801028d3:	89 15 7c 16 11 80    	mov    %edx,0x8011167c
  c = charcode[shift & (CTL | SHIFT)][data];
801028d9:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
801028dc:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
801028df:	8b 04 85 e0 77 10 80 	mov    -0x7fef8820(,%eax,4),%eax
801028e6:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
801028ea:	74 0b                	je     801028f7 <kbdgetc+0x77>
    if('a' <= c && c <= 'z')
801028ec:	8d 50 9f             	lea    -0x61(%eax),%edx
801028ef:	83 fa 19             	cmp    $0x19,%edx
801028f2:	77 4c                	ja     80102940 <kbdgetc+0xc0>
      c += 'A' - 'a';
801028f4:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801028f7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801028fa:	c9                   	leave  
801028fb:	c3                   	ret    
801028fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
80102900:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102903:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102905:	89 1d 7c 16 11 80    	mov    %ebx,0x8011167c
}
8010290b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010290e:	c9                   	leave  
8010290f:	c3                   	ret    
    data = (shift & E0ESC ? data : data & 0x7F);
80102910:	83 e0 7f             	and    $0x7f,%eax
80102913:	85 d2                	test   %edx,%edx
80102915:	0f 44 c8             	cmove  %eax,%ecx
    return 0;
80102918:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
8010291a:	0f b6 91 00 79 10 80 	movzbl -0x7fef8700(%ecx),%edx
80102921:	83 ca 40             	or     $0x40,%edx
80102924:	0f b6 d2             	movzbl %dl,%edx
80102927:	f7 d2                	not    %edx
80102929:	21 da                	and    %ebx,%edx
}
8010292b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    shift &= ~(shiftcode[data] | E0ESC);
8010292e:	89 15 7c 16 11 80    	mov    %edx,0x8011167c
}
80102934:	c9                   	leave  
80102935:	c3                   	ret    
80102936:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010293d:	8d 76 00             	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
80102940:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102943:	8d 50 20             	lea    0x20(%eax),%edx
}
80102946:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102949:	c9                   	leave  
      c += 'a' - 'A';
8010294a:	83 f9 1a             	cmp    $0x1a,%ecx
8010294d:	0f 42 c2             	cmovb  %edx,%eax
}
80102950:	c3                   	ret    
80102951:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80102958:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010295d:	c3                   	ret    
8010295e:	66 90                	xchg   %ax,%ax

80102960 <kbdintr>:

void
kbdintr(void)
{
80102960:	f3 0f 1e fb          	endbr32 
80102964:	55                   	push   %ebp
80102965:	89 e5                	mov    %esp,%ebp
80102967:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
8010296a:	68 80 28 10 80       	push   $0x80102880
8010296f:	e8 8c df ff ff       	call   80100900 <consoleintr>
}
80102974:	83 c4 10             	add    $0x10,%esp
80102977:	c9                   	leave  
80102978:	c3                   	ret    
80102979:	66 90                	xchg   %ax,%ax
8010297b:	66 90                	xchg   %ax,%ax
8010297d:	66 90                	xchg   %ax,%ax
8010297f:	90                   	nop

80102980 <lapicinit>:
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
80102980:	f3 0f 1e fb          	endbr32 
  if(!lapic)
80102984:	a1 80 16 11 80       	mov    0x80111680,%eax
80102989:	85 c0                	test   %eax,%eax
8010298b:	0f 84 c7 00 00 00    	je     80102a58 <lapicinit+0xd8>
  lapic[index] = value;
80102991:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102998:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010299b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010299e:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801029a5:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029a8:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029ab:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801029b2:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801029b5:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029b8:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801029bf:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801029c2:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029c5:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801029cc:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801029cf:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029d2:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801029d9:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801029dc:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801029df:	8b 50 30             	mov    0x30(%eax),%edx
801029e2:	c1 ea 10             	shr    $0x10,%edx
801029e5:	81 e2 fc 00 00 00    	and    $0xfc,%edx
801029eb:	75 73                	jne    80102a60 <lapicinit+0xe0>
  lapic[index] = value;
801029ed:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801029f4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029f7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029fa:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102a01:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a04:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a07:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102a0e:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a11:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a14:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102a1b:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a1e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a21:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102a28:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a2b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a2e:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102a35:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102a38:	8b 50 20             	mov    0x20(%eax),%edx
80102a3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a3f:	90                   	nop
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102a40:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102a46:	80 e6 10             	and    $0x10,%dh
80102a49:	75 f5                	jne    80102a40 <lapicinit+0xc0>
  lapic[index] = value;
80102a4b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102a52:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a55:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102a58:	c3                   	ret    
80102a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80102a60:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102a67:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102a6a:	8b 50 20             	mov    0x20(%eax),%edx
}
80102a6d:	e9 7b ff ff ff       	jmp    801029ed <lapicinit+0x6d>
80102a72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102a80 <lapicid>:

int
lapicid(void)
{
80102a80:	f3 0f 1e fb          	endbr32 
  if (!lapic)
80102a84:	a1 80 16 11 80       	mov    0x80111680,%eax
80102a89:	85 c0                	test   %eax,%eax
80102a8b:	74 0b                	je     80102a98 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
80102a8d:	8b 40 20             	mov    0x20(%eax),%eax
80102a90:	c1 e8 18             	shr    $0x18,%eax
80102a93:	c3                   	ret    
80102a94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80102a98:	31 c0                	xor    %eax,%eax
}
80102a9a:	c3                   	ret    
80102a9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a9f:	90                   	nop

80102aa0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102aa0:	f3 0f 1e fb          	endbr32 
  if(lapic)
80102aa4:	a1 80 16 11 80       	mov    0x80111680,%eax
80102aa9:	85 c0                	test   %eax,%eax
80102aab:	74 0d                	je     80102aba <lapiceoi+0x1a>
  lapic[index] = value;
80102aad:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102ab4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ab7:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102aba:	c3                   	ret    
80102abb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102abf:	90                   	nop

80102ac0 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102ac0:	f3 0f 1e fb          	endbr32 
}
80102ac4:	c3                   	ret    
80102ac5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102ad0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102ad0:	f3 0f 1e fb          	endbr32 
80102ad4:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ad5:	b8 0f 00 00 00       	mov    $0xf,%eax
80102ada:	ba 70 00 00 00       	mov    $0x70,%edx
80102adf:	89 e5                	mov    %esp,%ebp
80102ae1:	53                   	push   %ebx
80102ae2:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102ae5:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102ae8:	ee                   	out    %al,(%dx)
80102ae9:	b8 0a 00 00 00       	mov    $0xa,%eax
80102aee:	ba 71 00 00 00       	mov    $0x71,%edx
80102af3:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102af4:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102af6:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102af9:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102aff:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102b01:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
80102b04:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102b06:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102b09:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102b0c:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102b12:	a1 80 16 11 80       	mov    0x80111680,%eax
80102b17:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b1d:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b20:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102b27:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b2a:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b2d:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102b34:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b37:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b3a:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b40:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b43:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b49:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b4c:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b52:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102b55:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b5b:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
80102b5e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b61:	c9                   	leave  
80102b62:	c3                   	ret    
80102b63:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102b70 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102b70:	f3 0f 1e fb          	endbr32 
80102b74:	55                   	push   %ebp
80102b75:	b8 0b 00 00 00       	mov    $0xb,%eax
80102b7a:	ba 70 00 00 00       	mov    $0x70,%edx
80102b7f:	89 e5                	mov    %esp,%ebp
80102b81:	57                   	push   %edi
80102b82:	56                   	push   %esi
80102b83:	53                   	push   %ebx
80102b84:	83 ec 4c             	sub    $0x4c,%esp
80102b87:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b88:	ba 71 00 00 00       	mov    $0x71,%edx
80102b8d:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102b8e:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b91:	bb 70 00 00 00       	mov    $0x70,%ebx
80102b96:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ba0:	31 c0                	xor    %eax,%eax
80102ba2:	89 da                	mov    %ebx,%edx
80102ba4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ba5:	b9 71 00 00 00       	mov    $0x71,%ecx
80102baa:	89 ca                	mov    %ecx,%edx
80102bac:	ec                   	in     (%dx),%al
80102bad:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bb0:	89 da                	mov    %ebx,%edx
80102bb2:	b8 02 00 00 00       	mov    $0x2,%eax
80102bb7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bb8:	89 ca                	mov    %ecx,%edx
80102bba:	ec                   	in     (%dx),%al
80102bbb:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bbe:	89 da                	mov    %ebx,%edx
80102bc0:	b8 04 00 00 00       	mov    $0x4,%eax
80102bc5:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bc6:	89 ca                	mov    %ecx,%edx
80102bc8:	ec                   	in     (%dx),%al
80102bc9:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bcc:	89 da                	mov    %ebx,%edx
80102bce:	b8 07 00 00 00       	mov    $0x7,%eax
80102bd3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bd4:	89 ca                	mov    %ecx,%edx
80102bd6:	ec                   	in     (%dx),%al
80102bd7:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bda:	89 da                	mov    %ebx,%edx
80102bdc:	b8 08 00 00 00       	mov    $0x8,%eax
80102be1:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102be2:	89 ca                	mov    %ecx,%edx
80102be4:	ec                   	in     (%dx),%al
80102be5:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102be7:	89 da                	mov    %ebx,%edx
80102be9:	b8 09 00 00 00       	mov    $0x9,%eax
80102bee:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bef:	89 ca                	mov    %ecx,%edx
80102bf1:	ec                   	in     (%dx),%al
80102bf2:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bf4:	89 da                	mov    %ebx,%edx
80102bf6:	b8 0a 00 00 00       	mov    $0xa,%eax
80102bfb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bfc:	89 ca                	mov    %ecx,%edx
80102bfe:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102bff:	84 c0                	test   %al,%al
80102c01:	78 9d                	js     80102ba0 <cmostime+0x30>
  return inb(CMOS_RETURN);
80102c03:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102c07:	89 fa                	mov    %edi,%edx
80102c09:	0f b6 fa             	movzbl %dl,%edi
80102c0c:	89 f2                	mov    %esi,%edx
80102c0e:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102c11:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102c15:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c18:	89 da                	mov    %ebx,%edx
80102c1a:	89 7d c8             	mov    %edi,-0x38(%ebp)
80102c1d:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102c20:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102c24:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102c27:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102c2a:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102c2e:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102c31:	31 c0                	xor    %eax,%eax
80102c33:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c34:	89 ca                	mov    %ecx,%edx
80102c36:	ec                   	in     (%dx),%al
80102c37:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c3a:	89 da                	mov    %ebx,%edx
80102c3c:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102c3f:	b8 02 00 00 00       	mov    $0x2,%eax
80102c44:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c45:	89 ca                	mov    %ecx,%edx
80102c47:	ec                   	in     (%dx),%al
80102c48:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c4b:	89 da                	mov    %ebx,%edx
80102c4d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102c50:	b8 04 00 00 00       	mov    $0x4,%eax
80102c55:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c56:	89 ca                	mov    %ecx,%edx
80102c58:	ec                   	in     (%dx),%al
80102c59:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c5c:	89 da                	mov    %ebx,%edx
80102c5e:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102c61:	b8 07 00 00 00       	mov    $0x7,%eax
80102c66:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c67:	89 ca                	mov    %ecx,%edx
80102c69:	ec                   	in     (%dx),%al
80102c6a:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c6d:	89 da                	mov    %ebx,%edx
80102c6f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102c72:	b8 08 00 00 00       	mov    $0x8,%eax
80102c77:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c78:	89 ca                	mov    %ecx,%edx
80102c7a:	ec                   	in     (%dx),%al
80102c7b:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c7e:	89 da                	mov    %ebx,%edx
80102c80:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102c83:	b8 09 00 00 00       	mov    $0x9,%eax
80102c88:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c89:	89 ca                	mov    %ecx,%edx
80102c8b:	ec                   	in     (%dx),%al
80102c8c:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102c8f:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102c92:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102c95:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102c98:	6a 18                	push   $0x18
80102c9a:	50                   	push   %eax
80102c9b:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102c9e:	50                   	push   %eax
80102c9f:	e8 8c 1c 00 00       	call   80104930 <memcmp>
80102ca4:	83 c4 10             	add    $0x10,%esp
80102ca7:	85 c0                	test   %eax,%eax
80102ca9:	0f 85 f1 fe ff ff    	jne    80102ba0 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
80102caf:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102cb3:	75 78                	jne    80102d2d <cmostime+0x1bd>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102cb5:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102cb8:	89 c2                	mov    %eax,%edx
80102cba:	83 e0 0f             	and    $0xf,%eax
80102cbd:	c1 ea 04             	shr    $0x4,%edx
80102cc0:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102cc3:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102cc6:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102cc9:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102ccc:	89 c2                	mov    %eax,%edx
80102cce:	83 e0 0f             	and    $0xf,%eax
80102cd1:	c1 ea 04             	shr    $0x4,%edx
80102cd4:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102cd7:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102cda:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102cdd:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102ce0:	89 c2                	mov    %eax,%edx
80102ce2:	83 e0 0f             	and    $0xf,%eax
80102ce5:	c1 ea 04             	shr    $0x4,%edx
80102ce8:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ceb:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102cee:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102cf1:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102cf4:	89 c2                	mov    %eax,%edx
80102cf6:	83 e0 0f             	and    $0xf,%eax
80102cf9:	c1 ea 04             	shr    $0x4,%edx
80102cfc:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102cff:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d02:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102d05:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102d08:	89 c2                	mov    %eax,%edx
80102d0a:	83 e0 0f             	and    $0xf,%eax
80102d0d:	c1 ea 04             	shr    $0x4,%edx
80102d10:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d13:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d16:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102d19:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102d1c:	89 c2                	mov    %eax,%edx
80102d1e:	83 e0 0f             	and    $0xf,%eax
80102d21:	c1 ea 04             	shr    $0x4,%edx
80102d24:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d27:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d2a:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102d2d:	8b 75 08             	mov    0x8(%ebp),%esi
80102d30:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102d33:	89 06                	mov    %eax,(%esi)
80102d35:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102d38:	89 46 04             	mov    %eax,0x4(%esi)
80102d3b:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102d3e:	89 46 08             	mov    %eax,0x8(%esi)
80102d41:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102d44:	89 46 0c             	mov    %eax,0xc(%esi)
80102d47:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102d4a:	89 46 10             	mov    %eax,0x10(%esi)
80102d4d:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102d50:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102d53:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102d5a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d5d:	5b                   	pop    %ebx
80102d5e:	5e                   	pop    %esi
80102d5f:	5f                   	pop    %edi
80102d60:	5d                   	pop    %ebp
80102d61:	c3                   	ret    
80102d62:	66 90                	xchg   %ax,%ax
80102d64:	66 90                	xchg   %ax,%ax
80102d66:	66 90                	xchg   %ax,%ax
80102d68:	66 90                	xchg   %ax,%ax
80102d6a:	66 90                	xchg   %ax,%ax
80102d6c:	66 90                	xchg   %ax,%ax
80102d6e:	66 90                	xchg   %ax,%ax

80102d70 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102d70:	8b 0d e8 16 11 80    	mov    0x801116e8,%ecx
80102d76:	85 c9                	test   %ecx,%ecx
80102d78:	0f 8e 8a 00 00 00    	jle    80102e08 <install_trans+0x98>
{
80102d7e:	55                   	push   %ebp
80102d7f:	89 e5                	mov    %esp,%ebp
80102d81:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102d82:	31 ff                	xor    %edi,%edi
{
80102d84:	56                   	push   %esi
80102d85:	53                   	push   %ebx
80102d86:	83 ec 0c             	sub    $0xc,%esp
80102d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102d90:	a1 d4 16 11 80       	mov    0x801116d4,%eax
80102d95:	83 ec 08             	sub    $0x8,%esp
80102d98:	01 f8                	add    %edi,%eax
80102d9a:	83 c0 01             	add    $0x1,%eax
80102d9d:	50                   	push   %eax
80102d9e:	ff 35 e4 16 11 80    	pushl  0x801116e4
80102da4:	e8 27 d3 ff ff       	call   801000d0 <bread>
80102da9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102dab:	58                   	pop    %eax
80102dac:	5a                   	pop    %edx
80102dad:	ff 34 bd ec 16 11 80 	pushl  -0x7feee914(,%edi,4)
80102db4:	ff 35 e4 16 11 80    	pushl  0x801116e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102dba:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102dbd:	e8 0e d3 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102dc2:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102dc5:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102dc7:	8d 46 5c             	lea    0x5c(%esi),%eax
80102dca:	68 00 02 00 00       	push   $0x200
80102dcf:	50                   	push   %eax
80102dd0:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102dd3:	50                   	push   %eax
80102dd4:	e8 a7 1b 00 00       	call   80104980 <memmove>
    bwrite(dbuf);  // write dst to disk
80102dd9:	89 1c 24             	mov    %ebx,(%esp)
80102ddc:	e8 cf d3 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80102de1:	89 34 24             	mov    %esi,(%esp)
80102de4:	e8 07 d4 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80102de9:	89 1c 24             	mov    %ebx,(%esp)
80102dec:	e8 ff d3 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102df1:	83 c4 10             	add    $0x10,%esp
80102df4:	39 3d e8 16 11 80    	cmp    %edi,0x801116e8
80102dfa:	7f 94                	jg     80102d90 <install_trans+0x20>
  }
}
80102dfc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102dff:	5b                   	pop    %ebx
80102e00:	5e                   	pop    %esi
80102e01:	5f                   	pop    %edi
80102e02:	5d                   	pop    %ebp
80102e03:	c3                   	ret    
80102e04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102e08:	c3                   	ret    
80102e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102e10 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102e10:	55                   	push   %ebp
80102e11:	89 e5                	mov    %esp,%ebp
80102e13:	53                   	push   %ebx
80102e14:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102e17:	ff 35 d4 16 11 80    	pushl  0x801116d4
80102e1d:	ff 35 e4 16 11 80    	pushl  0x801116e4
80102e23:	e8 a8 d2 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102e28:	8b 0d e8 16 11 80    	mov    0x801116e8,%ecx
  for (i = 0; i < log.lh.n; i++) {
80102e2e:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102e31:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102e33:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102e36:	85 c9                	test   %ecx,%ecx
80102e38:	7e 18                	jle    80102e52 <write_head+0x42>
80102e3a:	31 c0                	xor    %eax,%eax
80102e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102e40:	8b 14 85 ec 16 11 80 	mov    -0x7feee914(,%eax,4),%edx
80102e47:	89 54 83 60          	mov    %edx,0x60(%ebx,%eax,4)
  for (i = 0; i < log.lh.n; i++) {
80102e4b:	83 c0 01             	add    $0x1,%eax
80102e4e:	39 c1                	cmp    %eax,%ecx
80102e50:	75 ee                	jne    80102e40 <write_head+0x30>
  }
  bwrite(buf);
80102e52:	83 ec 0c             	sub    $0xc,%esp
80102e55:	53                   	push   %ebx
80102e56:	e8 55 d3 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80102e5b:	89 1c 24             	mov    %ebx,(%esp)
80102e5e:	e8 8d d3 ff ff       	call   801001f0 <brelse>
}
80102e63:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e66:	83 c4 10             	add    $0x10,%esp
80102e69:	c9                   	leave  
80102e6a:	c3                   	ret    
80102e6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102e6f:	90                   	nop

80102e70 <initlog>:
{
80102e70:	f3 0f 1e fb          	endbr32 
80102e74:	55                   	push   %ebp
80102e75:	89 e5                	mov    %esp,%ebp
80102e77:	53                   	push   %ebx
80102e78:	83 ec 2c             	sub    $0x2c,%esp
80102e7b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102e7e:	68 00 7a 10 80       	push   $0x80107a00
80102e83:	68 a0 16 11 80       	push   $0x801116a0
80102e88:	e8 83 17 00 00       	call   80104610 <initlock>
  readsb(dev, &sb);
80102e8d:	58                   	pop    %eax
80102e8e:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102e91:	5a                   	pop    %edx
80102e92:	50                   	push   %eax
80102e93:	53                   	push   %ebx
80102e94:	e8 c7 e7 ff ff       	call   80101660 <readsb>
  log.start = sb.logstart;
80102e99:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102e9c:	59                   	pop    %ecx
  log.dev = dev;
80102e9d:	89 1d e4 16 11 80    	mov    %ebx,0x801116e4
  log.size = sb.nlog;
80102ea3:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102ea6:	a3 d4 16 11 80       	mov    %eax,0x801116d4
  log.size = sb.nlog;
80102eab:	89 15 d8 16 11 80    	mov    %edx,0x801116d8
  struct buf *buf = bread(log.dev, log.start);
80102eb1:	5a                   	pop    %edx
80102eb2:	50                   	push   %eax
80102eb3:	53                   	push   %ebx
80102eb4:	e8 17 d2 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102eb9:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102ebc:	8b 58 5c             	mov    0x5c(%eax),%ebx
  struct buf *buf = bread(log.dev, log.start);
80102ebf:	89 c1                	mov    %eax,%ecx
  log.lh.n = lh->n;
80102ec1:	89 1d e8 16 11 80    	mov    %ebx,0x801116e8
  for (i = 0; i < log.lh.n; i++) {
80102ec7:	85 db                	test   %ebx,%ebx
80102ec9:	7e 17                	jle    80102ee2 <initlog+0x72>
80102ecb:	31 c0                	xor    %eax,%eax
80102ecd:	8d 76 00             	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102ed0:	8b 54 81 60          	mov    0x60(%ecx,%eax,4),%edx
80102ed4:	89 14 85 ec 16 11 80 	mov    %edx,-0x7feee914(,%eax,4)
  for (i = 0; i < log.lh.n; i++) {
80102edb:	83 c0 01             	add    $0x1,%eax
80102ede:	39 c3                	cmp    %eax,%ebx
80102ee0:	75 ee                	jne    80102ed0 <initlog+0x60>
  brelse(buf);
80102ee2:	83 ec 0c             	sub    $0xc,%esp
80102ee5:	51                   	push   %ecx
80102ee6:	e8 05 d3 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102eeb:	e8 80 fe ff ff       	call   80102d70 <install_trans>
  log.lh.n = 0;
80102ef0:	c7 05 e8 16 11 80 00 	movl   $0x0,0x801116e8
80102ef7:	00 00 00 
  write_head(); // clear the log
80102efa:	e8 11 ff ff ff       	call   80102e10 <write_head>
}
80102eff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f02:	83 c4 10             	add    $0x10,%esp
80102f05:	c9                   	leave  
80102f06:	c3                   	ret    
80102f07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f0e:	66 90                	xchg   %ax,%ax

80102f10 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102f10:	f3 0f 1e fb          	endbr32 
80102f14:	55                   	push   %ebp
80102f15:	89 e5                	mov    %esp,%ebp
80102f17:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102f1a:	68 a0 16 11 80       	push   $0x801116a0
80102f1f:	e8 ec 18 00 00       	call   80104810 <acquire>
80102f24:	83 c4 10             	add    $0x10,%esp
80102f27:	eb 1c                	jmp    80102f45 <begin_op+0x35>
80102f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102f30:	83 ec 08             	sub    $0x8,%esp
80102f33:	68 a0 16 11 80       	push   $0x801116a0
80102f38:	68 a0 16 11 80       	push   $0x801116a0
80102f3d:	e8 0e 13 00 00       	call   80104250 <sleep>
80102f42:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102f45:	a1 e0 16 11 80       	mov    0x801116e0,%eax
80102f4a:	85 c0                	test   %eax,%eax
80102f4c:	75 e2                	jne    80102f30 <begin_op+0x20>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102f4e:	a1 dc 16 11 80       	mov    0x801116dc,%eax
80102f53:	8b 15 e8 16 11 80    	mov    0x801116e8,%edx
80102f59:	83 c0 01             	add    $0x1,%eax
80102f5c:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102f5f:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102f62:	83 fa 1e             	cmp    $0x1e,%edx
80102f65:	7f c9                	jg     80102f30 <begin_op+0x20>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102f67:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102f6a:	a3 dc 16 11 80       	mov    %eax,0x801116dc
      release(&log.lock);
80102f6f:	68 a0 16 11 80       	push   $0x801116a0
80102f74:	e8 27 18 00 00       	call   801047a0 <release>
      break;
    }
  }
}
80102f79:	83 c4 10             	add    $0x10,%esp
80102f7c:	c9                   	leave  
80102f7d:	c3                   	ret    
80102f7e:	66 90                	xchg   %ax,%ax

80102f80 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102f80:	f3 0f 1e fb          	endbr32 
80102f84:	55                   	push   %ebp
80102f85:	89 e5                	mov    %esp,%ebp
80102f87:	57                   	push   %edi
80102f88:	56                   	push   %esi
80102f89:	53                   	push   %ebx
80102f8a:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102f8d:	68 a0 16 11 80       	push   $0x801116a0
80102f92:	e8 79 18 00 00       	call   80104810 <acquire>
  log.outstanding -= 1;
80102f97:	a1 dc 16 11 80       	mov    0x801116dc,%eax
  if(log.committing)
80102f9c:	8b 35 e0 16 11 80    	mov    0x801116e0,%esi
80102fa2:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102fa5:	8d 58 ff             	lea    -0x1(%eax),%ebx
80102fa8:	89 1d dc 16 11 80    	mov    %ebx,0x801116dc
  if(log.committing)
80102fae:	85 f6                	test   %esi,%esi
80102fb0:	0f 85 1e 01 00 00    	jne    801030d4 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102fb6:	85 db                	test   %ebx,%ebx
80102fb8:	0f 85 f2 00 00 00    	jne    801030b0 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80102fbe:	c7 05 e0 16 11 80 01 	movl   $0x1,0x801116e0
80102fc5:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102fc8:	83 ec 0c             	sub    $0xc,%esp
80102fcb:	68 a0 16 11 80       	push   $0x801116a0
80102fd0:	e8 cb 17 00 00       	call   801047a0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102fd5:	8b 0d e8 16 11 80    	mov    0x801116e8,%ecx
80102fdb:	83 c4 10             	add    $0x10,%esp
80102fde:	85 c9                	test   %ecx,%ecx
80102fe0:	7f 3e                	jg     80103020 <end_op+0xa0>
    acquire(&log.lock);
80102fe2:	83 ec 0c             	sub    $0xc,%esp
80102fe5:	68 a0 16 11 80       	push   $0x801116a0
80102fea:	e8 21 18 00 00       	call   80104810 <acquire>
    wakeup(&log);
80102fef:	c7 04 24 a0 16 11 80 	movl   $0x801116a0,(%esp)
    log.committing = 0;
80102ff6:	c7 05 e0 16 11 80 00 	movl   $0x0,0x801116e0
80102ffd:	00 00 00 
    wakeup(&log);
80103000:	e8 0b 13 00 00       	call   80104310 <wakeup>
    release(&log.lock);
80103005:	c7 04 24 a0 16 11 80 	movl   $0x801116a0,(%esp)
8010300c:	e8 8f 17 00 00       	call   801047a0 <release>
80103011:	83 c4 10             	add    $0x10,%esp
}
80103014:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103017:	5b                   	pop    %ebx
80103018:	5e                   	pop    %esi
80103019:	5f                   	pop    %edi
8010301a:	5d                   	pop    %ebp
8010301b:	c3                   	ret    
8010301c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103020:	a1 d4 16 11 80       	mov    0x801116d4,%eax
80103025:	83 ec 08             	sub    $0x8,%esp
80103028:	01 d8                	add    %ebx,%eax
8010302a:	83 c0 01             	add    $0x1,%eax
8010302d:	50                   	push   %eax
8010302e:	ff 35 e4 16 11 80    	pushl  0x801116e4
80103034:	e8 97 d0 ff ff       	call   801000d0 <bread>
80103039:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010303b:	58                   	pop    %eax
8010303c:	5a                   	pop    %edx
8010303d:	ff 34 9d ec 16 11 80 	pushl  -0x7feee914(,%ebx,4)
80103044:	ff 35 e4 16 11 80    	pushl  0x801116e4
  for (tail = 0; tail < log.lh.n; tail++) {
8010304a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010304d:	e8 7e d0 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80103052:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103055:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103057:	8d 40 5c             	lea    0x5c(%eax),%eax
8010305a:	68 00 02 00 00       	push   $0x200
8010305f:	50                   	push   %eax
80103060:	8d 46 5c             	lea    0x5c(%esi),%eax
80103063:	50                   	push   %eax
80103064:	e8 17 19 00 00       	call   80104980 <memmove>
    bwrite(to);  // write the log
80103069:	89 34 24             	mov    %esi,(%esp)
8010306c:	e8 3f d1 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80103071:	89 3c 24             	mov    %edi,(%esp)
80103074:	e8 77 d1 ff ff       	call   801001f0 <brelse>
    brelse(to);
80103079:	89 34 24             	mov    %esi,(%esp)
8010307c:	e8 6f d1 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103081:	83 c4 10             	add    $0x10,%esp
80103084:	3b 1d e8 16 11 80    	cmp    0x801116e8,%ebx
8010308a:	7c 94                	jl     80103020 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
8010308c:	e8 7f fd ff ff       	call   80102e10 <write_head>
    install_trans(); // Now install writes to home locations
80103091:	e8 da fc ff ff       	call   80102d70 <install_trans>
    log.lh.n = 0;
80103096:	c7 05 e8 16 11 80 00 	movl   $0x0,0x801116e8
8010309d:	00 00 00 
    write_head();    // Erase the transaction from the log
801030a0:	e8 6b fd ff ff       	call   80102e10 <write_head>
801030a5:	e9 38 ff ff ff       	jmp    80102fe2 <end_op+0x62>
801030aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
801030b0:	83 ec 0c             	sub    $0xc,%esp
801030b3:	68 a0 16 11 80       	push   $0x801116a0
801030b8:	e8 53 12 00 00       	call   80104310 <wakeup>
  release(&log.lock);
801030bd:	c7 04 24 a0 16 11 80 	movl   $0x801116a0,(%esp)
801030c4:	e8 d7 16 00 00       	call   801047a0 <release>
801030c9:	83 c4 10             	add    $0x10,%esp
}
801030cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801030cf:	5b                   	pop    %ebx
801030d0:	5e                   	pop    %esi
801030d1:	5f                   	pop    %edi
801030d2:	5d                   	pop    %ebp
801030d3:	c3                   	ret    
    panic("log.committing");
801030d4:	83 ec 0c             	sub    $0xc,%esp
801030d7:	68 04 7a 10 80       	push   $0x80107a04
801030dc:	e8 af d2 ff ff       	call   80100390 <panic>
801030e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030ef:	90                   	nop

801030f0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
801030f0:	f3 0f 1e fb          	endbr32 
801030f4:	55                   	push   %ebp
801030f5:	89 e5                	mov    %esp,%ebp
801030f7:	53                   	push   %ebx
801030f8:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801030fb:	8b 15 e8 16 11 80    	mov    0x801116e8,%edx
{
80103101:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103104:	83 fa 1d             	cmp    $0x1d,%edx
80103107:	0f 8f 91 00 00 00    	jg     8010319e <log_write+0xae>
8010310d:	a1 d8 16 11 80       	mov    0x801116d8,%eax
80103112:	83 e8 01             	sub    $0x1,%eax
80103115:	39 c2                	cmp    %eax,%edx
80103117:	0f 8d 81 00 00 00    	jge    8010319e <log_write+0xae>
    panic("too big a transaction");
  if (log.outstanding < 1)
8010311d:	a1 dc 16 11 80       	mov    0x801116dc,%eax
80103122:	85 c0                	test   %eax,%eax
80103124:	0f 8e 81 00 00 00    	jle    801031ab <log_write+0xbb>
    panic("log_write outside of trans");

  acquire(&log.lock);
8010312a:	83 ec 0c             	sub    $0xc,%esp
8010312d:	68 a0 16 11 80       	push   $0x801116a0
80103132:	e8 d9 16 00 00       	call   80104810 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80103137:	8b 15 e8 16 11 80    	mov    0x801116e8,%edx
8010313d:	83 c4 10             	add    $0x10,%esp
80103140:	85 d2                	test   %edx,%edx
80103142:	7e 4e                	jle    80103192 <log_write+0xa2>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103144:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80103147:	31 c0                	xor    %eax,%eax
80103149:	eb 0c                	jmp    80103157 <log_write+0x67>
8010314b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010314f:	90                   	nop
80103150:	83 c0 01             	add    $0x1,%eax
80103153:	39 c2                	cmp    %eax,%edx
80103155:	74 29                	je     80103180 <log_write+0x90>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103157:	39 0c 85 ec 16 11 80 	cmp    %ecx,-0x7feee914(,%eax,4)
8010315e:	75 f0                	jne    80103150 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80103160:	89 0c 85 ec 16 11 80 	mov    %ecx,-0x7feee914(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80103167:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
8010316a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
8010316d:	c7 45 08 a0 16 11 80 	movl   $0x801116a0,0x8(%ebp)
}
80103174:	c9                   	leave  
  release(&log.lock);
80103175:	e9 26 16 00 00       	jmp    801047a0 <release>
8010317a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80103180:	89 0c 95 ec 16 11 80 	mov    %ecx,-0x7feee914(,%edx,4)
    log.lh.n++;
80103187:	83 c2 01             	add    $0x1,%edx
8010318a:	89 15 e8 16 11 80    	mov    %edx,0x801116e8
80103190:	eb d5                	jmp    80103167 <log_write+0x77>
  log.lh.block[i] = b->blockno;
80103192:	8b 43 08             	mov    0x8(%ebx),%eax
80103195:	a3 ec 16 11 80       	mov    %eax,0x801116ec
  if (i == log.lh.n)
8010319a:	75 cb                	jne    80103167 <log_write+0x77>
8010319c:	eb e9                	jmp    80103187 <log_write+0x97>
    panic("too big a transaction");
8010319e:	83 ec 0c             	sub    $0xc,%esp
801031a1:	68 13 7a 10 80       	push   $0x80107a13
801031a6:	e8 e5 d1 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
801031ab:	83 ec 0c             	sub    $0xc,%esp
801031ae:	68 29 7a 10 80       	push   $0x80107a29
801031b3:	e8 d8 d1 ff ff       	call   80100390 <panic>
801031b8:	66 90                	xchg   %ax,%ax
801031ba:	66 90                	xchg   %ax,%ax
801031bc:	66 90                	xchg   %ax,%ax
801031be:	66 90                	xchg   %ax,%ax

801031c0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801031c0:	55                   	push   %ebp
801031c1:	89 e5                	mov    %esp,%ebp
801031c3:	53                   	push   %ebx
801031c4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
801031c7:	e8 84 09 00 00       	call   80103b50 <cpuid>
801031cc:	89 c3                	mov    %eax,%ebx
801031ce:	e8 7d 09 00 00       	call   80103b50 <cpuid>
801031d3:	83 ec 04             	sub    $0x4,%esp
801031d6:	53                   	push   %ebx
801031d7:	50                   	push   %eax
801031d8:	68 44 7a 10 80       	push   $0x80107a44
801031dd:	e8 ae d4 ff ff       	call   80100690 <cprintf>
  idtinit();       // load idt register
801031e2:	e8 89 2a 00 00       	call   80105c70 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
801031e7:	e8 f4 08 00 00       	call   80103ae0 <mycpu>
801031ec:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801031ee:	b8 01 00 00 00       	mov    $0x1,%eax
801031f3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
801031fa:	e8 41 0c 00 00       	call   80103e40 <scheduler>
801031ff:	90                   	nop

80103200 <mpenter>:
{
80103200:	f3 0f 1e fb          	endbr32 
80103204:	55                   	push   %ebp
80103205:	89 e5                	mov    %esp,%ebp
80103207:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
8010320a:	e8 71 3b 00 00       	call   80106d80 <switchkvm>
  seginit();
8010320f:	e8 dc 3a 00 00       	call   80106cf0 <seginit>
  lapicinit();
80103214:	e8 67 f7 ff ff       	call   80102980 <lapicinit>
  mpmain();
80103219:	e8 a2 ff ff ff       	call   801031c0 <mpmain>
8010321e:	66 90                	xchg   %ax,%ax

80103220 <main>:
{
80103220:	f3 0f 1e fb          	endbr32 
80103224:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103228:	83 e4 f0             	and    $0xfffffff0,%esp
8010322b:	ff 71 fc             	pushl  -0x4(%ecx)
8010322e:	55                   	push   %ebp
8010322f:	89 e5                	mov    %esp,%ebp
80103231:	53                   	push   %ebx
80103232:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103233:	83 ec 08             	sub    $0x8,%esp
80103236:	68 00 00 40 80       	push   $0x80400000
8010323b:	68 30 55 11 80       	push   $0x80115530
80103240:	e8 5b f5 ff ff       	call   801027a0 <kinit1>
  kvmalloc();      // kernel page table
80103245:	e8 36 40 00 00       	call   80107280 <kvmalloc>
  mpinit();        // detect other processors
8010324a:	e8 81 01 00 00       	call   801033d0 <mpinit>
  lapicinit();     // interrupt controller
8010324f:	e8 2c f7 ff ff       	call   80102980 <lapicinit>
  seginit();       // segment descriptors
80103254:	e8 97 3a 00 00       	call   80106cf0 <seginit>
  picinit();       // disable pic
80103259:	e8 82 03 00 00       	call   801035e0 <picinit>
  ioapicinit();    // another interrupt controller
8010325e:	e8 fd f2 ff ff       	call   80102560 <ioapicinit>
  consoleinit();   // console hardware
80103263:	e8 28 d9 ff ff       	call   80100b90 <consoleinit>
  uartinit();      // serial port
80103268:	e8 f3 2c 00 00       	call   80105f60 <uartinit>
  pinit();         // process table
8010326d:	e8 4e 08 00 00       	call   80103ac0 <pinit>
  tvinit();        // trap vectors
80103272:	e8 79 29 00 00       	call   80105bf0 <tvinit>
  binit();         // buffer cache
80103277:	e8 c4 cd ff ff       	call   80100040 <binit>
  fileinit();      // file table
8010327c:	e8 bf dc ff ff       	call   80100f40 <fileinit>
  ideinit();       // disk 
80103281:	e8 aa f0 ff ff       	call   80102330 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103286:	83 c4 0c             	add    $0xc,%esp
80103289:	68 8a 00 00 00       	push   $0x8a
8010328e:	68 8c a4 10 80       	push   $0x8010a48c
80103293:	68 00 70 00 80       	push   $0x80007000
80103298:	e8 e3 16 00 00       	call   80104980 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
8010329d:	83 c4 10             	add    $0x10,%esp
801032a0:	69 05 84 17 11 80 b0 	imul   $0xb0,0x80111784,%eax
801032a7:	00 00 00 
801032aa:	05 a0 17 11 80       	add    $0x801117a0,%eax
801032af:	3d a0 17 11 80       	cmp    $0x801117a0,%eax
801032b4:	76 7a                	jbe    80103330 <main+0x110>
801032b6:	bb a0 17 11 80       	mov    $0x801117a0,%ebx
801032bb:	eb 1c                	jmp    801032d9 <main+0xb9>
801032bd:	8d 76 00             	lea    0x0(%esi),%esi
801032c0:	69 05 84 17 11 80 b0 	imul   $0xb0,0x80111784,%eax
801032c7:	00 00 00 
801032ca:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801032d0:	05 a0 17 11 80       	add    $0x801117a0,%eax
801032d5:	39 c3                	cmp    %eax,%ebx
801032d7:	73 57                	jae    80103330 <main+0x110>
    if(c == mycpu())  // We've started already.
801032d9:	e8 02 08 00 00       	call   80103ae0 <mycpu>
801032de:	39 c3                	cmp    %eax,%ebx
801032e0:	74 de                	je     801032c0 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801032e2:	e8 29 f5 ff ff       	call   80102810 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
801032e7:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
801032ea:	c7 05 f8 6f 00 80 00 	movl   $0x80103200,0x80006ff8
801032f1:	32 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
801032f4:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
801032fb:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
801032fe:	05 00 10 00 00       	add    $0x1000,%eax
80103303:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103308:	0f b6 03             	movzbl (%ebx),%eax
8010330b:	68 00 70 00 00       	push   $0x7000
80103310:	50                   	push   %eax
80103311:	e8 ba f7 ff ff       	call   80102ad0 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103316:	83 c4 10             	add    $0x10,%esp
80103319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103320:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103326:	85 c0                	test   %eax,%eax
80103328:	74 f6                	je     80103320 <main+0x100>
8010332a:	eb 94                	jmp    801032c0 <main+0xa0>
8010332c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103330:	83 ec 08             	sub    $0x8,%esp
80103333:	68 00 00 00 8e       	push   $0x8e000000
80103338:	68 00 00 40 80       	push   $0x80400000
8010333d:	e8 fe f3 ff ff       	call   80102740 <kinit2>
  userinit();      // first user process
80103342:	e8 59 08 00 00       	call   80103ba0 <userinit>
  mpmain();        // finish this processor's setup
80103347:	e8 74 fe ff ff       	call   801031c0 <mpmain>
8010334c:	66 90                	xchg   %ax,%ax
8010334e:	66 90                	xchg   %ax,%ax

80103350 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103350:	55                   	push   %ebp
80103351:	89 e5                	mov    %esp,%ebp
80103353:	57                   	push   %edi
80103354:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103355:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010335b:	53                   	push   %ebx
  e = addr+len;
8010335c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010335f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103362:	39 de                	cmp    %ebx,%esi
80103364:	72 10                	jb     80103376 <mpsearch1+0x26>
80103366:	eb 50                	jmp    801033b8 <mpsearch1+0x68>
80103368:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010336f:	90                   	nop
80103370:	89 fe                	mov    %edi,%esi
80103372:	39 fb                	cmp    %edi,%ebx
80103374:	76 42                	jbe    801033b8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103376:	83 ec 04             	sub    $0x4,%esp
80103379:	8d 7e 10             	lea    0x10(%esi),%edi
8010337c:	6a 04                	push   $0x4
8010337e:	68 58 7a 10 80       	push   $0x80107a58
80103383:	56                   	push   %esi
80103384:	e8 a7 15 00 00       	call   80104930 <memcmp>
80103389:	83 c4 10             	add    $0x10,%esp
8010338c:	89 c2                	mov    %eax,%edx
8010338e:	85 c0                	test   %eax,%eax
80103390:	75 de                	jne    80103370 <mpsearch1+0x20>
80103392:	89 f0                	mov    %esi,%eax
80103394:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103398:	0f b6 08             	movzbl (%eax),%ecx
  for(i=0; i<len; i++)
8010339b:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
8010339e:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801033a0:	39 f8                	cmp    %edi,%eax
801033a2:	75 f4                	jne    80103398 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801033a4:	84 d2                	test   %dl,%dl
801033a6:	75 c8                	jne    80103370 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801033a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801033ab:	89 f0                	mov    %esi,%eax
801033ad:	5b                   	pop    %ebx
801033ae:	5e                   	pop    %esi
801033af:	5f                   	pop    %edi
801033b0:	5d                   	pop    %ebp
801033b1:	c3                   	ret    
801033b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801033b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801033bb:	31 f6                	xor    %esi,%esi
}
801033bd:	5b                   	pop    %ebx
801033be:	89 f0                	mov    %esi,%eax
801033c0:	5e                   	pop    %esi
801033c1:	5f                   	pop    %edi
801033c2:	5d                   	pop    %ebp
801033c3:	c3                   	ret    
801033c4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801033cf:	90                   	nop

801033d0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801033d0:	f3 0f 1e fb          	endbr32 
801033d4:	55                   	push   %ebp
801033d5:	89 e5                	mov    %esp,%ebp
801033d7:	57                   	push   %edi
801033d8:	56                   	push   %esi
801033d9:	53                   	push   %ebx
801033da:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801033dd:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801033e4:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801033eb:	c1 e0 08             	shl    $0x8,%eax
801033ee:	09 d0                	or     %edx,%eax
801033f0:	c1 e0 04             	shl    $0x4,%eax
801033f3:	75 1b                	jne    80103410 <mpinit+0x40>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
801033f5:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801033fc:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103403:	c1 e0 08             	shl    $0x8,%eax
80103406:	09 d0                	or     %edx,%eax
80103408:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
8010340b:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
80103410:	ba 00 04 00 00       	mov    $0x400,%edx
80103415:	e8 36 ff ff ff       	call   80103350 <mpsearch1>
8010341a:	89 c3                	mov    %eax,%ebx
8010341c:	85 c0                	test   %eax,%eax
8010341e:	0f 84 4c 01 00 00    	je     80103570 <mpinit+0x1a0>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103424:	8b 73 04             	mov    0x4(%ebx),%esi
80103427:	85 f6                	test   %esi,%esi
80103429:	0f 84 31 01 00 00    	je     80103560 <mpinit+0x190>
  if(memcmp(conf, "PCMP", 4) != 0)
8010342f:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103432:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103438:	6a 04                	push   $0x4
8010343a:	68 5d 7a 10 80       	push   $0x80107a5d
8010343f:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103440:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103443:	e8 e8 14 00 00       	call   80104930 <memcmp>
80103448:	83 c4 10             	add    $0x10,%esp
8010344b:	85 c0                	test   %eax,%eax
8010344d:	0f 85 0d 01 00 00    	jne    80103560 <mpinit+0x190>
  if(conf->version != 1 && conf->version != 4)
80103453:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
8010345a:	3c 01                	cmp    $0x1,%al
8010345c:	74 08                	je     80103466 <mpinit+0x96>
8010345e:	3c 04                	cmp    $0x4,%al
80103460:	0f 85 fa 00 00 00    	jne    80103560 <mpinit+0x190>
  if(sum((uchar*)conf, conf->length) != 0)
80103466:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
8010346d:	66 85 d2             	test   %dx,%dx
80103470:	74 26                	je     80103498 <mpinit+0xc8>
80103472:	8d 3c 32             	lea    (%edx,%esi,1),%edi
80103475:	89 f0                	mov    %esi,%eax
  sum = 0;
80103477:	31 d2                	xor    %edx,%edx
80103479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103480:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
80103487:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
8010348a:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
8010348c:	39 f8                	cmp    %edi,%eax
8010348e:	75 f0                	jne    80103480 <mpinit+0xb0>
  if(sum((uchar*)conf, conf->length) != 0)
80103490:	84 d2                	test   %dl,%dl
80103492:	0f 85 c8 00 00 00    	jne    80103560 <mpinit+0x190>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103498:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
8010349e:	a3 80 16 11 80       	mov    %eax,0x80111680
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801034a3:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
801034aa:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
  ismp = 1;
801034b0:	be 01 00 00 00       	mov    $0x1,%esi
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801034b5:	03 55 e4             	add    -0x1c(%ebp),%edx
801034b8:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801034bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801034bf:	90                   	nop
801034c0:	39 d0                	cmp    %edx,%eax
801034c2:	73 15                	jae    801034d9 <mpinit+0x109>
    switch(*p){
801034c4:	0f b6 08             	movzbl (%eax),%ecx
801034c7:	80 f9 02             	cmp    $0x2,%cl
801034ca:	74 54                	je     80103520 <mpinit+0x150>
801034cc:	77 42                	ja     80103510 <mpinit+0x140>
801034ce:	84 c9                	test   %cl,%cl
801034d0:	74 5e                	je     80103530 <mpinit+0x160>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801034d2:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801034d5:	39 d0                	cmp    %edx,%eax
801034d7:	72 eb                	jb     801034c4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801034d9:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801034dc:	85 f6                	test   %esi,%esi
801034de:	0f 84 e1 00 00 00    	je     801035c5 <mpinit+0x1f5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801034e4:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
801034e8:	74 15                	je     801034ff <mpinit+0x12f>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801034ea:	b8 70 00 00 00       	mov    $0x70,%eax
801034ef:	ba 22 00 00 00       	mov    $0x22,%edx
801034f4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801034f5:	ba 23 00 00 00       	mov    $0x23,%edx
801034fa:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801034fb:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801034fe:	ee                   	out    %al,(%dx)
  }
}
801034ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103502:	5b                   	pop    %ebx
80103503:	5e                   	pop    %esi
80103504:	5f                   	pop    %edi
80103505:	5d                   	pop    %ebp
80103506:	c3                   	ret    
80103507:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010350e:	66 90                	xchg   %ax,%ax
    switch(*p){
80103510:	83 e9 03             	sub    $0x3,%ecx
80103513:	80 f9 01             	cmp    $0x1,%cl
80103516:	76 ba                	jbe    801034d2 <mpinit+0x102>
80103518:	31 f6                	xor    %esi,%esi
8010351a:	eb a4                	jmp    801034c0 <mpinit+0xf0>
8010351c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103520:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80103524:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80103527:	88 0d 80 17 11 80    	mov    %cl,0x80111780
      continue;
8010352d:	eb 91                	jmp    801034c0 <mpinit+0xf0>
8010352f:	90                   	nop
      if(ncpu < NCPU) {
80103530:	8b 0d 84 17 11 80    	mov    0x80111784,%ecx
80103536:	83 f9 07             	cmp    $0x7,%ecx
80103539:	7f 19                	jg     80103554 <mpinit+0x184>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010353b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80103541:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103545:	83 c1 01             	add    $0x1,%ecx
80103548:	89 0d 84 17 11 80    	mov    %ecx,0x80111784
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010354e:	88 9f a0 17 11 80    	mov    %bl,-0x7feee860(%edi)
      p += sizeof(struct mpproc);
80103554:	83 c0 14             	add    $0x14,%eax
      continue;
80103557:	e9 64 ff ff ff       	jmp    801034c0 <mpinit+0xf0>
8010355c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
80103560:	83 ec 0c             	sub    $0xc,%esp
80103563:	68 62 7a 10 80       	push   $0x80107a62
80103568:	e8 23 ce ff ff       	call   80100390 <panic>
8010356d:	8d 76 00             	lea    0x0(%esi),%esi
{
80103570:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
80103575:	eb 13                	jmp    8010358a <mpinit+0x1ba>
80103577:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010357e:	66 90                	xchg   %ax,%ax
  for(p = addr; p < e; p += sizeof(struct mp))
80103580:	89 f3                	mov    %esi,%ebx
80103582:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80103588:	74 d6                	je     80103560 <mpinit+0x190>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010358a:	83 ec 04             	sub    $0x4,%esp
8010358d:	8d 73 10             	lea    0x10(%ebx),%esi
80103590:	6a 04                	push   $0x4
80103592:	68 58 7a 10 80       	push   $0x80107a58
80103597:	53                   	push   %ebx
80103598:	e8 93 13 00 00       	call   80104930 <memcmp>
8010359d:	83 c4 10             	add    $0x10,%esp
801035a0:	89 c2                	mov    %eax,%edx
801035a2:	85 c0                	test   %eax,%eax
801035a4:	75 da                	jne    80103580 <mpinit+0x1b0>
801035a6:	89 d8                	mov    %ebx,%eax
801035a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801035af:	90                   	nop
    sum += addr[i];
801035b0:	0f b6 08             	movzbl (%eax),%ecx
  for(i=0; i<len; i++)
801035b3:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801035b6:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801035b8:	39 f0                	cmp    %esi,%eax
801035ba:	75 f4                	jne    801035b0 <mpinit+0x1e0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801035bc:	84 d2                	test   %dl,%dl
801035be:	75 c0                	jne    80103580 <mpinit+0x1b0>
801035c0:	e9 5f fe ff ff       	jmp    80103424 <mpinit+0x54>
    panic("Didn't find a suitable machine");
801035c5:	83 ec 0c             	sub    $0xc,%esp
801035c8:	68 7c 7a 10 80       	push   $0x80107a7c
801035cd:	e8 be cd ff ff       	call   80100390 <panic>
801035d2:	66 90                	xchg   %ax,%ax
801035d4:	66 90                	xchg   %ax,%ax
801035d6:	66 90                	xchg   %ax,%ax
801035d8:	66 90                	xchg   %ax,%ax
801035da:	66 90                	xchg   %ax,%ax
801035dc:	66 90                	xchg   %ax,%ax
801035de:	66 90                	xchg   %ax,%ax

801035e0 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
801035e0:	f3 0f 1e fb          	endbr32 
801035e4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801035e9:	ba 21 00 00 00       	mov    $0x21,%edx
801035ee:	ee                   	out    %al,(%dx)
801035ef:	ba a1 00 00 00       	mov    $0xa1,%edx
801035f4:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801035f5:	c3                   	ret    
801035f6:	66 90                	xchg   %ax,%ax
801035f8:	66 90                	xchg   %ax,%ax
801035fa:	66 90                	xchg   %ax,%ax
801035fc:	66 90                	xchg   %ax,%ax
801035fe:	66 90                	xchg   %ax,%ax

80103600 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103600:	f3 0f 1e fb          	endbr32 
80103604:	55                   	push   %ebp
80103605:	89 e5                	mov    %esp,%ebp
80103607:	57                   	push   %edi
80103608:	56                   	push   %esi
80103609:	53                   	push   %ebx
8010360a:	83 ec 0c             	sub    $0xc,%esp
8010360d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103610:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
80103613:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103619:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010361f:	e8 3c d9 ff ff       	call   80100f60 <filealloc>
80103624:	89 03                	mov    %eax,(%ebx)
80103626:	85 c0                	test   %eax,%eax
80103628:	0f 84 ac 00 00 00    	je     801036da <pipealloc+0xda>
8010362e:	e8 2d d9 ff ff       	call   80100f60 <filealloc>
80103633:	89 06                	mov    %eax,(%esi)
80103635:	85 c0                	test   %eax,%eax
80103637:	0f 84 8b 00 00 00    	je     801036c8 <pipealloc+0xc8>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
8010363d:	e8 ce f1 ff ff       	call   80102810 <kalloc>
80103642:	89 c7                	mov    %eax,%edi
80103644:	85 c0                	test   %eax,%eax
80103646:	0f 84 b4 00 00 00    	je     80103700 <pipealloc+0x100>
    goto bad;
  p->readopen = 1;
8010364c:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103653:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103656:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103659:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103660:	00 00 00 
  p->nwrite = 0;
80103663:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010366a:	00 00 00 
  p->nread = 0;
8010366d:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103674:	00 00 00 
  initlock(&p->lock, "pipe");
80103677:	68 9b 7a 10 80       	push   $0x80107a9b
8010367c:	50                   	push   %eax
8010367d:	e8 8e 0f 00 00       	call   80104610 <initlock>
  (*f0)->type = FD_PIPE;
80103682:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103684:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103687:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
8010368d:	8b 03                	mov    (%ebx),%eax
8010368f:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103693:	8b 03                	mov    (%ebx),%eax
80103695:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103699:	8b 03                	mov    (%ebx),%eax
8010369b:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010369e:	8b 06                	mov    (%esi),%eax
801036a0:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801036a6:	8b 06                	mov    (%esi),%eax
801036a8:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801036ac:	8b 06                	mov    (%esi),%eax
801036ae:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801036b2:	8b 06                	mov    (%esi),%eax
801036b4:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801036b7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801036ba:	31 c0                	xor    %eax,%eax
}
801036bc:	5b                   	pop    %ebx
801036bd:	5e                   	pop    %esi
801036be:	5f                   	pop    %edi
801036bf:	5d                   	pop    %ebp
801036c0:	c3                   	ret    
801036c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
801036c8:	8b 03                	mov    (%ebx),%eax
801036ca:	85 c0                	test   %eax,%eax
801036cc:	74 1e                	je     801036ec <pipealloc+0xec>
    fileclose(*f0);
801036ce:	83 ec 0c             	sub    $0xc,%esp
801036d1:	50                   	push   %eax
801036d2:	e8 49 d9 ff ff       	call   80101020 <fileclose>
801036d7:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801036da:	8b 06                	mov    (%esi),%eax
801036dc:	85 c0                	test   %eax,%eax
801036de:	74 0c                	je     801036ec <pipealloc+0xec>
    fileclose(*f1);
801036e0:	83 ec 0c             	sub    $0xc,%esp
801036e3:	50                   	push   %eax
801036e4:	e8 37 d9 ff ff       	call   80101020 <fileclose>
801036e9:	83 c4 10             	add    $0x10,%esp
}
801036ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801036ef:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801036f4:	5b                   	pop    %ebx
801036f5:	5e                   	pop    %esi
801036f6:	5f                   	pop    %edi
801036f7:	5d                   	pop    %ebp
801036f8:	c3                   	ret    
801036f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80103700:	8b 03                	mov    (%ebx),%eax
80103702:	85 c0                	test   %eax,%eax
80103704:	75 c8                	jne    801036ce <pipealloc+0xce>
80103706:	eb d2                	jmp    801036da <pipealloc+0xda>
80103708:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010370f:	90                   	nop

80103710 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103710:	f3 0f 1e fb          	endbr32 
80103714:	55                   	push   %ebp
80103715:	89 e5                	mov    %esp,%ebp
80103717:	56                   	push   %esi
80103718:	53                   	push   %ebx
80103719:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010371c:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010371f:	83 ec 0c             	sub    $0xc,%esp
80103722:	53                   	push   %ebx
80103723:	e8 e8 10 00 00       	call   80104810 <acquire>
  if(writable){
80103728:	83 c4 10             	add    $0x10,%esp
8010372b:	85 f6                	test   %esi,%esi
8010372d:	74 61                	je     80103790 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
8010372f:	83 ec 0c             	sub    $0xc,%esp
80103732:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103738:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010373f:	00 00 00 
    wakeup(&p->nread);
80103742:	50                   	push   %eax
80103743:	e8 c8 0b 00 00       	call   80104310 <wakeup>
80103748:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
8010374b:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80103751:	85 d2                	test   %edx,%edx
80103753:	75 0a                	jne    8010375f <pipeclose+0x4f>
80103755:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
8010375b:	85 c0                	test   %eax,%eax
8010375d:	74 11                	je     80103770 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010375f:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80103762:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103765:	5b                   	pop    %ebx
80103766:	5e                   	pop    %esi
80103767:	5d                   	pop    %ebp
    release(&p->lock);
80103768:	e9 33 10 00 00       	jmp    801047a0 <release>
8010376d:	8d 76 00             	lea    0x0(%esi),%esi
    release(&p->lock);
80103770:	83 ec 0c             	sub    $0xc,%esp
80103773:	53                   	push   %ebx
80103774:	e8 27 10 00 00       	call   801047a0 <release>
    kfree((char*)p);
80103779:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010377c:	83 c4 10             	add    $0x10,%esp
}
8010377f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103782:	5b                   	pop    %ebx
80103783:	5e                   	pop    %esi
80103784:	5d                   	pop    %ebp
    kfree((char*)p);
80103785:	e9 c6 ee ff ff       	jmp    80102650 <kfree>
8010378a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80103790:	83 ec 0c             	sub    $0xc,%esp
80103793:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103799:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801037a0:	00 00 00 
    wakeup(&p->nwrite);
801037a3:	50                   	push   %eax
801037a4:	e8 67 0b 00 00       	call   80104310 <wakeup>
801037a9:	83 c4 10             	add    $0x10,%esp
801037ac:	eb 9d                	jmp    8010374b <pipeclose+0x3b>
801037ae:	66 90                	xchg   %ax,%ax

801037b0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801037b0:	f3 0f 1e fb          	endbr32 
801037b4:	55                   	push   %ebp
801037b5:	89 e5                	mov    %esp,%ebp
801037b7:	57                   	push   %edi
801037b8:	56                   	push   %esi
801037b9:	53                   	push   %ebx
801037ba:	83 ec 28             	sub    $0x28,%esp
801037bd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801037c0:	53                   	push   %ebx
801037c1:	e8 4a 10 00 00       	call   80104810 <acquire>
  for(i = 0; i < n; i++){
801037c6:	8b 45 10             	mov    0x10(%ebp),%eax
801037c9:	83 c4 10             	add    $0x10,%esp
801037cc:	85 c0                	test   %eax,%eax
801037ce:	0f 8e bc 00 00 00    	jle    80103890 <pipewrite+0xe0>
801037d4:	8b 45 0c             	mov    0xc(%ebp),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801037d7:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801037dd:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
801037e3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801037e6:	03 45 10             	add    0x10(%ebp),%eax
801037e9:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801037ec:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801037f2:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801037f8:	89 ca                	mov    %ecx,%edx
801037fa:	05 00 02 00 00       	add    $0x200,%eax
801037ff:	39 c1                	cmp    %eax,%ecx
80103801:	74 3b                	je     8010383e <pipewrite+0x8e>
80103803:	eb 63                	jmp    80103868 <pipewrite+0xb8>
80103805:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->readopen == 0 || myproc()->killed){
80103808:	e8 63 03 00 00       	call   80103b70 <myproc>
8010380d:	8b 48 24             	mov    0x24(%eax),%ecx
80103810:	85 c9                	test   %ecx,%ecx
80103812:	75 34                	jne    80103848 <pipewrite+0x98>
      wakeup(&p->nread);
80103814:	83 ec 0c             	sub    $0xc,%esp
80103817:	57                   	push   %edi
80103818:	e8 f3 0a 00 00       	call   80104310 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010381d:	58                   	pop    %eax
8010381e:	5a                   	pop    %edx
8010381f:	53                   	push   %ebx
80103820:	56                   	push   %esi
80103821:	e8 2a 0a 00 00       	call   80104250 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103826:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010382c:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103832:	83 c4 10             	add    $0x10,%esp
80103835:	05 00 02 00 00       	add    $0x200,%eax
8010383a:	39 c2                	cmp    %eax,%edx
8010383c:	75 2a                	jne    80103868 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
8010383e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103844:	85 c0                	test   %eax,%eax
80103846:	75 c0                	jne    80103808 <pipewrite+0x58>
        release(&p->lock);
80103848:	83 ec 0c             	sub    $0xc,%esp
8010384b:	53                   	push   %ebx
8010384c:	e8 4f 0f 00 00       	call   801047a0 <release>
        return -1;
80103851:	83 c4 10             	add    $0x10,%esp
80103854:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103859:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010385c:	5b                   	pop    %ebx
8010385d:	5e                   	pop    %esi
8010385e:	5f                   	pop    %edi
8010385f:	5d                   	pop    %ebp
80103860:	c3                   	ret    
80103861:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103868:	8b 75 e4             	mov    -0x1c(%ebp),%esi
8010386b:	8d 4a 01             	lea    0x1(%edx),%ecx
8010386e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103874:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
8010387a:	0f b6 06             	movzbl (%esi),%eax
  for(i = 0; i < n; i++){
8010387d:	83 c6 01             	add    $0x1,%esi
80103880:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103883:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103887:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010388a:	0f 85 5c ff ff ff    	jne    801037ec <pipewrite+0x3c>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103890:	83 ec 0c             	sub    $0xc,%esp
80103893:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103899:	50                   	push   %eax
8010389a:	e8 71 0a 00 00       	call   80104310 <wakeup>
  release(&p->lock);
8010389f:	89 1c 24             	mov    %ebx,(%esp)
801038a2:	e8 f9 0e 00 00       	call   801047a0 <release>
  return n;
801038a7:	8b 45 10             	mov    0x10(%ebp),%eax
801038aa:	83 c4 10             	add    $0x10,%esp
801038ad:	eb aa                	jmp    80103859 <pipewrite+0xa9>
801038af:	90                   	nop

801038b0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801038b0:	f3 0f 1e fb          	endbr32 
801038b4:	55                   	push   %ebp
801038b5:	89 e5                	mov    %esp,%ebp
801038b7:	57                   	push   %edi
801038b8:	56                   	push   %esi
801038b9:	53                   	push   %ebx
801038ba:	83 ec 18             	sub    $0x18,%esp
801038bd:	8b 75 08             	mov    0x8(%ebp),%esi
801038c0:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801038c3:	56                   	push   %esi
801038c4:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801038ca:	e8 41 0f 00 00       	call   80104810 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801038cf:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801038d5:	83 c4 10             	add    $0x10,%esp
801038d8:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
801038de:	74 33                	je     80103913 <piperead+0x63>
801038e0:	eb 3b                	jmp    8010391d <piperead+0x6d>
801038e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed){
801038e8:	e8 83 02 00 00       	call   80103b70 <myproc>
801038ed:	8b 48 24             	mov    0x24(%eax),%ecx
801038f0:	85 c9                	test   %ecx,%ecx
801038f2:	0f 85 88 00 00 00    	jne    80103980 <piperead+0xd0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801038f8:	83 ec 08             	sub    $0x8,%esp
801038fb:	56                   	push   %esi
801038fc:	53                   	push   %ebx
801038fd:	e8 4e 09 00 00       	call   80104250 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103902:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80103908:	83 c4 10             	add    $0x10,%esp
8010390b:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80103911:	75 0a                	jne    8010391d <piperead+0x6d>
80103913:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80103919:	85 c0                	test   %eax,%eax
8010391b:	75 cb                	jne    801038e8 <piperead+0x38>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010391d:	8b 55 10             	mov    0x10(%ebp),%edx
80103920:	31 db                	xor    %ebx,%ebx
80103922:	85 d2                	test   %edx,%edx
80103924:	7f 28                	jg     8010394e <piperead+0x9e>
80103926:	eb 34                	jmp    8010395c <piperead+0xac>
80103928:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010392f:	90                   	nop
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103930:	8d 48 01             	lea    0x1(%eax),%ecx
80103933:	25 ff 01 00 00       	and    $0x1ff,%eax
80103938:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010393e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103943:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103946:	83 c3 01             	add    $0x1,%ebx
80103949:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010394c:	74 0e                	je     8010395c <piperead+0xac>
    if(p->nread == p->nwrite)
8010394e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103954:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010395a:	75 d4                	jne    80103930 <piperead+0x80>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010395c:	83 ec 0c             	sub    $0xc,%esp
8010395f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103965:	50                   	push   %eax
80103966:	e8 a5 09 00 00       	call   80104310 <wakeup>
  release(&p->lock);
8010396b:	89 34 24             	mov    %esi,(%esp)
8010396e:	e8 2d 0e 00 00       	call   801047a0 <release>
  return i;
80103973:	83 c4 10             	add    $0x10,%esp
}
80103976:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103979:	89 d8                	mov    %ebx,%eax
8010397b:	5b                   	pop    %ebx
8010397c:	5e                   	pop    %esi
8010397d:	5f                   	pop    %edi
8010397e:	5d                   	pop    %ebp
8010397f:	c3                   	ret    
      release(&p->lock);
80103980:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103983:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103988:	56                   	push   %esi
80103989:	e8 12 0e 00 00       	call   801047a0 <release>
      return -1;
8010398e:	83 c4 10             	add    $0x10,%esp
}
80103991:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103994:	89 d8                	mov    %ebx,%eax
80103996:	5b                   	pop    %ebx
80103997:	5e                   	pop    %esi
80103998:	5f                   	pop    %edi
80103999:	5d                   	pop    %ebp
8010399a:	c3                   	ret    
8010399b:	66 90                	xchg   %ax,%ax
8010399d:	66 90                	xchg   %ax,%ax
8010399f:	90                   	nop

801039a0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801039a0:	55                   	push   %ebp
801039a1:	89 e5                	mov    %esp,%ebp
801039a3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801039a4:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
{
801039a9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801039ac:	68 20 1d 11 80       	push   $0x80111d20
801039b1:	e8 5a 0e 00 00       	call   80104810 <acquire>
801039b6:	83 c4 10             	add    $0x10,%esp
801039b9:	eb 10                	jmp    801039cb <allocproc+0x2b>
801039bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801039bf:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801039c0:	83 c3 7c             	add    $0x7c,%ebx
801039c3:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
801039c9:	74 75                	je     80103a40 <allocproc+0xa0>
    if(p->state == UNUSED)
801039cb:	8b 43 0c             	mov    0xc(%ebx),%eax
801039ce:	85 c0                	test   %eax,%eax
801039d0:	75 ee                	jne    801039c0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801039d2:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
801039d7:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
801039da:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
801039e1:	89 43 10             	mov    %eax,0x10(%ebx)
801039e4:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
801039e7:	68 20 1d 11 80       	push   $0x80111d20
  p->pid = nextpid++;
801039ec:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
  release(&ptable.lock);
801039f2:	e8 a9 0d 00 00       	call   801047a0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801039f7:	e8 14 ee ff ff       	call   80102810 <kalloc>
801039fc:	83 c4 10             	add    $0x10,%esp
801039ff:	89 43 08             	mov    %eax,0x8(%ebx)
80103a02:	85 c0                	test   %eax,%eax
80103a04:	74 53                	je     80103a59 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103a06:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103a0c:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103a0f:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103a14:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103a17:	c7 40 14 d6 5b 10 80 	movl   $0x80105bd6,0x14(%eax)
  p->context = (struct context*)sp;
80103a1e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103a21:	6a 14                	push   $0x14
80103a23:	6a 00                	push   $0x0
80103a25:	50                   	push   %eax
80103a26:	e8 b5 0e 00 00       	call   801048e0 <memset>
  p->context->eip = (uint)forkret;
80103a2b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103a2e:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103a31:	c7 40 10 70 3a 10 80 	movl   $0x80103a70,0x10(%eax)
}
80103a38:	89 d8                	mov    %ebx,%eax
80103a3a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a3d:	c9                   	leave  
80103a3e:	c3                   	ret    
80103a3f:	90                   	nop
  release(&ptable.lock);
80103a40:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103a43:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103a45:	68 20 1d 11 80       	push   $0x80111d20
80103a4a:	e8 51 0d 00 00       	call   801047a0 <release>
}
80103a4f:	89 d8                	mov    %ebx,%eax
  return 0;
80103a51:	83 c4 10             	add    $0x10,%esp
}
80103a54:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a57:	c9                   	leave  
80103a58:	c3                   	ret    
    p->state = UNUSED;
80103a59:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103a60:	31 db                	xor    %ebx,%ebx
}
80103a62:	89 d8                	mov    %ebx,%eax
80103a64:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a67:	c9                   	leave  
80103a68:	c3                   	ret    
80103a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103a70 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103a70:	f3 0f 1e fb          	endbr32 
80103a74:	55                   	push   %ebp
80103a75:	89 e5                	mov    %esp,%ebp
80103a77:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103a7a:	68 20 1d 11 80       	push   $0x80111d20
80103a7f:	e8 1c 0d 00 00       	call   801047a0 <release>

  if (first) {
80103a84:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103a89:	83 c4 10             	add    $0x10,%esp
80103a8c:	85 c0                	test   %eax,%eax
80103a8e:	75 08                	jne    80103a98 <forkret+0x28>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103a90:	c9                   	leave  
80103a91:	c3                   	ret    
80103a92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    first = 0;
80103a98:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
80103a9f:	00 00 00 
    iinit(ROOTDEV);
80103aa2:	83 ec 0c             	sub    $0xc,%esp
80103aa5:	6a 01                	push   $0x1
80103aa7:	e8 f4 db ff ff       	call   801016a0 <iinit>
    initlog(ROOTDEV);
80103aac:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103ab3:	e8 b8 f3 ff ff       	call   80102e70 <initlog>
}
80103ab8:	83 c4 10             	add    $0x10,%esp
80103abb:	c9                   	leave  
80103abc:	c3                   	ret    
80103abd:	8d 76 00             	lea    0x0(%esi),%esi

80103ac0 <pinit>:
{
80103ac0:	f3 0f 1e fb          	endbr32 
80103ac4:	55                   	push   %ebp
80103ac5:	89 e5                	mov    %esp,%ebp
80103ac7:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103aca:	68 a0 7a 10 80       	push   $0x80107aa0
80103acf:	68 20 1d 11 80       	push   $0x80111d20
80103ad4:	e8 37 0b 00 00       	call   80104610 <initlock>
}
80103ad9:	83 c4 10             	add    $0x10,%esp
80103adc:	c9                   	leave  
80103add:	c3                   	ret    
80103ade:	66 90                	xchg   %ax,%ax

80103ae0 <mycpu>:
{
80103ae0:	f3 0f 1e fb          	endbr32 
80103ae4:	55                   	push   %ebp
80103ae5:	89 e5                	mov    %esp,%ebp
80103ae7:	56                   	push   %esi
80103ae8:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103ae9:	9c                   	pushf  
80103aea:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103aeb:	f6 c4 02             	test   $0x2,%ah
80103aee:	75 4a                	jne    80103b3a <mycpu+0x5a>
  apicid = lapicid();
80103af0:	e8 8b ef ff ff       	call   80102a80 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103af5:	8b 35 84 17 11 80    	mov    0x80111784,%esi
  apicid = lapicid();
80103afb:	89 c3                	mov    %eax,%ebx
  for (i = 0; i < ncpu; ++i) {
80103afd:	85 f6                	test   %esi,%esi
80103aff:	7e 2c                	jle    80103b2d <mycpu+0x4d>
80103b01:	31 c0                	xor    %eax,%eax
80103b03:	eb 0a                	jmp    80103b0f <mycpu+0x2f>
80103b05:	8d 76 00             	lea    0x0(%esi),%esi
80103b08:	83 c0 01             	add    $0x1,%eax
80103b0b:	39 f0                	cmp    %esi,%eax
80103b0d:	74 1e                	je     80103b2d <mycpu+0x4d>
    if (cpus[i].apicid == apicid)
80103b0f:	69 d0 b0 00 00 00    	imul   $0xb0,%eax,%edx
80103b15:	0f b6 8a a0 17 11 80 	movzbl -0x7feee860(%edx),%ecx
80103b1c:	39 d9                	cmp    %ebx,%ecx
80103b1e:	75 e8                	jne    80103b08 <mycpu+0x28>
}
80103b20:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
80103b23:	8d 82 a0 17 11 80    	lea    -0x7feee860(%edx),%eax
}
80103b29:	5b                   	pop    %ebx
80103b2a:	5e                   	pop    %esi
80103b2b:	5d                   	pop    %ebp
80103b2c:	c3                   	ret    
  panic("unknown apicid\n");
80103b2d:	83 ec 0c             	sub    $0xc,%esp
80103b30:	68 a7 7a 10 80       	push   $0x80107aa7
80103b35:	e8 56 c8 ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
80103b3a:	83 ec 0c             	sub    $0xc,%esp
80103b3d:	68 84 7b 10 80       	push   $0x80107b84
80103b42:	e8 49 c8 ff ff       	call   80100390 <panic>
80103b47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b4e:	66 90                	xchg   %ax,%ax

80103b50 <cpuid>:
cpuid() {
80103b50:	f3 0f 1e fb          	endbr32 
80103b54:	55                   	push   %ebp
80103b55:	89 e5                	mov    %esp,%ebp
80103b57:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103b5a:	e8 81 ff ff ff       	call   80103ae0 <mycpu>
}
80103b5f:	c9                   	leave  
  return mycpu()-cpus;
80103b60:	2d a0 17 11 80       	sub    $0x801117a0,%eax
80103b65:	c1 f8 04             	sar    $0x4,%eax
80103b68:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103b6e:	c3                   	ret    
80103b6f:	90                   	nop

80103b70 <myproc>:
myproc(void) {
80103b70:	f3 0f 1e fb          	endbr32 
80103b74:	55                   	push   %ebp
80103b75:	89 e5                	mov    %esp,%ebp
80103b77:	53                   	push   %ebx
80103b78:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103b7b:	e8 20 0b 00 00       	call   801046a0 <pushcli>
  c = mycpu();
80103b80:	e8 5b ff ff ff       	call   80103ae0 <mycpu>
  p = c->proc;
80103b85:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b8b:	e8 60 0b 00 00       	call   801046f0 <popcli>
}
80103b90:	89 d8                	mov    %ebx,%eax
80103b92:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b95:	c9                   	leave  
80103b96:	c3                   	ret    
80103b97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b9e:	66 90                	xchg   %ax,%ax

80103ba0 <userinit>:
{
80103ba0:	f3 0f 1e fb          	endbr32 
80103ba4:	55                   	push   %ebp
80103ba5:	89 e5                	mov    %esp,%ebp
80103ba7:	53                   	push   %ebx
80103ba8:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103bab:	e8 f0 fd ff ff       	call   801039a0 <allocproc>
80103bb0:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103bb2:	a3 54 3c 11 80       	mov    %eax,0x80113c54
  if((p->pgdir = setupkvm()) == 0)
80103bb7:	e8 44 36 00 00       	call   80107200 <setupkvm>
80103bbc:	89 43 04             	mov    %eax,0x4(%ebx)
80103bbf:	85 c0                	test   %eax,%eax
80103bc1:	0f 84 bd 00 00 00    	je     80103c84 <userinit+0xe4>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103bc7:	83 ec 04             	sub    $0x4,%esp
80103bca:	68 2c 00 00 00       	push   $0x2c
80103bcf:	68 60 a4 10 80       	push   $0x8010a460
80103bd4:	50                   	push   %eax
80103bd5:	e8 d6 32 00 00       	call   80106eb0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103bda:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103bdd:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103be3:	6a 4c                	push   $0x4c
80103be5:	6a 00                	push   $0x0
80103be7:	ff 73 18             	pushl  0x18(%ebx)
80103bea:	e8 f1 0c 00 00       	call   801048e0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103bef:	8b 43 18             	mov    0x18(%ebx),%eax
80103bf2:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103bf7:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103bfa:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103bff:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103c03:	8b 43 18             	mov    0x18(%ebx),%eax
80103c06:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103c0a:	8b 43 18             	mov    0x18(%ebx),%eax
80103c0d:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103c11:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103c15:	8b 43 18             	mov    0x18(%ebx),%eax
80103c18:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103c1c:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103c20:	8b 43 18             	mov    0x18(%ebx),%eax
80103c23:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103c2a:	8b 43 18             	mov    0x18(%ebx),%eax
80103c2d:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103c34:	8b 43 18             	mov    0x18(%ebx),%eax
80103c37:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103c3e:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103c41:	6a 10                	push   $0x10
80103c43:	68 d0 7a 10 80       	push   $0x80107ad0
80103c48:	50                   	push   %eax
80103c49:	e8 52 0e 00 00       	call   80104aa0 <safestrcpy>
  p->cwd = namei("/");
80103c4e:	c7 04 24 d9 7a 10 80 	movl   $0x80107ad9,(%esp)
80103c55:	e8 b6 e5 ff ff       	call   80102210 <namei>
80103c5a:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103c5d:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103c64:	e8 a7 0b 00 00       	call   80104810 <acquire>
  p->state = RUNNABLE;
80103c69:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103c70:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103c77:	e8 24 0b 00 00       	call   801047a0 <release>
}
80103c7c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103c7f:	83 c4 10             	add    $0x10,%esp
80103c82:	c9                   	leave  
80103c83:	c3                   	ret    
    panic("userinit: out of memory?");
80103c84:	83 ec 0c             	sub    $0xc,%esp
80103c87:	68 b7 7a 10 80       	push   $0x80107ab7
80103c8c:	e8 ff c6 ff ff       	call   80100390 <panic>
80103c91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c9f:	90                   	nop

80103ca0 <growproc>:
{
80103ca0:	f3 0f 1e fb          	endbr32 
80103ca4:	55                   	push   %ebp
80103ca5:	89 e5                	mov    %esp,%ebp
80103ca7:	56                   	push   %esi
80103ca8:	53                   	push   %ebx
80103ca9:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103cac:	e8 ef 09 00 00       	call   801046a0 <pushcli>
  c = mycpu();
80103cb1:	e8 2a fe ff ff       	call   80103ae0 <mycpu>
  p = c->proc;
80103cb6:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103cbc:	e8 2f 0a 00 00       	call   801046f0 <popcli>
  sz = curproc->sz;
80103cc1:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103cc3:	85 f6                	test   %esi,%esi
80103cc5:	7f 19                	jg     80103ce0 <growproc+0x40>
  } else if(n < 0){
80103cc7:	75 37                	jne    80103d00 <growproc+0x60>
  switchuvm(curproc);
80103cc9:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103ccc:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103cce:	53                   	push   %ebx
80103ccf:	e8 cc 30 00 00       	call   80106da0 <switchuvm>
  return 0;
80103cd4:	83 c4 10             	add    $0x10,%esp
80103cd7:	31 c0                	xor    %eax,%eax
}
80103cd9:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103cdc:	5b                   	pop    %ebx
80103cdd:	5e                   	pop    %esi
80103cde:	5d                   	pop    %ebp
80103cdf:	c3                   	ret    
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103ce0:	83 ec 04             	sub    $0x4,%esp
80103ce3:	01 c6                	add    %eax,%esi
80103ce5:	56                   	push   %esi
80103ce6:	50                   	push   %eax
80103ce7:	ff 73 04             	pushl  0x4(%ebx)
80103cea:	e8 31 33 00 00       	call   80107020 <allocuvm>
80103cef:	83 c4 10             	add    $0x10,%esp
80103cf2:	85 c0                	test   %eax,%eax
80103cf4:	75 d3                	jne    80103cc9 <growproc+0x29>
      return -1;
80103cf6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103cfb:	eb dc                	jmp    80103cd9 <growproc+0x39>
80103cfd:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103d00:	83 ec 04             	sub    $0x4,%esp
80103d03:	01 c6                	add    %eax,%esi
80103d05:	56                   	push   %esi
80103d06:	50                   	push   %eax
80103d07:	ff 73 04             	pushl  0x4(%ebx)
80103d0a:	e8 41 34 00 00       	call   80107150 <deallocuvm>
80103d0f:	83 c4 10             	add    $0x10,%esp
80103d12:	85 c0                	test   %eax,%eax
80103d14:	75 b3                	jne    80103cc9 <growproc+0x29>
80103d16:	eb de                	jmp    80103cf6 <growproc+0x56>
80103d18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d1f:	90                   	nop

80103d20 <fork>:
{
80103d20:	f3 0f 1e fb          	endbr32 
80103d24:	55                   	push   %ebp
80103d25:	89 e5                	mov    %esp,%ebp
80103d27:	57                   	push   %edi
80103d28:	56                   	push   %esi
80103d29:	53                   	push   %ebx
80103d2a:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103d2d:	e8 6e 09 00 00       	call   801046a0 <pushcli>
  c = mycpu();
80103d32:	e8 a9 fd ff ff       	call   80103ae0 <mycpu>
  p = c->proc;
80103d37:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d3d:	e8 ae 09 00 00       	call   801046f0 <popcli>
  if((np = allocproc()) == 0){
80103d42:	e8 59 fc ff ff       	call   801039a0 <allocproc>
80103d47:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103d4a:	85 c0                	test   %eax,%eax
80103d4c:	0f 84 bb 00 00 00    	je     80103e0d <fork+0xed>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103d52:	83 ec 08             	sub    $0x8,%esp
80103d55:	ff 33                	pushl  (%ebx)
80103d57:	89 c7                	mov    %eax,%edi
80103d59:	ff 73 04             	pushl  0x4(%ebx)
80103d5c:	e8 8f 35 00 00       	call   801072f0 <copyuvm>
80103d61:	83 c4 10             	add    $0x10,%esp
80103d64:	89 47 04             	mov    %eax,0x4(%edi)
80103d67:	85 c0                	test   %eax,%eax
80103d69:	0f 84 a5 00 00 00    	je     80103e14 <fork+0xf4>
  np->sz = curproc->sz;
80103d6f:	8b 03                	mov    (%ebx),%eax
80103d71:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103d74:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80103d76:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80103d79:	89 c8                	mov    %ecx,%eax
80103d7b:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103d7e:	b9 13 00 00 00       	mov    $0x13,%ecx
80103d83:	8b 73 18             	mov    0x18(%ebx),%esi
80103d86:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103d88:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103d8a:	8b 40 18             	mov    0x18(%eax),%eax
80103d8d:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
80103d94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[i])
80103d98:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103d9c:	85 c0                	test   %eax,%eax
80103d9e:	74 13                	je     80103db3 <fork+0x93>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103da0:	83 ec 0c             	sub    $0xc,%esp
80103da3:	50                   	push   %eax
80103da4:	e8 27 d2 ff ff       	call   80100fd0 <filedup>
80103da9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103dac:	83 c4 10             	add    $0x10,%esp
80103daf:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103db3:	83 c6 01             	add    $0x1,%esi
80103db6:	83 fe 10             	cmp    $0x10,%esi
80103db9:	75 dd                	jne    80103d98 <fork+0x78>
  np->cwd = idup(curproc->cwd);
80103dbb:	83 ec 0c             	sub    $0xc,%esp
80103dbe:	ff 73 68             	pushl  0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103dc1:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103dc4:	e8 d7 da ff ff       	call   801018a0 <idup>
80103dc9:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103dcc:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103dcf:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103dd2:	8d 47 6c             	lea    0x6c(%edi),%eax
80103dd5:	6a 10                	push   $0x10
80103dd7:	53                   	push   %ebx
80103dd8:	50                   	push   %eax
80103dd9:	e8 c2 0c 00 00       	call   80104aa0 <safestrcpy>
  pid = np->pid;
80103dde:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103de1:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103de8:	e8 23 0a 00 00       	call   80104810 <acquire>
  np->state = RUNNABLE;
80103ded:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103df4:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103dfb:	e8 a0 09 00 00       	call   801047a0 <release>
  return pid;
80103e00:	83 c4 10             	add    $0x10,%esp
}
80103e03:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103e06:	89 d8                	mov    %ebx,%eax
80103e08:	5b                   	pop    %ebx
80103e09:	5e                   	pop    %esi
80103e0a:	5f                   	pop    %edi
80103e0b:	5d                   	pop    %ebp
80103e0c:	c3                   	ret    
    return -1;
80103e0d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103e12:	eb ef                	jmp    80103e03 <fork+0xe3>
    kfree(np->kstack);
80103e14:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103e17:	83 ec 0c             	sub    $0xc,%esp
80103e1a:	ff 73 08             	pushl  0x8(%ebx)
80103e1d:	e8 2e e8 ff ff       	call   80102650 <kfree>
    np->kstack = 0;
80103e22:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80103e29:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103e2c:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103e33:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103e38:	eb c9                	jmp    80103e03 <fork+0xe3>
80103e3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103e40 <scheduler>:
{
80103e40:	f3 0f 1e fb          	endbr32 
80103e44:	55                   	push   %ebp
80103e45:	89 e5                	mov    %esp,%ebp
80103e47:	57                   	push   %edi
80103e48:	56                   	push   %esi
80103e49:	53                   	push   %ebx
80103e4a:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103e4d:	e8 8e fc ff ff       	call   80103ae0 <mycpu>
  c->proc = 0;
80103e52:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103e59:	00 00 00 
  struct cpu *c = mycpu();
80103e5c:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103e5e:	8d 78 04             	lea    0x4(%eax),%edi
80103e61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("sti");
80103e68:	fb                   	sti    
    acquire(&ptable.lock);
80103e69:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e6c:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
    acquire(&ptable.lock);
80103e71:	68 20 1d 11 80       	push   $0x80111d20
80103e76:	e8 95 09 00 00       	call   80104810 <acquire>
80103e7b:	83 c4 10             	add    $0x10,%esp
80103e7e:	66 90                	xchg   %ax,%ax
      if(p->state != RUNNABLE)
80103e80:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103e84:	75 33                	jne    80103eb9 <scheduler+0x79>
      switchuvm(p);
80103e86:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103e89:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103e8f:	53                   	push   %ebx
80103e90:	e8 0b 2f 00 00       	call   80106da0 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103e95:	58                   	pop    %eax
80103e96:	5a                   	pop    %edx
80103e97:	ff 73 1c             	pushl  0x1c(%ebx)
80103e9a:	57                   	push   %edi
      p->state = RUNNING;
80103e9b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103ea2:	e8 5c 0c 00 00       	call   80104b03 <swtch>
      switchkvm();
80103ea7:	e8 d4 2e 00 00       	call   80106d80 <switchkvm>
      c->proc = 0;
80103eac:	83 c4 10             	add    $0x10,%esp
80103eaf:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103eb6:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103eb9:	83 c3 7c             	add    $0x7c,%ebx
80103ebc:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
80103ec2:	75 bc                	jne    80103e80 <scheduler+0x40>
    release(&ptable.lock);
80103ec4:	83 ec 0c             	sub    $0xc,%esp
80103ec7:	68 20 1d 11 80       	push   $0x80111d20
80103ecc:	e8 cf 08 00 00       	call   801047a0 <release>
    sti();
80103ed1:	83 c4 10             	add    $0x10,%esp
80103ed4:	eb 92                	jmp    80103e68 <scheduler+0x28>
80103ed6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103edd:	8d 76 00             	lea    0x0(%esi),%esi

80103ee0 <sched>:
{
80103ee0:	f3 0f 1e fb          	endbr32 
80103ee4:	55                   	push   %ebp
80103ee5:	89 e5                	mov    %esp,%ebp
80103ee7:	56                   	push   %esi
80103ee8:	53                   	push   %ebx
  pushcli();
80103ee9:	e8 b2 07 00 00       	call   801046a0 <pushcli>
  c = mycpu();
80103eee:	e8 ed fb ff ff       	call   80103ae0 <mycpu>
  p = c->proc;
80103ef3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ef9:	e8 f2 07 00 00       	call   801046f0 <popcli>
  if(!holding(&ptable.lock))
80103efe:	83 ec 0c             	sub    $0xc,%esp
80103f01:	68 20 1d 11 80       	push   $0x80111d20
80103f06:	e8 45 08 00 00       	call   80104750 <holding>
80103f0b:	83 c4 10             	add    $0x10,%esp
80103f0e:	85 c0                	test   %eax,%eax
80103f10:	74 4f                	je     80103f61 <sched+0x81>
  if(mycpu()->ncli != 1)
80103f12:	e8 c9 fb ff ff       	call   80103ae0 <mycpu>
80103f17:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103f1e:	75 68                	jne    80103f88 <sched+0xa8>
  if(p->state == RUNNING)
80103f20:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103f24:	74 55                	je     80103f7b <sched+0x9b>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103f26:	9c                   	pushf  
80103f27:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103f28:	f6 c4 02             	test   $0x2,%ah
80103f2b:	75 41                	jne    80103f6e <sched+0x8e>
  intena = mycpu()->intena;
80103f2d:	e8 ae fb ff ff       	call   80103ae0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103f32:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103f35:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103f3b:	e8 a0 fb ff ff       	call   80103ae0 <mycpu>
80103f40:	83 ec 08             	sub    $0x8,%esp
80103f43:	ff 70 04             	pushl  0x4(%eax)
80103f46:	53                   	push   %ebx
80103f47:	e8 b7 0b 00 00       	call   80104b03 <swtch>
  mycpu()->intena = intena;
80103f4c:	e8 8f fb ff ff       	call   80103ae0 <mycpu>
}
80103f51:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103f54:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103f5a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103f5d:	5b                   	pop    %ebx
80103f5e:	5e                   	pop    %esi
80103f5f:	5d                   	pop    %ebp
80103f60:	c3                   	ret    
    panic("sched ptable.lock");
80103f61:	83 ec 0c             	sub    $0xc,%esp
80103f64:	68 db 7a 10 80       	push   $0x80107adb
80103f69:	e8 22 c4 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103f6e:	83 ec 0c             	sub    $0xc,%esp
80103f71:	68 07 7b 10 80       	push   $0x80107b07
80103f76:	e8 15 c4 ff ff       	call   80100390 <panic>
    panic("sched running");
80103f7b:	83 ec 0c             	sub    $0xc,%esp
80103f7e:	68 f9 7a 10 80       	push   $0x80107af9
80103f83:	e8 08 c4 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103f88:	83 ec 0c             	sub    $0xc,%esp
80103f8b:	68 ed 7a 10 80       	push   $0x80107aed
80103f90:	e8 fb c3 ff ff       	call   80100390 <panic>
80103f95:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103fa0 <exit>:
{
80103fa0:	f3 0f 1e fb          	endbr32 
80103fa4:	55                   	push   %ebp
80103fa5:	89 e5                	mov    %esp,%ebp
80103fa7:	57                   	push   %edi
80103fa8:	56                   	push   %esi
80103fa9:	53                   	push   %ebx
80103faa:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80103fad:	e8 be fb ff ff       	call   80103b70 <myproc>
  if(curproc == initproc)
80103fb2:	39 05 54 3c 11 80    	cmp    %eax,0x80113c54
80103fb8:	0f 84 f9 00 00 00    	je     801040b7 <exit+0x117>
80103fbe:	89 c3                	mov    %eax,%ebx
80103fc0:	8d 70 28             	lea    0x28(%eax),%esi
80103fc3:	8d 78 68             	lea    0x68(%eax),%edi
80103fc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103fcd:	8d 76 00             	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80103fd0:	8b 06                	mov    (%esi),%eax
80103fd2:	85 c0                	test   %eax,%eax
80103fd4:	74 12                	je     80103fe8 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103fd6:	83 ec 0c             	sub    $0xc,%esp
80103fd9:	50                   	push   %eax
80103fda:	e8 41 d0 ff ff       	call   80101020 <fileclose>
      curproc->ofile[fd] = 0;
80103fdf:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103fe5:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80103fe8:	83 c6 04             	add    $0x4,%esi
80103feb:	39 f7                	cmp    %esi,%edi
80103fed:	75 e1                	jne    80103fd0 <exit+0x30>
  begin_op();
80103fef:	e8 1c ef ff ff       	call   80102f10 <begin_op>
  iput(curproc->cwd);
80103ff4:	83 ec 0c             	sub    $0xc,%esp
80103ff7:	ff 73 68             	pushl  0x68(%ebx)
80103ffa:	e8 01 da ff ff       	call   80101a00 <iput>
  end_op();
80103fff:	e8 7c ef ff ff       	call   80102f80 <end_op>
  curproc->cwd = 0;
80104004:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
8010400b:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80104012:	e8 f9 07 00 00       	call   80104810 <acquire>
  wakeup1(curproc->parent);
80104017:	8b 53 14             	mov    0x14(%ebx),%edx
8010401a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010401d:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
80104022:	eb 0e                	jmp    80104032 <exit+0x92>
80104024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104028:	83 c0 7c             	add    $0x7c,%eax
8010402b:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80104030:	74 1c                	je     8010404e <exit+0xae>
    if(p->state == SLEEPING && p->chan == chan)
80104032:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104036:	75 f0                	jne    80104028 <exit+0x88>
80104038:	3b 50 20             	cmp    0x20(%eax),%edx
8010403b:	75 eb                	jne    80104028 <exit+0x88>
      p->state = RUNNABLE;
8010403d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104044:	83 c0 7c             	add    $0x7c,%eax
80104047:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
8010404c:	75 e4                	jne    80104032 <exit+0x92>
      p->parent = initproc;
8010404e:	8b 0d 54 3c 11 80    	mov    0x80113c54,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104054:	ba 54 1d 11 80       	mov    $0x80111d54,%edx
80104059:	eb 10                	jmp    8010406b <exit+0xcb>
8010405b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010405f:	90                   	nop
80104060:	83 c2 7c             	add    $0x7c,%edx
80104063:	81 fa 54 3c 11 80    	cmp    $0x80113c54,%edx
80104069:	74 33                	je     8010409e <exit+0xfe>
    if(p->parent == curproc){
8010406b:	39 5a 14             	cmp    %ebx,0x14(%edx)
8010406e:	75 f0                	jne    80104060 <exit+0xc0>
      if(p->state == ZOMBIE)
80104070:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80104074:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80104077:	75 e7                	jne    80104060 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104079:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
8010407e:	eb 0a                	jmp    8010408a <exit+0xea>
80104080:	83 c0 7c             	add    $0x7c,%eax
80104083:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80104088:	74 d6                	je     80104060 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
8010408a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010408e:	75 f0                	jne    80104080 <exit+0xe0>
80104090:	3b 48 20             	cmp    0x20(%eax),%ecx
80104093:	75 eb                	jne    80104080 <exit+0xe0>
      p->state = RUNNABLE;
80104095:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010409c:	eb e2                	jmp    80104080 <exit+0xe0>
  curproc->state = ZOMBIE;
8010409e:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
801040a5:	e8 36 fe ff ff       	call   80103ee0 <sched>
  panic("zombie exit");
801040aa:	83 ec 0c             	sub    $0xc,%esp
801040ad:	68 28 7b 10 80       	push   $0x80107b28
801040b2:	e8 d9 c2 ff ff       	call   80100390 <panic>
    panic("init exiting");
801040b7:	83 ec 0c             	sub    $0xc,%esp
801040ba:	68 1b 7b 10 80       	push   $0x80107b1b
801040bf:	e8 cc c2 ff ff       	call   80100390 <panic>
801040c4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801040cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801040cf:	90                   	nop

801040d0 <wait>:
{
801040d0:	f3 0f 1e fb          	endbr32 
801040d4:	55                   	push   %ebp
801040d5:	89 e5                	mov    %esp,%ebp
801040d7:	56                   	push   %esi
801040d8:	53                   	push   %ebx
  pushcli();
801040d9:	e8 c2 05 00 00       	call   801046a0 <pushcli>
  c = mycpu();
801040de:	e8 fd f9 ff ff       	call   80103ae0 <mycpu>
  p = c->proc;
801040e3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801040e9:	e8 02 06 00 00       	call   801046f0 <popcli>
  acquire(&ptable.lock);
801040ee:	83 ec 0c             	sub    $0xc,%esp
801040f1:	68 20 1d 11 80       	push   $0x80111d20
801040f6:	e8 15 07 00 00       	call   80104810 <acquire>
801040fb:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
801040fe:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104100:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
80104105:	eb 14                	jmp    8010411b <wait+0x4b>
80104107:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010410e:	66 90                	xchg   %ax,%ax
80104110:	83 c3 7c             	add    $0x7c,%ebx
80104113:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
80104119:	74 1b                	je     80104136 <wait+0x66>
      if(p->parent != curproc)
8010411b:	39 73 14             	cmp    %esi,0x14(%ebx)
8010411e:	75 f0                	jne    80104110 <wait+0x40>
      if(p->state == ZOMBIE){
80104120:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104124:	74 5a                	je     80104180 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104126:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
80104129:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010412e:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
80104134:	75 e5                	jne    8010411b <wait+0x4b>
    if(!havekids || curproc->killed){
80104136:	85 c0                	test   %eax,%eax
80104138:	0f 84 98 00 00 00    	je     801041d6 <wait+0x106>
8010413e:	8b 46 24             	mov    0x24(%esi),%eax
80104141:	85 c0                	test   %eax,%eax
80104143:	0f 85 8d 00 00 00    	jne    801041d6 <wait+0x106>
  pushcli();
80104149:	e8 52 05 00 00       	call   801046a0 <pushcli>
  c = mycpu();
8010414e:	e8 8d f9 ff ff       	call   80103ae0 <mycpu>
  p = c->proc;
80104153:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104159:	e8 92 05 00 00       	call   801046f0 <popcli>
  if(p == 0)
8010415e:	85 db                	test   %ebx,%ebx
80104160:	0f 84 87 00 00 00    	je     801041ed <wait+0x11d>
  p->chan = chan;
80104166:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80104169:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104170:	e8 6b fd ff ff       	call   80103ee0 <sched>
  p->chan = 0;
80104175:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010417c:	eb 80                	jmp    801040fe <wait+0x2e>
8010417e:	66 90                	xchg   %ax,%ax
        kfree(p->kstack);
80104180:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80104183:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104186:	ff 73 08             	pushl  0x8(%ebx)
80104189:	e8 c2 e4 ff ff       	call   80102650 <kfree>
        p->kstack = 0;
8010418e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104195:	5a                   	pop    %edx
80104196:	ff 73 04             	pushl  0x4(%ebx)
80104199:	e8 e2 2f 00 00       	call   80107180 <freevm>
        p->pid = 0;
8010419e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801041a5:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801041ac:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801041b0:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801041b7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801041be:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
801041c5:	e8 d6 05 00 00       	call   801047a0 <release>
        return pid;
801041ca:	83 c4 10             	add    $0x10,%esp
}
801041cd:	8d 65 f8             	lea    -0x8(%ebp),%esp
801041d0:	89 f0                	mov    %esi,%eax
801041d2:	5b                   	pop    %ebx
801041d3:	5e                   	pop    %esi
801041d4:	5d                   	pop    %ebp
801041d5:	c3                   	ret    
      release(&ptable.lock);
801041d6:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801041d9:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
801041de:	68 20 1d 11 80       	push   $0x80111d20
801041e3:	e8 b8 05 00 00       	call   801047a0 <release>
      return -1;
801041e8:	83 c4 10             	add    $0x10,%esp
801041eb:	eb e0                	jmp    801041cd <wait+0xfd>
    panic("sleep");
801041ed:	83 ec 0c             	sub    $0xc,%esp
801041f0:	68 34 7b 10 80       	push   $0x80107b34
801041f5:	e8 96 c1 ff ff       	call   80100390 <panic>
801041fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104200 <yield>:
{
80104200:	f3 0f 1e fb          	endbr32 
80104204:	55                   	push   %ebp
80104205:	89 e5                	mov    %esp,%ebp
80104207:	53                   	push   %ebx
80104208:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
8010420b:	68 20 1d 11 80       	push   $0x80111d20
80104210:	e8 fb 05 00 00       	call   80104810 <acquire>
  pushcli();
80104215:	e8 86 04 00 00       	call   801046a0 <pushcli>
  c = mycpu();
8010421a:	e8 c1 f8 ff ff       	call   80103ae0 <mycpu>
  p = c->proc;
8010421f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104225:	e8 c6 04 00 00       	call   801046f0 <popcli>
  myproc()->state = RUNNABLE;
8010422a:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80104231:	e8 aa fc ff ff       	call   80103ee0 <sched>
  release(&ptable.lock);
80104236:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
8010423d:	e8 5e 05 00 00       	call   801047a0 <release>
}
80104242:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104245:	83 c4 10             	add    $0x10,%esp
80104248:	c9                   	leave  
80104249:	c3                   	ret    
8010424a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104250 <sleep>:
{
80104250:	f3 0f 1e fb          	endbr32 
80104254:	55                   	push   %ebp
80104255:	89 e5                	mov    %esp,%ebp
80104257:	57                   	push   %edi
80104258:	56                   	push   %esi
80104259:	53                   	push   %ebx
8010425a:	83 ec 0c             	sub    $0xc,%esp
8010425d:	8b 7d 08             	mov    0x8(%ebp),%edi
80104260:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80104263:	e8 38 04 00 00       	call   801046a0 <pushcli>
  c = mycpu();
80104268:	e8 73 f8 ff ff       	call   80103ae0 <mycpu>
  p = c->proc;
8010426d:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104273:	e8 78 04 00 00       	call   801046f0 <popcli>
  if(p == 0)
80104278:	85 db                	test   %ebx,%ebx
8010427a:	0f 84 83 00 00 00    	je     80104303 <sleep+0xb3>
  if(lk == 0)
80104280:	85 f6                	test   %esi,%esi
80104282:	74 72                	je     801042f6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104284:	81 fe 20 1d 11 80    	cmp    $0x80111d20,%esi
8010428a:	74 4c                	je     801042d8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
8010428c:	83 ec 0c             	sub    $0xc,%esp
8010428f:	68 20 1d 11 80       	push   $0x80111d20
80104294:	e8 77 05 00 00       	call   80104810 <acquire>
    release(lk);
80104299:	89 34 24             	mov    %esi,(%esp)
8010429c:	e8 ff 04 00 00       	call   801047a0 <release>
  p->chan = chan;
801042a1:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801042a4:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801042ab:	e8 30 fc ff ff       	call   80103ee0 <sched>
  p->chan = 0;
801042b0:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
801042b7:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
801042be:	e8 dd 04 00 00       	call   801047a0 <release>
    acquire(lk);
801042c3:	89 75 08             	mov    %esi,0x8(%ebp)
801042c6:	83 c4 10             	add    $0x10,%esp
}
801042c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801042cc:	5b                   	pop    %ebx
801042cd:	5e                   	pop    %esi
801042ce:	5f                   	pop    %edi
801042cf:	5d                   	pop    %ebp
    acquire(lk);
801042d0:	e9 3b 05 00 00       	jmp    80104810 <acquire>
801042d5:	8d 76 00             	lea    0x0(%esi),%esi
  p->chan = chan;
801042d8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801042db:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801042e2:	e8 f9 fb ff ff       	call   80103ee0 <sched>
  p->chan = 0;
801042e7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801042ee:	8d 65 f4             	lea    -0xc(%ebp),%esp
801042f1:	5b                   	pop    %ebx
801042f2:	5e                   	pop    %esi
801042f3:	5f                   	pop    %edi
801042f4:	5d                   	pop    %ebp
801042f5:	c3                   	ret    
    panic("sleep without lk");
801042f6:	83 ec 0c             	sub    $0xc,%esp
801042f9:	68 3a 7b 10 80       	push   $0x80107b3a
801042fe:	e8 8d c0 ff ff       	call   80100390 <panic>
    panic("sleep");
80104303:	83 ec 0c             	sub    $0xc,%esp
80104306:	68 34 7b 10 80       	push   $0x80107b34
8010430b:	e8 80 c0 ff ff       	call   80100390 <panic>

80104310 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104310:	f3 0f 1e fb          	endbr32 
80104314:	55                   	push   %ebp
80104315:	89 e5                	mov    %esp,%ebp
80104317:	53                   	push   %ebx
80104318:	83 ec 10             	sub    $0x10,%esp
8010431b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010431e:	68 20 1d 11 80       	push   $0x80111d20
80104323:	e8 e8 04 00 00       	call   80104810 <acquire>
80104328:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010432b:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
80104330:	eb 10                	jmp    80104342 <wakeup+0x32>
80104332:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104338:	83 c0 7c             	add    $0x7c,%eax
8010433b:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80104340:	74 1c                	je     8010435e <wakeup+0x4e>
    if(p->state == SLEEPING && p->chan == chan)
80104342:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104346:	75 f0                	jne    80104338 <wakeup+0x28>
80104348:	3b 58 20             	cmp    0x20(%eax),%ebx
8010434b:	75 eb                	jne    80104338 <wakeup+0x28>
      p->state = RUNNABLE;
8010434d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104354:	83 c0 7c             	add    $0x7c,%eax
80104357:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
8010435c:	75 e4                	jne    80104342 <wakeup+0x32>
  wakeup1(chan);
  release(&ptable.lock);
8010435e:	c7 45 08 20 1d 11 80 	movl   $0x80111d20,0x8(%ebp)
}
80104365:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104368:	c9                   	leave  
  release(&ptable.lock);
80104369:	e9 32 04 00 00       	jmp    801047a0 <release>
8010436e:	66 90                	xchg   %ax,%ax

80104370 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104370:	f3 0f 1e fb          	endbr32 
80104374:	55                   	push   %ebp
80104375:	89 e5                	mov    %esp,%ebp
80104377:	53                   	push   %ebx
80104378:	83 ec 10             	sub    $0x10,%esp
8010437b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010437e:	68 20 1d 11 80       	push   $0x80111d20
80104383:	e8 88 04 00 00       	call   80104810 <acquire>
80104388:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010438b:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
80104390:	eb 10                	jmp    801043a2 <kill+0x32>
80104392:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104398:	83 c0 7c             	add    $0x7c,%eax
8010439b:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
801043a0:	74 36                	je     801043d8 <kill+0x68>
    if(p->pid == pid){
801043a2:	39 58 10             	cmp    %ebx,0x10(%eax)
801043a5:	75 f1                	jne    80104398 <kill+0x28>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801043a7:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
801043ab:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
801043b2:	75 07                	jne    801043bb <kill+0x4b>
        p->state = RUNNABLE;
801043b4:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801043bb:	83 ec 0c             	sub    $0xc,%esp
801043be:	68 20 1d 11 80       	push   $0x80111d20
801043c3:	e8 d8 03 00 00       	call   801047a0 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
801043c8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
801043cb:	83 c4 10             	add    $0x10,%esp
801043ce:	31 c0                	xor    %eax,%eax
}
801043d0:	c9                   	leave  
801043d1:	c3                   	ret    
801043d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
801043d8:	83 ec 0c             	sub    $0xc,%esp
801043db:	68 20 1d 11 80       	push   $0x80111d20
801043e0:	e8 bb 03 00 00       	call   801047a0 <release>
}
801043e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801043e8:	83 c4 10             	add    $0x10,%esp
801043eb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801043f0:	c9                   	leave  
801043f1:	c3                   	ret    
801043f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104400 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104400:	f3 0f 1e fb          	endbr32 
80104404:	55                   	push   %ebp
80104405:	89 e5                	mov    %esp,%ebp
80104407:	57                   	push   %edi
80104408:	56                   	push   %esi
80104409:	8d 75 e8             	lea    -0x18(%ebp),%esi
8010440c:	53                   	push   %ebx
8010440d:	bb c0 1d 11 80       	mov    $0x80111dc0,%ebx
80104412:	83 ec 3c             	sub    $0x3c,%esp
80104415:	eb 28                	jmp    8010443f <procdump+0x3f>
80104417:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010441e:	66 90                	xchg   %ax,%ax
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104420:	83 ec 0c             	sub    $0xc,%esp
80104423:	68 bb 7e 10 80       	push   $0x80107ebb
80104428:	e8 63 c2 ff ff       	call   80100690 <cprintf>
8010442d:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104430:	83 c3 7c             	add    $0x7c,%ebx
80104433:	81 fb c0 3c 11 80    	cmp    $0x80113cc0,%ebx
80104439:	0f 84 81 00 00 00    	je     801044c0 <procdump+0xc0>
    if(p->state == UNUSED)
8010443f:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104442:	85 c0                	test   %eax,%eax
80104444:	74 ea                	je     80104430 <procdump+0x30>
      state = "???";
80104446:	ba 4b 7b 10 80       	mov    $0x80107b4b,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010444b:	83 f8 05             	cmp    $0x5,%eax
8010444e:	77 11                	ja     80104461 <procdump+0x61>
80104450:	8b 14 85 ac 7b 10 80 	mov    -0x7fef8454(,%eax,4),%edx
      state = "???";
80104457:	b8 4b 7b 10 80       	mov    $0x80107b4b,%eax
8010445c:	85 d2                	test   %edx,%edx
8010445e:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104461:	53                   	push   %ebx
80104462:	52                   	push   %edx
80104463:	ff 73 a4             	pushl  -0x5c(%ebx)
80104466:	68 4f 7b 10 80       	push   $0x80107b4f
8010446b:	e8 20 c2 ff ff       	call   80100690 <cprintf>
    if(p->state == SLEEPING){
80104470:	83 c4 10             	add    $0x10,%esp
80104473:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104477:	75 a7                	jne    80104420 <procdump+0x20>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104479:	83 ec 08             	sub    $0x8,%esp
8010447c:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010447f:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104482:	50                   	push   %eax
80104483:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104486:	8b 40 0c             	mov    0xc(%eax),%eax
80104489:	83 c0 08             	add    $0x8,%eax
8010448c:	50                   	push   %eax
8010448d:	e8 9e 01 00 00       	call   80104630 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
80104492:	83 c4 10             	add    $0x10,%esp
80104495:	8d 76 00             	lea    0x0(%esi),%esi
80104498:	8b 17                	mov    (%edi),%edx
8010449a:	85 d2                	test   %edx,%edx
8010449c:	74 82                	je     80104420 <procdump+0x20>
        cprintf(" %p", pc[i]);
8010449e:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
801044a1:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
801044a4:	52                   	push   %edx
801044a5:	68 a1 75 10 80       	push   $0x801075a1
801044aa:	e8 e1 c1 ff ff       	call   80100690 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801044af:	83 c4 10             	add    $0x10,%esp
801044b2:	39 fe                	cmp    %edi,%esi
801044b4:	75 e2                	jne    80104498 <procdump+0x98>
801044b6:	e9 65 ff ff ff       	jmp    80104420 <procdump+0x20>
801044bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801044bf:	90                   	nop
  }
}
801044c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801044c3:	5b                   	pop    %ebx
801044c4:	5e                   	pop    %esi
801044c5:	5f                   	pop    %edi
801044c6:	5d                   	pop    %ebp
801044c7:	c3                   	ret    
801044c8:	66 90                	xchg   %ax,%ax
801044ca:	66 90                	xchg   %ax,%ax
801044cc:	66 90                	xchg   %ax,%ax
801044ce:	66 90                	xchg   %ax,%ax

801044d0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801044d0:	f3 0f 1e fb          	endbr32 
801044d4:	55                   	push   %ebp
801044d5:	89 e5                	mov    %esp,%ebp
801044d7:	53                   	push   %ebx
801044d8:	83 ec 0c             	sub    $0xc,%esp
801044db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801044de:	68 c4 7b 10 80       	push   $0x80107bc4
801044e3:	8d 43 04             	lea    0x4(%ebx),%eax
801044e6:	50                   	push   %eax
801044e7:	e8 24 01 00 00       	call   80104610 <initlock>
  lk->name = name;
801044ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801044ef:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801044f5:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801044f8:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801044ff:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104502:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104505:	c9                   	leave  
80104506:	c3                   	ret    
80104507:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010450e:	66 90                	xchg   %ax,%ax

80104510 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104510:	f3 0f 1e fb          	endbr32 
80104514:	55                   	push   %ebp
80104515:	89 e5                	mov    %esp,%ebp
80104517:	56                   	push   %esi
80104518:	53                   	push   %ebx
80104519:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
8010451c:	8d 73 04             	lea    0x4(%ebx),%esi
8010451f:	83 ec 0c             	sub    $0xc,%esp
80104522:	56                   	push   %esi
80104523:	e8 e8 02 00 00       	call   80104810 <acquire>
  while (lk->locked) {
80104528:	8b 13                	mov    (%ebx),%edx
8010452a:	83 c4 10             	add    $0x10,%esp
8010452d:	85 d2                	test   %edx,%edx
8010452f:	74 1a                	je     8010454b <acquiresleep+0x3b>
80104531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
80104538:	83 ec 08             	sub    $0x8,%esp
8010453b:	56                   	push   %esi
8010453c:	53                   	push   %ebx
8010453d:	e8 0e fd ff ff       	call   80104250 <sleep>
  while (lk->locked) {
80104542:	8b 03                	mov    (%ebx),%eax
80104544:	83 c4 10             	add    $0x10,%esp
80104547:	85 c0                	test   %eax,%eax
80104549:	75 ed                	jne    80104538 <acquiresleep+0x28>
  }
  lk->locked = 1;
8010454b:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104551:	e8 1a f6 ff ff       	call   80103b70 <myproc>
80104556:	8b 40 10             	mov    0x10(%eax),%eax
80104559:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
8010455c:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010455f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104562:	5b                   	pop    %ebx
80104563:	5e                   	pop    %esi
80104564:	5d                   	pop    %ebp
  release(&lk->lk);
80104565:	e9 36 02 00 00       	jmp    801047a0 <release>
8010456a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104570 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104570:	f3 0f 1e fb          	endbr32 
80104574:	55                   	push   %ebp
80104575:	89 e5                	mov    %esp,%ebp
80104577:	56                   	push   %esi
80104578:	53                   	push   %ebx
80104579:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
8010457c:	8d 73 04             	lea    0x4(%ebx),%esi
8010457f:	83 ec 0c             	sub    $0xc,%esp
80104582:	56                   	push   %esi
80104583:	e8 88 02 00 00       	call   80104810 <acquire>
  lk->locked = 0;
80104588:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010458e:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104595:	89 1c 24             	mov    %ebx,(%esp)
80104598:	e8 73 fd ff ff       	call   80104310 <wakeup>
  release(&lk->lk);
8010459d:	89 75 08             	mov    %esi,0x8(%ebp)
801045a0:	83 c4 10             	add    $0x10,%esp
}
801045a3:	8d 65 f8             	lea    -0x8(%ebp),%esp
801045a6:	5b                   	pop    %ebx
801045a7:	5e                   	pop    %esi
801045a8:	5d                   	pop    %ebp
  release(&lk->lk);
801045a9:	e9 f2 01 00 00       	jmp    801047a0 <release>
801045ae:	66 90                	xchg   %ax,%ax

801045b0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801045b0:	f3 0f 1e fb          	endbr32 
801045b4:	55                   	push   %ebp
801045b5:	89 e5                	mov    %esp,%ebp
801045b7:	57                   	push   %edi
801045b8:	31 ff                	xor    %edi,%edi
801045ba:	56                   	push   %esi
801045bb:	53                   	push   %ebx
801045bc:	83 ec 18             	sub    $0x18,%esp
801045bf:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
801045c2:	8d 73 04             	lea    0x4(%ebx),%esi
801045c5:	56                   	push   %esi
801045c6:	e8 45 02 00 00       	call   80104810 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801045cb:	8b 03                	mov    (%ebx),%eax
801045cd:	83 c4 10             	add    $0x10,%esp
801045d0:	85 c0                	test   %eax,%eax
801045d2:	75 1c                	jne    801045f0 <holdingsleep+0x40>
  release(&lk->lk);
801045d4:	83 ec 0c             	sub    $0xc,%esp
801045d7:	56                   	push   %esi
801045d8:	e8 c3 01 00 00       	call   801047a0 <release>
  return r;
}
801045dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801045e0:	89 f8                	mov    %edi,%eax
801045e2:	5b                   	pop    %ebx
801045e3:	5e                   	pop    %esi
801045e4:	5f                   	pop    %edi
801045e5:	5d                   	pop    %ebp
801045e6:	c3                   	ret    
801045e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045ee:	66 90                	xchg   %ax,%ax
  r = lk->locked && (lk->pid == myproc()->pid);
801045f0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801045f3:	e8 78 f5 ff ff       	call   80103b70 <myproc>
801045f8:	39 58 10             	cmp    %ebx,0x10(%eax)
801045fb:	0f 94 c0             	sete   %al
801045fe:	0f b6 c0             	movzbl %al,%eax
80104601:	89 c7                	mov    %eax,%edi
80104603:	eb cf                	jmp    801045d4 <holdingsleep+0x24>
80104605:	66 90                	xchg   %ax,%ax
80104607:	66 90                	xchg   %ax,%ax
80104609:	66 90                	xchg   %ax,%ax
8010460b:	66 90                	xchg   %ax,%ax
8010460d:	66 90                	xchg   %ax,%ax
8010460f:	90                   	nop

80104610 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104610:	f3 0f 1e fb          	endbr32 
80104614:	55                   	push   %ebp
80104615:	89 e5                	mov    %esp,%ebp
80104617:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
8010461a:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
8010461d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104623:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104626:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
8010462d:	5d                   	pop    %ebp
8010462e:	c3                   	ret    
8010462f:	90                   	nop

80104630 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104630:	f3 0f 1e fb          	endbr32 
80104634:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104635:	31 d2                	xor    %edx,%edx
{
80104637:	89 e5                	mov    %esp,%ebp
80104639:	53                   	push   %ebx
  ebp = (uint*)v - 2;
8010463a:	8b 45 08             	mov    0x8(%ebp),%eax
{
8010463d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104640:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
80104643:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104647:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104648:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
8010464e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104654:	77 1a                	ja     80104670 <getcallerpcs+0x40>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104656:	8b 58 04             	mov    0x4(%eax),%ebx
80104659:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
8010465c:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
8010465f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104661:	83 fa 0a             	cmp    $0xa,%edx
80104664:	75 e2                	jne    80104648 <getcallerpcs+0x18>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104666:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104669:	c9                   	leave  
8010466a:	c3                   	ret    
8010466b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010466f:	90                   	nop
  for(; i < 10; i++)
80104670:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104673:	8d 51 28             	lea    0x28(%ecx),%edx
80104676:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010467d:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80104680:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104686:	83 c0 04             	add    $0x4,%eax
80104689:	39 d0                	cmp    %edx,%eax
8010468b:	75 f3                	jne    80104680 <getcallerpcs+0x50>
}
8010468d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104690:	c9                   	leave  
80104691:	c3                   	ret    
80104692:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801046a0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801046a0:	f3 0f 1e fb          	endbr32 
801046a4:	55                   	push   %ebp
801046a5:	89 e5                	mov    %esp,%ebp
801046a7:	53                   	push   %ebx
801046a8:	83 ec 04             	sub    $0x4,%esp
801046ab:	9c                   	pushf  
801046ac:	5b                   	pop    %ebx
  asm volatile("cli");
801046ad:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801046ae:	e8 2d f4 ff ff       	call   80103ae0 <mycpu>
801046b3:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801046b9:	85 c0                	test   %eax,%eax
801046bb:	74 13                	je     801046d0 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
801046bd:	e8 1e f4 ff ff       	call   80103ae0 <mycpu>
801046c2:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801046c9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801046cc:	c9                   	leave  
801046cd:	c3                   	ret    
801046ce:	66 90                	xchg   %ax,%ax
    mycpu()->intena = eflags & FL_IF;
801046d0:	e8 0b f4 ff ff       	call   80103ae0 <mycpu>
801046d5:	81 e3 00 02 00 00    	and    $0x200,%ebx
801046db:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
801046e1:	eb da                	jmp    801046bd <pushcli+0x1d>
801046e3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801046f0 <popcli>:

void
popcli(void)
{
801046f0:	f3 0f 1e fb          	endbr32 
801046f4:	55                   	push   %ebp
801046f5:	89 e5                	mov    %esp,%ebp
801046f7:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801046fa:	9c                   	pushf  
801046fb:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801046fc:	f6 c4 02             	test   $0x2,%ah
801046ff:	75 31                	jne    80104732 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104701:	e8 da f3 ff ff       	call   80103ae0 <mycpu>
80104706:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
8010470d:	78 30                	js     8010473f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010470f:	e8 cc f3 ff ff       	call   80103ae0 <mycpu>
80104714:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
8010471a:	85 d2                	test   %edx,%edx
8010471c:	74 02                	je     80104720 <popcli+0x30>
    sti();
}
8010471e:	c9                   	leave  
8010471f:	c3                   	ret    
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104720:	e8 bb f3 ff ff       	call   80103ae0 <mycpu>
80104725:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010472b:	85 c0                	test   %eax,%eax
8010472d:	74 ef                	je     8010471e <popcli+0x2e>
  asm volatile("sti");
8010472f:	fb                   	sti    
}
80104730:	c9                   	leave  
80104731:	c3                   	ret    
    panic("popcli - interruptible");
80104732:	83 ec 0c             	sub    $0xc,%esp
80104735:	68 cf 7b 10 80       	push   $0x80107bcf
8010473a:	e8 51 bc ff ff       	call   80100390 <panic>
    panic("popcli");
8010473f:	83 ec 0c             	sub    $0xc,%esp
80104742:	68 e6 7b 10 80       	push   $0x80107be6
80104747:	e8 44 bc ff ff       	call   80100390 <panic>
8010474c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104750 <holding>:
{
80104750:	f3 0f 1e fb          	endbr32 
80104754:	55                   	push   %ebp
80104755:	89 e5                	mov    %esp,%ebp
80104757:	56                   	push   %esi
80104758:	53                   	push   %ebx
80104759:	8b 75 08             	mov    0x8(%ebp),%esi
8010475c:	31 db                	xor    %ebx,%ebx
  pushcli();
8010475e:	e8 3d ff ff ff       	call   801046a0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104763:	8b 06                	mov    (%esi),%eax
80104765:	85 c0                	test   %eax,%eax
80104767:	75 0f                	jne    80104778 <holding+0x28>
  popcli();
80104769:	e8 82 ff ff ff       	call   801046f0 <popcli>
}
8010476e:	89 d8                	mov    %ebx,%eax
80104770:	5b                   	pop    %ebx
80104771:	5e                   	pop    %esi
80104772:	5d                   	pop    %ebp
80104773:	c3                   	ret    
80104774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  r = lock->locked && lock->cpu == mycpu();
80104778:	8b 5e 08             	mov    0x8(%esi),%ebx
8010477b:	e8 60 f3 ff ff       	call   80103ae0 <mycpu>
80104780:	39 c3                	cmp    %eax,%ebx
80104782:	0f 94 c3             	sete   %bl
  popcli();
80104785:	e8 66 ff ff ff       	call   801046f0 <popcli>
  r = lock->locked && lock->cpu == mycpu();
8010478a:	0f b6 db             	movzbl %bl,%ebx
}
8010478d:	89 d8                	mov    %ebx,%eax
8010478f:	5b                   	pop    %ebx
80104790:	5e                   	pop    %esi
80104791:	5d                   	pop    %ebp
80104792:	c3                   	ret    
80104793:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010479a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801047a0 <release>:
{
801047a0:	f3 0f 1e fb          	endbr32 
801047a4:	55                   	push   %ebp
801047a5:	89 e5                	mov    %esp,%ebp
801047a7:	56                   	push   %esi
801047a8:	53                   	push   %ebx
801047a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
801047ac:	e8 ef fe ff ff       	call   801046a0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801047b1:	8b 03                	mov    (%ebx),%eax
801047b3:	85 c0                	test   %eax,%eax
801047b5:	75 19                	jne    801047d0 <release+0x30>
  popcli();
801047b7:	e8 34 ff ff ff       	call   801046f0 <popcli>
    panic("release");
801047bc:	83 ec 0c             	sub    $0xc,%esp
801047bf:	68 ed 7b 10 80       	push   $0x80107bed
801047c4:	e8 c7 bb ff ff       	call   80100390 <panic>
801047c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  r = lock->locked && lock->cpu == mycpu();
801047d0:	8b 73 08             	mov    0x8(%ebx),%esi
801047d3:	e8 08 f3 ff ff       	call   80103ae0 <mycpu>
801047d8:	39 c6                	cmp    %eax,%esi
801047da:	75 db                	jne    801047b7 <release+0x17>
  popcli();
801047dc:	e8 0f ff ff ff       	call   801046f0 <popcli>
  lk->pcs[0] = 0;
801047e1:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801047e8:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
801047ef:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801047f4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
801047fa:	8d 65 f8             	lea    -0x8(%ebp),%esp
801047fd:	5b                   	pop    %ebx
801047fe:	5e                   	pop    %esi
801047ff:	5d                   	pop    %ebp
  popcli();
80104800:	e9 eb fe ff ff       	jmp    801046f0 <popcli>
80104805:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010480c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104810 <acquire>:
{
80104810:	f3 0f 1e fb          	endbr32 
80104814:	55                   	push   %ebp
80104815:	89 e5                	mov    %esp,%ebp
80104817:	53                   	push   %ebx
80104818:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
8010481b:	e8 80 fe ff ff       	call   801046a0 <pushcli>
  if(holding(lk))
80104820:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80104823:	e8 78 fe ff ff       	call   801046a0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104828:	8b 03                	mov    (%ebx),%eax
8010482a:	85 c0                	test   %eax,%eax
8010482c:	0f 85 86 00 00 00    	jne    801048b8 <acquire+0xa8>
  popcli();
80104832:	e8 b9 fe ff ff       	call   801046f0 <popcli>
  asm volatile("lock; xchgl %0, %1" :
80104837:	b9 01 00 00 00       	mov    $0x1,%ecx
8010483c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(xchg(&lk->locked, 1) != 0)
80104840:	8b 55 08             	mov    0x8(%ebp),%edx
80104843:	89 c8                	mov    %ecx,%eax
80104845:	f0 87 02             	lock xchg %eax,(%edx)
80104848:	85 c0                	test   %eax,%eax
8010484a:	75 f4                	jne    80104840 <acquire+0x30>
  __sync_synchronize();
8010484c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104851:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104854:	e8 87 f2 ff ff       	call   80103ae0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104859:	8b 4d 08             	mov    0x8(%ebp),%ecx
  ebp = (uint*)v - 2;
8010485c:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
8010485e:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
80104861:	31 c0                	xor    %eax,%eax
80104863:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104867:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104868:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
8010486e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104874:	77 1a                	ja     80104890 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104876:	8b 5a 04             	mov    0x4(%edx),%ebx
80104879:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
8010487d:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104880:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80104882:	83 f8 0a             	cmp    $0xa,%eax
80104885:	75 e1                	jne    80104868 <acquire+0x58>
}
80104887:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010488a:	c9                   	leave  
8010488b:	c3                   	ret    
8010488c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80104890:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
80104894:	8d 51 34             	lea    0x34(%ecx),%edx
80104897:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010489e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
801048a0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801048a6:	83 c0 04             	add    $0x4,%eax
801048a9:	39 c2                	cmp    %eax,%edx
801048ab:	75 f3                	jne    801048a0 <acquire+0x90>
}
801048ad:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801048b0:	c9                   	leave  
801048b1:	c3                   	ret    
801048b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
801048b8:	8b 5b 08             	mov    0x8(%ebx),%ebx
801048bb:	e8 20 f2 ff ff       	call   80103ae0 <mycpu>
801048c0:	39 c3                	cmp    %eax,%ebx
801048c2:	0f 85 6a ff ff ff    	jne    80104832 <acquire+0x22>
  popcli();
801048c8:	e8 23 fe ff ff       	call   801046f0 <popcli>
    panic("acquire");
801048cd:	83 ec 0c             	sub    $0xc,%esp
801048d0:	68 f5 7b 10 80       	push   $0x80107bf5
801048d5:	e8 b6 ba ff ff       	call   80100390 <panic>
801048da:	66 90                	xchg   %ax,%ax
801048dc:	66 90                	xchg   %ax,%ax
801048de:	66 90                	xchg   %ax,%ax

801048e0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801048e0:	f3 0f 1e fb          	endbr32 
801048e4:	55                   	push   %ebp
801048e5:	89 e5                	mov    %esp,%ebp
801048e7:	57                   	push   %edi
801048e8:	8b 55 08             	mov    0x8(%ebp),%edx
801048eb:	8b 4d 10             	mov    0x10(%ebp),%ecx
801048ee:	53                   	push   %ebx
801048ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
801048f2:	89 d7                	mov    %edx,%edi
801048f4:	09 cf                	or     %ecx,%edi
801048f6:	83 e7 03             	and    $0x3,%edi
801048f9:	75 25                	jne    80104920 <memset+0x40>
    c &= 0xFF;
801048fb:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801048fe:	c1 e0 18             	shl    $0x18,%eax
80104901:	89 fb                	mov    %edi,%ebx
80104903:	c1 e9 02             	shr    $0x2,%ecx
80104906:	c1 e3 10             	shl    $0x10,%ebx
80104909:	09 d8                	or     %ebx,%eax
8010490b:	09 f8                	or     %edi,%eax
8010490d:	c1 e7 08             	shl    $0x8,%edi
80104910:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104912:	89 d7                	mov    %edx,%edi
80104914:	fc                   	cld    
80104915:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104917:	5b                   	pop    %ebx
80104918:	89 d0                	mov    %edx,%eax
8010491a:	5f                   	pop    %edi
8010491b:	5d                   	pop    %ebp
8010491c:	c3                   	ret    
8010491d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("cld; rep stosb" :
80104920:	89 d7                	mov    %edx,%edi
80104922:	fc                   	cld    
80104923:	f3 aa                	rep stos %al,%es:(%edi)
80104925:	5b                   	pop    %ebx
80104926:	89 d0                	mov    %edx,%eax
80104928:	5f                   	pop    %edi
80104929:	5d                   	pop    %ebp
8010492a:	c3                   	ret    
8010492b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010492f:	90                   	nop

80104930 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104930:	f3 0f 1e fb          	endbr32 
80104934:	55                   	push   %ebp
80104935:	89 e5                	mov    %esp,%ebp
80104937:	56                   	push   %esi
80104938:	8b 75 10             	mov    0x10(%ebp),%esi
8010493b:	8b 55 08             	mov    0x8(%ebp),%edx
8010493e:	53                   	push   %ebx
8010493f:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104942:	85 f6                	test   %esi,%esi
80104944:	74 2a                	je     80104970 <memcmp+0x40>
80104946:	01 c6                	add    %eax,%esi
80104948:	eb 10                	jmp    8010495a <memcmp+0x2a>
8010494a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80104950:	83 c0 01             	add    $0x1,%eax
80104953:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80104956:	39 f0                	cmp    %esi,%eax
80104958:	74 16                	je     80104970 <memcmp+0x40>
    if(*s1 != *s2)
8010495a:	0f b6 0a             	movzbl (%edx),%ecx
8010495d:	0f b6 18             	movzbl (%eax),%ebx
80104960:	38 d9                	cmp    %bl,%cl
80104962:	74 ec                	je     80104950 <memcmp+0x20>
      return *s1 - *s2;
80104964:	0f b6 c1             	movzbl %cl,%eax
80104967:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80104969:	5b                   	pop    %ebx
8010496a:	5e                   	pop    %esi
8010496b:	5d                   	pop    %ebp
8010496c:	c3                   	ret    
8010496d:	8d 76 00             	lea    0x0(%esi),%esi
80104970:	5b                   	pop    %ebx
  return 0;
80104971:	31 c0                	xor    %eax,%eax
}
80104973:	5e                   	pop    %esi
80104974:	5d                   	pop    %ebp
80104975:	c3                   	ret    
80104976:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010497d:	8d 76 00             	lea    0x0(%esi),%esi

80104980 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104980:	f3 0f 1e fb          	endbr32 
80104984:	55                   	push   %ebp
80104985:	89 e5                	mov    %esp,%ebp
80104987:	57                   	push   %edi
80104988:	8b 55 08             	mov    0x8(%ebp),%edx
8010498b:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010498e:	56                   	push   %esi
8010498f:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104992:	39 d6                	cmp    %edx,%esi
80104994:	73 2a                	jae    801049c0 <memmove+0x40>
80104996:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80104999:	39 fa                	cmp    %edi,%edx
8010499b:	73 23                	jae    801049c0 <memmove+0x40>
8010499d:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
801049a0:	85 c9                	test   %ecx,%ecx
801049a2:	74 10                	je     801049b4 <memmove+0x34>
801049a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      *--d = *--s;
801049a8:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
801049ac:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
801049af:	83 e8 01             	sub    $0x1,%eax
801049b2:	73 f4                	jae    801049a8 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
801049b4:	5e                   	pop    %esi
801049b5:	89 d0                	mov    %edx,%eax
801049b7:	5f                   	pop    %edi
801049b8:	5d                   	pop    %ebp
801049b9:	c3                   	ret    
801049ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
801049c0:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
801049c3:	89 d7                	mov    %edx,%edi
801049c5:	85 c9                	test   %ecx,%ecx
801049c7:	74 eb                	je     801049b4 <memmove+0x34>
801049c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
801049d0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
801049d1:	39 f0                	cmp    %esi,%eax
801049d3:	75 fb                	jne    801049d0 <memmove+0x50>
}
801049d5:	5e                   	pop    %esi
801049d6:	89 d0                	mov    %edx,%eax
801049d8:	5f                   	pop    %edi
801049d9:	5d                   	pop    %ebp
801049da:	c3                   	ret    
801049db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801049df:	90                   	nop

801049e0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801049e0:	f3 0f 1e fb          	endbr32 
  return memmove(dst, src, n);
801049e4:	eb 9a                	jmp    80104980 <memmove>
801049e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049ed:	8d 76 00             	lea    0x0(%esi),%esi

801049f0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
801049f0:	f3 0f 1e fb          	endbr32 
801049f4:	55                   	push   %ebp
801049f5:	89 e5                	mov    %esp,%ebp
801049f7:	56                   	push   %esi
801049f8:	8b 75 10             	mov    0x10(%ebp),%esi
801049fb:	8b 4d 08             	mov    0x8(%ebp),%ecx
801049fe:	53                   	push   %ebx
801049ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  while(n > 0 && *p && *p == *q)
80104a02:	85 f6                	test   %esi,%esi
80104a04:	74 32                	je     80104a38 <strncmp+0x48>
80104a06:	01 c6                	add    %eax,%esi
80104a08:	eb 14                	jmp    80104a1e <strncmp+0x2e>
80104a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a10:	38 da                	cmp    %bl,%dl
80104a12:	75 14                	jne    80104a28 <strncmp+0x38>
    n--, p++, q++;
80104a14:	83 c0 01             	add    $0x1,%eax
80104a17:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104a1a:	39 f0                	cmp    %esi,%eax
80104a1c:	74 1a                	je     80104a38 <strncmp+0x48>
80104a1e:	0f b6 11             	movzbl (%ecx),%edx
80104a21:	0f b6 18             	movzbl (%eax),%ebx
80104a24:	84 d2                	test   %dl,%dl
80104a26:	75 e8                	jne    80104a10 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104a28:	0f b6 c2             	movzbl %dl,%eax
80104a2b:	29 d8                	sub    %ebx,%eax
}
80104a2d:	5b                   	pop    %ebx
80104a2e:	5e                   	pop    %esi
80104a2f:	5d                   	pop    %ebp
80104a30:	c3                   	ret    
80104a31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a38:	5b                   	pop    %ebx
    return 0;
80104a39:	31 c0                	xor    %eax,%eax
}
80104a3b:	5e                   	pop    %esi
80104a3c:	5d                   	pop    %ebp
80104a3d:	c3                   	ret    
80104a3e:	66 90                	xchg   %ax,%ax

80104a40 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104a40:	f3 0f 1e fb          	endbr32 
80104a44:	55                   	push   %ebp
80104a45:	89 e5                	mov    %esp,%ebp
80104a47:	57                   	push   %edi
80104a48:	56                   	push   %esi
80104a49:	8b 75 08             	mov    0x8(%ebp),%esi
80104a4c:	53                   	push   %ebx
80104a4d:	8b 45 10             	mov    0x10(%ebp),%eax
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104a50:	89 f2                	mov    %esi,%edx
80104a52:	eb 1b                	jmp    80104a6f <strncpy+0x2f>
80104a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a58:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104a5c:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104a5f:	83 c2 01             	add    $0x1,%edx
80104a62:	0f b6 7f ff          	movzbl -0x1(%edi),%edi
80104a66:	89 f9                	mov    %edi,%ecx
80104a68:	88 4a ff             	mov    %cl,-0x1(%edx)
80104a6b:	84 c9                	test   %cl,%cl
80104a6d:	74 09                	je     80104a78 <strncpy+0x38>
80104a6f:	89 c3                	mov    %eax,%ebx
80104a71:	83 e8 01             	sub    $0x1,%eax
80104a74:	85 db                	test   %ebx,%ebx
80104a76:	7f e0                	jg     80104a58 <strncpy+0x18>
    ;
  while(n-- > 0)
80104a78:	89 d1                	mov    %edx,%ecx
80104a7a:	85 c0                	test   %eax,%eax
80104a7c:	7e 15                	jle    80104a93 <strncpy+0x53>
80104a7e:	66 90                	xchg   %ax,%ax
    *s++ = 0;
80104a80:	83 c1 01             	add    $0x1,%ecx
80104a83:	c6 41 ff 00          	movb   $0x0,-0x1(%ecx)
  while(n-- > 0)
80104a87:	89 c8                	mov    %ecx,%eax
80104a89:	f7 d0                	not    %eax
80104a8b:	01 d0                	add    %edx,%eax
80104a8d:	01 d8                	add    %ebx,%eax
80104a8f:	85 c0                	test   %eax,%eax
80104a91:	7f ed                	jg     80104a80 <strncpy+0x40>
  return os;
}
80104a93:	5b                   	pop    %ebx
80104a94:	89 f0                	mov    %esi,%eax
80104a96:	5e                   	pop    %esi
80104a97:	5f                   	pop    %edi
80104a98:	5d                   	pop    %ebp
80104a99:	c3                   	ret    
80104a9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104aa0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104aa0:	f3 0f 1e fb          	endbr32 
80104aa4:	55                   	push   %ebp
80104aa5:	89 e5                	mov    %esp,%ebp
80104aa7:	56                   	push   %esi
80104aa8:	8b 55 10             	mov    0x10(%ebp),%edx
80104aab:	8b 75 08             	mov    0x8(%ebp),%esi
80104aae:	53                   	push   %ebx
80104aaf:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80104ab2:	85 d2                	test   %edx,%edx
80104ab4:	7e 21                	jle    80104ad7 <safestrcpy+0x37>
80104ab6:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104aba:	89 f2                	mov    %esi,%edx
80104abc:	eb 12                	jmp    80104ad0 <safestrcpy+0x30>
80104abe:	66 90                	xchg   %ax,%ax
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104ac0:	0f b6 08             	movzbl (%eax),%ecx
80104ac3:	83 c0 01             	add    $0x1,%eax
80104ac6:	83 c2 01             	add    $0x1,%edx
80104ac9:	88 4a ff             	mov    %cl,-0x1(%edx)
80104acc:	84 c9                	test   %cl,%cl
80104ace:	74 04                	je     80104ad4 <safestrcpy+0x34>
80104ad0:	39 d8                	cmp    %ebx,%eax
80104ad2:	75 ec                	jne    80104ac0 <safestrcpy+0x20>
    ;
  *s = 0;
80104ad4:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104ad7:	89 f0                	mov    %esi,%eax
80104ad9:	5b                   	pop    %ebx
80104ada:	5e                   	pop    %esi
80104adb:	5d                   	pop    %ebp
80104adc:	c3                   	ret    
80104add:	8d 76 00             	lea    0x0(%esi),%esi

80104ae0 <strlen>:

int
strlen(const char *s)
{
80104ae0:	f3 0f 1e fb          	endbr32 
80104ae4:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104ae5:	31 c0                	xor    %eax,%eax
{
80104ae7:	89 e5                	mov    %esp,%ebp
80104ae9:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104aec:	80 3a 00             	cmpb   $0x0,(%edx)
80104aef:	74 10                	je     80104b01 <strlen+0x21>
80104af1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104af8:	83 c0 01             	add    $0x1,%eax
80104afb:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104aff:	75 f7                	jne    80104af8 <strlen+0x18>
    ;
  return n;
}
80104b01:	5d                   	pop    %ebp
80104b02:	c3                   	ret    

80104b03 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104b03:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104b07:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104b0b:	55                   	push   %ebp
  pushl %ebx
80104b0c:	53                   	push   %ebx
  pushl %esi
80104b0d:	56                   	push   %esi
  pushl %edi
80104b0e:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104b0f:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104b11:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104b13:	5f                   	pop    %edi
  popl %esi
80104b14:	5e                   	pop    %esi
  popl %ebx
80104b15:	5b                   	pop    %ebx
  popl %ebp
80104b16:	5d                   	pop    %ebp
  ret
80104b17:	c3                   	ret    
80104b18:	66 90                	xchg   %ax,%ax
80104b1a:	66 90                	xchg   %ax,%ax
80104b1c:	66 90                	xchg   %ax,%ax
80104b1e:	66 90                	xchg   %ax,%ax

80104b20 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104b20:	f3 0f 1e fb          	endbr32 
80104b24:	55                   	push   %ebp
80104b25:	89 e5                	mov    %esp,%ebp
80104b27:	53                   	push   %ebx
80104b28:	83 ec 04             	sub    $0x4,%esp
80104b2b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104b2e:	e8 3d f0 ff ff       	call   80103b70 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104b33:	8b 00                	mov    (%eax),%eax
80104b35:	39 d8                	cmp    %ebx,%eax
80104b37:	76 17                	jbe    80104b50 <fetchint+0x30>
80104b39:	8d 53 04             	lea    0x4(%ebx),%edx
80104b3c:	39 d0                	cmp    %edx,%eax
80104b3e:	72 10                	jb     80104b50 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104b40:	8b 45 0c             	mov    0xc(%ebp),%eax
80104b43:	8b 13                	mov    (%ebx),%edx
80104b45:	89 10                	mov    %edx,(%eax)
  return 0;
80104b47:	31 c0                	xor    %eax,%eax
}
80104b49:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b4c:	c9                   	leave  
80104b4d:	c3                   	ret    
80104b4e:	66 90                	xchg   %ax,%ax
    return -1;
80104b50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104b55:	eb f2                	jmp    80104b49 <fetchint+0x29>
80104b57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b5e:	66 90                	xchg   %ax,%ax

80104b60 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104b60:	f3 0f 1e fb          	endbr32 
80104b64:	55                   	push   %ebp
80104b65:	89 e5                	mov    %esp,%ebp
80104b67:	53                   	push   %ebx
80104b68:	83 ec 04             	sub    $0x4,%esp
80104b6b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104b6e:	e8 fd ef ff ff       	call   80103b70 <myproc>

  if(addr >= curproc->sz)
80104b73:	39 18                	cmp    %ebx,(%eax)
80104b75:	76 31                	jbe    80104ba8 <fetchstr+0x48>
    return -1;
  *pp = (char*)addr;
80104b77:	8b 55 0c             	mov    0xc(%ebp),%edx
80104b7a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104b7c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104b7e:	39 d3                	cmp    %edx,%ebx
80104b80:	73 26                	jae    80104ba8 <fetchstr+0x48>
80104b82:	89 d8                	mov    %ebx,%eax
80104b84:	eb 11                	jmp    80104b97 <fetchstr+0x37>
80104b86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b8d:	8d 76 00             	lea    0x0(%esi),%esi
80104b90:	83 c0 01             	add    $0x1,%eax
80104b93:	39 c2                	cmp    %eax,%edx
80104b95:	76 11                	jbe    80104ba8 <fetchstr+0x48>
    if(*s == 0)
80104b97:	80 38 00             	cmpb   $0x0,(%eax)
80104b9a:	75 f4                	jne    80104b90 <fetchstr+0x30>
      return s - *pp;
80104b9c:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104b9e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ba1:	c9                   	leave  
80104ba2:	c3                   	ret    
80104ba3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ba7:	90                   	nop
80104ba8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80104bab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104bb0:	c9                   	leave  
80104bb1:	c3                   	ret    
80104bb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104bc0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104bc0:	f3 0f 1e fb          	endbr32 
80104bc4:	55                   	push   %ebp
80104bc5:	89 e5                	mov    %esp,%ebp
80104bc7:	56                   	push   %esi
80104bc8:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104bc9:	e8 a2 ef ff ff       	call   80103b70 <myproc>
80104bce:	8b 55 08             	mov    0x8(%ebp),%edx
80104bd1:	8b 40 18             	mov    0x18(%eax),%eax
80104bd4:	8b 40 44             	mov    0x44(%eax),%eax
80104bd7:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104bda:	e8 91 ef ff ff       	call   80103b70 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104bdf:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104be2:	8b 00                	mov    (%eax),%eax
80104be4:	39 c6                	cmp    %eax,%esi
80104be6:	73 18                	jae    80104c00 <argint+0x40>
80104be8:	8d 53 08             	lea    0x8(%ebx),%edx
80104beb:	39 d0                	cmp    %edx,%eax
80104bed:	72 11                	jb     80104c00 <argint+0x40>
  *ip = *(int*)(addr);
80104bef:	8b 45 0c             	mov    0xc(%ebp),%eax
80104bf2:	8b 53 04             	mov    0x4(%ebx),%edx
80104bf5:	89 10                	mov    %edx,(%eax)
  return 0;
80104bf7:	31 c0                	xor    %eax,%eax
}
80104bf9:	5b                   	pop    %ebx
80104bfa:	5e                   	pop    %esi
80104bfb:	5d                   	pop    %ebp
80104bfc:	c3                   	ret    
80104bfd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104c00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104c05:	eb f2                	jmp    80104bf9 <argint+0x39>
80104c07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c0e:	66 90                	xchg   %ax,%ax

80104c10 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104c10:	f3 0f 1e fb          	endbr32 
80104c14:	55                   	push   %ebp
80104c15:	89 e5                	mov    %esp,%ebp
80104c17:	57                   	push   %edi
80104c18:	56                   	push   %esi
80104c19:	53                   	push   %ebx
80104c1a:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80104c1d:	e8 4e ef ff ff       	call   80103b70 <myproc>
80104c22:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104c24:	e8 47 ef ff ff       	call   80103b70 <myproc>
80104c29:	8b 55 08             	mov    0x8(%ebp),%edx
80104c2c:	8b 40 18             	mov    0x18(%eax),%eax
80104c2f:	8b 40 44             	mov    0x44(%eax),%eax
80104c32:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104c35:	e8 36 ef ff ff       	call   80103b70 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104c3a:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104c3d:	8b 00                	mov    (%eax),%eax
80104c3f:	39 c7                	cmp    %eax,%edi
80104c41:	73 35                	jae    80104c78 <argptr+0x68>
80104c43:	8d 4b 08             	lea    0x8(%ebx),%ecx
80104c46:	39 c8                	cmp    %ecx,%eax
80104c48:	72 2e                	jb     80104c78 <argptr+0x68>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104c4a:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
80104c4d:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104c50:	85 d2                	test   %edx,%edx
80104c52:	78 24                	js     80104c78 <argptr+0x68>
80104c54:	8b 16                	mov    (%esi),%edx
80104c56:	39 c2                	cmp    %eax,%edx
80104c58:	76 1e                	jbe    80104c78 <argptr+0x68>
80104c5a:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104c5d:	01 c3                	add    %eax,%ebx
80104c5f:	39 da                	cmp    %ebx,%edx
80104c61:	72 15                	jb     80104c78 <argptr+0x68>
    return -1;
  *pp = (char*)i;
80104c63:	8b 55 0c             	mov    0xc(%ebp),%edx
80104c66:	89 02                	mov    %eax,(%edx)
  return 0;
80104c68:	31 c0                	xor    %eax,%eax
}
80104c6a:	83 c4 0c             	add    $0xc,%esp
80104c6d:	5b                   	pop    %ebx
80104c6e:	5e                   	pop    %esi
80104c6f:	5f                   	pop    %edi
80104c70:	5d                   	pop    %ebp
80104c71:	c3                   	ret    
80104c72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104c78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c7d:	eb eb                	jmp    80104c6a <argptr+0x5a>
80104c7f:	90                   	nop

80104c80 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104c80:	f3 0f 1e fb          	endbr32 
80104c84:	55                   	push   %ebp
80104c85:	89 e5                	mov    %esp,%ebp
80104c87:	56                   	push   %esi
80104c88:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104c89:	e8 e2 ee ff ff       	call   80103b70 <myproc>
80104c8e:	8b 55 08             	mov    0x8(%ebp),%edx
80104c91:	8b 40 18             	mov    0x18(%eax),%eax
80104c94:	8b 40 44             	mov    0x44(%eax),%eax
80104c97:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104c9a:	e8 d1 ee ff ff       	call   80103b70 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104c9f:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104ca2:	8b 00                	mov    (%eax),%eax
80104ca4:	39 c6                	cmp    %eax,%esi
80104ca6:	73 40                	jae    80104ce8 <argstr+0x68>
80104ca8:	8d 53 08             	lea    0x8(%ebx),%edx
80104cab:	39 d0                	cmp    %edx,%eax
80104cad:	72 39                	jb     80104ce8 <argstr+0x68>
  *ip = *(int*)(addr);
80104caf:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
80104cb2:	e8 b9 ee ff ff       	call   80103b70 <myproc>
  if(addr >= curproc->sz)
80104cb7:	3b 18                	cmp    (%eax),%ebx
80104cb9:	73 2d                	jae    80104ce8 <argstr+0x68>
  *pp = (char*)addr;
80104cbb:	8b 55 0c             	mov    0xc(%ebp),%edx
80104cbe:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104cc0:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104cc2:	39 d3                	cmp    %edx,%ebx
80104cc4:	73 22                	jae    80104ce8 <argstr+0x68>
80104cc6:	89 d8                	mov    %ebx,%eax
80104cc8:	eb 0d                	jmp    80104cd7 <argstr+0x57>
80104cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104cd0:	83 c0 01             	add    $0x1,%eax
80104cd3:	39 c2                	cmp    %eax,%edx
80104cd5:	76 11                	jbe    80104ce8 <argstr+0x68>
    if(*s == 0)
80104cd7:	80 38 00             	cmpb   $0x0,(%eax)
80104cda:	75 f4                	jne    80104cd0 <argstr+0x50>
      return s - *pp;
80104cdc:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104cde:	5b                   	pop    %ebx
80104cdf:	5e                   	pop    %esi
80104ce0:	5d                   	pop    %ebp
80104ce1:	c3                   	ret    
80104ce2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104ce8:	5b                   	pop    %ebx
    return -1;
80104ce9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104cee:	5e                   	pop    %esi
80104cef:	5d                   	pop    %ebp
80104cf0:	c3                   	ret    
80104cf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cf8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cff:	90                   	nop

80104d00 <syscall>:
[SYS_getreadcount] sys_getreadcount,  //new syscall
};

void
syscall(void)
{
80104d00:	f3 0f 1e fb          	endbr32 
80104d04:	55                   	push   %ebp
80104d05:	89 e5                	mov    %esp,%ebp
80104d07:	53                   	push   %ebx
80104d08:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104d0b:	e8 60 ee ff ff       	call   80103b70 <myproc>
80104d10:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104d12:	8b 40 18             	mov    0x18(%eax),%eax
80104d15:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104d18:	8d 50 ff             	lea    -0x1(%eax),%edx
80104d1b:	83 fa 15             	cmp    $0x15,%edx
80104d1e:	77 20                	ja     80104d40 <syscall+0x40>
80104d20:	8b 14 85 20 7c 10 80 	mov    -0x7fef83e0(,%eax,4),%edx
80104d27:	85 d2                	test   %edx,%edx
80104d29:	74 15                	je     80104d40 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80104d2b:	ff d2                	call   *%edx
80104d2d:	89 c2                	mov    %eax,%edx
80104d2f:	8b 43 18             	mov    0x18(%ebx),%eax
80104d32:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104d35:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d38:	c9                   	leave  
80104d39:	c3                   	ret    
80104d3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104d40:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104d41:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104d44:	50                   	push   %eax
80104d45:	ff 73 10             	pushl  0x10(%ebx)
80104d48:	68 fd 7b 10 80       	push   $0x80107bfd
80104d4d:	e8 3e b9 ff ff       	call   80100690 <cprintf>
    curproc->tf->eax = -1;
80104d52:	8b 43 18             	mov    0x18(%ebx),%eax
80104d55:	83 c4 10             	add    $0x10,%esp
80104d58:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104d5f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d62:	c9                   	leave  
80104d63:	c3                   	ret    
80104d64:	66 90                	xchg   %ax,%ax
80104d66:	66 90                	xchg   %ax,%ax
80104d68:	66 90                	xchg   %ax,%ax
80104d6a:	66 90                	xchg   %ax,%ax
80104d6c:	66 90                	xchg   %ax,%ax
80104d6e:	66 90                	xchg   %ax,%ax

80104d70 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104d70:	55                   	push   %ebp
80104d71:	89 e5                	mov    %esp,%ebp
80104d73:	57                   	push   %edi
80104d74:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104d75:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80104d78:	53                   	push   %ebx
80104d79:	83 ec 34             	sub    $0x34,%esp
80104d7c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104d7f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104d82:	57                   	push   %edi
80104d83:	50                   	push   %eax
{
80104d84:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104d87:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104d8a:	e8 a1 d4 ff ff       	call   80102230 <nameiparent>
80104d8f:	83 c4 10             	add    $0x10,%esp
80104d92:	85 c0                	test   %eax,%eax
80104d94:	0f 84 46 01 00 00    	je     80104ee0 <create+0x170>
    return 0;
  ilock(dp);
80104d9a:	83 ec 0c             	sub    $0xc,%esp
80104d9d:	89 c3                	mov    %eax,%ebx
80104d9f:	50                   	push   %eax
80104da0:	e8 2b cb ff ff       	call   801018d0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104da5:	83 c4 0c             	add    $0xc,%esp
80104da8:	6a 00                	push   $0x0
80104daa:	57                   	push   %edi
80104dab:	53                   	push   %ebx
80104dac:	e8 8f d0 ff ff       	call   80101e40 <dirlookup>
80104db1:	83 c4 10             	add    $0x10,%esp
80104db4:	89 c6                	mov    %eax,%esi
80104db6:	85 c0                	test   %eax,%eax
80104db8:	74 56                	je     80104e10 <create+0xa0>
    iunlockput(dp);
80104dba:	83 ec 0c             	sub    $0xc,%esp
80104dbd:	53                   	push   %ebx
80104dbe:	e8 9d cd ff ff       	call   80101b60 <iunlockput>
    ilock(ip);
80104dc3:	89 34 24             	mov    %esi,(%esp)
80104dc6:	e8 05 cb ff ff       	call   801018d0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104dcb:	83 c4 10             	add    $0x10,%esp
80104dce:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104dd3:	75 1b                	jne    80104df0 <create+0x80>
80104dd5:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80104dda:	75 14                	jne    80104df0 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104ddc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ddf:	89 f0                	mov    %esi,%eax
80104de1:	5b                   	pop    %ebx
80104de2:	5e                   	pop    %esi
80104de3:	5f                   	pop    %edi
80104de4:	5d                   	pop    %ebp
80104de5:	c3                   	ret    
80104de6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ded:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80104df0:	83 ec 0c             	sub    $0xc,%esp
80104df3:	56                   	push   %esi
    return 0;
80104df4:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80104df6:	e8 65 cd ff ff       	call   80101b60 <iunlockput>
    return 0;
80104dfb:	83 c4 10             	add    $0x10,%esp
}
80104dfe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e01:	89 f0                	mov    %esi,%eax
80104e03:	5b                   	pop    %ebx
80104e04:	5e                   	pop    %esi
80104e05:	5f                   	pop    %edi
80104e06:	5d                   	pop    %ebp
80104e07:	c3                   	ret    
80104e08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e0f:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80104e10:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104e14:	83 ec 08             	sub    $0x8,%esp
80104e17:	50                   	push   %eax
80104e18:	ff 33                	pushl  (%ebx)
80104e1a:	e8 31 c9 ff ff       	call   80101750 <ialloc>
80104e1f:	83 c4 10             	add    $0x10,%esp
80104e22:	89 c6                	mov    %eax,%esi
80104e24:	85 c0                	test   %eax,%eax
80104e26:	0f 84 cd 00 00 00    	je     80104ef9 <create+0x189>
  ilock(ip);
80104e2c:	83 ec 0c             	sub    $0xc,%esp
80104e2f:	50                   	push   %eax
80104e30:	e8 9b ca ff ff       	call   801018d0 <ilock>
  ip->major = major;
80104e35:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104e39:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80104e3d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104e41:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80104e45:	b8 01 00 00 00       	mov    $0x1,%eax
80104e4a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
80104e4e:	89 34 24             	mov    %esi,(%esp)
80104e51:	e8 ba c9 ff ff       	call   80101810 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104e56:	83 c4 10             	add    $0x10,%esp
80104e59:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104e5e:	74 30                	je     80104e90 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104e60:	83 ec 04             	sub    $0x4,%esp
80104e63:	ff 76 04             	pushl  0x4(%esi)
80104e66:	57                   	push   %edi
80104e67:	53                   	push   %ebx
80104e68:	e8 e3 d2 ff ff       	call   80102150 <dirlink>
80104e6d:	83 c4 10             	add    $0x10,%esp
80104e70:	85 c0                	test   %eax,%eax
80104e72:	78 78                	js     80104eec <create+0x17c>
  iunlockput(dp);
80104e74:	83 ec 0c             	sub    $0xc,%esp
80104e77:	53                   	push   %ebx
80104e78:	e8 e3 cc ff ff       	call   80101b60 <iunlockput>
  return ip;
80104e7d:	83 c4 10             	add    $0x10,%esp
}
80104e80:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e83:	89 f0                	mov    %esi,%eax
80104e85:	5b                   	pop    %ebx
80104e86:	5e                   	pop    %esi
80104e87:	5f                   	pop    %edi
80104e88:	5d                   	pop    %ebp
80104e89:	c3                   	ret    
80104e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80104e90:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80104e93:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104e98:	53                   	push   %ebx
80104e99:	e8 72 c9 ff ff       	call   80101810 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104e9e:	83 c4 0c             	add    $0xc,%esp
80104ea1:	ff 76 04             	pushl  0x4(%esi)
80104ea4:	68 98 7c 10 80       	push   $0x80107c98
80104ea9:	56                   	push   %esi
80104eaa:	e8 a1 d2 ff ff       	call   80102150 <dirlink>
80104eaf:	83 c4 10             	add    $0x10,%esp
80104eb2:	85 c0                	test   %eax,%eax
80104eb4:	78 18                	js     80104ece <create+0x15e>
80104eb6:	83 ec 04             	sub    $0x4,%esp
80104eb9:	ff 73 04             	pushl  0x4(%ebx)
80104ebc:	68 97 7c 10 80       	push   $0x80107c97
80104ec1:	56                   	push   %esi
80104ec2:	e8 89 d2 ff ff       	call   80102150 <dirlink>
80104ec7:	83 c4 10             	add    $0x10,%esp
80104eca:	85 c0                	test   %eax,%eax
80104ecc:	79 92                	jns    80104e60 <create+0xf0>
      panic("create dots");
80104ece:	83 ec 0c             	sub    $0xc,%esp
80104ed1:	68 8b 7c 10 80       	push   $0x80107c8b
80104ed6:	e8 b5 b4 ff ff       	call   80100390 <panic>
80104edb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104edf:	90                   	nop
}
80104ee0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80104ee3:	31 f6                	xor    %esi,%esi
}
80104ee5:	5b                   	pop    %ebx
80104ee6:	89 f0                	mov    %esi,%eax
80104ee8:	5e                   	pop    %esi
80104ee9:	5f                   	pop    %edi
80104eea:	5d                   	pop    %ebp
80104eeb:	c3                   	ret    
    panic("create: dirlink");
80104eec:	83 ec 0c             	sub    $0xc,%esp
80104eef:	68 9a 7c 10 80       	push   $0x80107c9a
80104ef4:	e8 97 b4 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80104ef9:	83 ec 0c             	sub    $0xc,%esp
80104efc:	68 7c 7c 10 80       	push   $0x80107c7c
80104f01:	e8 8a b4 ff ff       	call   80100390 <panic>
80104f06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f0d:	8d 76 00             	lea    0x0(%esi),%esi

80104f10 <sys_dup>:
{
80104f10:	f3 0f 1e fb          	endbr32 
80104f14:	55                   	push   %ebp
80104f15:	89 e5                	mov    %esp,%ebp
80104f17:	56                   	push   %esi
80104f18:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104f19:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80104f1c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104f1f:	50                   	push   %eax
80104f20:	6a 00                	push   $0x0
80104f22:	e8 99 fc ff ff       	call   80104bc0 <argint>
80104f27:	83 c4 10             	add    $0x10,%esp
80104f2a:	85 c0                	test   %eax,%eax
80104f2c:	78 32                	js     80104f60 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104f2e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104f32:	77 2c                	ja     80104f60 <sys_dup+0x50>
80104f34:	e8 37 ec ff ff       	call   80103b70 <myproc>
80104f39:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104f3c:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104f40:	85 f6                	test   %esi,%esi
80104f42:	74 1c                	je     80104f60 <sys_dup+0x50>
  struct proc *curproc = myproc();
80104f44:	e8 27 ec ff ff       	call   80103b70 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80104f49:	31 db                	xor    %ebx,%ebx
80104f4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104f4f:	90                   	nop
    if(curproc->ofile[fd] == 0){
80104f50:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104f54:	85 d2                	test   %edx,%edx
80104f56:	74 18                	je     80104f70 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80104f58:	83 c3 01             	add    $0x1,%ebx
80104f5b:	83 fb 10             	cmp    $0x10,%ebx
80104f5e:	75 f0                	jne    80104f50 <sys_dup+0x40>
}
80104f60:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104f63:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104f68:	89 d8                	mov    %ebx,%eax
80104f6a:	5b                   	pop    %ebx
80104f6b:	5e                   	pop    %esi
80104f6c:	5d                   	pop    %ebp
80104f6d:	c3                   	ret    
80104f6e:	66 90                	xchg   %ax,%ax
  filedup(f);
80104f70:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80104f73:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104f77:	56                   	push   %esi
80104f78:	e8 53 c0 ff ff       	call   80100fd0 <filedup>
  return fd;
80104f7d:	83 c4 10             	add    $0x10,%esp
}
80104f80:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f83:	89 d8                	mov    %ebx,%eax
80104f85:	5b                   	pop    %ebx
80104f86:	5e                   	pop    %esi
80104f87:	5d                   	pop    %ebp
80104f88:	c3                   	ret    
80104f89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104f90 <sys_read>:
{
80104f90:	f3 0f 1e fb          	endbr32 
80104f94:	55                   	push   %ebp
80104f95:	89 e5                	mov    %esp,%ebp
80104f97:	56                   	push   %esi
80104f98:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104f99:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80104f9c:	83 ec 1c             	sub    $0x1c,%esp
  acquire(&readcountlock);
80104f9f:	68 80 3c 11 80       	push   $0x80113c80
80104fa4:	e8 67 f8 ff ff       	call   80104810 <acquire>
  release(&readcountlock);
80104fa9:	c7 04 24 80 3c 11 80 	movl   $0x80113c80,(%esp)
  readcount += 1;
80104fb0:	83 05 60 3c 11 80 01 	addl   $0x1,0x80113c60
  release(&readcountlock);
80104fb7:	e8 e4 f7 ff ff       	call   801047a0 <release>
  if(argint(n, &fd) < 0)
80104fbc:	58                   	pop    %eax
80104fbd:	5a                   	pop    %edx
80104fbe:	53                   	push   %ebx
80104fbf:	6a 00                	push   $0x0
80104fc1:	e8 fa fb ff ff       	call   80104bc0 <argint>
80104fc6:	83 c4 10             	add    $0x10,%esp
80104fc9:	85 c0                	test   %eax,%eax
80104fcb:	78 63                	js     80105030 <sys_read+0xa0>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104fcd:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104fd1:	77 5d                	ja     80105030 <sys_read+0xa0>
80104fd3:	e8 98 eb ff ff       	call   80103b70 <myproc>
80104fd8:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104fdb:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104fdf:	85 f6                	test   %esi,%esi
80104fe1:	74 4d                	je     80105030 <sys_read+0xa0>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104fe3:	83 ec 08             	sub    $0x8,%esp
80104fe6:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104fe9:	50                   	push   %eax
80104fea:	6a 02                	push   $0x2
80104fec:	e8 cf fb ff ff       	call   80104bc0 <argint>
80104ff1:	83 c4 10             	add    $0x10,%esp
80104ff4:	85 c0                	test   %eax,%eax
80104ff6:	78 38                	js     80105030 <sys_read+0xa0>
80104ff8:	83 ec 04             	sub    $0x4,%esp
80104ffb:	ff 75 f0             	pushl  -0x10(%ebp)
80104ffe:	53                   	push   %ebx
80104fff:	6a 01                	push   $0x1
80105001:	e8 0a fc ff ff       	call   80104c10 <argptr>
80105006:	83 c4 10             	add    $0x10,%esp
80105009:	85 c0                	test   %eax,%eax
8010500b:	78 23                	js     80105030 <sys_read+0xa0>
  return fileread(f, p, n);
8010500d:	83 ec 04             	sub    $0x4,%esp
80105010:	ff 75 f0             	pushl  -0x10(%ebp)
80105013:	ff 75 f4             	pushl  -0xc(%ebp)
80105016:	56                   	push   %esi
80105017:	e8 34 c1 ff ff       	call   80101150 <fileread>
8010501c:	83 c4 10             	add    $0x10,%esp
}
8010501f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105022:	5b                   	pop    %ebx
80105023:	5e                   	pop    %esi
80105024:	5d                   	pop    %ebp
80105025:	c3                   	ret    
80105026:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010502d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105030:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105035:	eb e8                	jmp    8010501f <sys_read+0x8f>
80105037:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010503e:	66 90                	xchg   %ax,%ax

80105040 <sys_write>:
{
80105040:	f3 0f 1e fb          	endbr32 
80105044:	55                   	push   %ebp
80105045:	89 e5                	mov    %esp,%ebp
80105047:	56                   	push   %esi
80105048:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105049:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
8010504c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010504f:	53                   	push   %ebx
80105050:	6a 00                	push   $0x0
80105052:	e8 69 fb ff ff       	call   80104bc0 <argint>
80105057:	83 c4 10             	add    $0x10,%esp
8010505a:	85 c0                	test   %eax,%eax
8010505c:	78 62                	js     801050c0 <sys_write+0x80>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010505e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105062:	77 5c                	ja     801050c0 <sys_write+0x80>
80105064:	e8 07 eb ff ff       	call   80103b70 <myproc>
80105069:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010506c:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105070:	85 f6                	test   %esi,%esi
80105072:	74 4c                	je     801050c0 <sys_write+0x80>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105074:	83 ec 08             	sub    $0x8,%esp
80105077:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010507a:	50                   	push   %eax
8010507b:	6a 02                	push   $0x2
8010507d:	e8 3e fb ff ff       	call   80104bc0 <argint>
80105082:	83 c4 10             	add    $0x10,%esp
80105085:	85 c0                	test   %eax,%eax
80105087:	78 37                	js     801050c0 <sys_write+0x80>
80105089:	83 ec 04             	sub    $0x4,%esp
8010508c:	ff 75 f0             	pushl  -0x10(%ebp)
8010508f:	53                   	push   %ebx
80105090:	6a 01                	push   $0x1
80105092:	e8 79 fb ff ff       	call   80104c10 <argptr>
80105097:	83 c4 10             	add    $0x10,%esp
8010509a:	85 c0                	test   %eax,%eax
8010509c:	78 22                	js     801050c0 <sys_write+0x80>
  return filewrite(f, p, n);
8010509e:	83 ec 04             	sub    $0x4,%esp
801050a1:	ff 75 f0             	pushl  -0x10(%ebp)
801050a4:	ff 75 f4             	pushl  -0xc(%ebp)
801050a7:	56                   	push   %esi
801050a8:	e8 43 c1 ff ff       	call   801011f0 <filewrite>
801050ad:	83 c4 10             	add    $0x10,%esp
}
801050b0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801050b3:	5b                   	pop    %ebx
801050b4:	5e                   	pop    %esi
801050b5:	5d                   	pop    %ebp
801050b6:	c3                   	ret    
801050b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801050be:	66 90                	xchg   %ax,%ax
    return -1;
801050c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050c5:	eb e9                	jmp    801050b0 <sys_write+0x70>
801050c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801050ce:	66 90                	xchg   %ax,%ax

801050d0 <sys_close>:
{
801050d0:	f3 0f 1e fb          	endbr32 
801050d4:	55                   	push   %ebp
801050d5:	89 e5                	mov    %esp,%ebp
801050d7:	56                   	push   %esi
801050d8:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801050d9:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801050dc:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801050df:	50                   	push   %eax
801050e0:	6a 00                	push   $0x0
801050e2:	e8 d9 fa ff ff       	call   80104bc0 <argint>
801050e7:	83 c4 10             	add    $0x10,%esp
801050ea:	85 c0                	test   %eax,%eax
801050ec:	78 42                	js     80105130 <sys_close+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801050ee:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801050f2:	77 3c                	ja     80105130 <sys_close+0x60>
801050f4:	e8 77 ea ff ff       	call   80103b70 <myproc>
801050f9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801050fc:	8d 5a 08             	lea    0x8(%edx),%ebx
801050ff:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
80105103:	85 f6                	test   %esi,%esi
80105105:	74 29                	je     80105130 <sys_close+0x60>
  myproc()->ofile[fd] = 0;
80105107:	e8 64 ea ff ff       	call   80103b70 <myproc>
  fileclose(f);
8010510c:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
8010510f:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
80105116:	00 
  fileclose(f);
80105117:	56                   	push   %esi
80105118:	e8 03 bf ff ff       	call   80101020 <fileclose>
  return 0;
8010511d:	83 c4 10             	add    $0x10,%esp
80105120:	31 c0                	xor    %eax,%eax
}
80105122:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105125:	5b                   	pop    %ebx
80105126:	5e                   	pop    %esi
80105127:	5d                   	pop    %ebp
80105128:	c3                   	ret    
80105129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105130:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105135:	eb eb                	jmp    80105122 <sys_close+0x52>
80105137:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010513e:	66 90                	xchg   %ax,%ax

80105140 <sys_fstat>:
{
80105140:	f3 0f 1e fb          	endbr32 
80105144:	55                   	push   %ebp
80105145:	89 e5                	mov    %esp,%ebp
80105147:	56                   	push   %esi
80105148:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105149:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
8010514c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010514f:	53                   	push   %ebx
80105150:	6a 00                	push   $0x0
80105152:	e8 69 fa ff ff       	call   80104bc0 <argint>
80105157:	83 c4 10             	add    $0x10,%esp
8010515a:	85 c0                	test   %eax,%eax
8010515c:	78 42                	js     801051a0 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010515e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105162:	77 3c                	ja     801051a0 <sys_fstat+0x60>
80105164:	e8 07 ea ff ff       	call   80103b70 <myproc>
80105169:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010516c:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105170:	85 f6                	test   %esi,%esi
80105172:	74 2c                	je     801051a0 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105174:	83 ec 04             	sub    $0x4,%esp
80105177:	6a 14                	push   $0x14
80105179:	53                   	push   %ebx
8010517a:	6a 01                	push   $0x1
8010517c:	e8 8f fa ff ff       	call   80104c10 <argptr>
80105181:	83 c4 10             	add    $0x10,%esp
80105184:	85 c0                	test   %eax,%eax
80105186:	78 18                	js     801051a0 <sys_fstat+0x60>
  return filestat(f, st);
80105188:	83 ec 08             	sub    $0x8,%esp
8010518b:	ff 75 f4             	pushl  -0xc(%ebp)
8010518e:	56                   	push   %esi
8010518f:	e8 6c bf ff ff       	call   80101100 <filestat>
80105194:	83 c4 10             	add    $0x10,%esp
}
80105197:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010519a:	5b                   	pop    %ebx
8010519b:	5e                   	pop    %esi
8010519c:	5d                   	pop    %ebp
8010519d:	c3                   	ret    
8010519e:	66 90                	xchg   %ax,%ax
    return -1;
801051a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051a5:	eb f0                	jmp    80105197 <sys_fstat+0x57>
801051a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051ae:	66 90                	xchg   %ax,%ax

801051b0 <sys_link>:
{
801051b0:	f3 0f 1e fb          	endbr32 
801051b4:	55                   	push   %ebp
801051b5:	89 e5                	mov    %esp,%ebp
801051b7:	57                   	push   %edi
801051b8:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801051b9:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
801051bc:	53                   	push   %ebx
801051bd:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801051c0:	50                   	push   %eax
801051c1:	6a 00                	push   $0x0
801051c3:	e8 b8 fa ff ff       	call   80104c80 <argstr>
801051c8:	83 c4 10             	add    $0x10,%esp
801051cb:	85 c0                	test   %eax,%eax
801051cd:	0f 88 ff 00 00 00    	js     801052d2 <sys_link+0x122>
801051d3:	83 ec 08             	sub    $0x8,%esp
801051d6:	8d 45 d0             	lea    -0x30(%ebp),%eax
801051d9:	50                   	push   %eax
801051da:	6a 01                	push   $0x1
801051dc:	e8 9f fa ff ff       	call   80104c80 <argstr>
801051e1:	83 c4 10             	add    $0x10,%esp
801051e4:	85 c0                	test   %eax,%eax
801051e6:	0f 88 e6 00 00 00    	js     801052d2 <sys_link+0x122>
  begin_op();
801051ec:	e8 1f dd ff ff       	call   80102f10 <begin_op>
  if((ip = namei(old)) == 0){
801051f1:	83 ec 0c             	sub    $0xc,%esp
801051f4:	ff 75 d4             	pushl  -0x2c(%ebp)
801051f7:	e8 14 d0 ff ff       	call   80102210 <namei>
801051fc:	83 c4 10             	add    $0x10,%esp
801051ff:	89 c3                	mov    %eax,%ebx
80105201:	85 c0                	test   %eax,%eax
80105203:	0f 84 e8 00 00 00    	je     801052f1 <sys_link+0x141>
  ilock(ip);
80105209:	83 ec 0c             	sub    $0xc,%esp
8010520c:	50                   	push   %eax
8010520d:	e8 be c6 ff ff       	call   801018d0 <ilock>
  if(ip->type == T_DIR){
80105212:	83 c4 10             	add    $0x10,%esp
80105215:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010521a:	0f 84 b9 00 00 00    	je     801052d9 <sys_link+0x129>
  iupdate(ip);
80105220:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
80105223:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105228:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
8010522b:	53                   	push   %ebx
8010522c:	e8 df c5 ff ff       	call   80101810 <iupdate>
  iunlock(ip);
80105231:	89 1c 24             	mov    %ebx,(%esp)
80105234:	e8 77 c7 ff ff       	call   801019b0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105239:	58                   	pop    %eax
8010523a:	5a                   	pop    %edx
8010523b:	57                   	push   %edi
8010523c:	ff 75 d0             	pushl  -0x30(%ebp)
8010523f:	e8 ec cf ff ff       	call   80102230 <nameiparent>
80105244:	83 c4 10             	add    $0x10,%esp
80105247:	89 c6                	mov    %eax,%esi
80105249:	85 c0                	test   %eax,%eax
8010524b:	74 5f                	je     801052ac <sys_link+0xfc>
  ilock(dp);
8010524d:	83 ec 0c             	sub    $0xc,%esp
80105250:	50                   	push   %eax
80105251:	e8 7a c6 ff ff       	call   801018d0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105256:	8b 03                	mov    (%ebx),%eax
80105258:	83 c4 10             	add    $0x10,%esp
8010525b:	39 06                	cmp    %eax,(%esi)
8010525d:	75 41                	jne    801052a0 <sys_link+0xf0>
8010525f:	83 ec 04             	sub    $0x4,%esp
80105262:	ff 73 04             	pushl  0x4(%ebx)
80105265:	57                   	push   %edi
80105266:	56                   	push   %esi
80105267:	e8 e4 ce ff ff       	call   80102150 <dirlink>
8010526c:	83 c4 10             	add    $0x10,%esp
8010526f:	85 c0                	test   %eax,%eax
80105271:	78 2d                	js     801052a0 <sys_link+0xf0>
  iunlockput(dp);
80105273:	83 ec 0c             	sub    $0xc,%esp
80105276:	56                   	push   %esi
80105277:	e8 e4 c8 ff ff       	call   80101b60 <iunlockput>
  iput(ip);
8010527c:	89 1c 24             	mov    %ebx,(%esp)
8010527f:	e8 7c c7 ff ff       	call   80101a00 <iput>
  end_op();
80105284:	e8 f7 dc ff ff       	call   80102f80 <end_op>
  return 0;
80105289:	83 c4 10             	add    $0x10,%esp
8010528c:	31 c0                	xor    %eax,%eax
}
8010528e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105291:	5b                   	pop    %ebx
80105292:	5e                   	pop    %esi
80105293:	5f                   	pop    %edi
80105294:	5d                   	pop    %ebp
80105295:	c3                   	ret    
80105296:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010529d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(dp);
801052a0:	83 ec 0c             	sub    $0xc,%esp
801052a3:	56                   	push   %esi
801052a4:	e8 b7 c8 ff ff       	call   80101b60 <iunlockput>
    goto bad;
801052a9:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
801052ac:	83 ec 0c             	sub    $0xc,%esp
801052af:	53                   	push   %ebx
801052b0:	e8 1b c6 ff ff       	call   801018d0 <ilock>
  ip->nlink--;
801052b5:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801052ba:	89 1c 24             	mov    %ebx,(%esp)
801052bd:	e8 4e c5 ff ff       	call   80101810 <iupdate>
  iunlockput(ip);
801052c2:	89 1c 24             	mov    %ebx,(%esp)
801052c5:	e8 96 c8 ff ff       	call   80101b60 <iunlockput>
  end_op();
801052ca:	e8 b1 dc ff ff       	call   80102f80 <end_op>
  return -1;
801052cf:	83 c4 10             	add    $0x10,%esp
801052d2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052d7:	eb b5                	jmp    8010528e <sys_link+0xde>
    iunlockput(ip);
801052d9:	83 ec 0c             	sub    $0xc,%esp
801052dc:	53                   	push   %ebx
801052dd:	e8 7e c8 ff ff       	call   80101b60 <iunlockput>
    end_op();
801052e2:	e8 99 dc ff ff       	call   80102f80 <end_op>
    return -1;
801052e7:	83 c4 10             	add    $0x10,%esp
801052ea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052ef:	eb 9d                	jmp    8010528e <sys_link+0xde>
    end_op();
801052f1:	e8 8a dc ff ff       	call   80102f80 <end_op>
    return -1;
801052f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052fb:	eb 91                	jmp    8010528e <sys_link+0xde>
801052fd:	8d 76 00             	lea    0x0(%esi),%esi

80105300 <sys_unlink>:
{
80105300:	f3 0f 1e fb          	endbr32 
80105304:	55                   	push   %ebp
80105305:	89 e5                	mov    %esp,%ebp
80105307:	57                   	push   %edi
80105308:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105309:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
8010530c:	53                   	push   %ebx
8010530d:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
80105310:	50                   	push   %eax
80105311:	6a 00                	push   $0x0
80105313:	e8 68 f9 ff ff       	call   80104c80 <argstr>
80105318:	83 c4 10             	add    $0x10,%esp
8010531b:	85 c0                	test   %eax,%eax
8010531d:	0f 88 86 01 00 00    	js     801054a9 <sys_unlink+0x1a9>
  begin_op();
80105323:	e8 e8 db ff ff       	call   80102f10 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105328:	8d 5d ca             	lea    -0x36(%ebp),%ebx
8010532b:	83 ec 08             	sub    $0x8,%esp
8010532e:	53                   	push   %ebx
8010532f:	ff 75 c0             	pushl  -0x40(%ebp)
80105332:	e8 f9 ce ff ff       	call   80102230 <nameiparent>
80105337:	83 c4 10             	add    $0x10,%esp
8010533a:	89 45 b4             	mov    %eax,-0x4c(%ebp)
8010533d:	85 c0                	test   %eax,%eax
8010533f:	0f 84 6e 01 00 00    	je     801054b3 <sys_unlink+0x1b3>
  ilock(dp);
80105345:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105348:	83 ec 0c             	sub    $0xc,%esp
8010534b:	57                   	push   %edi
8010534c:	e8 7f c5 ff ff       	call   801018d0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105351:	58                   	pop    %eax
80105352:	5a                   	pop    %edx
80105353:	68 98 7c 10 80       	push   $0x80107c98
80105358:	53                   	push   %ebx
80105359:	e8 c2 ca ff ff       	call   80101e20 <namecmp>
8010535e:	83 c4 10             	add    $0x10,%esp
80105361:	85 c0                	test   %eax,%eax
80105363:	0f 84 07 01 00 00    	je     80105470 <sys_unlink+0x170>
80105369:	83 ec 08             	sub    $0x8,%esp
8010536c:	68 97 7c 10 80       	push   $0x80107c97
80105371:	53                   	push   %ebx
80105372:	e8 a9 ca ff ff       	call   80101e20 <namecmp>
80105377:	83 c4 10             	add    $0x10,%esp
8010537a:	85 c0                	test   %eax,%eax
8010537c:	0f 84 ee 00 00 00    	je     80105470 <sys_unlink+0x170>
  if((ip = dirlookup(dp, name, &off)) == 0)
80105382:	83 ec 04             	sub    $0x4,%esp
80105385:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105388:	50                   	push   %eax
80105389:	53                   	push   %ebx
8010538a:	57                   	push   %edi
8010538b:	e8 b0 ca ff ff       	call   80101e40 <dirlookup>
80105390:	83 c4 10             	add    $0x10,%esp
80105393:	89 c3                	mov    %eax,%ebx
80105395:	85 c0                	test   %eax,%eax
80105397:	0f 84 d3 00 00 00    	je     80105470 <sys_unlink+0x170>
  ilock(ip);
8010539d:	83 ec 0c             	sub    $0xc,%esp
801053a0:	50                   	push   %eax
801053a1:	e8 2a c5 ff ff       	call   801018d0 <ilock>
  if(ip->nlink < 1)
801053a6:	83 c4 10             	add    $0x10,%esp
801053a9:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801053ae:	0f 8e 28 01 00 00    	jle    801054dc <sys_unlink+0x1dc>
  if(ip->type == T_DIR && !isdirempty(ip)){
801053b4:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801053b9:	8d 7d d8             	lea    -0x28(%ebp),%edi
801053bc:	74 6a                	je     80105428 <sys_unlink+0x128>
  memset(&de, 0, sizeof(de));
801053be:	83 ec 04             	sub    $0x4,%esp
801053c1:	6a 10                	push   $0x10
801053c3:	6a 00                	push   $0x0
801053c5:	57                   	push   %edi
801053c6:	e8 15 f5 ff ff       	call   801048e0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801053cb:	6a 10                	push   $0x10
801053cd:	ff 75 c4             	pushl  -0x3c(%ebp)
801053d0:	57                   	push   %edi
801053d1:	ff 75 b4             	pushl  -0x4c(%ebp)
801053d4:	e8 17 c9 ff ff       	call   80101cf0 <writei>
801053d9:	83 c4 20             	add    $0x20,%esp
801053dc:	83 f8 10             	cmp    $0x10,%eax
801053df:	0f 85 ea 00 00 00    	jne    801054cf <sys_unlink+0x1cf>
  if(ip->type == T_DIR){
801053e5:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801053ea:	0f 84 a0 00 00 00    	je     80105490 <sys_unlink+0x190>
  iunlockput(dp);
801053f0:	83 ec 0c             	sub    $0xc,%esp
801053f3:	ff 75 b4             	pushl  -0x4c(%ebp)
801053f6:	e8 65 c7 ff ff       	call   80101b60 <iunlockput>
  ip->nlink--;
801053fb:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105400:	89 1c 24             	mov    %ebx,(%esp)
80105403:	e8 08 c4 ff ff       	call   80101810 <iupdate>
  iunlockput(ip);
80105408:	89 1c 24             	mov    %ebx,(%esp)
8010540b:	e8 50 c7 ff ff       	call   80101b60 <iunlockput>
  end_op();
80105410:	e8 6b db ff ff       	call   80102f80 <end_op>
  return 0;
80105415:	83 c4 10             	add    $0x10,%esp
80105418:	31 c0                	xor    %eax,%eax
}
8010541a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010541d:	5b                   	pop    %ebx
8010541e:	5e                   	pop    %esi
8010541f:	5f                   	pop    %edi
80105420:	5d                   	pop    %ebp
80105421:	c3                   	ret    
80105422:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105428:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
8010542c:	76 90                	jbe    801053be <sys_unlink+0xbe>
8010542e:	be 20 00 00 00       	mov    $0x20,%esi
80105433:	eb 0f                	jmp    80105444 <sys_unlink+0x144>
80105435:	8d 76 00             	lea    0x0(%esi),%esi
80105438:	83 c6 10             	add    $0x10,%esi
8010543b:	3b 73 58             	cmp    0x58(%ebx),%esi
8010543e:	0f 83 7a ff ff ff    	jae    801053be <sys_unlink+0xbe>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105444:	6a 10                	push   $0x10
80105446:	56                   	push   %esi
80105447:	57                   	push   %edi
80105448:	53                   	push   %ebx
80105449:	e8 a2 c7 ff ff       	call   80101bf0 <readi>
8010544e:	83 c4 10             	add    $0x10,%esp
80105451:	83 f8 10             	cmp    $0x10,%eax
80105454:	75 6c                	jne    801054c2 <sys_unlink+0x1c2>
    if(de.inum != 0)
80105456:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010545b:	74 db                	je     80105438 <sys_unlink+0x138>
    iunlockput(ip);
8010545d:	83 ec 0c             	sub    $0xc,%esp
80105460:	53                   	push   %ebx
80105461:	e8 fa c6 ff ff       	call   80101b60 <iunlockput>
    goto bad;
80105466:	83 c4 10             	add    $0x10,%esp
80105469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlockput(dp);
80105470:	83 ec 0c             	sub    $0xc,%esp
80105473:	ff 75 b4             	pushl  -0x4c(%ebp)
80105476:	e8 e5 c6 ff ff       	call   80101b60 <iunlockput>
  end_op();
8010547b:	e8 00 db ff ff       	call   80102f80 <end_op>
  return -1;
80105480:	83 c4 10             	add    $0x10,%esp
80105483:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105488:	eb 90                	jmp    8010541a <sys_unlink+0x11a>
8010548a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80105490:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105493:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105496:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
8010549b:	50                   	push   %eax
8010549c:	e8 6f c3 ff ff       	call   80101810 <iupdate>
801054a1:	83 c4 10             	add    $0x10,%esp
801054a4:	e9 47 ff ff ff       	jmp    801053f0 <sys_unlink+0xf0>
    return -1;
801054a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054ae:	e9 67 ff ff ff       	jmp    8010541a <sys_unlink+0x11a>
    end_op();
801054b3:	e8 c8 da ff ff       	call   80102f80 <end_op>
    return -1;
801054b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054bd:	e9 58 ff ff ff       	jmp    8010541a <sys_unlink+0x11a>
      panic("isdirempty: readi");
801054c2:	83 ec 0c             	sub    $0xc,%esp
801054c5:	68 bc 7c 10 80       	push   $0x80107cbc
801054ca:	e8 c1 ae ff ff       	call   80100390 <panic>
    panic("unlink: writei");
801054cf:	83 ec 0c             	sub    $0xc,%esp
801054d2:	68 ce 7c 10 80       	push   $0x80107cce
801054d7:	e8 b4 ae ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
801054dc:	83 ec 0c             	sub    $0xc,%esp
801054df:	68 aa 7c 10 80       	push   $0x80107caa
801054e4:	e8 a7 ae ff ff       	call   80100390 <panic>
801054e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801054f0 <sys_open>:

int
sys_open(void)
{
801054f0:	f3 0f 1e fb          	endbr32 
801054f4:	55                   	push   %ebp
801054f5:	89 e5                	mov    %esp,%ebp
801054f7:	57                   	push   %edi
801054f8:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801054f9:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
801054fc:	53                   	push   %ebx
801054fd:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105500:	50                   	push   %eax
80105501:	6a 00                	push   $0x0
80105503:	e8 78 f7 ff ff       	call   80104c80 <argstr>
80105508:	83 c4 10             	add    $0x10,%esp
8010550b:	85 c0                	test   %eax,%eax
8010550d:	0f 88 8a 00 00 00    	js     8010559d <sys_open+0xad>
80105513:	83 ec 08             	sub    $0x8,%esp
80105516:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105519:	50                   	push   %eax
8010551a:	6a 01                	push   $0x1
8010551c:	e8 9f f6 ff ff       	call   80104bc0 <argint>
80105521:	83 c4 10             	add    $0x10,%esp
80105524:	85 c0                	test   %eax,%eax
80105526:	78 75                	js     8010559d <sys_open+0xad>
    return -1;

  begin_op();
80105528:	e8 e3 d9 ff ff       	call   80102f10 <begin_op>

  if(omode & O_CREATE){
8010552d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105531:	75 75                	jne    801055a8 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105533:	83 ec 0c             	sub    $0xc,%esp
80105536:	ff 75 e0             	pushl  -0x20(%ebp)
80105539:	e8 d2 cc ff ff       	call   80102210 <namei>
8010553e:	83 c4 10             	add    $0x10,%esp
80105541:	89 c6                	mov    %eax,%esi
80105543:	85 c0                	test   %eax,%eax
80105545:	74 7e                	je     801055c5 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80105547:	83 ec 0c             	sub    $0xc,%esp
8010554a:	50                   	push   %eax
8010554b:	e8 80 c3 ff ff       	call   801018d0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105550:	83 c4 10             	add    $0x10,%esp
80105553:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105558:	0f 84 c2 00 00 00    	je     80105620 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010555e:	e8 fd b9 ff ff       	call   80100f60 <filealloc>
80105563:	89 c7                	mov    %eax,%edi
80105565:	85 c0                	test   %eax,%eax
80105567:	74 23                	je     8010558c <sys_open+0x9c>
  struct proc *curproc = myproc();
80105569:	e8 02 e6 ff ff       	call   80103b70 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010556e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105570:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105574:	85 d2                	test   %edx,%edx
80105576:	74 60                	je     801055d8 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
80105578:	83 c3 01             	add    $0x1,%ebx
8010557b:	83 fb 10             	cmp    $0x10,%ebx
8010557e:	75 f0                	jne    80105570 <sys_open+0x80>
    if(f)
      fileclose(f);
80105580:	83 ec 0c             	sub    $0xc,%esp
80105583:	57                   	push   %edi
80105584:	e8 97 ba ff ff       	call   80101020 <fileclose>
80105589:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010558c:	83 ec 0c             	sub    $0xc,%esp
8010558f:	56                   	push   %esi
80105590:	e8 cb c5 ff ff       	call   80101b60 <iunlockput>
    end_op();
80105595:	e8 e6 d9 ff ff       	call   80102f80 <end_op>
    return -1;
8010559a:	83 c4 10             	add    $0x10,%esp
8010559d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801055a2:	eb 6d                	jmp    80105611 <sys_open+0x121>
801055a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
801055a8:	83 ec 0c             	sub    $0xc,%esp
801055ab:	8b 45 e0             	mov    -0x20(%ebp),%eax
801055ae:	31 c9                	xor    %ecx,%ecx
801055b0:	ba 02 00 00 00       	mov    $0x2,%edx
801055b5:	6a 00                	push   $0x0
801055b7:	e8 b4 f7 ff ff       	call   80104d70 <create>
    if(ip == 0){
801055bc:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
801055bf:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801055c1:	85 c0                	test   %eax,%eax
801055c3:	75 99                	jne    8010555e <sys_open+0x6e>
      end_op();
801055c5:	e8 b6 d9 ff ff       	call   80102f80 <end_op>
      return -1;
801055ca:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801055cf:	eb 40                	jmp    80105611 <sys_open+0x121>
801055d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
801055d8:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801055db:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
801055df:	56                   	push   %esi
801055e0:	e8 cb c3 ff ff       	call   801019b0 <iunlock>
  end_op();
801055e5:	e8 96 d9 ff ff       	call   80102f80 <end_op>

  f->type = FD_INODE;
801055ea:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801055f0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801055f3:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801055f6:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
801055f9:	89 d0                	mov    %edx,%eax
  f->off = 0;
801055fb:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105602:	f7 d0                	not    %eax
80105604:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105607:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
8010560a:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010560d:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105611:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105614:	89 d8                	mov    %ebx,%eax
80105616:	5b                   	pop    %ebx
80105617:	5e                   	pop    %esi
80105618:	5f                   	pop    %edi
80105619:	5d                   	pop    %ebp
8010561a:	c3                   	ret    
8010561b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010561f:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
80105620:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105623:	85 c9                	test   %ecx,%ecx
80105625:	0f 84 33 ff ff ff    	je     8010555e <sys_open+0x6e>
8010562b:	e9 5c ff ff ff       	jmp    8010558c <sys_open+0x9c>

80105630 <sys_mkdir>:

int
sys_mkdir(void)
{
80105630:	f3 0f 1e fb          	endbr32 
80105634:	55                   	push   %ebp
80105635:	89 e5                	mov    %esp,%ebp
80105637:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
8010563a:	e8 d1 d8 ff ff       	call   80102f10 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010563f:	83 ec 08             	sub    $0x8,%esp
80105642:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105645:	50                   	push   %eax
80105646:	6a 00                	push   $0x0
80105648:	e8 33 f6 ff ff       	call   80104c80 <argstr>
8010564d:	83 c4 10             	add    $0x10,%esp
80105650:	85 c0                	test   %eax,%eax
80105652:	78 34                	js     80105688 <sys_mkdir+0x58>
80105654:	83 ec 0c             	sub    $0xc,%esp
80105657:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010565a:	31 c9                	xor    %ecx,%ecx
8010565c:	ba 01 00 00 00       	mov    $0x1,%edx
80105661:	6a 00                	push   $0x0
80105663:	e8 08 f7 ff ff       	call   80104d70 <create>
80105668:	83 c4 10             	add    $0x10,%esp
8010566b:	85 c0                	test   %eax,%eax
8010566d:	74 19                	je     80105688 <sys_mkdir+0x58>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010566f:	83 ec 0c             	sub    $0xc,%esp
80105672:	50                   	push   %eax
80105673:	e8 e8 c4 ff ff       	call   80101b60 <iunlockput>
  end_op();
80105678:	e8 03 d9 ff ff       	call   80102f80 <end_op>
  return 0;
8010567d:	83 c4 10             	add    $0x10,%esp
80105680:	31 c0                	xor    %eax,%eax
}
80105682:	c9                   	leave  
80105683:	c3                   	ret    
80105684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105688:	e8 f3 d8 ff ff       	call   80102f80 <end_op>
    return -1;
8010568d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105692:	c9                   	leave  
80105693:	c3                   	ret    
80105694:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010569b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010569f:	90                   	nop

801056a0 <sys_mknod>:

int
sys_mknod(void)
{
801056a0:	f3 0f 1e fb          	endbr32 
801056a4:	55                   	push   %ebp
801056a5:	89 e5                	mov    %esp,%ebp
801056a7:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801056aa:	e8 61 d8 ff ff       	call   80102f10 <begin_op>
  if((argstr(0, &path)) < 0 ||
801056af:	83 ec 08             	sub    $0x8,%esp
801056b2:	8d 45 ec             	lea    -0x14(%ebp),%eax
801056b5:	50                   	push   %eax
801056b6:	6a 00                	push   $0x0
801056b8:	e8 c3 f5 ff ff       	call   80104c80 <argstr>
801056bd:	83 c4 10             	add    $0x10,%esp
801056c0:	85 c0                	test   %eax,%eax
801056c2:	78 64                	js     80105728 <sys_mknod+0x88>
     argint(1, &major) < 0 ||
801056c4:	83 ec 08             	sub    $0x8,%esp
801056c7:	8d 45 f0             	lea    -0x10(%ebp),%eax
801056ca:	50                   	push   %eax
801056cb:	6a 01                	push   $0x1
801056cd:	e8 ee f4 ff ff       	call   80104bc0 <argint>
  if((argstr(0, &path)) < 0 ||
801056d2:	83 c4 10             	add    $0x10,%esp
801056d5:	85 c0                	test   %eax,%eax
801056d7:	78 4f                	js     80105728 <sys_mknod+0x88>
     argint(2, &minor) < 0 ||
801056d9:	83 ec 08             	sub    $0x8,%esp
801056dc:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056df:	50                   	push   %eax
801056e0:	6a 02                	push   $0x2
801056e2:	e8 d9 f4 ff ff       	call   80104bc0 <argint>
     argint(1, &major) < 0 ||
801056e7:	83 c4 10             	add    $0x10,%esp
801056ea:	85 c0                	test   %eax,%eax
801056ec:	78 3a                	js     80105728 <sys_mknod+0x88>
     (ip = create(path, T_DEV, major, minor)) == 0){
801056ee:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801056f2:	83 ec 0c             	sub    $0xc,%esp
801056f5:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801056f9:	ba 03 00 00 00       	mov    $0x3,%edx
801056fe:	50                   	push   %eax
801056ff:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105702:	e8 69 f6 ff ff       	call   80104d70 <create>
     argint(2, &minor) < 0 ||
80105707:	83 c4 10             	add    $0x10,%esp
8010570a:	85 c0                	test   %eax,%eax
8010570c:	74 1a                	je     80105728 <sys_mknod+0x88>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010570e:	83 ec 0c             	sub    $0xc,%esp
80105711:	50                   	push   %eax
80105712:	e8 49 c4 ff ff       	call   80101b60 <iunlockput>
  end_op();
80105717:	e8 64 d8 ff ff       	call   80102f80 <end_op>
  return 0;
8010571c:	83 c4 10             	add    $0x10,%esp
8010571f:	31 c0                	xor    %eax,%eax
}
80105721:	c9                   	leave  
80105722:	c3                   	ret    
80105723:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105727:	90                   	nop
    end_op();
80105728:	e8 53 d8 ff ff       	call   80102f80 <end_op>
    return -1;
8010572d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105732:	c9                   	leave  
80105733:	c3                   	ret    
80105734:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010573b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010573f:	90                   	nop

80105740 <sys_chdir>:

int
sys_chdir(void)
{
80105740:	f3 0f 1e fb          	endbr32 
80105744:	55                   	push   %ebp
80105745:	89 e5                	mov    %esp,%ebp
80105747:	56                   	push   %esi
80105748:	53                   	push   %ebx
80105749:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
8010574c:	e8 1f e4 ff ff       	call   80103b70 <myproc>
80105751:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105753:	e8 b8 d7 ff ff       	call   80102f10 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105758:	83 ec 08             	sub    $0x8,%esp
8010575b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010575e:	50                   	push   %eax
8010575f:	6a 00                	push   $0x0
80105761:	e8 1a f5 ff ff       	call   80104c80 <argstr>
80105766:	83 c4 10             	add    $0x10,%esp
80105769:	85 c0                	test   %eax,%eax
8010576b:	78 73                	js     801057e0 <sys_chdir+0xa0>
8010576d:	83 ec 0c             	sub    $0xc,%esp
80105770:	ff 75 f4             	pushl  -0xc(%ebp)
80105773:	e8 98 ca ff ff       	call   80102210 <namei>
80105778:	83 c4 10             	add    $0x10,%esp
8010577b:	89 c3                	mov    %eax,%ebx
8010577d:	85 c0                	test   %eax,%eax
8010577f:	74 5f                	je     801057e0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105781:	83 ec 0c             	sub    $0xc,%esp
80105784:	50                   	push   %eax
80105785:	e8 46 c1 ff ff       	call   801018d0 <ilock>
  if(ip->type != T_DIR){
8010578a:	83 c4 10             	add    $0x10,%esp
8010578d:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105792:	75 2c                	jne    801057c0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105794:	83 ec 0c             	sub    $0xc,%esp
80105797:	53                   	push   %ebx
80105798:	e8 13 c2 ff ff       	call   801019b0 <iunlock>
  iput(curproc->cwd);
8010579d:	58                   	pop    %eax
8010579e:	ff 76 68             	pushl  0x68(%esi)
801057a1:	e8 5a c2 ff ff       	call   80101a00 <iput>
  end_op();
801057a6:	e8 d5 d7 ff ff       	call   80102f80 <end_op>
  curproc->cwd = ip;
801057ab:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
801057ae:	83 c4 10             	add    $0x10,%esp
801057b1:	31 c0                	xor    %eax,%eax
}
801057b3:	8d 65 f8             	lea    -0x8(%ebp),%esp
801057b6:	5b                   	pop    %ebx
801057b7:	5e                   	pop    %esi
801057b8:	5d                   	pop    %ebp
801057b9:	c3                   	ret    
801057ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
801057c0:	83 ec 0c             	sub    $0xc,%esp
801057c3:	53                   	push   %ebx
801057c4:	e8 97 c3 ff ff       	call   80101b60 <iunlockput>
    end_op();
801057c9:	e8 b2 d7 ff ff       	call   80102f80 <end_op>
    return -1;
801057ce:	83 c4 10             	add    $0x10,%esp
801057d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057d6:	eb db                	jmp    801057b3 <sys_chdir+0x73>
801057d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801057df:	90                   	nop
    end_op();
801057e0:	e8 9b d7 ff ff       	call   80102f80 <end_op>
    return -1;
801057e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057ea:	eb c7                	jmp    801057b3 <sys_chdir+0x73>
801057ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801057f0 <sys_exec>:

int
sys_exec(void)
{
801057f0:	f3 0f 1e fb          	endbr32 
801057f4:	55                   	push   %ebp
801057f5:	89 e5                	mov    %esp,%ebp
801057f7:	57                   	push   %edi
801057f8:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801057f9:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
801057ff:	53                   	push   %ebx
80105800:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105806:	50                   	push   %eax
80105807:	6a 00                	push   $0x0
80105809:	e8 72 f4 ff ff       	call   80104c80 <argstr>
8010580e:	83 c4 10             	add    $0x10,%esp
80105811:	85 c0                	test   %eax,%eax
80105813:	0f 88 83 00 00 00    	js     8010589c <sys_exec+0xac>
80105819:	83 ec 08             	sub    $0x8,%esp
8010581c:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105822:	50                   	push   %eax
80105823:	6a 01                	push   $0x1
80105825:	e8 96 f3 ff ff       	call   80104bc0 <argint>
8010582a:	83 c4 10             	add    $0x10,%esp
8010582d:	85 c0                	test   %eax,%eax
8010582f:	78 6b                	js     8010589c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105831:	83 ec 04             	sub    $0x4,%esp
80105834:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
8010583a:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
8010583c:	68 80 00 00 00       	push   $0x80
80105841:	6a 00                	push   $0x0
80105843:	56                   	push   %esi
80105844:	e8 97 f0 ff ff       	call   801048e0 <memset>
80105849:	83 c4 10             	add    $0x10,%esp
8010584c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105850:	83 ec 08             	sub    $0x8,%esp
80105853:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80105859:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80105860:	50                   	push   %eax
80105861:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105867:	01 f8                	add    %edi,%eax
80105869:	50                   	push   %eax
8010586a:	e8 b1 f2 ff ff       	call   80104b20 <fetchint>
8010586f:	83 c4 10             	add    $0x10,%esp
80105872:	85 c0                	test   %eax,%eax
80105874:	78 26                	js     8010589c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80105876:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010587c:	85 c0                	test   %eax,%eax
8010587e:	74 30                	je     801058b0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105880:	83 ec 08             	sub    $0x8,%esp
80105883:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80105886:	52                   	push   %edx
80105887:	50                   	push   %eax
80105888:	e8 d3 f2 ff ff       	call   80104b60 <fetchstr>
8010588d:	83 c4 10             	add    $0x10,%esp
80105890:	85 c0                	test   %eax,%eax
80105892:	78 08                	js     8010589c <sys_exec+0xac>
  for(i=0;; i++){
80105894:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105897:	83 fb 20             	cmp    $0x20,%ebx
8010589a:	75 b4                	jne    80105850 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010589c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010589f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801058a4:	5b                   	pop    %ebx
801058a5:	5e                   	pop    %esi
801058a6:	5f                   	pop    %edi
801058a7:	5d                   	pop    %ebp
801058a8:	c3                   	ret    
801058a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
801058b0:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801058b7:	00 00 00 00 
  return exec(path, argv);
801058bb:	83 ec 08             	sub    $0x8,%esp
801058be:	56                   	push   %esi
801058bf:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
801058c5:	e8 16 b3 ff ff       	call   80100be0 <exec>
801058ca:	83 c4 10             	add    $0x10,%esp
}
801058cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801058d0:	5b                   	pop    %ebx
801058d1:	5e                   	pop    %esi
801058d2:	5f                   	pop    %edi
801058d3:	5d                   	pop    %ebp
801058d4:	c3                   	ret    
801058d5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801058dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801058e0 <sys_pipe>:

int
sys_pipe(void)
{
801058e0:	f3 0f 1e fb          	endbr32 
801058e4:	55                   	push   %ebp
801058e5:	89 e5                	mov    %esp,%ebp
801058e7:	57                   	push   %edi
801058e8:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801058e9:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
801058ec:	53                   	push   %ebx
801058ed:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801058f0:	6a 08                	push   $0x8
801058f2:	50                   	push   %eax
801058f3:	6a 00                	push   $0x0
801058f5:	e8 16 f3 ff ff       	call   80104c10 <argptr>
801058fa:	83 c4 10             	add    $0x10,%esp
801058fd:	85 c0                	test   %eax,%eax
801058ff:	78 4e                	js     8010594f <sys_pipe+0x6f>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105901:	83 ec 08             	sub    $0x8,%esp
80105904:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105907:	50                   	push   %eax
80105908:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010590b:	50                   	push   %eax
8010590c:	e8 ef dc ff ff       	call   80103600 <pipealloc>
80105911:	83 c4 10             	add    $0x10,%esp
80105914:	85 c0                	test   %eax,%eax
80105916:	78 37                	js     8010594f <sys_pipe+0x6f>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105918:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010591b:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010591d:	e8 4e e2 ff ff       	call   80103b70 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105922:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd] == 0){
80105928:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
8010592c:	85 f6                	test   %esi,%esi
8010592e:	74 30                	je     80105960 <sys_pipe+0x80>
  for(fd = 0; fd < NOFILE; fd++){
80105930:	83 c3 01             	add    $0x1,%ebx
80105933:	83 fb 10             	cmp    $0x10,%ebx
80105936:	75 f0                	jne    80105928 <sys_pipe+0x48>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80105938:	83 ec 0c             	sub    $0xc,%esp
8010593b:	ff 75 e0             	pushl  -0x20(%ebp)
8010593e:	e8 dd b6 ff ff       	call   80101020 <fileclose>
    fileclose(wf);
80105943:	58                   	pop    %eax
80105944:	ff 75 e4             	pushl  -0x1c(%ebp)
80105947:	e8 d4 b6 ff ff       	call   80101020 <fileclose>
    return -1;
8010594c:	83 c4 10             	add    $0x10,%esp
8010594f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105954:	eb 5b                	jmp    801059b1 <sys_pipe+0xd1>
80105956:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010595d:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
80105960:	8d 73 08             	lea    0x8(%ebx),%esi
80105963:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105967:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010596a:	e8 01 e2 ff ff       	call   80103b70 <myproc>
8010596f:	89 c2                	mov    %eax,%edx
  for(fd = 0; fd < NOFILE; fd++){
80105971:	31 c0                	xor    %eax,%eax
80105973:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105977:	90                   	nop
    if(curproc->ofile[fd] == 0){
80105978:	8b 4c 82 28          	mov    0x28(%edx,%eax,4),%ecx
8010597c:	85 c9                	test   %ecx,%ecx
8010597e:	74 20                	je     801059a0 <sys_pipe+0xc0>
  for(fd = 0; fd < NOFILE; fd++){
80105980:	83 c0 01             	add    $0x1,%eax
80105983:	83 f8 10             	cmp    $0x10,%eax
80105986:	75 f0                	jne    80105978 <sys_pipe+0x98>
      myproc()->ofile[fd0] = 0;
80105988:	e8 e3 e1 ff ff       	call   80103b70 <myproc>
8010598d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105994:	00 
80105995:	eb a1                	jmp    80105938 <sys_pipe+0x58>
80105997:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010599e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
801059a0:	89 7c 82 28          	mov    %edi,0x28(%edx,%eax,4)
  }
  fd[0] = fd0;
801059a4:	8b 55 dc             	mov    -0x24(%ebp),%edx
801059a7:	89 1a                	mov    %ebx,(%edx)
  fd[1] = fd1;
801059a9:	8b 55 dc             	mov    -0x24(%ebp),%edx
801059ac:	89 42 04             	mov    %eax,0x4(%edx)
  return 0;
801059af:	31 c0                	xor    %eax,%eax
}
801059b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801059b4:	5b                   	pop    %ebx
801059b5:	5e                   	pop    %esi
801059b6:	5f                   	pop    %edi
801059b7:	5d                   	pop    %ebp
801059b8:	c3                   	ret    
801059b9:	66 90                	xchg   %ax,%ax
801059bb:	66 90                	xchg   %ax,%ax
801059bd:	66 90                	xchg   %ax,%ax
801059bf:	90                   	nop

801059c0 <sys_fork>:
struct spinlock readcountlock;
uint readcount;

int
sys_fork(void)
{
801059c0:	f3 0f 1e fb          	endbr32 
  return fork();
801059c4:	e9 57 e3 ff ff       	jmp    80103d20 <fork>
801059c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801059d0 <sys_exit>:
}

int
sys_exit(void)
{
801059d0:	f3 0f 1e fb          	endbr32 
801059d4:	55                   	push   %ebp
801059d5:	89 e5                	mov    %esp,%ebp
801059d7:	83 ec 08             	sub    $0x8,%esp
  exit();
801059da:	e8 c1 e5 ff ff       	call   80103fa0 <exit>
  return 0;  // not reached
}
801059df:	31 c0                	xor    %eax,%eax
801059e1:	c9                   	leave  
801059e2:	c3                   	ret    
801059e3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801059f0 <sys_wait>:

int
sys_wait(void)
{
801059f0:	f3 0f 1e fb          	endbr32 
  return wait();
801059f4:	e9 d7 e6 ff ff       	jmp    801040d0 <wait>
801059f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105a00 <sys_kill>:
}

int
sys_kill(void)
{
80105a00:	f3 0f 1e fb          	endbr32 
80105a04:	55                   	push   %ebp
80105a05:	89 e5                	mov    %esp,%ebp
80105a07:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105a0a:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a0d:	50                   	push   %eax
80105a0e:	6a 00                	push   $0x0
80105a10:	e8 ab f1 ff ff       	call   80104bc0 <argint>
80105a15:	83 c4 10             	add    $0x10,%esp
80105a18:	85 c0                	test   %eax,%eax
80105a1a:	78 14                	js     80105a30 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105a1c:	83 ec 0c             	sub    $0xc,%esp
80105a1f:	ff 75 f4             	pushl  -0xc(%ebp)
80105a22:	e8 49 e9 ff ff       	call   80104370 <kill>
80105a27:	83 c4 10             	add    $0x10,%esp
}
80105a2a:	c9                   	leave  
80105a2b:	c3                   	ret    
80105a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a30:	c9                   	leave  
    return -1;
80105a31:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a36:	c3                   	ret    
80105a37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a3e:	66 90                	xchg   %ax,%ax

80105a40 <sys_getpid>:

int
sys_getpid(void)
{
80105a40:	f3 0f 1e fb          	endbr32 
80105a44:	55                   	push   %ebp
80105a45:	89 e5                	mov    %esp,%ebp
80105a47:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105a4a:	e8 21 e1 ff ff       	call   80103b70 <myproc>
80105a4f:	8b 40 10             	mov    0x10(%eax),%eax
}
80105a52:	c9                   	leave  
80105a53:	c3                   	ret    
80105a54:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a5f:	90                   	nop

80105a60 <sys_sbrk>:

int
sys_sbrk(void)
{
80105a60:	f3 0f 1e fb          	endbr32 
80105a64:	55                   	push   %ebp
80105a65:	89 e5                	mov    %esp,%ebp
80105a67:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105a68:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105a6b:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105a6e:	50                   	push   %eax
80105a6f:	6a 00                	push   $0x0
80105a71:	e8 4a f1 ff ff       	call   80104bc0 <argint>
80105a76:	83 c4 10             	add    $0x10,%esp
80105a79:	85 c0                	test   %eax,%eax
80105a7b:	78 23                	js     80105aa0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105a7d:	e8 ee e0 ff ff       	call   80103b70 <myproc>
  if(growproc(n) < 0)
80105a82:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105a85:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105a87:	ff 75 f4             	pushl  -0xc(%ebp)
80105a8a:	e8 11 e2 ff ff       	call   80103ca0 <growproc>
80105a8f:	83 c4 10             	add    $0x10,%esp
80105a92:	85 c0                	test   %eax,%eax
80105a94:	78 0a                	js     80105aa0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105a96:	89 d8                	mov    %ebx,%eax
80105a98:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105a9b:	c9                   	leave  
80105a9c:	c3                   	ret    
80105a9d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105aa0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105aa5:	eb ef                	jmp    80105a96 <sys_sbrk+0x36>
80105aa7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105aae:	66 90                	xchg   %ax,%ax

80105ab0 <sys_sleep>:

int
sys_sleep(void)
{
80105ab0:	f3 0f 1e fb          	endbr32 
80105ab4:	55                   	push   %ebp
80105ab5:	89 e5                	mov    %esp,%ebp
80105ab7:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105ab8:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105abb:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105abe:	50                   	push   %eax
80105abf:	6a 00                	push   $0x0
80105ac1:	e8 fa f0 ff ff       	call   80104bc0 <argint>
80105ac6:	83 c4 10             	add    $0x10,%esp
80105ac9:	85 c0                	test   %eax,%eax
80105acb:	0f 88 86 00 00 00    	js     80105b57 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105ad1:	83 ec 0c             	sub    $0xc,%esp
80105ad4:	68 e0 3c 11 80       	push   $0x80113ce0
80105ad9:	e8 32 ed ff ff       	call   80104810 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105ade:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80105ae1:	8b 1d c0 3c 11 80    	mov    0x80113cc0,%ebx
  while(ticks - ticks0 < n){
80105ae7:	83 c4 10             	add    $0x10,%esp
80105aea:	85 d2                	test   %edx,%edx
80105aec:	75 23                	jne    80105b11 <sys_sleep+0x61>
80105aee:	eb 50                	jmp    80105b40 <sys_sleep+0x90>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105af0:	83 ec 08             	sub    $0x8,%esp
80105af3:	68 e0 3c 11 80       	push   $0x80113ce0
80105af8:	68 c0 3c 11 80       	push   $0x80113cc0
80105afd:	e8 4e e7 ff ff       	call   80104250 <sleep>
  while(ticks - ticks0 < n){
80105b02:	a1 c0 3c 11 80       	mov    0x80113cc0,%eax
80105b07:	83 c4 10             	add    $0x10,%esp
80105b0a:	29 d8                	sub    %ebx,%eax
80105b0c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105b0f:	73 2f                	jae    80105b40 <sys_sleep+0x90>
    if(myproc()->killed){
80105b11:	e8 5a e0 ff ff       	call   80103b70 <myproc>
80105b16:	8b 40 24             	mov    0x24(%eax),%eax
80105b19:	85 c0                	test   %eax,%eax
80105b1b:	74 d3                	je     80105af0 <sys_sleep+0x40>
      release(&tickslock);
80105b1d:	83 ec 0c             	sub    $0xc,%esp
80105b20:	68 e0 3c 11 80       	push   $0x80113ce0
80105b25:	e8 76 ec ff ff       	call   801047a0 <release>
  }
  release(&tickslock);
  return 0;
}
80105b2a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
80105b2d:	83 c4 10             	add    $0x10,%esp
80105b30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b35:	c9                   	leave  
80105b36:	c3                   	ret    
80105b37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b3e:	66 90                	xchg   %ax,%ax
  release(&tickslock);
80105b40:	83 ec 0c             	sub    $0xc,%esp
80105b43:	68 e0 3c 11 80       	push   $0x80113ce0
80105b48:	e8 53 ec ff ff       	call   801047a0 <release>
  return 0;
80105b4d:	83 c4 10             	add    $0x10,%esp
80105b50:	31 c0                	xor    %eax,%eax
}
80105b52:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105b55:	c9                   	leave  
80105b56:	c3                   	ret    
    return -1;
80105b57:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b5c:	eb f4                	jmp    80105b52 <sys_sleep+0xa2>
80105b5e:	66 90                	xchg   %ax,%ax

80105b60 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105b60:	f3 0f 1e fb          	endbr32 
80105b64:	55                   	push   %ebp
80105b65:	89 e5                	mov    %esp,%ebp
80105b67:	53                   	push   %ebx
80105b68:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105b6b:	68 e0 3c 11 80       	push   $0x80113ce0
80105b70:	e8 9b ec ff ff       	call   80104810 <acquire>
  xticks = ticks;
80105b75:	8b 1d c0 3c 11 80    	mov    0x80113cc0,%ebx
  release(&tickslock);
80105b7b:	c7 04 24 e0 3c 11 80 	movl   $0x80113ce0,(%esp)
80105b82:	e8 19 ec ff ff       	call   801047a0 <release>
  return xticks;
}
80105b87:	89 d8                	mov    %ebx,%eax
80105b89:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105b8c:	c9                   	leave  
80105b8d:	c3                   	ret    
80105b8e:	66 90                	xchg   %ax,%ax

80105b90 <sys_getreadcount>:

//new syscall
int
sys_getreadcount(void)
{
80105b90:	f3 0f 1e fb          	endbr32 
80105b94:	55                   	push   %ebp
80105b95:	89 e5                	mov    %esp,%ebp
80105b97:	53                   	push   %ebx
80105b98:	83 ec 10             	sub    $0x10,%esp
  uint count;
  acquire(&readcountlock);
80105b9b:	68 80 3c 11 80       	push   $0x80113c80
80105ba0:	e8 6b ec ff ff       	call   80104810 <acquire>
  count = readcount;
80105ba5:	8b 1d 60 3c 11 80    	mov    0x80113c60,%ebx
  release(&readcountlock);
80105bab:	c7 04 24 80 3c 11 80 	movl   $0x80113c80,(%esp)
80105bb2:	e8 e9 eb ff ff       	call   801047a0 <release>
  return count;
80105bb7:	89 d8                	mov    %ebx,%eax
80105bb9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105bbc:	c9                   	leave  
80105bbd:	c3                   	ret    

80105bbe <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105bbe:	1e                   	push   %ds
  pushl %es
80105bbf:	06                   	push   %es
  pushl %fs
80105bc0:	0f a0                	push   %fs
  pushl %gs
80105bc2:	0f a8                	push   %gs
  pushal
80105bc4:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105bc5:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105bc9:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105bcb:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105bcd:	54                   	push   %esp
  call trap
80105bce:	e8 cd 00 00 00       	call   80105ca0 <trap>
  addl $4, %esp
80105bd3:	83 c4 04             	add    $0x4,%esp

80105bd6 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105bd6:	61                   	popa   
  popl %gs
80105bd7:	0f a9                	pop    %gs
  popl %fs
80105bd9:	0f a1                	pop    %fs
  popl %es
80105bdb:	07                   	pop    %es
  popl %ds
80105bdc:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105bdd:	83 c4 08             	add    $0x8,%esp
  iret
80105be0:	cf                   	iret   
80105be1:	66 90                	xchg   %ax,%ax
80105be3:	66 90                	xchg   %ax,%ax
80105be5:	66 90                	xchg   %ax,%ax
80105be7:	66 90                	xchg   %ax,%ax
80105be9:	66 90                	xchg   %ax,%ax
80105beb:	66 90                	xchg   %ax,%ax
80105bed:	66 90                	xchg   %ax,%ax
80105bef:	90                   	nop

80105bf0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105bf0:	f3 0f 1e fb          	endbr32 
80105bf4:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105bf5:	31 c0                	xor    %eax,%eax
{
80105bf7:	89 e5                	mov    %esp,%ebp
80105bf9:	83 ec 08             	sub    $0x8,%esp
80105bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105c00:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105c07:	c7 04 c5 22 3d 11 80 	movl   $0x8e000008,-0x7feec2de(,%eax,8)
80105c0e:	08 00 00 8e 
80105c12:	66 89 14 c5 20 3d 11 	mov    %dx,-0x7feec2e0(,%eax,8)
80105c19:	80 
80105c1a:	c1 ea 10             	shr    $0x10,%edx
80105c1d:	66 89 14 c5 26 3d 11 	mov    %dx,-0x7feec2da(,%eax,8)
80105c24:	80 
  for(i = 0; i < 256; i++)
80105c25:	83 c0 01             	add    $0x1,%eax
80105c28:	3d 00 01 00 00       	cmp    $0x100,%eax
80105c2d:	75 d1                	jne    80105c00 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
80105c2f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105c32:	a1 08 a1 10 80       	mov    0x8010a108,%eax
80105c37:	c7 05 22 3f 11 80 08 	movl   $0xef000008,0x80113f22
80105c3e:	00 00 ef 
  initlock(&tickslock, "time");
80105c41:	68 dd 7c 10 80       	push   $0x80107cdd
80105c46:	68 e0 3c 11 80       	push   $0x80113ce0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105c4b:	66 a3 20 3f 11 80    	mov    %ax,0x80113f20
80105c51:	c1 e8 10             	shr    $0x10,%eax
80105c54:	66 a3 26 3f 11 80    	mov    %ax,0x80113f26
  initlock(&tickslock, "time");
80105c5a:	e8 b1 e9 ff ff       	call   80104610 <initlock>
}
80105c5f:	83 c4 10             	add    $0x10,%esp
80105c62:	c9                   	leave  
80105c63:	c3                   	ret    
80105c64:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105c6f:	90                   	nop

80105c70 <idtinit>:

void
idtinit(void)
{
80105c70:	f3 0f 1e fb          	endbr32 
80105c74:	55                   	push   %ebp
  pd[0] = size-1;
80105c75:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105c7a:	89 e5                	mov    %esp,%ebp
80105c7c:	83 ec 10             	sub    $0x10,%esp
80105c7f:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105c83:	b8 20 3d 11 80       	mov    $0x80113d20,%eax
80105c88:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105c8c:	c1 e8 10             	shr    $0x10,%eax
80105c8f:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105c93:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105c96:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105c99:	c9                   	leave  
80105c9a:	c3                   	ret    
80105c9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105c9f:	90                   	nop

80105ca0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105ca0:	f3 0f 1e fb          	endbr32 
80105ca4:	55                   	push   %ebp
80105ca5:	89 e5                	mov    %esp,%ebp
80105ca7:	57                   	push   %edi
80105ca8:	56                   	push   %esi
80105ca9:	53                   	push   %ebx
80105caa:	83 ec 1c             	sub    $0x1c,%esp
80105cad:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80105cb0:	8b 43 30             	mov    0x30(%ebx),%eax
80105cb3:	83 f8 40             	cmp    $0x40,%eax
80105cb6:	0f 84 64 01 00 00    	je     80105e20 <trap+0x180>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105cbc:	83 e8 20             	sub    $0x20,%eax
80105cbf:	83 f8 1f             	cmp    $0x1f,%eax
80105cc2:	0f 87 88 00 00 00    	ja     80105d50 <trap+0xb0>
80105cc8:	3e ff 24 85 84 7d 10 	notrack jmp *-0x7fef827c(,%eax,4)
80105ccf:	80 
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105cd0:	e8 eb c6 ff ff       	call   801023c0 <ideintr>
    lapiceoi();
80105cd5:	e8 c6 cd ff ff       	call   80102aa0 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105cda:	e8 91 de ff ff       	call   80103b70 <myproc>
80105cdf:	85 c0                	test   %eax,%eax
80105ce1:	74 1d                	je     80105d00 <trap+0x60>
80105ce3:	e8 88 de ff ff       	call   80103b70 <myproc>
80105ce8:	8b 50 24             	mov    0x24(%eax),%edx
80105ceb:	85 d2                	test   %edx,%edx
80105ced:	74 11                	je     80105d00 <trap+0x60>
80105cef:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105cf3:	83 e0 03             	and    $0x3,%eax
80105cf6:	66 83 f8 03          	cmp    $0x3,%ax
80105cfa:	0f 84 e8 01 00 00    	je     80105ee8 <trap+0x248>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105d00:	e8 6b de ff ff       	call   80103b70 <myproc>
80105d05:	85 c0                	test   %eax,%eax
80105d07:	74 0f                	je     80105d18 <trap+0x78>
80105d09:	e8 62 de ff ff       	call   80103b70 <myproc>
80105d0e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105d12:	0f 84 b8 00 00 00    	je     80105dd0 <trap+0x130>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105d18:	e8 53 de ff ff       	call   80103b70 <myproc>
80105d1d:	85 c0                	test   %eax,%eax
80105d1f:	74 1d                	je     80105d3e <trap+0x9e>
80105d21:	e8 4a de ff ff       	call   80103b70 <myproc>
80105d26:	8b 40 24             	mov    0x24(%eax),%eax
80105d29:	85 c0                	test   %eax,%eax
80105d2b:	74 11                	je     80105d3e <trap+0x9e>
80105d2d:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105d31:	83 e0 03             	and    $0x3,%eax
80105d34:	66 83 f8 03          	cmp    $0x3,%ax
80105d38:	0f 84 0f 01 00 00    	je     80105e4d <trap+0x1ad>
    exit();
}
80105d3e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d41:	5b                   	pop    %ebx
80105d42:	5e                   	pop    %esi
80105d43:	5f                   	pop    %edi
80105d44:	5d                   	pop    %ebp
80105d45:	c3                   	ret    
80105d46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d4d:	8d 76 00             	lea    0x0(%esi),%esi
    if(myproc() == 0 || (tf->cs&3) == 0){
80105d50:	e8 1b de ff ff       	call   80103b70 <myproc>
80105d55:	8b 7b 38             	mov    0x38(%ebx),%edi
80105d58:	85 c0                	test   %eax,%eax
80105d5a:	0f 84 a2 01 00 00    	je     80105f02 <trap+0x262>
80105d60:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105d64:	0f 84 98 01 00 00    	je     80105f02 <trap+0x262>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105d6a:	0f 20 d1             	mov    %cr2,%ecx
80105d6d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105d70:	e8 db dd ff ff       	call   80103b50 <cpuid>
80105d75:	8b 73 30             	mov    0x30(%ebx),%esi
80105d78:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105d7b:	8b 43 34             	mov    0x34(%ebx),%eax
80105d7e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80105d81:	e8 ea dd ff ff       	call   80103b70 <myproc>
80105d86:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105d89:	e8 e2 dd ff ff       	call   80103b70 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105d8e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105d91:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105d94:	51                   	push   %ecx
80105d95:	57                   	push   %edi
80105d96:	52                   	push   %edx
80105d97:	ff 75 e4             	pushl  -0x1c(%ebp)
80105d9a:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80105d9b:	8b 75 e0             	mov    -0x20(%ebp),%esi
80105d9e:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105da1:	56                   	push   %esi
80105da2:	ff 70 10             	pushl  0x10(%eax)
80105da5:	68 40 7d 10 80       	push   $0x80107d40
80105daa:	e8 e1 a8 ff ff       	call   80100690 <cprintf>
    myproc()->killed = 1;
80105daf:	83 c4 20             	add    $0x20,%esp
80105db2:	e8 b9 dd ff ff       	call   80103b70 <myproc>
80105db7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105dbe:	e8 ad dd ff ff       	call   80103b70 <myproc>
80105dc3:	85 c0                	test   %eax,%eax
80105dc5:	0f 85 18 ff ff ff    	jne    80105ce3 <trap+0x43>
80105dcb:	e9 30 ff ff ff       	jmp    80105d00 <trap+0x60>
  if(myproc() && myproc()->state == RUNNING &&
80105dd0:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105dd4:	0f 85 3e ff ff ff    	jne    80105d18 <trap+0x78>
    yield();
80105dda:	e8 21 e4 ff ff       	call   80104200 <yield>
80105ddf:	e9 34 ff ff ff       	jmp    80105d18 <trap+0x78>
80105de4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105de8:	8b 7b 38             	mov    0x38(%ebx),%edi
80105deb:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105def:	e8 5c dd ff ff       	call   80103b50 <cpuid>
80105df4:	57                   	push   %edi
80105df5:	56                   	push   %esi
80105df6:	50                   	push   %eax
80105df7:	68 e8 7c 10 80       	push   $0x80107ce8
80105dfc:	e8 8f a8 ff ff       	call   80100690 <cprintf>
    lapiceoi();
80105e01:	e8 9a cc ff ff       	call   80102aa0 <lapiceoi>
    break;
80105e06:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105e09:	e8 62 dd ff ff       	call   80103b70 <myproc>
80105e0e:	85 c0                	test   %eax,%eax
80105e10:	0f 85 cd fe ff ff    	jne    80105ce3 <trap+0x43>
80105e16:	e9 e5 fe ff ff       	jmp    80105d00 <trap+0x60>
80105e1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105e1f:	90                   	nop
    if(myproc()->killed)
80105e20:	e8 4b dd ff ff       	call   80103b70 <myproc>
80105e25:	8b 70 24             	mov    0x24(%eax),%esi
80105e28:	85 f6                	test   %esi,%esi
80105e2a:	0f 85 c8 00 00 00    	jne    80105ef8 <trap+0x258>
    myproc()->tf = tf;
80105e30:	e8 3b dd ff ff       	call   80103b70 <myproc>
80105e35:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105e38:	e8 c3 ee ff ff       	call   80104d00 <syscall>
    if(myproc()->killed)
80105e3d:	e8 2e dd ff ff       	call   80103b70 <myproc>
80105e42:	8b 48 24             	mov    0x24(%eax),%ecx
80105e45:	85 c9                	test   %ecx,%ecx
80105e47:	0f 84 f1 fe ff ff    	je     80105d3e <trap+0x9e>
}
80105e4d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e50:	5b                   	pop    %ebx
80105e51:	5e                   	pop    %esi
80105e52:	5f                   	pop    %edi
80105e53:	5d                   	pop    %ebp
      exit();
80105e54:	e9 47 e1 ff ff       	jmp    80103fa0 <exit>
80105e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105e60:	e8 5b 02 00 00       	call   801060c0 <uartintr>
    lapiceoi();
80105e65:	e8 36 cc ff ff       	call   80102aa0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105e6a:	e8 01 dd ff ff       	call   80103b70 <myproc>
80105e6f:	85 c0                	test   %eax,%eax
80105e71:	0f 85 6c fe ff ff    	jne    80105ce3 <trap+0x43>
80105e77:	e9 84 fe ff ff       	jmp    80105d00 <trap+0x60>
80105e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105e80:	e8 db ca ff ff       	call   80102960 <kbdintr>
    lapiceoi();
80105e85:	e8 16 cc ff ff       	call   80102aa0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105e8a:	e8 e1 dc ff ff       	call   80103b70 <myproc>
80105e8f:	85 c0                	test   %eax,%eax
80105e91:	0f 85 4c fe ff ff    	jne    80105ce3 <trap+0x43>
80105e97:	e9 64 fe ff ff       	jmp    80105d00 <trap+0x60>
80105e9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80105ea0:	e8 ab dc ff ff       	call   80103b50 <cpuid>
80105ea5:	85 c0                	test   %eax,%eax
80105ea7:	0f 85 28 fe ff ff    	jne    80105cd5 <trap+0x35>
      acquire(&tickslock);
80105ead:	83 ec 0c             	sub    $0xc,%esp
80105eb0:	68 e0 3c 11 80       	push   $0x80113ce0
80105eb5:	e8 56 e9 ff ff       	call   80104810 <acquire>
      wakeup(&ticks);
80105eba:	c7 04 24 c0 3c 11 80 	movl   $0x80113cc0,(%esp)
      ticks++;
80105ec1:	83 05 c0 3c 11 80 01 	addl   $0x1,0x80113cc0
      wakeup(&ticks);
80105ec8:	e8 43 e4 ff ff       	call   80104310 <wakeup>
      release(&tickslock);
80105ecd:	c7 04 24 e0 3c 11 80 	movl   $0x80113ce0,(%esp)
80105ed4:	e8 c7 e8 ff ff       	call   801047a0 <release>
80105ed9:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80105edc:	e9 f4 fd ff ff       	jmp    80105cd5 <trap+0x35>
80105ee1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
80105ee8:	e8 b3 e0 ff ff       	call   80103fa0 <exit>
80105eed:	e9 0e fe ff ff       	jmp    80105d00 <trap+0x60>
80105ef2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105ef8:	e8 a3 e0 ff ff       	call   80103fa0 <exit>
80105efd:	e9 2e ff ff ff       	jmp    80105e30 <trap+0x190>
80105f02:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105f05:	e8 46 dc ff ff       	call   80103b50 <cpuid>
80105f0a:	83 ec 0c             	sub    $0xc,%esp
80105f0d:	56                   	push   %esi
80105f0e:	57                   	push   %edi
80105f0f:	50                   	push   %eax
80105f10:	ff 73 30             	pushl  0x30(%ebx)
80105f13:	68 0c 7d 10 80       	push   $0x80107d0c
80105f18:	e8 73 a7 ff ff       	call   80100690 <cprintf>
      panic("trap");
80105f1d:	83 c4 14             	add    $0x14,%esp
80105f20:	68 e2 7c 10 80       	push   $0x80107ce2
80105f25:	e8 66 a4 ff ff       	call   80100390 <panic>
80105f2a:	66 90                	xchg   %ax,%ax
80105f2c:	66 90                	xchg   %ax,%ax
80105f2e:	66 90                	xchg   %ax,%ax

80105f30 <uartgetc>:
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80105f30:	f3 0f 1e fb          	endbr32 
  if(!uart)
80105f34:	a1 20 45 11 80       	mov    0x80114520,%eax
80105f39:	85 c0                	test   %eax,%eax
80105f3b:	74 1b                	je     80105f58 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105f3d:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105f42:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105f43:	a8 01                	test   $0x1,%al
80105f45:	74 11                	je     80105f58 <uartgetc+0x28>
80105f47:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105f4c:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105f4d:	0f b6 c0             	movzbl %al,%eax
80105f50:	c3                   	ret    
80105f51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105f58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f5d:	c3                   	ret    
80105f5e:	66 90                	xchg   %ax,%ax

80105f60 <uartinit>:
{
80105f60:	f3 0f 1e fb          	endbr32 
80105f64:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105f65:	31 c9                	xor    %ecx,%ecx
80105f67:	89 c8                	mov    %ecx,%eax
80105f69:	89 e5                	mov    %esp,%ebp
80105f6b:	57                   	push   %edi
80105f6c:	bf fa 03 00 00       	mov    $0x3fa,%edi
80105f71:	56                   	push   %esi
80105f72:	89 fa                	mov    %edi,%edx
80105f74:	53                   	push   %ebx
80105f75:	83 ec 1c             	sub    $0x1c,%esp
80105f78:	ee                   	out    %al,(%dx)
80105f79:	be fb 03 00 00       	mov    $0x3fb,%esi
80105f7e:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105f83:	89 f2                	mov    %esi,%edx
80105f85:	ee                   	out    %al,(%dx)
80105f86:	b8 0c 00 00 00       	mov    $0xc,%eax
80105f8b:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105f90:	ee                   	out    %al,(%dx)
80105f91:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80105f96:	89 c8                	mov    %ecx,%eax
80105f98:	89 da                	mov    %ebx,%edx
80105f9a:	ee                   	out    %al,(%dx)
80105f9b:	b8 03 00 00 00       	mov    $0x3,%eax
80105fa0:	89 f2                	mov    %esi,%edx
80105fa2:	ee                   	out    %al,(%dx)
80105fa3:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105fa8:	89 c8                	mov    %ecx,%eax
80105faa:	ee                   	out    %al,(%dx)
80105fab:	b8 01 00 00 00       	mov    $0x1,%eax
80105fb0:	89 da                	mov    %ebx,%edx
80105fb2:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105fb3:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105fb8:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105fb9:	3c ff                	cmp    $0xff,%al
80105fbb:	0f 84 8f 00 00 00    	je     80106050 <uartinit+0xf0>
  uart = 1;
80105fc1:	c7 05 20 45 11 80 01 	movl   $0x1,0x80114520
80105fc8:	00 00 00 
80105fcb:	89 fa                	mov    %edi,%edx
80105fcd:	ec                   	in     (%dx),%al
80105fce:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105fd3:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105fd4:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80105fd7:	bf 04 7e 10 80       	mov    $0x80107e04,%edi
80105fdc:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
80105fe1:	6a 00                	push   $0x0
80105fe3:	6a 04                	push   $0x4
80105fe5:	e8 26 c6 ff ff       	call   80102610 <ioapicenable>
80105fea:	c6 45 e7 76          	movb   $0x76,-0x19(%ebp)
80105fee:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105ff1:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
80105ff5:	8d 76 00             	lea    0x0(%esi),%esi
  if(!uart)
80105ff8:	a1 20 45 11 80       	mov    0x80114520,%eax
80105ffd:	bb 80 00 00 00       	mov    $0x80,%ebx
80106002:	85 c0                	test   %eax,%eax
80106004:	75 1c                	jne    80106022 <uartinit+0xc2>
80106006:	eb 2b                	jmp    80106033 <uartinit+0xd3>
80106008:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010600f:	90                   	nop
    microdelay(10);
80106010:	83 ec 0c             	sub    $0xc,%esp
80106013:	6a 0a                	push   $0xa
80106015:	e8 a6 ca ff ff       	call   80102ac0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010601a:	83 c4 10             	add    $0x10,%esp
8010601d:	83 eb 01             	sub    $0x1,%ebx
80106020:	74 07                	je     80106029 <uartinit+0xc9>
80106022:	89 f2                	mov    %esi,%edx
80106024:	ec                   	in     (%dx),%al
80106025:	a8 20                	test   $0x20,%al
80106027:	74 e7                	je     80106010 <uartinit+0xb0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106029:	0f b6 45 e6          	movzbl -0x1a(%ebp),%eax
8010602d:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106032:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80106033:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80106037:	83 c7 01             	add    $0x1,%edi
8010603a:	84 c0                	test   %al,%al
8010603c:	74 12                	je     80106050 <uartinit+0xf0>
8010603e:	88 45 e6             	mov    %al,-0x1a(%ebp)
80106041:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80106045:	88 45 e7             	mov    %al,-0x19(%ebp)
80106048:	eb ae                	jmp    80105ff8 <uartinit+0x98>
8010604a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
80106050:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106053:	5b                   	pop    %ebx
80106054:	5e                   	pop    %esi
80106055:	5f                   	pop    %edi
80106056:	5d                   	pop    %ebp
80106057:	c3                   	ret    
80106058:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010605f:	90                   	nop

80106060 <uartputc>:
{
80106060:	f3 0f 1e fb          	endbr32 
  if(!uart)
80106064:	a1 20 45 11 80       	mov    0x80114520,%eax
80106069:	85 c0                	test   %eax,%eax
8010606b:	74 43                	je     801060b0 <uartputc+0x50>
{
8010606d:	55                   	push   %ebp
8010606e:	89 e5                	mov    %esp,%ebp
80106070:	56                   	push   %esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106071:	be fd 03 00 00       	mov    $0x3fd,%esi
80106076:	53                   	push   %ebx
80106077:	bb 80 00 00 00       	mov    $0x80,%ebx
8010607c:	eb 14                	jmp    80106092 <uartputc+0x32>
8010607e:	66 90                	xchg   %ax,%ax
    microdelay(10);
80106080:	83 ec 0c             	sub    $0xc,%esp
80106083:	6a 0a                	push   $0xa
80106085:	e8 36 ca ff ff       	call   80102ac0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010608a:	83 c4 10             	add    $0x10,%esp
8010608d:	83 eb 01             	sub    $0x1,%ebx
80106090:	74 07                	je     80106099 <uartputc+0x39>
80106092:	89 f2                	mov    %esi,%edx
80106094:	ec                   	in     (%dx),%al
80106095:	a8 20                	test   $0x20,%al
80106097:	74 e7                	je     80106080 <uartputc+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106099:	8b 45 08             	mov    0x8(%ebp),%eax
8010609c:	ba f8 03 00 00       	mov    $0x3f8,%edx
801060a1:	ee                   	out    %al,(%dx)
}
801060a2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801060a5:	5b                   	pop    %ebx
801060a6:	5e                   	pop    %esi
801060a7:	5d                   	pop    %ebp
801060a8:	c3                   	ret    
801060a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801060b0:	c3                   	ret    
801060b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801060b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801060bf:	90                   	nop

801060c0 <uartintr>:

void
uartintr(void)
{
801060c0:	f3 0f 1e fb          	endbr32 
801060c4:	55                   	push   %ebp
801060c5:	89 e5                	mov    %esp,%ebp
801060c7:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
801060ca:	68 30 5f 10 80       	push   $0x80105f30
801060cf:	e8 2c a8 ff ff       	call   80100900 <consoleintr>
}
801060d4:	83 c4 10             	add    $0x10,%esp
801060d7:	c9                   	leave  
801060d8:	c3                   	ret    

801060d9 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801060d9:	6a 00                	push   $0x0
  pushl $0
801060db:	6a 00                	push   $0x0
  jmp alltraps
801060dd:	e9 dc fa ff ff       	jmp    80105bbe <alltraps>

801060e2 <vector1>:
.globl vector1
vector1:
  pushl $0
801060e2:	6a 00                	push   $0x0
  pushl $1
801060e4:	6a 01                	push   $0x1
  jmp alltraps
801060e6:	e9 d3 fa ff ff       	jmp    80105bbe <alltraps>

801060eb <vector2>:
.globl vector2
vector2:
  pushl $0
801060eb:	6a 00                	push   $0x0
  pushl $2
801060ed:	6a 02                	push   $0x2
  jmp alltraps
801060ef:	e9 ca fa ff ff       	jmp    80105bbe <alltraps>

801060f4 <vector3>:
.globl vector3
vector3:
  pushl $0
801060f4:	6a 00                	push   $0x0
  pushl $3
801060f6:	6a 03                	push   $0x3
  jmp alltraps
801060f8:	e9 c1 fa ff ff       	jmp    80105bbe <alltraps>

801060fd <vector4>:
.globl vector4
vector4:
  pushl $0
801060fd:	6a 00                	push   $0x0
  pushl $4
801060ff:	6a 04                	push   $0x4
  jmp alltraps
80106101:	e9 b8 fa ff ff       	jmp    80105bbe <alltraps>

80106106 <vector5>:
.globl vector5
vector5:
  pushl $0
80106106:	6a 00                	push   $0x0
  pushl $5
80106108:	6a 05                	push   $0x5
  jmp alltraps
8010610a:	e9 af fa ff ff       	jmp    80105bbe <alltraps>

8010610f <vector6>:
.globl vector6
vector6:
  pushl $0
8010610f:	6a 00                	push   $0x0
  pushl $6
80106111:	6a 06                	push   $0x6
  jmp alltraps
80106113:	e9 a6 fa ff ff       	jmp    80105bbe <alltraps>

80106118 <vector7>:
.globl vector7
vector7:
  pushl $0
80106118:	6a 00                	push   $0x0
  pushl $7
8010611a:	6a 07                	push   $0x7
  jmp alltraps
8010611c:	e9 9d fa ff ff       	jmp    80105bbe <alltraps>

80106121 <vector8>:
.globl vector8
vector8:
  pushl $8
80106121:	6a 08                	push   $0x8
  jmp alltraps
80106123:	e9 96 fa ff ff       	jmp    80105bbe <alltraps>

80106128 <vector9>:
.globl vector9
vector9:
  pushl $0
80106128:	6a 00                	push   $0x0
  pushl $9
8010612a:	6a 09                	push   $0x9
  jmp alltraps
8010612c:	e9 8d fa ff ff       	jmp    80105bbe <alltraps>

80106131 <vector10>:
.globl vector10
vector10:
  pushl $10
80106131:	6a 0a                	push   $0xa
  jmp alltraps
80106133:	e9 86 fa ff ff       	jmp    80105bbe <alltraps>

80106138 <vector11>:
.globl vector11
vector11:
  pushl $11
80106138:	6a 0b                	push   $0xb
  jmp alltraps
8010613a:	e9 7f fa ff ff       	jmp    80105bbe <alltraps>

8010613f <vector12>:
.globl vector12
vector12:
  pushl $12
8010613f:	6a 0c                	push   $0xc
  jmp alltraps
80106141:	e9 78 fa ff ff       	jmp    80105bbe <alltraps>

80106146 <vector13>:
.globl vector13
vector13:
  pushl $13
80106146:	6a 0d                	push   $0xd
  jmp alltraps
80106148:	e9 71 fa ff ff       	jmp    80105bbe <alltraps>

8010614d <vector14>:
.globl vector14
vector14:
  pushl $14
8010614d:	6a 0e                	push   $0xe
  jmp alltraps
8010614f:	e9 6a fa ff ff       	jmp    80105bbe <alltraps>

80106154 <vector15>:
.globl vector15
vector15:
  pushl $0
80106154:	6a 00                	push   $0x0
  pushl $15
80106156:	6a 0f                	push   $0xf
  jmp alltraps
80106158:	e9 61 fa ff ff       	jmp    80105bbe <alltraps>

8010615d <vector16>:
.globl vector16
vector16:
  pushl $0
8010615d:	6a 00                	push   $0x0
  pushl $16
8010615f:	6a 10                	push   $0x10
  jmp alltraps
80106161:	e9 58 fa ff ff       	jmp    80105bbe <alltraps>

80106166 <vector17>:
.globl vector17
vector17:
  pushl $17
80106166:	6a 11                	push   $0x11
  jmp alltraps
80106168:	e9 51 fa ff ff       	jmp    80105bbe <alltraps>

8010616d <vector18>:
.globl vector18
vector18:
  pushl $0
8010616d:	6a 00                	push   $0x0
  pushl $18
8010616f:	6a 12                	push   $0x12
  jmp alltraps
80106171:	e9 48 fa ff ff       	jmp    80105bbe <alltraps>

80106176 <vector19>:
.globl vector19
vector19:
  pushl $0
80106176:	6a 00                	push   $0x0
  pushl $19
80106178:	6a 13                	push   $0x13
  jmp alltraps
8010617a:	e9 3f fa ff ff       	jmp    80105bbe <alltraps>

8010617f <vector20>:
.globl vector20
vector20:
  pushl $0
8010617f:	6a 00                	push   $0x0
  pushl $20
80106181:	6a 14                	push   $0x14
  jmp alltraps
80106183:	e9 36 fa ff ff       	jmp    80105bbe <alltraps>

80106188 <vector21>:
.globl vector21
vector21:
  pushl $0
80106188:	6a 00                	push   $0x0
  pushl $21
8010618a:	6a 15                	push   $0x15
  jmp alltraps
8010618c:	e9 2d fa ff ff       	jmp    80105bbe <alltraps>

80106191 <vector22>:
.globl vector22
vector22:
  pushl $0
80106191:	6a 00                	push   $0x0
  pushl $22
80106193:	6a 16                	push   $0x16
  jmp alltraps
80106195:	e9 24 fa ff ff       	jmp    80105bbe <alltraps>

8010619a <vector23>:
.globl vector23
vector23:
  pushl $0
8010619a:	6a 00                	push   $0x0
  pushl $23
8010619c:	6a 17                	push   $0x17
  jmp alltraps
8010619e:	e9 1b fa ff ff       	jmp    80105bbe <alltraps>

801061a3 <vector24>:
.globl vector24
vector24:
  pushl $0
801061a3:	6a 00                	push   $0x0
  pushl $24
801061a5:	6a 18                	push   $0x18
  jmp alltraps
801061a7:	e9 12 fa ff ff       	jmp    80105bbe <alltraps>

801061ac <vector25>:
.globl vector25
vector25:
  pushl $0
801061ac:	6a 00                	push   $0x0
  pushl $25
801061ae:	6a 19                	push   $0x19
  jmp alltraps
801061b0:	e9 09 fa ff ff       	jmp    80105bbe <alltraps>

801061b5 <vector26>:
.globl vector26
vector26:
  pushl $0
801061b5:	6a 00                	push   $0x0
  pushl $26
801061b7:	6a 1a                	push   $0x1a
  jmp alltraps
801061b9:	e9 00 fa ff ff       	jmp    80105bbe <alltraps>

801061be <vector27>:
.globl vector27
vector27:
  pushl $0
801061be:	6a 00                	push   $0x0
  pushl $27
801061c0:	6a 1b                	push   $0x1b
  jmp alltraps
801061c2:	e9 f7 f9 ff ff       	jmp    80105bbe <alltraps>

801061c7 <vector28>:
.globl vector28
vector28:
  pushl $0
801061c7:	6a 00                	push   $0x0
  pushl $28
801061c9:	6a 1c                	push   $0x1c
  jmp alltraps
801061cb:	e9 ee f9 ff ff       	jmp    80105bbe <alltraps>

801061d0 <vector29>:
.globl vector29
vector29:
  pushl $0
801061d0:	6a 00                	push   $0x0
  pushl $29
801061d2:	6a 1d                	push   $0x1d
  jmp alltraps
801061d4:	e9 e5 f9 ff ff       	jmp    80105bbe <alltraps>

801061d9 <vector30>:
.globl vector30
vector30:
  pushl $0
801061d9:	6a 00                	push   $0x0
  pushl $30
801061db:	6a 1e                	push   $0x1e
  jmp alltraps
801061dd:	e9 dc f9 ff ff       	jmp    80105bbe <alltraps>

801061e2 <vector31>:
.globl vector31
vector31:
  pushl $0
801061e2:	6a 00                	push   $0x0
  pushl $31
801061e4:	6a 1f                	push   $0x1f
  jmp alltraps
801061e6:	e9 d3 f9 ff ff       	jmp    80105bbe <alltraps>

801061eb <vector32>:
.globl vector32
vector32:
  pushl $0
801061eb:	6a 00                	push   $0x0
  pushl $32
801061ed:	6a 20                	push   $0x20
  jmp alltraps
801061ef:	e9 ca f9 ff ff       	jmp    80105bbe <alltraps>

801061f4 <vector33>:
.globl vector33
vector33:
  pushl $0
801061f4:	6a 00                	push   $0x0
  pushl $33
801061f6:	6a 21                	push   $0x21
  jmp alltraps
801061f8:	e9 c1 f9 ff ff       	jmp    80105bbe <alltraps>

801061fd <vector34>:
.globl vector34
vector34:
  pushl $0
801061fd:	6a 00                	push   $0x0
  pushl $34
801061ff:	6a 22                	push   $0x22
  jmp alltraps
80106201:	e9 b8 f9 ff ff       	jmp    80105bbe <alltraps>

80106206 <vector35>:
.globl vector35
vector35:
  pushl $0
80106206:	6a 00                	push   $0x0
  pushl $35
80106208:	6a 23                	push   $0x23
  jmp alltraps
8010620a:	e9 af f9 ff ff       	jmp    80105bbe <alltraps>

8010620f <vector36>:
.globl vector36
vector36:
  pushl $0
8010620f:	6a 00                	push   $0x0
  pushl $36
80106211:	6a 24                	push   $0x24
  jmp alltraps
80106213:	e9 a6 f9 ff ff       	jmp    80105bbe <alltraps>

80106218 <vector37>:
.globl vector37
vector37:
  pushl $0
80106218:	6a 00                	push   $0x0
  pushl $37
8010621a:	6a 25                	push   $0x25
  jmp alltraps
8010621c:	e9 9d f9 ff ff       	jmp    80105bbe <alltraps>

80106221 <vector38>:
.globl vector38
vector38:
  pushl $0
80106221:	6a 00                	push   $0x0
  pushl $38
80106223:	6a 26                	push   $0x26
  jmp alltraps
80106225:	e9 94 f9 ff ff       	jmp    80105bbe <alltraps>

8010622a <vector39>:
.globl vector39
vector39:
  pushl $0
8010622a:	6a 00                	push   $0x0
  pushl $39
8010622c:	6a 27                	push   $0x27
  jmp alltraps
8010622e:	e9 8b f9 ff ff       	jmp    80105bbe <alltraps>

80106233 <vector40>:
.globl vector40
vector40:
  pushl $0
80106233:	6a 00                	push   $0x0
  pushl $40
80106235:	6a 28                	push   $0x28
  jmp alltraps
80106237:	e9 82 f9 ff ff       	jmp    80105bbe <alltraps>

8010623c <vector41>:
.globl vector41
vector41:
  pushl $0
8010623c:	6a 00                	push   $0x0
  pushl $41
8010623e:	6a 29                	push   $0x29
  jmp alltraps
80106240:	e9 79 f9 ff ff       	jmp    80105bbe <alltraps>

80106245 <vector42>:
.globl vector42
vector42:
  pushl $0
80106245:	6a 00                	push   $0x0
  pushl $42
80106247:	6a 2a                	push   $0x2a
  jmp alltraps
80106249:	e9 70 f9 ff ff       	jmp    80105bbe <alltraps>

8010624e <vector43>:
.globl vector43
vector43:
  pushl $0
8010624e:	6a 00                	push   $0x0
  pushl $43
80106250:	6a 2b                	push   $0x2b
  jmp alltraps
80106252:	e9 67 f9 ff ff       	jmp    80105bbe <alltraps>

80106257 <vector44>:
.globl vector44
vector44:
  pushl $0
80106257:	6a 00                	push   $0x0
  pushl $44
80106259:	6a 2c                	push   $0x2c
  jmp alltraps
8010625b:	e9 5e f9 ff ff       	jmp    80105bbe <alltraps>

80106260 <vector45>:
.globl vector45
vector45:
  pushl $0
80106260:	6a 00                	push   $0x0
  pushl $45
80106262:	6a 2d                	push   $0x2d
  jmp alltraps
80106264:	e9 55 f9 ff ff       	jmp    80105bbe <alltraps>

80106269 <vector46>:
.globl vector46
vector46:
  pushl $0
80106269:	6a 00                	push   $0x0
  pushl $46
8010626b:	6a 2e                	push   $0x2e
  jmp alltraps
8010626d:	e9 4c f9 ff ff       	jmp    80105bbe <alltraps>

80106272 <vector47>:
.globl vector47
vector47:
  pushl $0
80106272:	6a 00                	push   $0x0
  pushl $47
80106274:	6a 2f                	push   $0x2f
  jmp alltraps
80106276:	e9 43 f9 ff ff       	jmp    80105bbe <alltraps>

8010627b <vector48>:
.globl vector48
vector48:
  pushl $0
8010627b:	6a 00                	push   $0x0
  pushl $48
8010627d:	6a 30                	push   $0x30
  jmp alltraps
8010627f:	e9 3a f9 ff ff       	jmp    80105bbe <alltraps>

80106284 <vector49>:
.globl vector49
vector49:
  pushl $0
80106284:	6a 00                	push   $0x0
  pushl $49
80106286:	6a 31                	push   $0x31
  jmp alltraps
80106288:	e9 31 f9 ff ff       	jmp    80105bbe <alltraps>

8010628d <vector50>:
.globl vector50
vector50:
  pushl $0
8010628d:	6a 00                	push   $0x0
  pushl $50
8010628f:	6a 32                	push   $0x32
  jmp alltraps
80106291:	e9 28 f9 ff ff       	jmp    80105bbe <alltraps>

80106296 <vector51>:
.globl vector51
vector51:
  pushl $0
80106296:	6a 00                	push   $0x0
  pushl $51
80106298:	6a 33                	push   $0x33
  jmp alltraps
8010629a:	e9 1f f9 ff ff       	jmp    80105bbe <alltraps>

8010629f <vector52>:
.globl vector52
vector52:
  pushl $0
8010629f:	6a 00                	push   $0x0
  pushl $52
801062a1:	6a 34                	push   $0x34
  jmp alltraps
801062a3:	e9 16 f9 ff ff       	jmp    80105bbe <alltraps>

801062a8 <vector53>:
.globl vector53
vector53:
  pushl $0
801062a8:	6a 00                	push   $0x0
  pushl $53
801062aa:	6a 35                	push   $0x35
  jmp alltraps
801062ac:	e9 0d f9 ff ff       	jmp    80105bbe <alltraps>

801062b1 <vector54>:
.globl vector54
vector54:
  pushl $0
801062b1:	6a 00                	push   $0x0
  pushl $54
801062b3:	6a 36                	push   $0x36
  jmp alltraps
801062b5:	e9 04 f9 ff ff       	jmp    80105bbe <alltraps>

801062ba <vector55>:
.globl vector55
vector55:
  pushl $0
801062ba:	6a 00                	push   $0x0
  pushl $55
801062bc:	6a 37                	push   $0x37
  jmp alltraps
801062be:	e9 fb f8 ff ff       	jmp    80105bbe <alltraps>

801062c3 <vector56>:
.globl vector56
vector56:
  pushl $0
801062c3:	6a 00                	push   $0x0
  pushl $56
801062c5:	6a 38                	push   $0x38
  jmp alltraps
801062c7:	e9 f2 f8 ff ff       	jmp    80105bbe <alltraps>

801062cc <vector57>:
.globl vector57
vector57:
  pushl $0
801062cc:	6a 00                	push   $0x0
  pushl $57
801062ce:	6a 39                	push   $0x39
  jmp alltraps
801062d0:	e9 e9 f8 ff ff       	jmp    80105bbe <alltraps>

801062d5 <vector58>:
.globl vector58
vector58:
  pushl $0
801062d5:	6a 00                	push   $0x0
  pushl $58
801062d7:	6a 3a                	push   $0x3a
  jmp alltraps
801062d9:	e9 e0 f8 ff ff       	jmp    80105bbe <alltraps>

801062de <vector59>:
.globl vector59
vector59:
  pushl $0
801062de:	6a 00                	push   $0x0
  pushl $59
801062e0:	6a 3b                	push   $0x3b
  jmp alltraps
801062e2:	e9 d7 f8 ff ff       	jmp    80105bbe <alltraps>

801062e7 <vector60>:
.globl vector60
vector60:
  pushl $0
801062e7:	6a 00                	push   $0x0
  pushl $60
801062e9:	6a 3c                	push   $0x3c
  jmp alltraps
801062eb:	e9 ce f8 ff ff       	jmp    80105bbe <alltraps>

801062f0 <vector61>:
.globl vector61
vector61:
  pushl $0
801062f0:	6a 00                	push   $0x0
  pushl $61
801062f2:	6a 3d                	push   $0x3d
  jmp alltraps
801062f4:	e9 c5 f8 ff ff       	jmp    80105bbe <alltraps>

801062f9 <vector62>:
.globl vector62
vector62:
  pushl $0
801062f9:	6a 00                	push   $0x0
  pushl $62
801062fb:	6a 3e                	push   $0x3e
  jmp alltraps
801062fd:	e9 bc f8 ff ff       	jmp    80105bbe <alltraps>

80106302 <vector63>:
.globl vector63
vector63:
  pushl $0
80106302:	6a 00                	push   $0x0
  pushl $63
80106304:	6a 3f                	push   $0x3f
  jmp alltraps
80106306:	e9 b3 f8 ff ff       	jmp    80105bbe <alltraps>

8010630b <vector64>:
.globl vector64
vector64:
  pushl $0
8010630b:	6a 00                	push   $0x0
  pushl $64
8010630d:	6a 40                	push   $0x40
  jmp alltraps
8010630f:	e9 aa f8 ff ff       	jmp    80105bbe <alltraps>

80106314 <vector65>:
.globl vector65
vector65:
  pushl $0
80106314:	6a 00                	push   $0x0
  pushl $65
80106316:	6a 41                	push   $0x41
  jmp alltraps
80106318:	e9 a1 f8 ff ff       	jmp    80105bbe <alltraps>

8010631d <vector66>:
.globl vector66
vector66:
  pushl $0
8010631d:	6a 00                	push   $0x0
  pushl $66
8010631f:	6a 42                	push   $0x42
  jmp alltraps
80106321:	e9 98 f8 ff ff       	jmp    80105bbe <alltraps>

80106326 <vector67>:
.globl vector67
vector67:
  pushl $0
80106326:	6a 00                	push   $0x0
  pushl $67
80106328:	6a 43                	push   $0x43
  jmp alltraps
8010632a:	e9 8f f8 ff ff       	jmp    80105bbe <alltraps>

8010632f <vector68>:
.globl vector68
vector68:
  pushl $0
8010632f:	6a 00                	push   $0x0
  pushl $68
80106331:	6a 44                	push   $0x44
  jmp alltraps
80106333:	e9 86 f8 ff ff       	jmp    80105bbe <alltraps>

80106338 <vector69>:
.globl vector69
vector69:
  pushl $0
80106338:	6a 00                	push   $0x0
  pushl $69
8010633a:	6a 45                	push   $0x45
  jmp alltraps
8010633c:	e9 7d f8 ff ff       	jmp    80105bbe <alltraps>

80106341 <vector70>:
.globl vector70
vector70:
  pushl $0
80106341:	6a 00                	push   $0x0
  pushl $70
80106343:	6a 46                	push   $0x46
  jmp alltraps
80106345:	e9 74 f8 ff ff       	jmp    80105bbe <alltraps>

8010634a <vector71>:
.globl vector71
vector71:
  pushl $0
8010634a:	6a 00                	push   $0x0
  pushl $71
8010634c:	6a 47                	push   $0x47
  jmp alltraps
8010634e:	e9 6b f8 ff ff       	jmp    80105bbe <alltraps>

80106353 <vector72>:
.globl vector72
vector72:
  pushl $0
80106353:	6a 00                	push   $0x0
  pushl $72
80106355:	6a 48                	push   $0x48
  jmp alltraps
80106357:	e9 62 f8 ff ff       	jmp    80105bbe <alltraps>

8010635c <vector73>:
.globl vector73
vector73:
  pushl $0
8010635c:	6a 00                	push   $0x0
  pushl $73
8010635e:	6a 49                	push   $0x49
  jmp alltraps
80106360:	e9 59 f8 ff ff       	jmp    80105bbe <alltraps>

80106365 <vector74>:
.globl vector74
vector74:
  pushl $0
80106365:	6a 00                	push   $0x0
  pushl $74
80106367:	6a 4a                	push   $0x4a
  jmp alltraps
80106369:	e9 50 f8 ff ff       	jmp    80105bbe <alltraps>

8010636e <vector75>:
.globl vector75
vector75:
  pushl $0
8010636e:	6a 00                	push   $0x0
  pushl $75
80106370:	6a 4b                	push   $0x4b
  jmp alltraps
80106372:	e9 47 f8 ff ff       	jmp    80105bbe <alltraps>

80106377 <vector76>:
.globl vector76
vector76:
  pushl $0
80106377:	6a 00                	push   $0x0
  pushl $76
80106379:	6a 4c                	push   $0x4c
  jmp alltraps
8010637b:	e9 3e f8 ff ff       	jmp    80105bbe <alltraps>

80106380 <vector77>:
.globl vector77
vector77:
  pushl $0
80106380:	6a 00                	push   $0x0
  pushl $77
80106382:	6a 4d                	push   $0x4d
  jmp alltraps
80106384:	e9 35 f8 ff ff       	jmp    80105bbe <alltraps>

80106389 <vector78>:
.globl vector78
vector78:
  pushl $0
80106389:	6a 00                	push   $0x0
  pushl $78
8010638b:	6a 4e                	push   $0x4e
  jmp alltraps
8010638d:	e9 2c f8 ff ff       	jmp    80105bbe <alltraps>

80106392 <vector79>:
.globl vector79
vector79:
  pushl $0
80106392:	6a 00                	push   $0x0
  pushl $79
80106394:	6a 4f                	push   $0x4f
  jmp alltraps
80106396:	e9 23 f8 ff ff       	jmp    80105bbe <alltraps>

8010639b <vector80>:
.globl vector80
vector80:
  pushl $0
8010639b:	6a 00                	push   $0x0
  pushl $80
8010639d:	6a 50                	push   $0x50
  jmp alltraps
8010639f:	e9 1a f8 ff ff       	jmp    80105bbe <alltraps>

801063a4 <vector81>:
.globl vector81
vector81:
  pushl $0
801063a4:	6a 00                	push   $0x0
  pushl $81
801063a6:	6a 51                	push   $0x51
  jmp alltraps
801063a8:	e9 11 f8 ff ff       	jmp    80105bbe <alltraps>

801063ad <vector82>:
.globl vector82
vector82:
  pushl $0
801063ad:	6a 00                	push   $0x0
  pushl $82
801063af:	6a 52                	push   $0x52
  jmp alltraps
801063b1:	e9 08 f8 ff ff       	jmp    80105bbe <alltraps>

801063b6 <vector83>:
.globl vector83
vector83:
  pushl $0
801063b6:	6a 00                	push   $0x0
  pushl $83
801063b8:	6a 53                	push   $0x53
  jmp alltraps
801063ba:	e9 ff f7 ff ff       	jmp    80105bbe <alltraps>

801063bf <vector84>:
.globl vector84
vector84:
  pushl $0
801063bf:	6a 00                	push   $0x0
  pushl $84
801063c1:	6a 54                	push   $0x54
  jmp alltraps
801063c3:	e9 f6 f7 ff ff       	jmp    80105bbe <alltraps>

801063c8 <vector85>:
.globl vector85
vector85:
  pushl $0
801063c8:	6a 00                	push   $0x0
  pushl $85
801063ca:	6a 55                	push   $0x55
  jmp alltraps
801063cc:	e9 ed f7 ff ff       	jmp    80105bbe <alltraps>

801063d1 <vector86>:
.globl vector86
vector86:
  pushl $0
801063d1:	6a 00                	push   $0x0
  pushl $86
801063d3:	6a 56                	push   $0x56
  jmp alltraps
801063d5:	e9 e4 f7 ff ff       	jmp    80105bbe <alltraps>

801063da <vector87>:
.globl vector87
vector87:
  pushl $0
801063da:	6a 00                	push   $0x0
  pushl $87
801063dc:	6a 57                	push   $0x57
  jmp alltraps
801063de:	e9 db f7 ff ff       	jmp    80105bbe <alltraps>

801063e3 <vector88>:
.globl vector88
vector88:
  pushl $0
801063e3:	6a 00                	push   $0x0
  pushl $88
801063e5:	6a 58                	push   $0x58
  jmp alltraps
801063e7:	e9 d2 f7 ff ff       	jmp    80105bbe <alltraps>

801063ec <vector89>:
.globl vector89
vector89:
  pushl $0
801063ec:	6a 00                	push   $0x0
  pushl $89
801063ee:	6a 59                	push   $0x59
  jmp alltraps
801063f0:	e9 c9 f7 ff ff       	jmp    80105bbe <alltraps>

801063f5 <vector90>:
.globl vector90
vector90:
  pushl $0
801063f5:	6a 00                	push   $0x0
  pushl $90
801063f7:	6a 5a                	push   $0x5a
  jmp alltraps
801063f9:	e9 c0 f7 ff ff       	jmp    80105bbe <alltraps>

801063fe <vector91>:
.globl vector91
vector91:
  pushl $0
801063fe:	6a 00                	push   $0x0
  pushl $91
80106400:	6a 5b                	push   $0x5b
  jmp alltraps
80106402:	e9 b7 f7 ff ff       	jmp    80105bbe <alltraps>

80106407 <vector92>:
.globl vector92
vector92:
  pushl $0
80106407:	6a 00                	push   $0x0
  pushl $92
80106409:	6a 5c                	push   $0x5c
  jmp alltraps
8010640b:	e9 ae f7 ff ff       	jmp    80105bbe <alltraps>

80106410 <vector93>:
.globl vector93
vector93:
  pushl $0
80106410:	6a 00                	push   $0x0
  pushl $93
80106412:	6a 5d                	push   $0x5d
  jmp alltraps
80106414:	e9 a5 f7 ff ff       	jmp    80105bbe <alltraps>

80106419 <vector94>:
.globl vector94
vector94:
  pushl $0
80106419:	6a 00                	push   $0x0
  pushl $94
8010641b:	6a 5e                	push   $0x5e
  jmp alltraps
8010641d:	e9 9c f7 ff ff       	jmp    80105bbe <alltraps>

80106422 <vector95>:
.globl vector95
vector95:
  pushl $0
80106422:	6a 00                	push   $0x0
  pushl $95
80106424:	6a 5f                	push   $0x5f
  jmp alltraps
80106426:	e9 93 f7 ff ff       	jmp    80105bbe <alltraps>

8010642b <vector96>:
.globl vector96
vector96:
  pushl $0
8010642b:	6a 00                	push   $0x0
  pushl $96
8010642d:	6a 60                	push   $0x60
  jmp alltraps
8010642f:	e9 8a f7 ff ff       	jmp    80105bbe <alltraps>

80106434 <vector97>:
.globl vector97
vector97:
  pushl $0
80106434:	6a 00                	push   $0x0
  pushl $97
80106436:	6a 61                	push   $0x61
  jmp alltraps
80106438:	e9 81 f7 ff ff       	jmp    80105bbe <alltraps>

8010643d <vector98>:
.globl vector98
vector98:
  pushl $0
8010643d:	6a 00                	push   $0x0
  pushl $98
8010643f:	6a 62                	push   $0x62
  jmp alltraps
80106441:	e9 78 f7 ff ff       	jmp    80105bbe <alltraps>

80106446 <vector99>:
.globl vector99
vector99:
  pushl $0
80106446:	6a 00                	push   $0x0
  pushl $99
80106448:	6a 63                	push   $0x63
  jmp alltraps
8010644a:	e9 6f f7 ff ff       	jmp    80105bbe <alltraps>

8010644f <vector100>:
.globl vector100
vector100:
  pushl $0
8010644f:	6a 00                	push   $0x0
  pushl $100
80106451:	6a 64                	push   $0x64
  jmp alltraps
80106453:	e9 66 f7 ff ff       	jmp    80105bbe <alltraps>

80106458 <vector101>:
.globl vector101
vector101:
  pushl $0
80106458:	6a 00                	push   $0x0
  pushl $101
8010645a:	6a 65                	push   $0x65
  jmp alltraps
8010645c:	e9 5d f7 ff ff       	jmp    80105bbe <alltraps>

80106461 <vector102>:
.globl vector102
vector102:
  pushl $0
80106461:	6a 00                	push   $0x0
  pushl $102
80106463:	6a 66                	push   $0x66
  jmp alltraps
80106465:	e9 54 f7 ff ff       	jmp    80105bbe <alltraps>

8010646a <vector103>:
.globl vector103
vector103:
  pushl $0
8010646a:	6a 00                	push   $0x0
  pushl $103
8010646c:	6a 67                	push   $0x67
  jmp alltraps
8010646e:	e9 4b f7 ff ff       	jmp    80105bbe <alltraps>

80106473 <vector104>:
.globl vector104
vector104:
  pushl $0
80106473:	6a 00                	push   $0x0
  pushl $104
80106475:	6a 68                	push   $0x68
  jmp alltraps
80106477:	e9 42 f7 ff ff       	jmp    80105bbe <alltraps>

8010647c <vector105>:
.globl vector105
vector105:
  pushl $0
8010647c:	6a 00                	push   $0x0
  pushl $105
8010647e:	6a 69                	push   $0x69
  jmp alltraps
80106480:	e9 39 f7 ff ff       	jmp    80105bbe <alltraps>

80106485 <vector106>:
.globl vector106
vector106:
  pushl $0
80106485:	6a 00                	push   $0x0
  pushl $106
80106487:	6a 6a                	push   $0x6a
  jmp alltraps
80106489:	e9 30 f7 ff ff       	jmp    80105bbe <alltraps>

8010648e <vector107>:
.globl vector107
vector107:
  pushl $0
8010648e:	6a 00                	push   $0x0
  pushl $107
80106490:	6a 6b                	push   $0x6b
  jmp alltraps
80106492:	e9 27 f7 ff ff       	jmp    80105bbe <alltraps>

80106497 <vector108>:
.globl vector108
vector108:
  pushl $0
80106497:	6a 00                	push   $0x0
  pushl $108
80106499:	6a 6c                	push   $0x6c
  jmp alltraps
8010649b:	e9 1e f7 ff ff       	jmp    80105bbe <alltraps>

801064a0 <vector109>:
.globl vector109
vector109:
  pushl $0
801064a0:	6a 00                	push   $0x0
  pushl $109
801064a2:	6a 6d                	push   $0x6d
  jmp alltraps
801064a4:	e9 15 f7 ff ff       	jmp    80105bbe <alltraps>

801064a9 <vector110>:
.globl vector110
vector110:
  pushl $0
801064a9:	6a 00                	push   $0x0
  pushl $110
801064ab:	6a 6e                	push   $0x6e
  jmp alltraps
801064ad:	e9 0c f7 ff ff       	jmp    80105bbe <alltraps>

801064b2 <vector111>:
.globl vector111
vector111:
  pushl $0
801064b2:	6a 00                	push   $0x0
  pushl $111
801064b4:	6a 6f                	push   $0x6f
  jmp alltraps
801064b6:	e9 03 f7 ff ff       	jmp    80105bbe <alltraps>

801064bb <vector112>:
.globl vector112
vector112:
  pushl $0
801064bb:	6a 00                	push   $0x0
  pushl $112
801064bd:	6a 70                	push   $0x70
  jmp alltraps
801064bf:	e9 fa f6 ff ff       	jmp    80105bbe <alltraps>

801064c4 <vector113>:
.globl vector113
vector113:
  pushl $0
801064c4:	6a 00                	push   $0x0
  pushl $113
801064c6:	6a 71                	push   $0x71
  jmp alltraps
801064c8:	e9 f1 f6 ff ff       	jmp    80105bbe <alltraps>

801064cd <vector114>:
.globl vector114
vector114:
  pushl $0
801064cd:	6a 00                	push   $0x0
  pushl $114
801064cf:	6a 72                	push   $0x72
  jmp alltraps
801064d1:	e9 e8 f6 ff ff       	jmp    80105bbe <alltraps>

801064d6 <vector115>:
.globl vector115
vector115:
  pushl $0
801064d6:	6a 00                	push   $0x0
  pushl $115
801064d8:	6a 73                	push   $0x73
  jmp alltraps
801064da:	e9 df f6 ff ff       	jmp    80105bbe <alltraps>

801064df <vector116>:
.globl vector116
vector116:
  pushl $0
801064df:	6a 00                	push   $0x0
  pushl $116
801064e1:	6a 74                	push   $0x74
  jmp alltraps
801064e3:	e9 d6 f6 ff ff       	jmp    80105bbe <alltraps>

801064e8 <vector117>:
.globl vector117
vector117:
  pushl $0
801064e8:	6a 00                	push   $0x0
  pushl $117
801064ea:	6a 75                	push   $0x75
  jmp alltraps
801064ec:	e9 cd f6 ff ff       	jmp    80105bbe <alltraps>

801064f1 <vector118>:
.globl vector118
vector118:
  pushl $0
801064f1:	6a 00                	push   $0x0
  pushl $118
801064f3:	6a 76                	push   $0x76
  jmp alltraps
801064f5:	e9 c4 f6 ff ff       	jmp    80105bbe <alltraps>

801064fa <vector119>:
.globl vector119
vector119:
  pushl $0
801064fa:	6a 00                	push   $0x0
  pushl $119
801064fc:	6a 77                	push   $0x77
  jmp alltraps
801064fe:	e9 bb f6 ff ff       	jmp    80105bbe <alltraps>

80106503 <vector120>:
.globl vector120
vector120:
  pushl $0
80106503:	6a 00                	push   $0x0
  pushl $120
80106505:	6a 78                	push   $0x78
  jmp alltraps
80106507:	e9 b2 f6 ff ff       	jmp    80105bbe <alltraps>

8010650c <vector121>:
.globl vector121
vector121:
  pushl $0
8010650c:	6a 00                	push   $0x0
  pushl $121
8010650e:	6a 79                	push   $0x79
  jmp alltraps
80106510:	e9 a9 f6 ff ff       	jmp    80105bbe <alltraps>

80106515 <vector122>:
.globl vector122
vector122:
  pushl $0
80106515:	6a 00                	push   $0x0
  pushl $122
80106517:	6a 7a                	push   $0x7a
  jmp alltraps
80106519:	e9 a0 f6 ff ff       	jmp    80105bbe <alltraps>

8010651e <vector123>:
.globl vector123
vector123:
  pushl $0
8010651e:	6a 00                	push   $0x0
  pushl $123
80106520:	6a 7b                	push   $0x7b
  jmp alltraps
80106522:	e9 97 f6 ff ff       	jmp    80105bbe <alltraps>

80106527 <vector124>:
.globl vector124
vector124:
  pushl $0
80106527:	6a 00                	push   $0x0
  pushl $124
80106529:	6a 7c                	push   $0x7c
  jmp alltraps
8010652b:	e9 8e f6 ff ff       	jmp    80105bbe <alltraps>

80106530 <vector125>:
.globl vector125
vector125:
  pushl $0
80106530:	6a 00                	push   $0x0
  pushl $125
80106532:	6a 7d                	push   $0x7d
  jmp alltraps
80106534:	e9 85 f6 ff ff       	jmp    80105bbe <alltraps>

80106539 <vector126>:
.globl vector126
vector126:
  pushl $0
80106539:	6a 00                	push   $0x0
  pushl $126
8010653b:	6a 7e                	push   $0x7e
  jmp alltraps
8010653d:	e9 7c f6 ff ff       	jmp    80105bbe <alltraps>

80106542 <vector127>:
.globl vector127
vector127:
  pushl $0
80106542:	6a 00                	push   $0x0
  pushl $127
80106544:	6a 7f                	push   $0x7f
  jmp alltraps
80106546:	e9 73 f6 ff ff       	jmp    80105bbe <alltraps>

8010654b <vector128>:
.globl vector128
vector128:
  pushl $0
8010654b:	6a 00                	push   $0x0
  pushl $128
8010654d:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106552:	e9 67 f6 ff ff       	jmp    80105bbe <alltraps>

80106557 <vector129>:
.globl vector129
vector129:
  pushl $0
80106557:	6a 00                	push   $0x0
  pushl $129
80106559:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010655e:	e9 5b f6 ff ff       	jmp    80105bbe <alltraps>

80106563 <vector130>:
.globl vector130
vector130:
  pushl $0
80106563:	6a 00                	push   $0x0
  pushl $130
80106565:	68 82 00 00 00       	push   $0x82
  jmp alltraps
8010656a:	e9 4f f6 ff ff       	jmp    80105bbe <alltraps>

8010656f <vector131>:
.globl vector131
vector131:
  pushl $0
8010656f:	6a 00                	push   $0x0
  pushl $131
80106571:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106576:	e9 43 f6 ff ff       	jmp    80105bbe <alltraps>

8010657b <vector132>:
.globl vector132
vector132:
  pushl $0
8010657b:	6a 00                	push   $0x0
  pushl $132
8010657d:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106582:	e9 37 f6 ff ff       	jmp    80105bbe <alltraps>

80106587 <vector133>:
.globl vector133
vector133:
  pushl $0
80106587:	6a 00                	push   $0x0
  pushl $133
80106589:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010658e:	e9 2b f6 ff ff       	jmp    80105bbe <alltraps>

80106593 <vector134>:
.globl vector134
vector134:
  pushl $0
80106593:	6a 00                	push   $0x0
  pushl $134
80106595:	68 86 00 00 00       	push   $0x86
  jmp alltraps
8010659a:	e9 1f f6 ff ff       	jmp    80105bbe <alltraps>

8010659f <vector135>:
.globl vector135
vector135:
  pushl $0
8010659f:	6a 00                	push   $0x0
  pushl $135
801065a1:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801065a6:	e9 13 f6 ff ff       	jmp    80105bbe <alltraps>

801065ab <vector136>:
.globl vector136
vector136:
  pushl $0
801065ab:	6a 00                	push   $0x0
  pushl $136
801065ad:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801065b2:	e9 07 f6 ff ff       	jmp    80105bbe <alltraps>

801065b7 <vector137>:
.globl vector137
vector137:
  pushl $0
801065b7:	6a 00                	push   $0x0
  pushl $137
801065b9:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801065be:	e9 fb f5 ff ff       	jmp    80105bbe <alltraps>

801065c3 <vector138>:
.globl vector138
vector138:
  pushl $0
801065c3:	6a 00                	push   $0x0
  pushl $138
801065c5:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801065ca:	e9 ef f5 ff ff       	jmp    80105bbe <alltraps>

801065cf <vector139>:
.globl vector139
vector139:
  pushl $0
801065cf:	6a 00                	push   $0x0
  pushl $139
801065d1:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801065d6:	e9 e3 f5 ff ff       	jmp    80105bbe <alltraps>

801065db <vector140>:
.globl vector140
vector140:
  pushl $0
801065db:	6a 00                	push   $0x0
  pushl $140
801065dd:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801065e2:	e9 d7 f5 ff ff       	jmp    80105bbe <alltraps>

801065e7 <vector141>:
.globl vector141
vector141:
  pushl $0
801065e7:	6a 00                	push   $0x0
  pushl $141
801065e9:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801065ee:	e9 cb f5 ff ff       	jmp    80105bbe <alltraps>

801065f3 <vector142>:
.globl vector142
vector142:
  pushl $0
801065f3:	6a 00                	push   $0x0
  pushl $142
801065f5:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801065fa:	e9 bf f5 ff ff       	jmp    80105bbe <alltraps>

801065ff <vector143>:
.globl vector143
vector143:
  pushl $0
801065ff:	6a 00                	push   $0x0
  pushl $143
80106601:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106606:	e9 b3 f5 ff ff       	jmp    80105bbe <alltraps>

8010660b <vector144>:
.globl vector144
vector144:
  pushl $0
8010660b:	6a 00                	push   $0x0
  pushl $144
8010660d:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106612:	e9 a7 f5 ff ff       	jmp    80105bbe <alltraps>

80106617 <vector145>:
.globl vector145
vector145:
  pushl $0
80106617:	6a 00                	push   $0x0
  pushl $145
80106619:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010661e:	e9 9b f5 ff ff       	jmp    80105bbe <alltraps>

80106623 <vector146>:
.globl vector146
vector146:
  pushl $0
80106623:	6a 00                	push   $0x0
  pushl $146
80106625:	68 92 00 00 00       	push   $0x92
  jmp alltraps
8010662a:	e9 8f f5 ff ff       	jmp    80105bbe <alltraps>

8010662f <vector147>:
.globl vector147
vector147:
  pushl $0
8010662f:	6a 00                	push   $0x0
  pushl $147
80106631:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106636:	e9 83 f5 ff ff       	jmp    80105bbe <alltraps>

8010663b <vector148>:
.globl vector148
vector148:
  pushl $0
8010663b:	6a 00                	push   $0x0
  pushl $148
8010663d:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106642:	e9 77 f5 ff ff       	jmp    80105bbe <alltraps>

80106647 <vector149>:
.globl vector149
vector149:
  pushl $0
80106647:	6a 00                	push   $0x0
  pushl $149
80106649:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010664e:	e9 6b f5 ff ff       	jmp    80105bbe <alltraps>

80106653 <vector150>:
.globl vector150
vector150:
  pushl $0
80106653:	6a 00                	push   $0x0
  pushl $150
80106655:	68 96 00 00 00       	push   $0x96
  jmp alltraps
8010665a:	e9 5f f5 ff ff       	jmp    80105bbe <alltraps>

8010665f <vector151>:
.globl vector151
vector151:
  pushl $0
8010665f:	6a 00                	push   $0x0
  pushl $151
80106661:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106666:	e9 53 f5 ff ff       	jmp    80105bbe <alltraps>

8010666b <vector152>:
.globl vector152
vector152:
  pushl $0
8010666b:	6a 00                	push   $0x0
  pushl $152
8010666d:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106672:	e9 47 f5 ff ff       	jmp    80105bbe <alltraps>

80106677 <vector153>:
.globl vector153
vector153:
  pushl $0
80106677:	6a 00                	push   $0x0
  pushl $153
80106679:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010667e:	e9 3b f5 ff ff       	jmp    80105bbe <alltraps>

80106683 <vector154>:
.globl vector154
vector154:
  pushl $0
80106683:	6a 00                	push   $0x0
  pushl $154
80106685:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
8010668a:	e9 2f f5 ff ff       	jmp    80105bbe <alltraps>

8010668f <vector155>:
.globl vector155
vector155:
  pushl $0
8010668f:	6a 00                	push   $0x0
  pushl $155
80106691:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106696:	e9 23 f5 ff ff       	jmp    80105bbe <alltraps>

8010669b <vector156>:
.globl vector156
vector156:
  pushl $0
8010669b:	6a 00                	push   $0x0
  pushl $156
8010669d:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801066a2:	e9 17 f5 ff ff       	jmp    80105bbe <alltraps>

801066a7 <vector157>:
.globl vector157
vector157:
  pushl $0
801066a7:	6a 00                	push   $0x0
  pushl $157
801066a9:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801066ae:	e9 0b f5 ff ff       	jmp    80105bbe <alltraps>

801066b3 <vector158>:
.globl vector158
vector158:
  pushl $0
801066b3:	6a 00                	push   $0x0
  pushl $158
801066b5:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801066ba:	e9 ff f4 ff ff       	jmp    80105bbe <alltraps>

801066bf <vector159>:
.globl vector159
vector159:
  pushl $0
801066bf:	6a 00                	push   $0x0
  pushl $159
801066c1:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801066c6:	e9 f3 f4 ff ff       	jmp    80105bbe <alltraps>

801066cb <vector160>:
.globl vector160
vector160:
  pushl $0
801066cb:	6a 00                	push   $0x0
  pushl $160
801066cd:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801066d2:	e9 e7 f4 ff ff       	jmp    80105bbe <alltraps>

801066d7 <vector161>:
.globl vector161
vector161:
  pushl $0
801066d7:	6a 00                	push   $0x0
  pushl $161
801066d9:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801066de:	e9 db f4 ff ff       	jmp    80105bbe <alltraps>

801066e3 <vector162>:
.globl vector162
vector162:
  pushl $0
801066e3:	6a 00                	push   $0x0
  pushl $162
801066e5:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801066ea:	e9 cf f4 ff ff       	jmp    80105bbe <alltraps>

801066ef <vector163>:
.globl vector163
vector163:
  pushl $0
801066ef:	6a 00                	push   $0x0
  pushl $163
801066f1:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801066f6:	e9 c3 f4 ff ff       	jmp    80105bbe <alltraps>

801066fb <vector164>:
.globl vector164
vector164:
  pushl $0
801066fb:	6a 00                	push   $0x0
  pushl $164
801066fd:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106702:	e9 b7 f4 ff ff       	jmp    80105bbe <alltraps>

80106707 <vector165>:
.globl vector165
vector165:
  pushl $0
80106707:	6a 00                	push   $0x0
  pushl $165
80106709:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010670e:	e9 ab f4 ff ff       	jmp    80105bbe <alltraps>

80106713 <vector166>:
.globl vector166
vector166:
  pushl $0
80106713:	6a 00                	push   $0x0
  pushl $166
80106715:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
8010671a:	e9 9f f4 ff ff       	jmp    80105bbe <alltraps>

8010671f <vector167>:
.globl vector167
vector167:
  pushl $0
8010671f:	6a 00                	push   $0x0
  pushl $167
80106721:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106726:	e9 93 f4 ff ff       	jmp    80105bbe <alltraps>

8010672b <vector168>:
.globl vector168
vector168:
  pushl $0
8010672b:	6a 00                	push   $0x0
  pushl $168
8010672d:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106732:	e9 87 f4 ff ff       	jmp    80105bbe <alltraps>

80106737 <vector169>:
.globl vector169
vector169:
  pushl $0
80106737:	6a 00                	push   $0x0
  pushl $169
80106739:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010673e:	e9 7b f4 ff ff       	jmp    80105bbe <alltraps>

80106743 <vector170>:
.globl vector170
vector170:
  pushl $0
80106743:	6a 00                	push   $0x0
  pushl $170
80106745:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
8010674a:	e9 6f f4 ff ff       	jmp    80105bbe <alltraps>

8010674f <vector171>:
.globl vector171
vector171:
  pushl $0
8010674f:	6a 00                	push   $0x0
  pushl $171
80106751:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106756:	e9 63 f4 ff ff       	jmp    80105bbe <alltraps>

8010675b <vector172>:
.globl vector172
vector172:
  pushl $0
8010675b:	6a 00                	push   $0x0
  pushl $172
8010675d:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106762:	e9 57 f4 ff ff       	jmp    80105bbe <alltraps>

80106767 <vector173>:
.globl vector173
vector173:
  pushl $0
80106767:	6a 00                	push   $0x0
  pushl $173
80106769:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010676e:	e9 4b f4 ff ff       	jmp    80105bbe <alltraps>

80106773 <vector174>:
.globl vector174
vector174:
  pushl $0
80106773:	6a 00                	push   $0x0
  pushl $174
80106775:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
8010677a:	e9 3f f4 ff ff       	jmp    80105bbe <alltraps>

8010677f <vector175>:
.globl vector175
vector175:
  pushl $0
8010677f:	6a 00                	push   $0x0
  pushl $175
80106781:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106786:	e9 33 f4 ff ff       	jmp    80105bbe <alltraps>

8010678b <vector176>:
.globl vector176
vector176:
  pushl $0
8010678b:	6a 00                	push   $0x0
  pushl $176
8010678d:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106792:	e9 27 f4 ff ff       	jmp    80105bbe <alltraps>

80106797 <vector177>:
.globl vector177
vector177:
  pushl $0
80106797:	6a 00                	push   $0x0
  pushl $177
80106799:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010679e:	e9 1b f4 ff ff       	jmp    80105bbe <alltraps>

801067a3 <vector178>:
.globl vector178
vector178:
  pushl $0
801067a3:	6a 00                	push   $0x0
  pushl $178
801067a5:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801067aa:	e9 0f f4 ff ff       	jmp    80105bbe <alltraps>

801067af <vector179>:
.globl vector179
vector179:
  pushl $0
801067af:	6a 00                	push   $0x0
  pushl $179
801067b1:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801067b6:	e9 03 f4 ff ff       	jmp    80105bbe <alltraps>

801067bb <vector180>:
.globl vector180
vector180:
  pushl $0
801067bb:	6a 00                	push   $0x0
  pushl $180
801067bd:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801067c2:	e9 f7 f3 ff ff       	jmp    80105bbe <alltraps>

801067c7 <vector181>:
.globl vector181
vector181:
  pushl $0
801067c7:	6a 00                	push   $0x0
  pushl $181
801067c9:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801067ce:	e9 eb f3 ff ff       	jmp    80105bbe <alltraps>

801067d3 <vector182>:
.globl vector182
vector182:
  pushl $0
801067d3:	6a 00                	push   $0x0
  pushl $182
801067d5:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801067da:	e9 df f3 ff ff       	jmp    80105bbe <alltraps>

801067df <vector183>:
.globl vector183
vector183:
  pushl $0
801067df:	6a 00                	push   $0x0
  pushl $183
801067e1:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801067e6:	e9 d3 f3 ff ff       	jmp    80105bbe <alltraps>

801067eb <vector184>:
.globl vector184
vector184:
  pushl $0
801067eb:	6a 00                	push   $0x0
  pushl $184
801067ed:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801067f2:	e9 c7 f3 ff ff       	jmp    80105bbe <alltraps>

801067f7 <vector185>:
.globl vector185
vector185:
  pushl $0
801067f7:	6a 00                	push   $0x0
  pushl $185
801067f9:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801067fe:	e9 bb f3 ff ff       	jmp    80105bbe <alltraps>

80106803 <vector186>:
.globl vector186
vector186:
  pushl $0
80106803:	6a 00                	push   $0x0
  pushl $186
80106805:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
8010680a:	e9 af f3 ff ff       	jmp    80105bbe <alltraps>

8010680f <vector187>:
.globl vector187
vector187:
  pushl $0
8010680f:	6a 00                	push   $0x0
  pushl $187
80106811:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106816:	e9 a3 f3 ff ff       	jmp    80105bbe <alltraps>

8010681b <vector188>:
.globl vector188
vector188:
  pushl $0
8010681b:	6a 00                	push   $0x0
  pushl $188
8010681d:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106822:	e9 97 f3 ff ff       	jmp    80105bbe <alltraps>

80106827 <vector189>:
.globl vector189
vector189:
  pushl $0
80106827:	6a 00                	push   $0x0
  pushl $189
80106829:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010682e:	e9 8b f3 ff ff       	jmp    80105bbe <alltraps>

80106833 <vector190>:
.globl vector190
vector190:
  pushl $0
80106833:	6a 00                	push   $0x0
  pushl $190
80106835:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
8010683a:	e9 7f f3 ff ff       	jmp    80105bbe <alltraps>

8010683f <vector191>:
.globl vector191
vector191:
  pushl $0
8010683f:	6a 00                	push   $0x0
  pushl $191
80106841:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106846:	e9 73 f3 ff ff       	jmp    80105bbe <alltraps>

8010684b <vector192>:
.globl vector192
vector192:
  pushl $0
8010684b:	6a 00                	push   $0x0
  pushl $192
8010684d:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106852:	e9 67 f3 ff ff       	jmp    80105bbe <alltraps>

80106857 <vector193>:
.globl vector193
vector193:
  pushl $0
80106857:	6a 00                	push   $0x0
  pushl $193
80106859:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010685e:	e9 5b f3 ff ff       	jmp    80105bbe <alltraps>

80106863 <vector194>:
.globl vector194
vector194:
  pushl $0
80106863:	6a 00                	push   $0x0
  pushl $194
80106865:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
8010686a:	e9 4f f3 ff ff       	jmp    80105bbe <alltraps>

8010686f <vector195>:
.globl vector195
vector195:
  pushl $0
8010686f:	6a 00                	push   $0x0
  pushl $195
80106871:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106876:	e9 43 f3 ff ff       	jmp    80105bbe <alltraps>

8010687b <vector196>:
.globl vector196
vector196:
  pushl $0
8010687b:	6a 00                	push   $0x0
  pushl $196
8010687d:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106882:	e9 37 f3 ff ff       	jmp    80105bbe <alltraps>

80106887 <vector197>:
.globl vector197
vector197:
  pushl $0
80106887:	6a 00                	push   $0x0
  pushl $197
80106889:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010688e:	e9 2b f3 ff ff       	jmp    80105bbe <alltraps>

80106893 <vector198>:
.globl vector198
vector198:
  pushl $0
80106893:	6a 00                	push   $0x0
  pushl $198
80106895:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
8010689a:	e9 1f f3 ff ff       	jmp    80105bbe <alltraps>

8010689f <vector199>:
.globl vector199
vector199:
  pushl $0
8010689f:	6a 00                	push   $0x0
  pushl $199
801068a1:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801068a6:	e9 13 f3 ff ff       	jmp    80105bbe <alltraps>

801068ab <vector200>:
.globl vector200
vector200:
  pushl $0
801068ab:	6a 00                	push   $0x0
  pushl $200
801068ad:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801068b2:	e9 07 f3 ff ff       	jmp    80105bbe <alltraps>

801068b7 <vector201>:
.globl vector201
vector201:
  pushl $0
801068b7:	6a 00                	push   $0x0
  pushl $201
801068b9:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801068be:	e9 fb f2 ff ff       	jmp    80105bbe <alltraps>

801068c3 <vector202>:
.globl vector202
vector202:
  pushl $0
801068c3:	6a 00                	push   $0x0
  pushl $202
801068c5:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801068ca:	e9 ef f2 ff ff       	jmp    80105bbe <alltraps>

801068cf <vector203>:
.globl vector203
vector203:
  pushl $0
801068cf:	6a 00                	push   $0x0
  pushl $203
801068d1:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801068d6:	e9 e3 f2 ff ff       	jmp    80105bbe <alltraps>

801068db <vector204>:
.globl vector204
vector204:
  pushl $0
801068db:	6a 00                	push   $0x0
  pushl $204
801068dd:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801068e2:	e9 d7 f2 ff ff       	jmp    80105bbe <alltraps>

801068e7 <vector205>:
.globl vector205
vector205:
  pushl $0
801068e7:	6a 00                	push   $0x0
  pushl $205
801068e9:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801068ee:	e9 cb f2 ff ff       	jmp    80105bbe <alltraps>

801068f3 <vector206>:
.globl vector206
vector206:
  pushl $0
801068f3:	6a 00                	push   $0x0
  pushl $206
801068f5:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801068fa:	e9 bf f2 ff ff       	jmp    80105bbe <alltraps>

801068ff <vector207>:
.globl vector207
vector207:
  pushl $0
801068ff:	6a 00                	push   $0x0
  pushl $207
80106901:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106906:	e9 b3 f2 ff ff       	jmp    80105bbe <alltraps>

8010690b <vector208>:
.globl vector208
vector208:
  pushl $0
8010690b:	6a 00                	push   $0x0
  pushl $208
8010690d:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106912:	e9 a7 f2 ff ff       	jmp    80105bbe <alltraps>

80106917 <vector209>:
.globl vector209
vector209:
  pushl $0
80106917:	6a 00                	push   $0x0
  pushl $209
80106919:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010691e:	e9 9b f2 ff ff       	jmp    80105bbe <alltraps>

80106923 <vector210>:
.globl vector210
vector210:
  pushl $0
80106923:	6a 00                	push   $0x0
  pushl $210
80106925:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
8010692a:	e9 8f f2 ff ff       	jmp    80105bbe <alltraps>

8010692f <vector211>:
.globl vector211
vector211:
  pushl $0
8010692f:	6a 00                	push   $0x0
  pushl $211
80106931:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106936:	e9 83 f2 ff ff       	jmp    80105bbe <alltraps>

8010693b <vector212>:
.globl vector212
vector212:
  pushl $0
8010693b:	6a 00                	push   $0x0
  pushl $212
8010693d:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106942:	e9 77 f2 ff ff       	jmp    80105bbe <alltraps>

80106947 <vector213>:
.globl vector213
vector213:
  pushl $0
80106947:	6a 00                	push   $0x0
  pushl $213
80106949:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010694e:	e9 6b f2 ff ff       	jmp    80105bbe <alltraps>

80106953 <vector214>:
.globl vector214
vector214:
  pushl $0
80106953:	6a 00                	push   $0x0
  pushl $214
80106955:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
8010695a:	e9 5f f2 ff ff       	jmp    80105bbe <alltraps>

8010695f <vector215>:
.globl vector215
vector215:
  pushl $0
8010695f:	6a 00                	push   $0x0
  pushl $215
80106961:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106966:	e9 53 f2 ff ff       	jmp    80105bbe <alltraps>

8010696b <vector216>:
.globl vector216
vector216:
  pushl $0
8010696b:	6a 00                	push   $0x0
  pushl $216
8010696d:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106972:	e9 47 f2 ff ff       	jmp    80105bbe <alltraps>

80106977 <vector217>:
.globl vector217
vector217:
  pushl $0
80106977:	6a 00                	push   $0x0
  pushl $217
80106979:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010697e:	e9 3b f2 ff ff       	jmp    80105bbe <alltraps>

80106983 <vector218>:
.globl vector218
vector218:
  pushl $0
80106983:	6a 00                	push   $0x0
  pushl $218
80106985:	68 da 00 00 00       	push   $0xda
  jmp alltraps
8010698a:	e9 2f f2 ff ff       	jmp    80105bbe <alltraps>

8010698f <vector219>:
.globl vector219
vector219:
  pushl $0
8010698f:	6a 00                	push   $0x0
  pushl $219
80106991:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106996:	e9 23 f2 ff ff       	jmp    80105bbe <alltraps>

8010699b <vector220>:
.globl vector220
vector220:
  pushl $0
8010699b:	6a 00                	push   $0x0
  pushl $220
8010699d:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801069a2:	e9 17 f2 ff ff       	jmp    80105bbe <alltraps>

801069a7 <vector221>:
.globl vector221
vector221:
  pushl $0
801069a7:	6a 00                	push   $0x0
  pushl $221
801069a9:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801069ae:	e9 0b f2 ff ff       	jmp    80105bbe <alltraps>

801069b3 <vector222>:
.globl vector222
vector222:
  pushl $0
801069b3:	6a 00                	push   $0x0
  pushl $222
801069b5:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801069ba:	e9 ff f1 ff ff       	jmp    80105bbe <alltraps>

801069bf <vector223>:
.globl vector223
vector223:
  pushl $0
801069bf:	6a 00                	push   $0x0
  pushl $223
801069c1:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801069c6:	e9 f3 f1 ff ff       	jmp    80105bbe <alltraps>

801069cb <vector224>:
.globl vector224
vector224:
  pushl $0
801069cb:	6a 00                	push   $0x0
  pushl $224
801069cd:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801069d2:	e9 e7 f1 ff ff       	jmp    80105bbe <alltraps>

801069d7 <vector225>:
.globl vector225
vector225:
  pushl $0
801069d7:	6a 00                	push   $0x0
  pushl $225
801069d9:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801069de:	e9 db f1 ff ff       	jmp    80105bbe <alltraps>

801069e3 <vector226>:
.globl vector226
vector226:
  pushl $0
801069e3:	6a 00                	push   $0x0
  pushl $226
801069e5:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801069ea:	e9 cf f1 ff ff       	jmp    80105bbe <alltraps>

801069ef <vector227>:
.globl vector227
vector227:
  pushl $0
801069ef:	6a 00                	push   $0x0
  pushl $227
801069f1:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801069f6:	e9 c3 f1 ff ff       	jmp    80105bbe <alltraps>

801069fb <vector228>:
.globl vector228
vector228:
  pushl $0
801069fb:	6a 00                	push   $0x0
  pushl $228
801069fd:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106a02:	e9 b7 f1 ff ff       	jmp    80105bbe <alltraps>

80106a07 <vector229>:
.globl vector229
vector229:
  pushl $0
80106a07:	6a 00                	push   $0x0
  pushl $229
80106a09:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106a0e:	e9 ab f1 ff ff       	jmp    80105bbe <alltraps>

80106a13 <vector230>:
.globl vector230
vector230:
  pushl $0
80106a13:	6a 00                	push   $0x0
  pushl $230
80106a15:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106a1a:	e9 9f f1 ff ff       	jmp    80105bbe <alltraps>

80106a1f <vector231>:
.globl vector231
vector231:
  pushl $0
80106a1f:	6a 00                	push   $0x0
  pushl $231
80106a21:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106a26:	e9 93 f1 ff ff       	jmp    80105bbe <alltraps>

80106a2b <vector232>:
.globl vector232
vector232:
  pushl $0
80106a2b:	6a 00                	push   $0x0
  pushl $232
80106a2d:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106a32:	e9 87 f1 ff ff       	jmp    80105bbe <alltraps>

80106a37 <vector233>:
.globl vector233
vector233:
  pushl $0
80106a37:	6a 00                	push   $0x0
  pushl $233
80106a39:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106a3e:	e9 7b f1 ff ff       	jmp    80105bbe <alltraps>

80106a43 <vector234>:
.globl vector234
vector234:
  pushl $0
80106a43:	6a 00                	push   $0x0
  pushl $234
80106a45:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106a4a:	e9 6f f1 ff ff       	jmp    80105bbe <alltraps>

80106a4f <vector235>:
.globl vector235
vector235:
  pushl $0
80106a4f:	6a 00                	push   $0x0
  pushl $235
80106a51:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106a56:	e9 63 f1 ff ff       	jmp    80105bbe <alltraps>

80106a5b <vector236>:
.globl vector236
vector236:
  pushl $0
80106a5b:	6a 00                	push   $0x0
  pushl $236
80106a5d:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106a62:	e9 57 f1 ff ff       	jmp    80105bbe <alltraps>

80106a67 <vector237>:
.globl vector237
vector237:
  pushl $0
80106a67:	6a 00                	push   $0x0
  pushl $237
80106a69:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106a6e:	e9 4b f1 ff ff       	jmp    80105bbe <alltraps>

80106a73 <vector238>:
.globl vector238
vector238:
  pushl $0
80106a73:	6a 00                	push   $0x0
  pushl $238
80106a75:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106a7a:	e9 3f f1 ff ff       	jmp    80105bbe <alltraps>

80106a7f <vector239>:
.globl vector239
vector239:
  pushl $0
80106a7f:	6a 00                	push   $0x0
  pushl $239
80106a81:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106a86:	e9 33 f1 ff ff       	jmp    80105bbe <alltraps>

80106a8b <vector240>:
.globl vector240
vector240:
  pushl $0
80106a8b:	6a 00                	push   $0x0
  pushl $240
80106a8d:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106a92:	e9 27 f1 ff ff       	jmp    80105bbe <alltraps>

80106a97 <vector241>:
.globl vector241
vector241:
  pushl $0
80106a97:	6a 00                	push   $0x0
  pushl $241
80106a99:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106a9e:	e9 1b f1 ff ff       	jmp    80105bbe <alltraps>

80106aa3 <vector242>:
.globl vector242
vector242:
  pushl $0
80106aa3:	6a 00                	push   $0x0
  pushl $242
80106aa5:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106aaa:	e9 0f f1 ff ff       	jmp    80105bbe <alltraps>

80106aaf <vector243>:
.globl vector243
vector243:
  pushl $0
80106aaf:	6a 00                	push   $0x0
  pushl $243
80106ab1:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106ab6:	e9 03 f1 ff ff       	jmp    80105bbe <alltraps>

80106abb <vector244>:
.globl vector244
vector244:
  pushl $0
80106abb:	6a 00                	push   $0x0
  pushl $244
80106abd:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106ac2:	e9 f7 f0 ff ff       	jmp    80105bbe <alltraps>

80106ac7 <vector245>:
.globl vector245
vector245:
  pushl $0
80106ac7:	6a 00                	push   $0x0
  pushl $245
80106ac9:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106ace:	e9 eb f0 ff ff       	jmp    80105bbe <alltraps>

80106ad3 <vector246>:
.globl vector246
vector246:
  pushl $0
80106ad3:	6a 00                	push   $0x0
  pushl $246
80106ad5:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106ada:	e9 df f0 ff ff       	jmp    80105bbe <alltraps>

80106adf <vector247>:
.globl vector247
vector247:
  pushl $0
80106adf:	6a 00                	push   $0x0
  pushl $247
80106ae1:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106ae6:	e9 d3 f0 ff ff       	jmp    80105bbe <alltraps>

80106aeb <vector248>:
.globl vector248
vector248:
  pushl $0
80106aeb:	6a 00                	push   $0x0
  pushl $248
80106aed:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106af2:	e9 c7 f0 ff ff       	jmp    80105bbe <alltraps>

80106af7 <vector249>:
.globl vector249
vector249:
  pushl $0
80106af7:	6a 00                	push   $0x0
  pushl $249
80106af9:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106afe:	e9 bb f0 ff ff       	jmp    80105bbe <alltraps>

80106b03 <vector250>:
.globl vector250
vector250:
  pushl $0
80106b03:	6a 00                	push   $0x0
  pushl $250
80106b05:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106b0a:	e9 af f0 ff ff       	jmp    80105bbe <alltraps>

80106b0f <vector251>:
.globl vector251
vector251:
  pushl $0
80106b0f:	6a 00                	push   $0x0
  pushl $251
80106b11:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106b16:	e9 a3 f0 ff ff       	jmp    80105bbe <alltraps>

80106b1b <vector252>:
.globl vector252
vector252:
  pushl $0
80106b1b:	6a 00                	push   $0x0
  pushl $252
80106b1d:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106b22:	e9 97 f0 ff ff       	jmp    80105bbe <alltraps>

80106b27 <vector253>:
.globl vector253
vector253:
  pushl $0
80106b27:	6a 00                	push   $0x0
  pushl $253
80106b29:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106b2e:	e9 8b f0 ff ff       	jmp    80105bbe <alltraps>

80106b33 <vector254>:
.globl vector254
vector254:
  pushl $0
80106b33:	6a 00                	push   $0x0
  pushl $254
80106b35:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106b3a:	e9 7f f0 ff ff       	jmp    80105bbe <alltraps>

80106b3f <vector255>:
.globl vector255
vector255:
  pushl $0
80106b3f:	6a 00                	push   $0x0
  pushl $255
80106b41:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106b46:	e9 73 f0 ff ff       	jmp    80105bbe <alltraps>
80106b4b:	66 90                	xchg   %ax,%ax
80106b4d:	66 90                	xchg   %ax,%ax
80106b4f:	90                   	nop

80106b50 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106b50:	55                   	push   %ebp
80106b51:	89 e5                	mov    %esp,%ebp
80106b53:	57                   	push   %edi
80106b54:	56                   	push   %esi
80106b55:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106b56:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80106b5c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106b62:	83 ec 1c             	sub    $0x1c,%esp
80106b65:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106b68:	39 d3                	cmp    %edx,%ebx
80106b6a:	73 45                	jae    80106bb1 <deallocuvm.part.0+0x61>
80106b6c:	89 c7                	mov    %eax,%edi
80106b6e:	eb 0a                	jmp    80106b7a <deallocuvm.part.0+0x2a>
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106b70:	8d 59 01             	lea    0x1(%ecx),%ebx
80106b73:	c1 e3 16             	shl    $0x16,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106b76:	39 da                	cmp    %ebx,%edx
80106b78:	76 37                	jbe    80106bb1 <deallocuvm.part.0+0x61>
  pde = &pgdir[PDX(va)];
80106b7a:	89 d9                	mov    %ebx,%ecx
80106b7c:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80106b7f:	8b 04 8f             	mov    (%edi,%ecx,4),%eax
80106b82:	a8 01                	test   $0x1,%al
80106b84:	74 ea                	je     80106b70 <deallocuvm.part.0+0x20>
  return &pgtab[PTX(va)];
80106b86:	89 de                	mov    %ebx,%esi
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106b88:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106b8d:	c1 ee 0a             	shr    $0xa,%esi
80106b90:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
80106b96:	8d b4 30 00 00 00 80 	lea    -0x80000000(%eax,%esi,1),%esi
    if(!pte)
80106b9d:	85 f6                	test   %esi,%esi
80106b9f:	74 cf                	je     80106b70 <deallocuvm.part.0+0x20>
    else if((*pte & PTE_P) != 0){
80106ba1:	8b 06                	mov    (%esi),%eax
80106ba3:	a8 01                	test   $0x1,%al
80106ba5:	75 19                	jne    80106bc0 <deallocuvm.part.0+0x70>
  for(; a  < oldsz; a += PGSIZE){
80106ba7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106bad:	39 da                	cmp    %ebx,%edx
80106baf:	77 c9                	ja     80106b7a <deallocuvm.part.0+0x2a>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106bb1:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106bb4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106bb7:	5b                   	pop    %ebx
80106bb8:	5e                   	pop    %esi
80106bb9:	5f                   	pop    %edi
80106bba:	5d                   	pop    %ebp
80106bbb:	c3                   	ret    
80106bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(pa == 0)
80106bc0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106bc5:	74 25                	je     80106bec <deallocuvm.part.0+0x9c>
      kfree(v);
80106bc7:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106bca:	05 00 00 00 80       	add    $0x80000000,%eax
80106bcf:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106bd2:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80106bd8:	50                   	push   %eax
80106bd9:	e8 72 ba ff ff       	call   80102650 <kfree>
      *pte = 0;
80106bde:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  for(; a  < oldsz; a += PGSIZE){
80106be4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106be7:	83 c4 10             	add    $0x10,%esp
80106bea:	eb 8a                	jmp    80106b76 <deallocuvm.part.0+0x26>
        panic("kfree");
80106bec:	83 ec 0c             	sub    $0xc,%esp
80106bef:	68 c6 77 10 80       	push   $0x801077c6
80106bf4:	e8 97 97 ff ff       	call   80100390 <panic>
80106bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106c00 <mappages>:
{
80106c00:	55                   	push   %ebp
80106c01:	89 e5                	mov    %esp,%ebp
80106c03:	57                   	push   %edi
80106c04:	56                   	push   %esi
80106c05:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80106c06:	89 d3                	mov    %edx,%ebx
80106c08:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106c0e:	83 ec 1c             	sub    $0x1c,%esp
80106c11:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106c14:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106c18:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106c1d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106c20:	8b 45 08             	mov    0x8(%ebp),%eax
80106c23:	29 d8                	sub    %ebx,%eax
80106c25:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106c28:	eb 3d                	jmp    80106c67 <mappages+0x67>
80106c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106c30:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106c32:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106c37:	c1 ea 0a             	shr    $0xa,%edx
80106c3a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106c40:	8d 94 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%edx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106c47:	85 d2                	test   %edx,%edx
80106c49:	74 75                	je     80106cc0 <mappages+0xc0>
    if(*pte & PTE_P)
80106c4b:	f6 02 01             	testb  $0x1,(%edx)
80106c4e:	0f 85 86 00 00 00    	jne    80106cda <mappages+0xda>
    *pte = pa | perm | PTE_P;
80106c54:	0b 75 0c             	or     0xc(%ebp),%esi
80106c57:	83 ce 01             	or     $0x1,%esi
80106c5a:	89 32                	mov    %esi,(%edx)
    if(a == last)
80106c5c:	3b 5d dc             	cmp    -0x24(%ebp),%ebx
80106c5f:	74 6f                	je     80106cd0 <mappages+0xd0>
    a += PGSIZE;
80106c61:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80106c67:	8b 45 e0             	mov    -0x20(%ebp),%eax
  pde = &pgdir[PDX(va)];
80106c6a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106c6d:	8d 34 18             	lea    (%eax,%ebx,1),%esi
80106c70:	89 d8                	mov    %ebx,%eax
80106c72:	c1 e8 16             	shr    $0x16,%eax
80106c75:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
80106c78:	8b 07                	mov    (%edi),%eax
80106c7a:	a8 01                	test   $0x1,%al
80106c7c:	75 b2                	jne    80106c30 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106c7e:	e8 8d bb ff ff       	call   80102810 <kalloc>
80106c83:	85 c0                	test   %eax,%eax
80106c85:	74 39                	je     80106cc0 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80106c87:	83 ec 04             	sub    $0x4,%esp
80106c8a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80106c8d:	68 00 10 00 00       	push   $0x1000
80106c92:	6a 00                	push   $0x0
80106c94:	50                   	push   %eax
80106c95:	e8 46 dc ff ff       	call   801048e0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106c9a:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
80106c9d:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106ca0:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80106ca6:	83 c8 07             	or     $0x7,%eax
80106ca9:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
80106cab:	89 d8                	mov    %ebx,%eax
80106cad:	c1 e8 0a             	shr    $0xa,%eax
80106cb0:	25 fc 0f 00 00       	and    $0xffc,%eax
80106cb5:	01 c2                	add    %eax,%edx
80106cb7:	eb 92                	jmp    80106c4b <mappages+0x4b>
80106cb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
80106cc0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106cc3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106cc8:	5b                   	pop    %ebx
80106cc9:	5e                   	pop    %esi
80106cca:	5f                   	pop    %edi
80106ccb:	5d                   	pop    %ebp
80106ccc:	c3                   	ret    
80106ccd:	8d 76 00             	lea    0x0(%esi),%esi
80106cd0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106cd3:	31 c0                	xor    %eax,%eax
}
80106cd5:	5b                   	pop    %ebx
80106cd6:	5e                   	pop    %esi
80106cd7:	5f                   	pop    %edi
80106cd8:	5d                   	pop    %ebp
80106cd9:	c3                   	ret    
      panic("remap");
80106cda:	83 ec 0c             	sub    $0xc,%esp
80106cdd:	68 0c 7e 10 80       	push   $0x80107e0c
80106ce2:	e8 a9 96 ff ff       	call   80100390 <panic>
80106ce7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106cee:	66 90                	xchg   %ax,%ax

80106cf0 <seginit>:
{
80106cf0:	f3 0f 1e fb          	endbr32 
80106cf4:	55                   	push   %ebp
80106cf5:	89 e5                	mov    %esp,%ebp
80106cf7:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106cfa:	e8 51 ce ff ff       	call   80103b50 <cpuid>
  pd[0] = size-1;
80106cff:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106d04:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106d0a:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106d0e:	c7 80 18 18 11 80 ff 	movl   $0xffff,-0x7feee7e8(%eax)
80106d15:	ff 00 00 
80106d18:	c7 80 1c 18 11 80 00 	movl   $0xcf9a00,-0x7feee7e4(%eax)
80106d1f:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106d22:	c7 80 20 18 11 80 ff 	movl   $0xffff,-0x7feee7e0(%eax)
80106d29:	ff 00 00 
80106d2c:	c7 80 24 18 11 80 00 	movl   $0xcf9200,-0x7feee7dc(%eax)
80106d33:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106d36:	c7 80 28 18 11 80 ff 	movl   $0xffff,-0x7feee7d8(%eax)
80106d3d:	ff 00 00 
80106d40:	c7 80 2c 18 11 80 00 	movl   $0xcffa00,-0x7feee7d4(%eax)
80106d47:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106d4a:	c7 80 30 18 11 80 ff 	movl   $0xffff,-0x7feee7d0(%eax)
80106d51:	ff 00 00 
80106d54:	c7 80 34 18 11 80 00 	movl   $0xcff200,-0x7feee7cc(%eax)
80106d5b:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106d5e:	05 10 18 11 80       	add    $0x80111810,%eax
  pd[1] = (uint)p;
80106d63:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106d67:	c1 e8 10             	shr    $0x10,%eax
80106d6a:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106d6e:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106d71:	0f 01 10             	lgdtl  (%eax)
}
80106d74:	c9                   	leave  
80106d75:	c3                   	ret    
80106d76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d7d:	8d 76 00             	lea    0x0(%esi),%esi

80106d80 <switchkvm>:
{
80106d80:	f3 0f 1e fb          	endbr32 
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106d84:	a1 24 45 11 80       	mov    0x80114524,%eax
80106d89:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106d8e:	0f 22 d8             	mov    %eax,%cr3
}
80106d91:	c3                   	ret    
80106d92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106da0 <switchuvm>:
{
80106da0:	f3 0f 1e fb          	endbr32 
80106da4:	55                   	push   %ebp
80106da5:	89 e5                	mov    %esp,%ebp
80106da7:	57                   	push   %edi
80106da8:	56                   	push   %esi
80106da9:	53                   	push   %ebx
80106daa:	83 ec 1c             	sub    $0x1c,%esp
80106dad:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106db0:	85 f6                	test   %esi,%esi
80106db2:	0f 84 cb 00 00 00    	je     80106e83 <switchuvm+0xe3>
  if(p->kstack == 0)
80106db8:	8b 46 08             	mov    0x8(%esi),%eax
80106dbb:	85 c0                	test   %eax,%eax
80106dbd:	0f 84 da 00 00 00    	je     80106e9d <switchuvm+0xfd>
  if(p->pgdir == 0)
80106dc3:	8b 46 04             	mov    0x4(%esi),%eax
80106dc6:	85 c0                	test   %eax,%eax
80106dc8:	0f 84 c2 00 00 00    	je     80106e90 <switchuvm+0xf0>
  pushcli();
80106dce:	e8 cd d8 ff ff       	call   801046a0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106dd3:	e8 08 cd ff ff       	call   80103ae0 <mycpu>
80106dd8:	89 c3                	mov    %eax,%ebx
80106dda:	e8 01 cd ff ff       	call   80103ae0 <mycpu>
80106ddf:	89 c7                	mov    %eax,%edi
80106de1:	e8 fa cc ff ff       	call   80103ae0 <mycpu>
80106de6:	83 c7 08             	add    $0x8,%edi
80106de9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106dec:	e8 ef cc ff ff       	call   80103ae0 <mycpu>
80106df1:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106df4:	ba 67 00 00 00       	mov    $0x67,%edx
80106df9:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106e00:	83 c0 08             	add    $0x8,%eax
80106e03:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106e0a:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106e0f:	83 c1 08             	add    $0x8,%ecx
80106e12:	c1 e8 18             	shr    $0x18,%eax
80106e15:	c1 e9 10             	shr    $0x10,%ecx
80106e18:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106e1e:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80106e24:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106e29:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106e30:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80106e35:	e8 a6 cc ff ff       	call   80103ae0 <mycpu>
80106e3a:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106e41:	e8 9a cc ff ff       	call   80103ae0 <mycpu>
80106e46:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106e4a:	8b 5e 08             	mov    0x8(%esi),%ebx
80106e4d:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106e53:	e8 88 cc ff ff       	call   80103ae0 <mycpu>
80106e58:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106e5b:	e8 80 cc ff ff       	call   80103ae0 <mycpu>
80106e60:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106e64:	b8 28 00 00 00       	mov    $0x28,%eax
80106e69:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106e6c:	8b 46 04             	mov    0x4(%esi),%eax
80106e6f:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106e74:	0f 22 d8             	mov    %eax,%cr3
}
80106e77:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e7a:	5b                   	pop    %ebx
80106e7b:	5e                   	pop    %esi
80106e7c:	5f                   	pop    %edi
80106e7d:	5d                   	pop    %ebp
  popcli();
80106e7e:	e9 6d d8 ff ff       	jmp    801046f0 <popcli>
    panic("switchuvm: no process");
80106e83:	83 ec 0c             	sub    $0xc,%esp
80106e86:	68 12 7e 10 80       	push   $0x80107e12
80106e8b:	e8 00 95 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
80106e90:	83 ec 0c             	sub    $0xc,%esp
80106e93:	68 3d 7e 10 80       	push   $0x80107e3d
80106e98:	e8 f3 94 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
80106e9d:	83 ec 0c             	sub    $0xc,%esp
80106ea0:	68 28 7e 10 80       	push   $0x80107e28
80106ea5:	e8 e6 94 ff ff       	call   80100390 <panic>
80106eaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106eb0 <inituvm>:
{
80106eb0:	f3 0f 1e fb          	endbr32 
80106eb4:	55                   	push   %ebp
80106eb5:	89 e5                	mov    %esp,%ebp
80106eb7:	57                   	push   %edi
80106eb8:	56                   	push   %esi
80106eb9:	53                   	push   %ebx
80106eba:	83 ec 1c             	sub    $0x1c,%esp
80106ebd:	8b 45 0c             	mov    0xc(%ebp),%eax
80106ec0:	8b 75 10             	mov    0x10(%ebp),%esi
80106ec3:	8b 7d 08             	mov    0x8(%ebp),%edi
80106ec6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106ec9:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106ecf:	77 4b                	ja     80106f1c <inituvm+0x6c>
  mem = kalloc();
80106ed1:	e8 3a b9 ff ff       	call   80102810 <kalloc>
  memset(mem, 0, PGSIZE);
80106ed6:	83 ec 04             	sub    $0x4,%esp
80106ed9:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
80106ede:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106ee0:	6a 00                	push   $0x0
80106ee2:	50                   	push   %eax
80106ee3:	e8 f8 d9 ff ff       	call   801048e0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106ee8:	58                   	pop    %eax
80106ee9:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106eef:	5a                   	pop    %edx
80106ef0:	6a 06                	push   $0x6
80106ef2:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106ef7:	31 d2                	xor    %edx,%edx
80106ef9:	50                   	push   %eax
80106efa:	89 f8                	mov    %edi,%eax
80106efc:	e8 ff fc ff ff       	call   80106c00 <mappages>
  memmove(mem, init, sz);
80106f01:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106f04:	89 75 10             	mov    %esi,0x10(%ebp)
80106f07:	83 c4 10             	add    $0x10,%esp
80106f0a:	89 5d 08             	mov    %ebx,0x8(%ebp)
80106f0d:	89 45 0c             	mov    %eax,0xc(%ebp)
}
80106f10:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f13:	5b                   	pop    %ebx
80106f14:	5e                   	pop    %esi
80106f15:	5f                   	pop    %edi
80106f16:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106f17:	e9 64 da ff ff       	jmp    80104980 <memmove>
    panic("inituvm: more than a page");
80106f1c:	83 ec 0c             	sub    $0xc,%esp
80106f1f:	68 51 7e 10 80       	push   $0x80107e51
80106f24:	e8 67 94 ff ff       	call   80100390 <panic>
80106f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106f30 <loaduvm>:
{
80106f30:	f3 0f 1e fb          	endbr32 
80106f34:	55                   	push   %ebp
80106f35:	89 e5                	mov    %esp,%ebp
80106f37:	57                   	push   %edi
80106f38:	56                   	push   %esi
80106f39:	53                   	push   %ebx
80106f3a:	83 ec 1c             	sub    $0x1c,%esp
80106f3d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106f40:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
80106f43:	a9 ff 0f 00 00       	test   $0xfff,%eax
80106f48:	0f 85 b7 00 00 00    	jne    80107005 <loaduvm+0xd5>
  for(i = 0; i < sz; i += PGSIZE){
80106f4e:	01 f0                	add    %esi,%eax
80106f50:	89 f3                	mov    %esi,%ebx
80106f52:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106f55:	8b 45 14             	mov    0x14(%ebp),%eax
80106f58:	01 f0                	add    %esi,%eax
80106f5a:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
80106f5d:	85 f6                	test   %esi,%esi
80106f5f:	0f 84 83 00 00 00    	je     80106fe8 <loaduvm+0xb8>
80106f65:	8d 76 00             	lea    0x0(%esi),%esi
  pde = &pgdir[PDX(va)];
80106f68:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  if(*pde & PTE_P){
80106f6b:	8b 4d 08             	mov    0x8(%ebp),%ecx
80106f6e:	29 d8                	sub    %ebx,%eax
  pde = &pgdir[PDX(va)];
80106f70:	89 c2                	mov    %eax,%edx
80106f72:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80106f75:	8b 14 91             	mov    (%ecx,%edx,4),%edx
80106f78:	f6 c2 01             	test   $0x1,%dl
80106f7b:	75 13                	jne    80106f90 <loaduvm+0x60>
      panic("loaduvm: address should exist");
80106f7d:	83 ec 0c             	sub    $0xc,%esp
80106f80:	68 6b 7e 10 80       	push   $0x80107e6b
80106f85:	e8 06 94 ff ff       	call   80100390 <panic>
80106f8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106f90:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106f93:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80106f99:	25 fc 0f 00 00       	and    $0xffc,%eax
80106f9e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106fa5:	85 c0                	test   %eax,%eax
80106fa7:	74 d4                	je     80106f7d <loaduvm+0x4d>
    pa = PTE_ADDR(*pte);
80106fa9:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106fab:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
80106fae:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80106fb3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106fb8:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
80106fbe:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106fc1:	29 d9                	sub    %ebx,%ecx
80106fc3:	05 00 00 00 80       	add    $0x80000000,%eax
80106fc8:	57                   	push   %edi
80106fc9:	51                   	push   %ecx
80106fca:	50                   	push   %eax
80106fcb:	ff 75 10             	pushl  0x10(%ebp)
80106fce:	e8 1d ac ff ff       	call   80101bf0 <readi>
80106fd3:	83 c4 10             	add    $0x10,%esp
80106fd6:	39 f8                	cmp    %edi,%eax
80106fd8:	75 1e                	jne    80106ff8 <loaduvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80106fda:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80106fe0:	89 f0                	mov    %esi,%eax
80106fe2:	29 d8                	sub    %ebx,%eax
80106fe4:	39 c6                	cmp    %eax,%esi
80106fe6:	77 80                	ja     80106f68 <loaduvm+0x38>
}
80106fe8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106feb:	31 c0                	xor    %eax,%eax
}
80106fed:	5b                   	pop    %ebx
80106fee:	5e                   	pop    %esi
80106fef:	5f                   	pop    %edi
80106ff0:	5d                   	pop    %ebp
80106ff1:	c3                   	ret    
80106ff2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106ff8:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106ffb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107000:	5b                   	pop    %ebx
80107001:	5e                   	pop    %esi
80107002:	5f                   	pop    %edi
80107003:	5d                   	pop    %ebp
80107004:	c3                   	ret    
    panic("loaduvm: addr must be page aligned");
80107005:	83 ec 0c             	sub    $0xc,%esp
80107008:	68 0c 7f 10 80       	push   $0x80107f0c
8010700d:	e8 7e 93 ff ff       	call   80100390 <panic>
80107012:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107020 <allocuvm>:
{
80107020:	f3 0f 1e fb          	endbr32 
80107024:	55                   	push   %ebp
80107025:	89 e5                	mov    %esp,%ebp
80107027:	57                   	push   %edi
80107028:	56                   	push   %esi
80107029:	53                   	push   %ebx
8010702a:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
8010702d:	8b 45 10             	mov    0x10(%ebp),%eax
{
80107030:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
80107033:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107036:	85 c0                	test   %eax,%eax
80107038:	0f 88 b2 00 00 00    	js     801070f0 <allocuvm+0xd0>
  if(newsz < oldsz)
8010703e:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
80107041:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80107044:	0f 82 96 00 00 00    	jb     801070e0 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
8010704a:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
80107050:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80107056:	39 75 10             	cmp    %esi,0x10(%ebp)
80107059:	77 40                	ja     8010709b <allocuvm+0x7b>
8010705b:	e9 83 00 00 00       	jmp    801070e3 <allocuvm+0xc3>
    memset(mem, 0, PGSIZE);
80107060:	83 ec 04             	sub    $0x4,%esp
80107063:	68 00 10 00 00       	push   $0x1000
80107068:	6a 00                	push   $0x0
8010706a:	50                   	push   %eax
8010706b:	e8 70 d8 ff ff       	call   801048e0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107070:	58                   	pop    %eax
80107071:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107077:	5a                   	pop    %edx
80107078:	6a 06                	push   $0x6
8010707a:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010707f:	89 f2                	mov    %esi,%edx
80107081:	50                   	push   %eax
80107082:	89 f8                	mov    %edi,%eax
80107084:	e8 77 fb ff ff       	call   80106c00 <mappages>
80107089:	83 c4 10             	add    $0x10,%esp
8010708c:	85 c0                	test   %eax,%eax
8010708e:	78 78                	js     80107108 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
80107090:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107096:	39 75 10             	cmp    %esi,0x10(%ebp)
80107099:	76 48                	jbe    801070e3 <allocuvm+0xc3>
    mem = kalloc();
8010709b:	e8 70 b7 ff ff       	call   80102810 <kalloc>
801070a0:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
801070a2:	85 c0                	test   %eax,%eax
801070a4:	75 ba                	jne    80107060 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
801070a6:	83 ec 0c             	sub    $0xc,%esp
801070a9:	68 89 7e 10 80       	push   $0x80107e89
801070ae:	e8 dd 95 ff ff       	call   80100690 <cprintf>
  if(newsz >= oldsz)
801070b3:	8b 45 0c             	mov    0xc(%ebp),%eax
801070b6:	83 c4 10             	add    $0x10,%esp
801070b9:	39 45 10             	cmp    %eax,0x10(%ebp)
801070bc:	74 32                	je     801070f0 <allocuvm+0xd0>
801070be:	8b 55 10             	mov    0x10(%ebp),%edx
801070c1:	89 c1                	mov    %eax,%ecx
801070c3:	89 f8                	mov    %edi,%eax
801070c5:	e8 86 fa ff ff       	call   80106b50 <deallocuvm.part.0>
      return 0;
801070ca:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
801070d1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801070d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070d7:	5b                   	pop    %ebx
801070d8:	5e                   	pop    %esi
801070d9:	5f                   	pop    %edi
801070da:	5d                   	pop    %ebp
801070db:	c3                   	ret    
801070dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
801070e0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
801070e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801070e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070e9:	5b                   	pop    %ebx
801070ea:	5e                   	pop    %esi
801070eb:	5f                   	pop    %edi
801070ec:	5d                   	pop    %ebp
801070ed:	c3                   	ret    
801070ee:	66 90                	xchg   %ax,%ax
    return 0;
801070f0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
801070f7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801070fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070fd:	5b                   	pop    %ebx
801070fe:	5e                   	pop    %esi
801070ff:	5f                   	pop    %edi
80107100:	5d                   	pop    %ebp
80107101:	c3                   	ret    
80107102:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107108:	83 ec 0c             	sub    $0xc,%esp
8010710b:	68 a1 7e 10 80       	push   $0x80107ea1
80107110:	e8 7b 95 ff ff       	call   80100690 <cprintf>
  if(newsz >= oldsz)
80107115:	8b 45 0c             	mov    0xc(%ebp),%eax
80107118:	83 c4 10             	add    $0x10,%esp
8010711b:	39 45 10             	cmp    %eax,0x10(%ebp)
8010711e:	74 0c                	je     8010712c <allocuvm+0x10c>
80107120:	8b 55 10             	mov    0x10(%ebp),%edx
80107123:	89 c1                	mov    %eax,%ecx
80107125:	89 f8                	mov    %edi,%eax
80107127:	e8 24 fa ff ff       	call   80106b50 <deallocuvm.part.0>
      kfree(mem);
8010712c:	83 ec 0c             	sub    $0xc,%esp
8010712f:	53                   	push   %ebx
80107130:	e8 1b b5 ff ff       	call   80102650 <kfree>
      return 0;
80107135:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010713c:	83 c4 10             	add    $0x10,%esp
}
8010713f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107142:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107145:	5b                   	pop    %ebx
80107146:	5e                   	pop    %esi
80107147:	5f                   	pop    %edi
80107148:	5d                   	pop    %ebp
80107149:	c3                   	ret    
8010714a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107150 <deallocuvm>:
{
80107150:	f3 0f 1e fb          	endbr32 
80107154:	55                   	push   %ebp
80107155:	89 e5                	mov    %esp,%ebp
80107157:	8b 55 0c             	mov    0xc(%ebp),%edx
8010715a:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010715d:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80107160:	39 d1                	cmp    %edx,%ecx
80107162:	73 0c                	jae    80107170 <deallocuvm+0x20>
}
80107164:	5d                   	pop    %ebp
80107165:	e9 e6 f9 ff ff       	jmp    80106b50 <deallocuvm.part.0>
8010716a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107170:	89 d0                	mov    %edx,%eax
80107172:	5d                   	pop    %ebp
80107173:	c3                   	ret    
80107174:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010717b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010717f:	90                   	nop

80107180 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107180:	f3 0f 1e fb          	endbr32 
80107184:	55                   	push   %ebp
80107185:	89 e5                	mov    %esp,%ebp
80107187:	57                   	push   %edi
80107188:	56                   	push   %esi
80107189:	53                   	push   %ebx
8010718a:	83 ec 0c             	sub    $0xc,%esp
8010718d:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80107190:	85 f6                	test   %esi,%esi
80107192:	74 55                	je     801071e9 <freevm+0x69>
  if(newsz >= oldsz)
80107194:	31 c9                	xor    %ecx,%ecx
80107196:	ba 00 00 00 80       	mov    $0x80000000,%edx
8010719b:	89 f0                	mov    %esi,%eax
8010719d:	89 f3                	mov    %esi,%ebx
8010719f:	e8 ac f9 ff ff       	call   80106b50 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801071a4:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801071aa:	eb 0b                	jmp    801071b7 <freevm+0x37>
801071ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801071b0:	83 c3 04             	add    $0x4,%ebx
801071b3:	39 df                	cmp    %ebx,%edi
801071b5:	74 23                	je     801071da <freevm+0x5a>
    if(pgdir[i] & PTE_P){
801071b7:	8b 03                	mov    (%ebx),%eax
801071b9:	a8 01                	test   $0x1,%al
801071bb:	74 f3                	je     801071b0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801071bd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
801071c2:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
801071c5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
801071c8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
801071cd:	50                   	push   %eax
801071ce:	e8 7d b4 ff ff       	call   80102650 <kfree>
801071d3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
801071d6:	39 df                	cmp    %ebx,%edi
801071d8:	75 dd                	jne    801071b7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
801071da:	89 75 08             	mov    %esi,0x8(%ebp)
}
801071dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801071e0:	5b                   	pop    %ebx
801071e1:	5e                   	pop    %esi
801071e2:	5f                   	pop    %edi
801071e3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
801071e4:	e9 67 b4 ff ff       	jmp    80102650 <kfree>
    panic("freevm: no pgdir");
801071e9:	83 ec 0c             	sub    $0xc,%esp
801071ec:	68 bd 7e 10 80       	push   $0x80107ebd
801071f1:	e8 9a 91 ff ff       	call   80100390 <panic>
801071f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801071fd:	8d 76 00             	lea    0x0(%esi),%esi

80107200 <setupkvm>:
{
80107200:	f3 0f 1e fb          	endbr32 
80107204:	55                   	push   %ebp
80107205:	89 e5                	mov    %esp,%ebp
80107207:	56                   	push   %esi
80107208:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107209:	e8 02 b6 ff ff       	call   80102810 <kalloc>
8010720e:	89 c6                	mov    %eax,%esi
80107210:	85 c0                	test   %eax,%eax
80107212:	74 42                	je     80107256 <setupkvm+0x56>
  memset(pgdir, 0, PGSIZE);
80107214:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107217:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
8010721c:	68 00 10 00 00       	push   $0x1000
80107221:	6a 00                	push   $0x0
80107223:	50                   	push   %eax
80107224:	e8 b7 d6 ff ff       	call   801048e0 <memset>
80107229:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
8010722c:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010722f:	83 ec 08             	sub    $0x8,%esp
80107232:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107235:	ff 73 0c             	pushl  0xc(%ebx)
80107238:	8b 13                	mov    (%ebx),%edx
8010723a:	50                   	push   %eax
8010723b:	29 c1                	sub    %eax,%ecx
8010723d:	89 f0                	mov    %esi,%eax
8010723f:	e8 bc f9 ff ff       	call   80106c00 <mappages>
80107244:	83 c4 10             	add    $0x10,%esp
80107247:	85 c0                	test   %eax,%eax
80107249:	78 15                	js     80107260 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
8010724b:	83 c3 10             	add    $0x10,%ebx
8010724e:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80107254:	75 d6                	jne    8010722c <setupkvm+0x2c>
}
80107256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107259:	89 f0                	mov    %esi,%eax
8010725b:	5b                   	pop    %ebx
8010725c:	5e                   	pop    %esi
8010725d:	5d                   	pop    %ebp
8010725e:	c3                   	ret    
8010725f:	90                   	nop
      freevm(pgdir);
80107260:	83 ec 0c             	sub    $0xc,%esp
80107263:	56                   	push   %esi
      return 0;
80107264:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107266:	e8 15 ff ff ff       	call   80107180 <freevm>
      return 0;
8010726b:	83 c4 10             	add    $0x10,%esp
}
8010726e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107271:	89 f0                	mov    %esi,%eax
80107273:	5b                   	pop    %ebx
80107274:	5e                   	pop    %esi
80107275:	5d                   	pop    %ebp
80107276:	c3                   	ret    
80107277:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010727e:	66 90                	xchg   %ax,%ax

80107280 <kvmalloc>:
{
80107280:	f3 0f 1e fb          	endbr32 
80107284:	55                   	push   %ebp
80107285:	89 e5                	mov    %esp,%ebp
80107287:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
8010728a:	e8 71 ff ff ff       	call   80107200 <setupkvm>
8010728f:	a3 24 45 11 80       	mov    %eax,0x80114524
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107294:	05 00 00 00 80       	add    $0x80000000,%eax
80107299:	0f 22 d8             	mov    %eax,%cr3
}
8010729c:	c9                   	leave  
8010729d:	c3                   	ret    
8010729e:	66 90                	xchg   %ax,%ax

801072a0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801072a0:	f3 0f 1e fb          	endbr32 
801072a4:	55                   	push   %ebp
801072a5:	89 e5                	mov    %esp,%ebp
801072a7:	83 ec 08             	sub    $0x8,%esp
801072aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801072ad:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
801072b0:	89 c1                	mov    %eax,%ecx
801072b2:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801072b5:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
801072b8:	f6 c2 01             	test   $0x1,%dl
801072bb:	75 13                	jne    801072d0 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
801072bd:	83 ec 0c             	sub    $0xc,%esp
801072c0:	68 ce 7e 10 80       	push   $0x80107ece
801072c5:	e8 c6 90 ff ff       	call   80100390 <panic>
801072ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
801072d0:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801072d3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
801072d9:	25 fc 0f 00 00       	and    $0xffc,%eax
801072de:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
801072e5:	85 c0                	test   %eax,%eax
801072e7:	74 d4                	je     801072bd <clearpteu+0x1d>
  *pte &= ~PTE_U;
801072e9:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801072ec:	c9                   	leave  
801072ed:	c3                   	ret    
801072ee:	66 90                	xchg   %ax,%ax

801072f0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801072f0:	f3 0f 1e fb          	endbr32 
801072f4:	55                   	push   %ebp
801072f5:	89 e5                	mov    %esp,%ebp
801072f7:	57                   	push   %edi
801072f8:	56                   	push   %esi
801072f9:	53                   	push   %ebx
801072fa:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801072fd:	e8 fe fe ff ff       	call   80107200 <setupkvm>
80107302:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107305:	85 c0                	test   %eax,%eax
80107307:	0f 84 b9 00 00 00    	je     801073c6 <copyuvm+0xd6>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
8010730d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107310:	85 c9                	test   %ecx,%ecx
80107312:	0f 84 ae 00 00 00    	je     801073c6 <copyuvm+0xd6>
80107318:	31 f6                	xor    %esi,%esi
8010731a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(*pde & PTE_P){
80107320:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
80107323:	89 f0                	mov    %esi,%eax
80107325:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107328:	8b 04 81             	mov    (%ecx,%eax,4),%eax
8010732b:	a8 01                	test   $0x1,%al
8010732d:	75 11                	jne    80107340 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010732f:	83 ec 0c             	sub    $0xc,%esp
80107332:	68 d8 7e 10 80       	push   $0x80107ed8
80107337:	e8 54 90 ff ff       	call   80100390 <panic>
8010733c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80107340:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107342:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107347:	c1 ea 0a             	shr    $0xa,%edx
8010734a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107350:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107357:	85 c0                	test   %eax,%eax
80107359:	74 d4                	je     8010732f <copyuvm+0x3f>
    if(!(*pte & PTE_P))
8010735b:	8b 00                	mov    (%eax),%eax
8010735d:	a8 01                	test   $0x1,%al
8010735f:	0f 84 9f 00 00 00    	je     80107404 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107365:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80107367:	25 ff 0f 00 00       	and    $0xfff,%eax
8010736c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
8010736f:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80107375:	e8 96 b4 ff ff       	call   80102810 <kalloc>
8010737a:	89 c3                	mov    %eax,%ebx
8010737c:	85 c0                	test   %eax,%eax
8010737e:	74 64                	je     801073e4 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107380:	83 ec 04             	sub    $0x4,%esp
80107383:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107389:	68 00 10 00 00       	push   $0x1000
8010738e:	57                   	push   %edi
8010738f:	50                   	push   %eax
80107390:	e8 eb d5 ff ff       	call   80104980 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107395:	58                   	pop    %eax
80107396:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010739c:	5a                   	pop    %edx
8010739d:	ff 75 e4             	pushl  -0x1c(%ebp)
801073a0:	b9 00 10 00 00       	mov    $0x1000,%ecx
801073a5:	89 f2                	mov    %esi,%edx
801073a7:	50                   	push   %eax
801073a8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801073ab:	e8 50 f8 ff ff       	call   80106c00 <mappages>
801073b0:	83 c4 10             	add    $0x10,%esp
801073b3:	85 c0                	test   %eax,%eax
801073b5:	78 21                	js     801073d8 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
801073b7:	81 c6 00 10 00 00    	add    $0x1000,%esi
801073bd:	39 75 0c             	cmp    %esi,0xc(%ebp)
801073c0:	0f 87 5a ff ff ff    	ja     80107320 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
801073c6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801073c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801073cc:	5b                   	pop    %ebx
801073cd:	5e                   	pop    %esi
801073ce:	5f                   	pop    %edi
801073cf:	5d                   	pop    %ebp
801073d0:	c3                   	ret    
801073d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
801073d8:	83 ec 0c             	sub    $0xc,%esp
801073db:	53                   	push   %ebx
801073dc:	e8 6f b2 ff ff       	call   80102650 <kfree>
      goto bad;
801073e1:	83 c4 10             	add    $0x10,%esp
  freevm(d);
801073e4:	83 ec 0c             	sub    $0xc,%esp
801073e7:	ff 75 e0             	pushl  -0x20(%ebp)
801073ea:	e8 91 fd ff ff       	call   80107180 <freevm>
  return 0;
801073ef:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
801073f6:	83 c4 10             	add    $0x10,%esp
}
801073f9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801073fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801073ff:	5b                   	pop    %ebx
80107400:	5e                   	pop    %esi
80107401:	5f                   	pop    %edi
80107402:	5d                   	pop    %ebp
80107403:	c3                   	ret    
      panic("copyuvm: page not present");
80107404:	83 ec 0c             	sub    $0xc,%esp
80107407:	68 f2 7e 10 80       	push   $0x80107ef2
8010740c:	e8 7f 8f ff ff       	call   80100390 <panic>
80107411:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107418:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010741f:	90                   	nop

80107420 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107420:	f3 0f 1e fb          	endbr32 
80107424:	55                   	push   %ebp
80107425:	89 e5                	mov    %esp,%ebp
80107427:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
8010742a:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
8010742d:	89 c1                	mov    %eax,%ecx
8010742f:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107432:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107435:	f6 c2 01             	test   $0x1,%dl
80107438:	0f 84 fc 00 00 00    	je     8010753a <uva2ka.cold>
  return &pgtab[PTX(va)];
8010743e:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107441:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107447:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80107448:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
8010744d:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
  if((*pte & PTE_U) == 0)
80107454:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107456:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
8010745b:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
8010745e:	05 00 00 00 80       	add    $0x80000000,%eax
80107463:	83 fa 05             	cmp    $0x5,%edx
80107466:	ba 00 00 00 00       	mov    $0x0,%edx
8010746b:	0f 45 c2             	cmovne %edx,%eax
}
8010746e:	c3                   	ret    
8010746f:	90                   	nop

80107470 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107470:	f3 0f 1e fb          	endbr32 
80107474:	55                   	push   %ebp
80107475:	89 e5                	mov    %esp,%ebp
80107477:	57                   	push   %edi
80107478:	56                   	push   %esi
80107479:	53                   	push   %ebx
8010747a:	83 ec 0c             	sub    $0xc,%esp
8010747d:	8b 75 14             	mov    0x14(%ebp),%esi
80107480:	8b 45 0c             	mov    0xc(%ebp),%eax
80107483:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107486:	85 f6                	test   %esi,%esi
80107488:	75 4d                	jne    801074d7 <copyout+0x67>
8010748a:	e9 a1 00 00 00       	jmp    80107530 <copyout+0xc0>
8010748f:	90                   	nop
  return (char*)P2V(PTE_ADDR(*pte));
80107490:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107496:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
8010749c:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
801074a2:	74 75                	je     80107519 <copyout+0xa9>
      return -1;
    n = PGSIZE - (va - va0);
801074a4:	89 fb                	mov    %edi,%ebx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801074a6:	89 55 10             	mov    %edx,0x10(%ebp)
    n = PGSIZE - (va - va0);
801074a9:	29 c3                	sub    %eax,%ebx
801074ab:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
801074b1:	39 f3                	cmp    %esi,%ebx
801074b3:	0f 47 de             	cmova  %esi,%ebx
    memmove(pa0 + (va - va0), buf, n);
801074b6:	29 f8                	sub    %edi,%eax
801074b8:	83 ec 04             	sub    $0x4,%esp
801074bb:	01 c8                	add    %ecx,%eax
801074bd:	53                   	push   %ebx
801074be:	52                   	push   %edx
801074bf:	50                   	push   %eax
801074c0:	e8 bb d4 ff ff       	call   80104980 <memmove>
    len -= n;
    buf += n;
801074c5:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
801074c8:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
801074ce:	83 c4 10             	add    $0x10,%esp
    buf += n;
801074d1:	01 da                	add    %ebx,%edx
  while(len > 0){
801074d3:	29 de                	sub    %ebx,%esi
801074d5:	74 59                	je     80107530 <copyout+0xc0>
  if(*pde & PTE_P){
801074d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
801074da:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
801074dc:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
801074de:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
801074e1:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
801074e7:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
801074ea:	f6 c1 01             	test   $0x1,%cl
801074ed:	0f 84 4e 00 00 00    	je     80107541 <copyout.cold>
  return &pgtab[PTX(va)];
801074f3:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801074f5:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
801074fb:	c1 eb 0c             	shr    $0xc,%ebx
801074fe:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80107504:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
8010750b:	89 d9                	mov    %ebx,%ecx
8010750d:	83 e1 05             	and    $0x5,%ecx
80107510:	83 f9 05             	cmp    $0x5,%ecx
80107513:	0f 84 77 ff ff ff    	je     80107490 <copyout+0x20>
  }
  return 0;
}
80107519:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010751c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107521:	5b                   	pop    %ebx
80107522:	5e                   	pop    %esi
80107523:	5f                   	pop    %edi
80107524:	5d                   	pop    %ebp
80107525:	c3                   	ret    
80107526:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010752d:	8d 76 00             	lea    0x0(%esi),%esi
80107530:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107533:	31 c0                	xor    %eax,%eax
}
80107535:	5b                   	pop    %ebx
80107536:	5e                   	pop    %esi
80107537:	5f                   	pop    %edi
80107538:	5d                   	pop    %ebp
80107539:	c3                   	ret    

8010753a <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
8010753a:	a1 00 00 00 00       	mov    0x0,%eax
8010753f:	0f 0b                	ud2    

80107541 <copyout.cold>:
80107541:	a1 00 00 00 00       	mov    0x0,%eax
80107546:	0f 0b                	ud2    
