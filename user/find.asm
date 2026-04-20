
user/_find:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <find>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"
#include "kernel/fcntl.h"
void find(char *path,char *name){
   0:	d9010113          	addi	sp,sp,-624
   4:	26113423          	sd	ra,616(sp)
   8:	26813023          	sd	s0,608(sp)
   c:	25213823          	sd	s2,592(sp)
  10:	25313423          	sd	s3,584(sp)
  14:	1c80                	addi	s0,sp,624
  16:	892a                	mv	s2,a0
  18:	89ae                	mv	s3,a1
    char buf[512], *p;
    int fd;
    struct dirent de;
    struct stat st;
    if((fd = open(path, O_RDONLY)) < 0){
  1a:	4581                	li	a1,0
  1c:	46a000ef          	jal	486 <open>
  20:	04054063          	bltz	a0,60 <find+0x60>
  24:	24913c23          	sd	s1,600(sp)
  28:	84aa                	mv	s1,a0
        fprintf(2, "find: cannot open %s\n", path);
        return;
    }
    if(fstat(fd, &st) < 0){
  2a:	d9840593          	addi	a1,s0,-616
  2e:	470000ef          	jal	49e <fstat>
  32:	04054063          	bltz	a0,72 <find+0x72>
        fprintf(2, "find: cannot stat %s\n", path);
        close(fd);
        return;
    }
    if(st.type!=T_DIR){
  36:	da041703          	lh	a4,-608(s0)
  3a:	4785                	li	a5,1
  3c:	04f70963          	beq	a4,a5,8e <find+0x8e>
        close(fd);
  40:	8526                	mv	a0,s1
  42:	42c000ef          	jal	46e <close>
        return;
  46:	25813483          	ld	s1,600(sp)
        }

    }
    close(fd);

}
  4a:	26813083          	ld	ra,616(sp)
  4e:	26013403          	ld	s0,608(sp)
  52:	25013903          	ld	s2,592(sp)
  56:	24813983          	ld	s3,584(sp)
  5a:	27010113          	addi	sp,sp,624
  5e:	8082                	ret
        fprintf(2, "find: cannot open %s\n", path);
  60:	864a                	mv	a2,s2
  62:	00001597          	auipc	a1,0x1
  66:	9be58593          	addi	a1,a1,-1602 # a20 <malloc+0x106>
  6a:	4509                	li	a0,2
  6c:	7d0000ef          	jal	83c <fprintf>
        return;
  70:	bfe9                	j	4a <find+0x4a>
        fprintf(2, "find: cannot stat %s\n", path);
  72:	864a                	mv	a2,s2
  74:	00001597          	auipc	a1,0x1
  78:	9cc58593          	addi	a1,a1,-1588 # a40 <malloc+0x126>
  7c:	4509                	li	a0,2
  7e:	7be000ef          	jal	83c <fprintf>
        close(fd);
  82:	8526                	mv	a0,s1
  84:	3ea000ef          	jal	46e <close>
        return;
  88:	25813483          	ld	s1,600(sp)
  8c:	bf7d                	j	4a <find+0x4a>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
  8e:	854a                	mv	a0,s2
  90:	1a6000ef          	jal	236 <strlen>
  94:	2541                	addiw	a0,a0,16
  96:	20000793          	li	a5,512
  9a:	0aa7e963          	bltu	a5,a0,14c <find+0x14c>
  9e:	25413023          	sd	s4,576(sp)
  a2:	23513c23          	sd	s5,568(sp)
  a6:	23613823          	sd	s6,560(sp)
    strcpy(buf, path);
  aa:	85ca                	mv	a1,s2
  ac:	dc040513          	addi	a0,s0,-576
  b0:	13e000ef          	jal	1ee <strcpy>
    p = buf+strlen(buf);
  b4:	dc040513          	addi	a0,s0,-576
  b8:	17e000ef          	jal	236 <strlen>
  bc:	1502                	slli	a0,a0,0x20
  be:	9101                	srli	a0,a0,0x20
  c0:	dc040793          	addi	a5,s0,-576
  c4:	00a78933          	add	s2,a5,a0
    *p++ = '/';
  c8:	00190a13          	addi	s4,s2,1
  cc:	02f00793          	li	a5,47
  d0:	00f90023          	sb	a5,0(s2)
        if(strcmp(p,".")==0 ||strcmp(p,"..")==0){
  d4:	00001a97          	auipc	s5,0x1
  d8:	99ca8a93          	addi	s5,s5,-1636 # a70 <malloc+0x156>
  dc:	00001b17          	auipc	s6,0x1
  e0:	99cb0b13          	addi	s6,s6,-1636 # a78 <malloc+0x15e>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
  e4:	4641                	li	a2,16
  e6:	db040593          	addi	a1,s0,-592
  ea:	8526                	mv	a0,s1
  ec:	372000ef          	jal	45e <read>
  f0:	47c1                	li	a5,16
  f2:	0af51063          	bne	a0,a5,192 <find+0x192>
        if( de.inum == 0)
  f6:	db045783          	lhu	a5,-592(s0)
  fa:	d7ed                	beqz	a5,e4 <find+0xe4>
        memmove(p, de.name, DIRSIZ);
  fc:	4639                	li	a2,14
  fe:	db240593          	addi	a1,s0,-590
 102:	8552                	mv	a0,s4
 104:	294000ef          	jal	398 <memmove>
        p[DIRSIZ] = 0;
 108:	000907a3          	sb	zero,15(s2)
        if(strcmp(p,".")==0 ||strcmp(p,"..")==0){
 10c:	85d6                	mv	a1,s5
 10e:	8552                	mv	a0,s4
 110:	0fa000ef          	jal	20a <strcmp>
 114:	d961                	beqz	a0,e4 <find+0xe4>
 116:	85da                	mv	a1,s6
 118:	8552                	mv	a0,s4
 11a:	0f0000ef          	jal	20a <strcmp>
 11e:	d179                	beqz	a0,e4 <find+0xe4>
        if(stat(buf, &st) < 0){
 120:	d9840593          	addi	a1,s0,-616
 124:	dc040513          	addi	a0,s0,-576
 128:	1ee000ef          	jal	316 <stat>
 12c:	02054c63          	bltz	a0,164 <find+0x164>
        if(st.type==T_FILE){
 130:	da041783          	lh	a5,-608(s0)
 134:	4709                	li	a4,2
 136:	04e78063          	beq	a5,a4,176 <find+0x176>
        }else if(st.type==T_DIR){
 13a:	4705                	li	a4,1
 13c:	fae794e3          	bne	a5,a4,e4 <find+0xe4>
            find(buf,name);
 140:	85ce                	mv	a1,s3
 142:	dc040513          	addi	a0,s0,-576
 146:	ebbff0ef          	jal	0 <find>
 14a:	bf69                	j	e4 <find+0xe4>
        printf("find: path too long\n");
 14c:	00001517          	auipc	a0,0x1
 150:	90c50513          	addi	a0,a0,-1780 # a58 <malloc+0x13e>
 154:	712000ef          	jal	866 <printf>
        close(fd);
 158:	8526                	mv	a0,s1
 15a:	314000ef          	jal	46e <close>
        return;
 15e:	25813483          	ld	s1,600(sp)
 162:	b5e5                	j	4a <find+0x4a>
            printf("find: cannot stat %s\n", buf);
 164:	dc040593          	addi	a1,s0,-576
 168:	00001517          	auipc	a0,0x1
 16c:	8d850513          	addi	a0,a0,-1832 # a40 <malloc+0x126>
 170:	6f6000ef          	jal	866 <printf>
            continue;
 174:	bf85                	j	e4 <find+0xe4>
            if(strcmp(p,name)==0){
 176:	85ce                	mv	a1,s3
 178:	8552                	mv	a0,s4
 17a:	090000ef          	jal	20a <strcmp>
 17e:	f13d                	bnez	a0,e4 <find+0xe4>
                printf("%s\n",buf);
 180:	dc040593          	addi	a1,s0,-576
 184:	00001517          	auipc	a0,0x1
 188:	8fc50513          	addi	a0,a0,-1796 # a80 <malloc+0x166>
 18c:	6da000ef          	jal	866 <printf>
 190:	bf91                	j	e4 <find+0xe4>
    close(fd);
 192:	8526                	mv	a0,s1
 194:	2da000ef          	jal	46e <close>
 198:	25813483          	ld	s1,600(sp)
 19c:	24013a03          	ld	s4,576(sp)
 1a0:	23813a83          	ld	s5,568(sp)
 1a4:	23013b03          	ld	s6,560(sp)
 1a8:	b54d                	j	4a <find+0x4a>

00000000000001aa <main>:
int main(int argc, char *argv[])
{
 1aa:	1141                	addi	sp,sp,-16
 1ac:	e406                	sd	ra,8(sp)
 1ae:	e022                	sd	s0,0(sp)
 1b0:	0800                	addi	s0,sp,16
    if(argc!=3){
 1b2:	470d                	li	a4,3
 1b4:	00e50c63          	beq	a0,a4,1cc <main+0x22>
        fprintf(2,"Usage:find <path> <name>\n");
 1b8:	00001597          	auipc	a1,0x1
 1bc:	8d058593          	addi	a1,a1,-1840 # a88 <malloc+0x16e>
 1c0:	4509                	li	a0,2
 1c2:	67a000ef          	jal	83c <fprintf>
        exit(0);
 1c6:	4501                	li	a0,0
 1c8:	27e000ef          	jal	446 <exit>
 1cc:	87ae                	mv	a5,a1
    }else{
        find(argv[1],argv[2]);
 1ce:	698c                	ld	a1,16(a1)
 1d0:	6788                	ld	a0,8(a5)
 1d2:	e2fff0ef          	jal	0 <find>
    }
    exit(0);
 1d6:	4501                	li	a0,0
 1d8:	26e000ef          	jal	446 <exit>

00000000000001dc <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 1dc:	1141                	addi	sp,sp,-16
 1de:	e406                	sd	ra,8(sp)
 1e0:	e022                	sd	s0,0(sp)
 1e2:	0800                	addi	s0,sp,16
  extern int main();
  main();
 1e4:	fc7ff0ef          	jal	1aa <main>
  exit(0);
 1e8:	4501                	li	a0,0
 1ea:	25c000ef          	jal	446 <exit>

00000000000001ee <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 1ee:	1141                	addi	sp,sp,-16
 1f0:	e422                	sd	s0,8(sp)
 1f2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1f4:	87aa                	mv	a5,a0
 1f6:	0585                	addi	a1,a1,1
 1f8:	0785                	addi	a5,a5,1
 1fa:	fff5c703          	lbu	a4,-1(a1)
 1fe:	fee78fa3          	sb	a4,-1(a5)
 202:	fb75                	bnez	a4,1f6 <strcpy+0x8>
    ;
  return os;
}
 204:	6422                	ld	s0,8(sp)
 206:	0141                	addi	sp,sp,16
 208:	8082                	ret

000000000000020a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 20a:	1141                	addi	sp,sp,-16
 20c:	e422                	sd	s0,8(sp)
 20e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 210:	00054783          	lbu	a5,0(a0)
 214:	cb91                	beqz	a5,228 <strcmp+0x1e>
 216:	0005c703          	lbu	a4,0(a1)
 21a:	00f71763          	bne	a4,a5,228 <strcmp+0x1e>
    p++, q++;
 21e:	0505                	addi	a0,a0,1
 220:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 222:	00054783          	lbu	a5,0(a0)
 226:	fbe5                	bnez	a5,216 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 228:	0005c503          	lbu	a0,0(a1)
}
 22c:	40a7853b          	subw	a0,a5,a0
 230:	6422                	ld	s0,8(sp)
 232:	0141                	addi	sp,sp,16
 234:	8082                	ret

0000000000000236 <strlen>:

uint
strlen(const char *s)
{
 236:	1141                	addi	sp,sp,-16
 238:	e422                	sd	s0,8(sp)
 23a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 23c:	00054783          	lbu	a5,0(a0)
 240:	cf91                	beqz	a5,25c <strlen+0x26>
 242:	0505                	addi	a0,a0,1
 244:	87aa                	mv	a5,a0
 246:	86be                	mv	a3,a5
 248:	0785                	addi	a5,a5,1
 24a:	fff7c703          	lbu	a4,-1(a5)
 24e:	ff65                	bnez	a4,246 <strlen+0x10>
 250:	40a6853b          	subw	a0,a3,a0
 254:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 256:	6422                	ld	s0,8(sp)
 258:	0141                	addi	sp,sp,16
 25a:	8082                	ret
  for(n = 0; s[n]; n++)
 25c:	4501                	li	a0,0
 25e:	bfe5                	j	256 <strlen+0x20>

0000000000000260 <memset>:

void*
memset(void *dst, int c, uint n)
{
 260:	1141                	addi	sp,sp,-16
 262:	e422                	sd	s0,8(sp)
 264:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 266:	ca19                	beqz	a2,27c <memset+0x1c>
 268:	87aa                	mv	a5,a0
 26a:	1602                	slli	a2,a2,0x20
 26c:	9201                	srli	a2,a2,0x20
 26e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 272:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 276:	0785                	addi	a5,a5,1
 278:	fee79de3          	bne	a5,a4,272 <memset+0x12>
  }
  return dst;
}
 27c:	6422                	ld	s0,8(sp)
 27e:	0141                	addi	sp,sp,16
 280:	8082                	ret

0000000000000282 <strchr>:

char*
strchr(const char *s, char c)
{
 282:	1141                	addi	sp,sp,-16
 284:	e422                	sd	s0,8(sp)
 286:	0800                	addi	s0,sp,16
  for(; *s; s++)
 288:	00054783          	lbu	a5,0(a0)
 28c:	cb99                	beqz	a5,2a2 <strchr+0x20>
    if(*s == c)
 28e:	00f58763          	beq	a1,a5,29c <strchr+0x1a>
  for(; *s; s++)
 292:	0505                	addi	a0,a0,1
 294:	00054783          	lbu	a5,0(a0)
 298:	fbfd                	bnez	a5,28e <strchr+0xc>
      return (char*)s;
  return 0;
 29a:	4501                	li	a0,0
}
 29c:	6422                	ld	s0,8(sp)
 29e:	0141                	addi	sp,sp,16
 2a0:	8082                	ret
  return 0;
 2a2:	4501                	li	a0,0
 2a4:	bfe5                	j	29c <strchr+0x1a>

00000000000002a6 <gets>:

char*
gets(char *buf, int max)
{
 2a6:	711d                	addi	sp,sp,-96
 2a8:	ec86                	sd	ra,88(sp)
 2aa:	e8a2                	sd	s0,80(sp)
 2ac:	e4a6                	sd	s1,72(sp)
 2ae:	e0ca                	sd	s2,64(sp)
 2b0:	fc4e                	sd	s3,56(sp)
 2b2:	f852                	sd	s4,48(sp)
 2b4:	f456                	sd	s5,40(sp)
 2b6:	f05a                	sd	s6,32(sp)
 2b8:	ec5e                	sd	s7,24(sp)
 2ba:	1080                	addi	s0,sp,96
 2bc:	8baa                	mv	s7,a0
 2be:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2c0:	892a                	mv	s2,a0
 2c2:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2c4:	4aa9                	li	s5,10
 2c6:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 2c8:	89a6                	mv	s3,s1
 2ca:	2485                	addiw	s1,s1,1
 2cc:	0344d663          	bge	s1,s4,2f8 <gets+0x52>
    cc = read(0, &c, 1);
 2d0:	4605                	li	a2,1
 2d2:	faf40593          	addi	a1,s0,-81
 2d6:	4501                	li	a0,0
 2d8:	186000ef          	jal	45e <read>
    if(cc < 1)
 2dc:	00a05e63          	blez	a0,2f8 <gets+0x52>
    buf[i++] = c;
 2e0:	faf44783          	lbu	a5,-81(s0)
 2e4:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2e8:	01578763          	beq	a5,s5,2f6 <gets+0x50>
 2ec:	0905                	addi	s2,s2,1
 2ee:	fd679de3          	bne	a5,s6,2c8 <gets+0x22>
    buf[i++] = c;
 2f2:	89a6                	mv	s3,s1
 2f4:	a011                	j	2f8 <gets+0x52>
 2f6:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2f8:	99de                	add	s3,s3,s7
 2fa:	00098023          	sb	zero,0(s3)
  return buf;
}
 2fe:	855e                	mv	a0,s7
 300:	60e6                	ld	ra,88(sp)
 302:	6446                	ld	s0,80(sp)
 304:	64a6                	ld	s1,72(sp)
 306:	6906                	ld	s2,64(sp)
 308:	79e2                	ld	s3,56(sp)
 30a:	7a42                	ld	s4,48(sp)
 30c:	7aa2                	ld	s5,40(sp)
 30e:	7b02                	ld	s6,32(sp)
 310:	6be2                	ld	s7,24(sp)
 312:	6125                	addi	sp,sp,96
 314:	8082                	ret

0000000000000316 <stat>:

int
stat(const char *n, struct stat *st)
{
 316:	1101                	addi	sp,sp,-32
 318:	ec06                	sd	ra,24(sp)
 31a:	e822                	sd	s0,16(sp)
 31c:	e04a                	sd	s2,0(sp)
 31e:	1000                	addi	s0,sp,32
 320:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 322:	4581                	li	a1,0
 324:	162000ef          	jal	486 <open>
  if(fd < 0)
 328:	02054263          	bltz	a0,34c <stat+0x36>
 32c:	e426                	sd	s1,8(sp)
 32e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 330:	85ca                	mv	a1,s2
 332:	16c000ef          	jal	49e <fstat>
 336:	892a                	mv	s2,a0
  close(fd);
 338:	8526                	mv	a0,s1
 33a:	134000ef          	jal	46e <close>
  return r;
 33e:	64a2                	ld	s1,8(sp)
}
 340:	854a                	mv	a0,s2
 342:	60e2                	ld	ra,24(sp)
 344:	6442                	ld	s0,16(sp)
 346:	6902                	ld	s2,0(sp)
 348:	6105                	addi	sp,sp,32
 34a:	8082                	ret
    return -1;
 34c:	597d                	li	s2,-1
 34e:	bfcd                	j	340 <stat+0x2a>

0000000000000350 <atoi>:

int
atoi(const char *s)
{
 350:	1141                	addi	sp,sp,-16
 352:	e422                	sd	s0,8(sp)
 354:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 356:	00054683          	lbu	a3,0(a0)
 35a:	fd06879b          	addiw	a5,a3,-48
 35e:	0ff7f793          	zext.b	a5,a5
 362:	4625                	li	a2,9
 364:	02f66863          	bltu	a2,a5,394 <atoi+0x44>
 368:	872a                	mv	a4,a0
  n = 0;
 36a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 36c:	0705                	addi	a4,a4,1
 36e:	0025179b          	slliw	a5,a0,0x2
 372:	9fa9                	addw	a5,a5,a0
 374:	0017979b          	slliw	a5,a5,0x1
 378:	9fb5                	addw	a5,a5,a3
 37a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 37e:	00074683          	lbu	a3,0(a4)
 382:	fd06879b          	addiw	a5,a3,-48
 386:	0ff7f793          	zext.b	a5,a5
 38a:	fef671e3          	bgeu	a2,a5,36c <atoi+0x1c>
  return n;
}
 38e:	6422                	ld	s0,8(sp)
 390:	0141                	addi	sp,sp,16
 392:	8082                	ret
  n = 0;
 394:	4501                	li	a0,0
 396:	bfe5                	j	38e <atoi+0x3e>

0000000000000398 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 398:	1141                	addi	sp,sp,-16
 39a:	e422                	sd	s0,8(sp)
 39c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 39e:	02b57463          	bgeu	a0,a1,3c6 <memmove+0x2e>
    while(n-- > 0)
 3a2:	00c05f63          	blez	a2,3c0 <memmove+0x28>
 3a6:	1602                	slli	a2,a2,0x20
 3a8:	9201                	srli	a2,a2,0x20
 3aa:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 3ae:	872a                	mv	a4,a0
      *dst++ = *src++;
 3b0:	0585                	addi	a1,a1,1
 3b2:	0705                	addi	a4,a4,1
 3b4:	fff5c683          	lbu	a3,-1(a1)
 3b8:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3bc:	fef71ae3          	bne	a4,a5,3b0 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3c0:	6422                	ld	s0,8(sp)
 3c2:	0141                	addi	sp,sp,16
 3c4:	8082                	ret
    dst += n;
 3c6:	00c50733          	add	a4,a0,a2
    src += n;
 3ca:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3cc:	fec05ae3          	blez	a2,3c0 <memmove+0x28>
 3d0:	fff6079b          	addiw	a5,a2,-1
 3d4:	1782                	slli	a5,a5,0x20
 3d6:	9381                	srli	a5,a5,0x20
 3d8:	fff7c793          	not	a5,a5
 3dc:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3de:	15fd                	addi	a1,a1,-1
 3e0:	177d                	addi	a4,a4,-1
 3e2:	0005c683          	lbu	a3,0(a1)
 3e6:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3ea:	fee79ae3          	bne	a5,a4,3de <memmove+0x46>
 3ee:	bfc9                	j	3c0 <memmove+0x28>

00000000000003f0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3f0:	1141                	addi	sp,sp,-16
 3f2:	e422                	sd	s0,8(sp)
 3f4:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3f6:	ca05                	beqz	a2,426 <memcmp+0x36>
 3f8:	fff6069b          	addiw	a3,a2,-1
 3fc:	1682                	slli	a3,a3,0x20
 3fe:	9281                	srli	a3,a3,0x20
 400:	0685                	addi	a3,a3,1
 402:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 404:	00054783          	lbu	a5,0(a0)
 408:	0005c703          	lbu	a4,0(a1)
 40c:	00e79863          	bne	a5,a4,41c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 410:	0505                	addi	a0,a0,1
    p2++;
 412:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 414:	fed518e3          	bne	a0,a3,404 <memcmp+0x14>
  }
  return 0;
 418:	4501                	li	a0,0
 41a:	a019                	j	420 <memcmp+0x30>
      return *p1 - *p2;
 41c:	40e7853b          	subw	a0,a5,a4
}
 420:	6422                	ld	s0,8(sp)
 422:	0141                	addi	sp,sp,16
 424:	8082                	ret
  return 0;
 426:	4501                	li	a0,0
 428:	bfe5                	j	420 <memcmp+0x30>

000000000000042a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 42a:	1141                	addi	sp,sp,-16
 42c:	e406                	sd	ra,8(sp)
 42e:	e022                	sd	s0,0(sp)
 430:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 432:	f67ff0ef          	jal	398 <memmove>
}
 436:	60a2                	ld	ra,8(sp)
 438:	6402                	ld	s0,0(sp)
 43a:	0141                	addi	sp,sp,16
 43c:	8082                	ret

000000000000043e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 43e:	4885                	li	a7,1
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <exit>:
.global exit
exit:
 li a7, SYS_exit
 446:	4889                	li	a7,2
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <wait>:
.global wait
wait:
 li a7, SYS_wait
 44e:	488d                	li	a7,3
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 456:	4891                	li	a7,4
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <read>:
.global read
read:
 li a7, SYS_read
 45e:	4895                	li	a7,5
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <write>:
.global write
write:
 li a7, SYS_write
 466:	48c1                	li	a7,16
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <close>:
.global close
close:
 li a7, SYS_close
 46e:	48d5                	li	a7,21
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <kill>:
.global kill
kill:
 li a7, SYS_kill
 476:	4899                	li	a7,6
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <exec>:
.global exec
exec:
 li a7, SYS_exec
 47e:	489d                	li	a7,7
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <open>:
.global open
open:
 li a7, SYS_open
 486:	48bd                	li	a7,15
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 48e:	48c5                	li	a7,17
 ecall
 490:	00000073          	ecall
 ret
 494:	8082                	ret

0000000000000496 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 496:	48c9                	li	a7,18
 ecall
 498:	00000073          	ecall
 ret
 49c:	8082                	ret

000000000000049e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 49e:	48a1                	li	a7,8
 ecall
 4a0:	00000073          	ecall
 ret
 4a4:	8082                	ret

00000000000004a6 <link>:
.global link
link:
 li a7, SYS_link
 4a6:	48cd                	li	a7,19
 ecall
 4a8:	00000073          	ecall
 ret
 4ac:	8082                	ret

00000000000004ae <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4ae:	48d1                	li	a7,20
 ecall
 4b0:	00000073          	ecall
 ret
 4b4:	8082                	ret

00000000000004b6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4b6:	48a5                	li	a7,9
 ecall
 4b8:	00000073          	ecall
 ret
 4bc:	8082                	ret

00000000000004be <dup>:
.global dup
dup:
 li a7, SYS_dup
 4be:	48a9                	li	a7,10
 ecall
 4c0:	00000073          	ecall
 ret
 4c4:	8082                	ret

00000000000004c6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4c6:	48ad                	li	a7,11
 ecall
 4c8:	00000073          	ecall
 ret
 4cc:	8082                	ret

00000000000004ce <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4ce:	48b1                	li	a7,12
 ecall
 4d0:	00000073          	ecall
 ret
 4d4:	8082                	ret

00000000000004d6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4d6:	48b5                	li	a7,13
 ecall
 4d8:	00000073          	ecall
 ret
 4dc:	8082                	ret

00000000000004de <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4de:	48b9                	li	a7,14
 ecall
 4e0:	00000073          	ecall
 ret
 4e4:	8082                	ret

00000000000004e6 <hello>:
.global hello
hello:
 li a7, SYS_hello
 4e6:	48d9                	li	a7,22
 ecall
 4e8:	00000073          	ecall
 ret
 4ec:	8082                	ret

00000000000004ee <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4ee:	1101                	addi	sp,sp,-32
 4f0:	ec06                	sd	ra,24(sp)
 4f2:	e822                	sd	s0,16(sp)
 4f4:	1000                	addi	s0,sp,32
 4f6:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4fa:	4605                	li	a2,1
 4fc:	fef40593          	addi	a1,s0,-17
 500:	f67ff0ef          	jal	466 <write>
}
 504:	60e2                	ld	ra,24(sp)
 506:	6442                	ld	s0,16(sp)
 508:	6105                	addi	sp,sp,32
 50a:	8082                	ret

000000000000050c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 50c:	7139                	addi	sp,sp,-64
 50e:	fc06                	sd	ra,56(sp)
 510:	f822                	sd	s0,48(sp)
 512:	f426                	sd	s1,40(sp)
 514:	0080                	addi	s0,sp,64
 516:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 518:	c299                	beqz	a3,51e <printint+0x12>
 51a:	0805c963          	bltz	a1,5ac <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 51e:	2581                	sext.w	a1,a1
  neg = 0;
 520:	4881                	li	a7,0
 522:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 526:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 528:	2601                	sext.w	a2,a2
 52a:	00000517          	auipc	a0,0x0
 52e:	58650513          	addi	a0,a0,1414 # ab0 <digits>
 532:	883a                	mv	a6,a4
 534:	2705                	addiw	a4,a4,1
 536:	02c5f7bb          	remuw	a5,a1,a2
 53a:	1782                	slli	a5,a5,0x20
 53c:	9381                	srli	a5,a5,0x20
 53e:	97aa                	add	a5,a5,a0
 540:	0007c783          	lbu	a5,0(a5)
 544:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 548:	0005879b          	sext.w	a5,a1
 54c:	02c5d5bb          	divuw	a1,a1,a2
 550:	0685                	addi	a3,a3,1
 552:	fec7f0e3          	bgeu	a5,a2,532 <printint+0x26>
  if(neg)
 556:	00088c63          	beqz	a7,56e <printint+0x62>
    buf[i++] = '-';
 55a:	fd070793          	addi	a5,a4,-48
 55e:	00878733          	add	a4,a5,s0
 562:	02d00793          	li	a5,45
 566:	fef70823          	sb	a5,-16(a4)
 56a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 56e:	02e05a63          	blez	a4,5a2 <printint+0x96>
 572:	f04a                	sd	s2,32(sp)
 574:	ec4e                	sd	s3,24(sp)
 576:	fc040793          	addi	a5,s0,-64
 57a:	00e78933          	add	s2,a5,a4
 57e:	fff78993          	addi	s3,a5,-1
 582:	99ba                	add	s3,s3,a4
 584:	377d                	addiw	a4,a4,-1
 586:	1702                	slli	a4,a4,0x20
 588:	9301                	srli	a4,a4,0x20
 58a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 58e:	fff94583          	lbu	a1,-1(s2)
 592:	8526                	mv	a0,s1
 594:	f5bff0ef          	jal	4ee <putc>
  while(--i >= 0)
 598:	197d                	addi	s2,s2,-1
 59a:	ff391ae3          	bne	s2,s3,58e <printint+0x82>
 59e:	7902                	ld	s2,32(sp)
 5a0:	69e2                	ld	s3,24(sp)
}
 5a2:	70e2                	ld	ra,56(sp)
 5a4:	7442                	ld	s0,48(sp)
 5a6:	74a2                	ld	s1,40(sp)
 5a8:	6121                	addi	sp,sp,64
 5aa:	8082                	ret
    x = -xx;
 5ac:	40b005bb          	negw	a1,a1
    neg = 1;
 5b0:	4885                	li	a7,1
    x = -xx;
 5b2:	bf85                	j	522 <printint+0x16>

00000000000005b4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5b4:	711d                	addi	sp,sp,-96
 5b6:	ec86                	sd	ra,88(sp)
 5b8:	e8a2                	sd	s0,80(sp)
 5ba:	e0ca                	sd	s2,64(sp)
 5bc:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5be:	0005c903          	lbu	s2,0(a1)
 5c2:	26090863          	beqz	s2,832 <vprintf+0x27e>
 5c6:	e4a6                	sd	s1,72(sp)
 5c8:	fc4e                	sd	s3,56(sp)
 5ca:	f852                	sd	s4,48(sp)
 5cc:	f456                	sd	s5,40(sp)
 5ce:	f05a                	sd	s6,32(sp)
 5d0:	ec5e                	sd	s7,24(sp)
 5d2:	e862                	sd	s8,16(sp)
 5d4:	e466                	sd	s9,8(sp)
 5d6:	8b2a                	mv	s6,a0
 5d8:	8a2e                	mv	s4,a1
 5da:	8bb2                	mv	s7,a2
  state = 0;
 5dc:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 5de:	4481                	li	s1,0
 5e0:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 5e2:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 5e6:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 5ea:	06c00c93          	li	s9,108
 5ee:	a005                	j	60e <vprintf+0x5a>
        putc(fd, c0);
 5f0:	85ca                	mv	a1,s2
 5f2:	855a                	mv	a0,s6
 5f4:	efbff0ef          	jal	4ee <putc>
 5f8:	a019                	j	5fe <vprintf+0x4a>
    } else if(state == '%'){
 5fa:	03598263          	beq	s3,s5,61e <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 5fe:	2485                	addiw	s1,s1,1
 600:	8726                	mv	a4,s1
 602:	009a07b3          	add	a5,s4,s1
 606:	0007c903          	lbu	s2,0(a5)
 60a:	20090c63          	beqz	s2,822 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 60e:	0009079b          	sext.w	a5,s2
    if(state == 0){
 612:	fe0994e3          	bnez	s3,5fa <vprintf+0x46>
      if(c0 == '%'){
 616:	fd579de3          	bne	a5,s5,5f0 <vprintf+0x3c>
        state = '%';
 61a:	89be                	mv	s3,a5
 61c:	b7cd                	j	5fe <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 61e:	00ea06b3          	add	a3,s4,a4
 622:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 626:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 628:	c681                	beqz	a3,630 <vprintf+0x7c>
 62a:	9752                	add	a4,a4,s4
 62c:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 630:	03878f63          	beq	a5,s8,66e <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 634:	05978963          	beq	a5,s9,686 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 638:	07500713          	li	a4,117
 63c:	0ee78363          	beq	a5,a4,722 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 640:	07800713          	li	a4,120
 644:	12e78563          	beq	a5,a4,76e <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 648:	07000713          	li	a4,112
 64c:	14e78a63          	beq	a5,a4,7a0 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 650:	07300713          	li	a4,115
 654:	18e78a63          	beq	a5,a4,7e8 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 658:	02500713          	li	a4,37
 65c:	04e79563          	bne	a5,a4,6a6 <vprintf+0xf2>
        putc(fd, '%');
 660:	02500593          	li	a1,37
 664:	855a                	mv	a0,s6
 666:	e89ff0ef          	jal	4ee <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 66a:	4981                	li	s3,0
 66c:	bf49                	j	5fe <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 66e:	008b8913          	addi	s2,s7,8
 672:	4685                	li	a3,1
 674:	4629                	li	a2,10
 676:	000ba583          	lw	a1,0(s7)
 67a:	855a                	mv	a0,s6
 67c:	e91ff0ef          	jal	50c <printint>
 680:	8bca                	mv	s7,s2
      state = 0;
 682:	4981                	li	s3,0
 684:	bfad                	j	5fe <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 686:	06400793          	li	a5,100
 68a:	02f68963          	beq	a3,a5,6bc <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 68e:	06c00793          	li	a5,108
 692:	04f68263          	beq	a3,a5,6d6 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 696:	07500793          	li	a5,117
 69a:	0af68063          	beq	a3,a5,73a <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 69e:	07800793          	li	a5,120
 6a2:	0ef68263          	beq	a3,a5,786 <vprintf+0x1d2>
        putc(fd, '%');
 6a6:	02500593          	li	a1,37
 6aa:	855a                	mv	a0,s6
 6ac:	e43ff0ef          	jal	4ee <putc>
        putc(fd, c0);
 6b0:	85ca                	mv	a1,s2
 6b2:	855a                	mv	a0,s6
 6b4:	e3bff0ef          	jal	4ee <putc>
      state = 0;
 6b8:	4981                	li	s3,0
 6ba:	b791                	j	5fe <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6bc:	008b8913          	addi	s2,s7,8
 6c0:	4685                	li	a3,1
 6c2:	4629                	li	a2,10
 6c4:	000ba583          	lw	a1,0(s7)
 6c8:	855a                	mv	a0,s6
 6ca:	e43ff0ef          	jal	50c <printint>
        i += 1;
 6ce:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6d0:	8bca                	mv	s7,s2
      state = 0;
 6d2:	4981                	li	s3,0
        i += 1;
 6d4:	b72d                	j	5fe <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6d6:	06400793          	li	a5,100
 6da:	02f60763          	beq	a2,a5,708 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 6de:	07500793          	li	a5,117
 6e2:	06f60963          	beq	a2,a5,754 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 6e6:	07800793          	li	a5,120
 6ea:	faf61ee3          	bne	a2,a5,6a6 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6ee:	008b8913          	addi	s2,s7,8
 6f2:	4681                	li	a3,0
 6f4:	4641                	li	a2,16
 6f6:	000ba583          	lw	a1,0(s7)
 6fa:	855a                	mv	a0,s6
 6fc:	e11ff0ef          	jal	50c <printint>
        i += 2;
 700:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 702:	8bca                	mv	s7,s2
      state = 0;
 704:	4981                	li	s3,0
        i += 2;
 706:	bde5                	j	5fe <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 708:	008b8913          	addi	s2,s7,8
 70c:	4685                	li	a3,1
 70e:	4629                	li	a2,10
 710:	000ba583          	lw	a1,0(s7)
 714:	855a                	mv	a0,s6
 716:	df7ff0ef          	jal	50c <printint>
        i += 2;
 71a:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 71c:	8bca                	mv	s7,s2
      state = 0;
 71e:	4981                	li	s3,0
        i += 2;
 720:	bdf9                	j	5fe <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 722:	008b8913          	addi	s2,s7,8
 726:	4681                	li	a3,0
 728:	4629                	li	a2,10
 72a:	000ba583          	lw	a1,0(s7)
 72e:	855a                	mv	a0,s6
 730:	dddff0ef          	jal	50c <printint>
 734:	8bca                	mv	s7,s2
      state = 0;
 736:	4981                	li	s3,0
 738:	b5d9                	j	5fe <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 73a:	008b8913          	addi	s2,s7,8
 73e:	4681                	li	a3,0
 740:	4629                	li	a2,10
 742:	000ba583          	lw	a1,0(s7)
 746:	855a                	mv	a0,s6
 748:	dc5ff0ef          	jal	50c <printint>
        i += 1;
 74c:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 74e:	8bca                	mv	s7,s2
      state = 0;
 750:	4981                	li	s3,0
        i += 1;
 752:	b575                	j	5fe <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 754:	008b8913          	addi	s2,s7,8
 758:	4681                	li	a3,0
 75a:	4629                	li	a2,10
 75c:	000ba583          	lw	a1,0(s7)
 760:	855a                	mv	a0,s6
 762:	dabff0ef          	jal	50c <printint>
        i += 2;
 766:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 768:	8bca                	mv	s7,s2
      state = 0;
 76a:	4981                	li	s3,0
        i += 2;
 76c:	bd49                	j	5fe <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 76e:	008b8913          	addi	s2,s7,8
 772:	4681                	li	a3,0
 774:	4641                	li	a2,16
 776:	000ba583          	lw	a1,0(s7)
 77a:	855a                	mv	a0,s6
 77c:	d91ff0ef          	jal	50c <printint>
 780:	8bca                	mv	s7,s2
      state = 0;
 782:	4981                	li	s3,0
 784:	bdad                	j	5fe <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 786:	008b8913          	addi	s2,s7,8
 78a:	4681                	li	a3,0
 78c:	4641                	li	a2,16
 78e:	000ba583          	lw	a1,0(s7)
 792:	855a                	mv	a0,s6
 794:	d79ff0ef          	jal	50c <printint>
        i += 1;
 798:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 79a:	8bca                	mv	s7,s2
      state = 0;
 79c:	4981                	li	s3,0
        i += 1;
 79e:	b585                	j	5fe <vprintf+0x4a>
 7a0:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 7a2:	008b8d13          	addi	s10,s7,8
 7a6:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7aa:	03000593          	li	a1,48
 7ae:	855a                	mv	a0,s6
 7b0:	d3fff0ef          	jal	4ee <putc>
  putc(fd, 'x');
 7b4:	07800593          	li	a1,120
 7b8:	855a                	mv	a0,s6
 7ba:	d35ff0ef          	jal	4ee <putc>
 7be:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7c0:	00000b97          	auipc	s7,0x0
 7c4:	2f0b8b93          	addi	s7,s7,752 # ab0 <digits>
 7c8:	03c9d793          	srli	a5,s3,0x3c
 7cc:	97de                	add	a5,a5,s7
 7ce:	0007c583          	lbu	a1,0(a5)
 7d2:	855a                	mv	a0,s6
 7d4:	d1bff0ef          	jal	4ee <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7d8:	0992                	slli	s3,s3,0x4
 7da:	397d                	addiw	s2,s2,-1
 7dc:	fe0916e3          	bnez	s2,7c8 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 7e0:	8bea                	mv	s7,s10
      state = 0;
 7e2:	4981                	li	s3,0
 7e4:	6d02                	ld	s10,0(sp)
 7e6:	bd21                	j	5fe <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 7e8:	008b8993          	addi	s3,s7,8
 7ec:	000bb903          	ld	s2,0(s7)
 7f0:	00090f63          	beqz	s2,80e <vprintf+0x25a>
        for(; *s; s++)
 7f4:	00094583          	lbu	a1,0(s2)
 7f8:	c195                	beqz	a1,81c <vprintf+0x268>
          putc(fd, *s);
 7fa:	855a                	mv	a0,s6
 7fc:	cf3ff0ef          	jal	4ee <putc>
        for(; *s; s++)
 800:	0905                	addi	s2,s2,1
 802:	00094583          	lbu	a1,0(s2)
 806:	f9f5                	bnez	a1,7fa <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 808:	8bce                	mv	s7,s3
      state = 0;
 80a:	4981                	li	s3,0
 80c:	bbcd                	j	5fe <vprintf+0x4a>
          s = "(null)";
 80e:	00000917          	auipc	s2,0x0
 812:	29a90913          	addi	s2,s2,666 # aa8 <malloc+0x18e>
        for(; *s; s++)
 816:	02800593          	li	a1,40
 81a:	b7c5                	j	7fa <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 81c:	8bce                	mv	s7,s3
      state = 0;
 81e:	4981                	li	s3,0
 820:	bbf9                	j	5fe <vprintf+0x4a>
 822:	64a6                	ld	s1,72(sp)
 824:	79e2                	ld	s3,56(sp)
 826:	7a42                	ld	s4,48(sp)
 828:	7aa2                	ld	s5,40(sp)
 82a:	7b02                	ld	s6,32(sp)
 82c:	6be2                	ld	s7,24(sp)
 82e:	6c42                	ld	s8,16(sp)
 830:	6ca2                	ld	s9,8(sp)
    }
  }
}
 832:	60e6                	ld	ra,88(sp)
 834:	6446                	ld	s0,80(sp)
 836:	6906                	ld	s2,64(sp)
 838:	6125                	addi	sp,sp,96
 83a:	8082                	ret

000000000000083c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 83c:	715d                	addi	sp,sp,-80
 83e:	ec06                	sd	ra,24(sp)
 840:	e822                	sd	s0,16(sp)
 842:	1000                	addi	s0,sp,32
 844:	e010                	sd	a2,0(s0)
 846:	e414                	sd	a3,8(s0)
 848:	e818                	sd	a4,16(s0)
 84a:	ec1c                	sd	a5,24(s0)
 84c:	03043023          	sd	a6,32(s0)
 850:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 854:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 858:	8622                	mv	a2,s0
 85a:	d5bff0ef          	jal	5b4 <vprintf>
}
 85e:	60e2                	ld	ra,24(sp)
 860:	6442                	ld	s0,16(sp)
 862:	6161                	addi	sp,sp,80
 864:	8082                	ret

0000000000000866 <printf>:

void
printf(const char *fmt, ...)
{
 866:	711d                	addi	sp,sp,-96
 868:	ec06                	sd	ra,24(sp)
 86a:	e822                	sd	s0,16(sp)
 86c:	1000                	addi	s0,sp,32
 86e:	e40c                	sd	a1,8(s0)
 870:	e810                	sd	a2,16(s0)
 872:	ec14                	sd	a3,24(s0)
 874:	f018                	sd	a4,32(s0)
 876:	f41c                	sd	a5,40(s0)
 878:	03043823          	sd	a6,48(s0)
 87c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 880:	00840613          	addi	a2,s0,8
 884:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 888:	85aa                	mv	a1,a0
 88a:	4505                	li	a0,1
 88c:	d29ff0ef          	jal	5b4 <vprintf>
}
 890:	60e2                	ld	ra,24(sp)
 892:	6442                	ld	s0,16(sp)
 894:	6125                	addi	sp,sp,96
 896:	8082                	ret

0000000000000898 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 898:	1141                	addi	sp,sp,-16
 89a:	e422                	sd	s0,8(sp)
 89c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 89e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a2:	00000797          	auipc	a5,0x0
 8a6:	75e7b783          	ld	a5,1886(a5) # 1000 <freep>
 8aa:	a02d                	j	8d4 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8ac:	4618                	lw	a4,8(a2)
 8ae:	9f2d                	addw	a4,a4,a1
 8b0:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8b4:	6398                	ld	a4,0(a5)
 8b6:	6310                	ld	a2,0(a4)
 8b8:	a83d                	j	8f6 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8ba:	ff852703          	lw	a4,-8(a0)
 8be:	9f31                	addw	a4,a4,a2
 8c0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8c2:	ff053683          	ld	a3,-16(a0)
 8c6:	a091                	j	90a <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8c8:	6398                	ld	a4,0(a5)
 8ca:	00e7e463          	bltu	a5,a4,8d2 <free+0x3a>
 8ce:	00e6ea63          	bltu	a3,a4,8e2 <free+0x4a>
{
 8d2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d4:	fed7fae3          	bgeu	a5,a3,8c8 <free+0x30>
 8d8:	6398                	ld	a4,0(a5)
 8da:	00e6e463          	bltu	a3,a4,8e2 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8de:	fee7eae3          	bltu	a5,a4,8d2 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 8e2:	ff852583          	lw	a1,-8(a0)
 8e6:	6390                	ld	a2,0(a5)
 8e8:	02059813          	slli	a6,a1,0x20
 8ec:	01c85713          	srli	a4,a6,0x1c
 8f0:	9736                	add	a4,a4,a3
 8f2:	fae60de3          	beq	a2,a4,8ac <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 8f6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8fa:	4790                	lw	a2,8(a5)
 8fc:	02061593          	slli	a1,a2,0x20
 900:	01c5d713          	srli	a4,a1,0x1c
 904:	973e                	add	a4,a4,a5
 906:	fae68ae3          	beq	a3,a4,8ba <free+0x22>
    p->s.ptr = bp->s.ptr;
 90a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 90c:	00000717          	auipc	a4,0x0
 910:	6ef73a23          	sd	a5,1780(a4) # 1000 <freep>
}
 914:	6422                	ld	s0,8(sp)
 916:	0141                	addi	sp,sp,16
 918:	8082                	ret

000000000000091a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 91a:	7139                	addi	sp,sp,-64
 91c:	fc06                	sd	ra,56(sp)
 91e:	f822                	sd	s0,48(sp)
 920:	f426                	sd	s1,40(sp)
 922:	ec4e                	sd	s3,24(sp)
 924:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 926:	02051493          	slli	s1,a0,0x20
 92a:	9081                	srli	s1,s1,0x20
 92c:	04bd                	addi	s1,s1,15
 92e:	8091                	srli	s1,s1,0x4
 930:	0014899b          	addiw	s3,s1,1
 934:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 936:	00000517          	auipc	a0,0x0
 93a:	6ca53503          	ld	a0,1738(a0) # 1000 <freep>
 93e:	c915                	beqz	a0,972 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 940:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 942:	4798                	lw	a4,8(a5)
 944:	08977a63          	bgeu	a4,s1,9d8 <malloc+0xbe>
 948:	f04a                	sd	s2,32(sp)
 94a:	e852                	sd	s4,16(sp)
 94c:	e456                	sd	s5,8(sp)
 94e:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 950:	8a4e                	mv	s4,s3
 952:	0009871b          	sext.w	a4,s3
 956:	6685                	lui	a3,0x1
 958:	00d77363          	bgeu	a4,a3,95e <malloc+0x44>
 95c:	6a05                	lui	s4,0x1
 95e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 962:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 966:	00000917          	auipc	s2,0x0
 96a:	69a90913          	addi	s2,s2,1690 # 1000 <freep>
  if(p == (char*)-1)
 96e:	5afd                	li	s5,-1
 970:	a081                	j	9b0 <malloc+0x96>
 972:	f04a                	sd	s2,32(sp)
 974:	e852                	sd	s4,16(sp)
 976:	e456                	sd	s5,8(sp)
 978:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 97a:	00000797          	auipc	a5,0x0
 97e:	69678793          	addi	a5,a5,1686 # 1010 <base>
 982:	00000717          	auipc	a4,0x0
 986:	66f73f23          	sd	a5,1662(a4) # 1000 <freep>
 98a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 98c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 990:	b7c1                	j	950 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 992:	6398                	ld	a4,0(a5)
 994:	e118                	sd	a4,0(a0)
 996:	a8a9                	j	9f0 <malloc+0xd6>
  hp->s.size = nu;
 998:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 99c:	0541                	addi	a0,a0,16
 99e:	efbff0ef          	jal	898 <free>
  return freep;
 9a2:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9a6:	c12d                	beqz	a0,a08 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9a8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9aa:	4798                	lw	a4,8(a5)
 9ac:	02977263          	bgeu	a4,s1,9d0 <malloc+0xb6>
    if(p == freep)
 9b0:	00093703          	ld	a4,0(s2)
 9b4:	853e                	mv	a0,a5
 9b6:	fef719e3          	bne	a4,a5,9a8 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 9ba:	8552                	mv	a0,s4
 9bc:	b13ff0ef          	jal	4ce <sbrk>
  if(p == (char*)-1)
 9c0:	fd551ce3          	bne	a0,s5,998 <malloc+0x7e>
        return 0;
 9c4:	4501                	li	a0,0
 9c6:	7902                	ld	s2,32(sp)
 9c8:	6a42                	ld	s4,16(sp)
 9ca:	6aa2                	ld	s5,8(sp)
 9cc:	6b02                	ld	s6,0(sp)
 9ce:	a03d                	j	9fc <malloc+0xe2>
 9d0:	7902                	ld	s2,32(sp)
 9d2:	6a42                	ld	s4,16(sp)
 9d4:	6aa2                	ld	s5,8(sp)
 9d6:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9d8:	fae48de3          	beq	s1,a4,992 <malloc+0x78>
        p->s.size -= nunits;
 9dc:	4137073b          	subw	a4,a4,s3
 9e0:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9e2:	02071693          	slli	a3,a4,0x20
 9e6:	01c6d713          	srli	a4,a3,0x1c
 9ea:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9ec:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9f0:	00000717          	auipc	a4,0x0
 9f4:	60a73823          	sd	a0,1552(a4) # 1000 <freep>
      return (void*)(p + 1);
 9f8:	01078513          	addi	a0,a5,16
  }
}
 9fc:	70e2                	ld	ra,56(sp)
 9fe:	7442                	ld	s0,48(sp)
 a00:	74a2                	ld	s1,40(sp)
 a02:	69e2                	ld	s3,24(sp)
 a04:	6121                	addi	sp,sp,64
 a06:	8082                	ret
 a08:	7902                	ld	s2,32(sp)
 a0a:	6a42                	ld	s4,16(sp)
 a0c:	6aa2                	ld	s5,8(sp)
 a0e:	6b02                	ld	s6,0(sp)
 a10:	b7f5                	j	9fc <malloc+0xe2>
