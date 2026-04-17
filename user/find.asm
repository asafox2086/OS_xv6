
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
  66:	9ae58593          	addi	a1,a1,-1618 # a10 <malloc+0xfe>
  6a:	4509                	li	a0,2
  6c:	7c8000ef          	jal	834 <fprintf>
        return;
  70:	bfe9                	j	4a <find+0x4a>
        fprintf(2, "find: cannot stat %s\n", path);
  72:	864a                	mv	a2,s2
  74:	00001597          	auipc	a1,0x1
  78:	9bc58593          	addi	a1,a1,-1604 # a30 <malloc+0x11e>
  7c:	4509                	li	a0,2
  7e:	7b6000ef          	jal	834 <fprintf>
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
  d8:	98ca8a93          	addi	s5,s5,-1652 # a60 <malloc+0x14e>
  dc:	00001b17          	auipc	s6,0x1
  e0:	98cb0b13          	addi	s6,s6,-1652 # a68 <malloc+0x156>
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
 150:	8fc50513          	addi	a0,a0,-1796 # a48 <malloc+0x136>
 154:	70a000ef          	jal	85e <printf>
        close(fd);
 158:	8526                	mv	a0,s1
 15a:	314000ef          	jal	46e <close>
        return;
 15e:	25813483          	ld	s1,600(sp)
 162:	b5e5                	j	4a <find+0x4a>
            printf("find: cannot stat %s\n", buf);
 164:	dc040593          	addi	a1,s0,-576
 168:	00001517          	auipc	a0,0x1
 16c:	8c850513          	addi	a0,a0,-1848 # a30 <malloc+0x11e>
 170:	6ee000ef          	jal	85e <printf>
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
 188:	8ec50513          	addi	a0,a0,-1812 # a70 <malloc+0x15e>
 18c:	6d2000ef          	jal	85e <printf>
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
 1bc:	8c058593          	addi	a1,a1,-1856 # a78 <malloc+0x166>
 1c0:	4509                	li	a0,2
 1c2:	672000ef          	jal	834 <fprintf>
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

00000000000004e6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4e6:	1101                	addi	sp,sp,-32
 4e8:	ec06                	sd	ra,24(sp)
 4ea:	e822                	sd	s0,16(sp)
 4ec:	1000                	addi	s0,sp,32
 4ee:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4f2:	4605                	li	a2,1
 4f4:	fef40593          	addi	a1,s0,-17
 4f8:	f6fff0ef          	jal	466 <write>
}
 4fc:	60e2                	ld	ra,24(sp)
 4fe:	6442                	ld	s0,16(sp)
 500:	6105                	addi	sp,sp,32
 502:	8082                	ret

0000000000000504 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 504:	7139                	addi	sp,sp,-64
 506:	fc06                	sd	ra,56(sp)
 508:	f822                	sd	s0,48(sp)
 50a:	f426                	sd	s1,40(sp)
 50c:	0080                	addi	s0,sp,64
 50e:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 510:	c299                	beqz	a3,516 <printint+0x12>
 512:	0805c963          	bltz	a1,5a4 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 516:	2581                	sext.w	a1,a1
  neg = 0;
 518:	4881                	li	a7,0
 51a:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 51e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 520:	2601                	sext.w	a2,a2
 522:	00000517          	auipc	a0,0x0
 526:	57e50513          	addi	a0,a0,1406 # aa0 <digits>
 52a:	883a                	mv	a6,a4
 52c:	2705                	addiw	a4,a4,1
 52e:	02c5f7bb          	remuw	a5,a1,a2
 532:	1782                	slli	a5,a5,0x20
 534:	9381                	srli	a5,a5,0x20
 536:	97aa                	add	a5,a5,a0
 538:	0007c783          	lbu	a5,0(a5)
 53c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 540:	0005879b          	sext.w	a5,a1
 544:	02c5d5bb          	divuw	a1,a1,a2
 548:	0685                	addi	a3,a3,1
 54a:	fec7f0e3          	bgeu	a5,a2,52a <printint+0x26>
  if(neg)
 54e:	00088c63          	beqz	a7,566 <printint+0x62>
    buf[i++] = '-';
 552:	fd070793          	addi	a5,a4,-48
 556:	00878733          	add	a4,a5,s0
 55a:	02d00793          	li	a5,45
 55e:	fef70823          	sb	a5,-16(a4)
 562:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 566:	02e05a63          	blez	a4,59a <printint+0x96>
 56a:	f04a                	sd	s2,32(sp)
 56c:	ec4e                	sd	s3,24(sp)
 56e:	fc040793          	addi	a5,s0,-64
 572:	00e78933          	add	s2,a5,a4
 576:	fff78993          	addi	s3,a5,-1
 57a:	99ba                	add	s3,s3,a4
 57c:	377d                	addiw	a4,a4,-1
 57e:	1702                	slli	a4,a4,0x20
 580:	9301                	srli	a4,a4,0x20
 582:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 586:	fff94583          	lbu	a1,-1(s2)
 58a:	8526                	mv	a0,s1
 58c:	f5bff0ef          	jal	4e6 <putc>
  while(--i >= 0)
 590:	197d                	addi	s2,s2,-1
 592:	ff391ae3          	bne	s2,s3,586 <printint+0x82>
 596:	7902                	ld	s2,32(sp)
 598:	69e2                	ld	s3,24(sp)
}
 59a:	70e2                	ld	ra,56(sp)
 59c:	7442                	ld	s0,48(sp)
 59e:	74a2                	ld	s1,40(sp)
 5a0:	6121                	addi	sp,sp,64
 5a2:	8082                	ret
    x = -xx;
 5a4:	40b005bb          	negw	a1,a1
    neg = 1;
 5a8:	4885                	li	a7,1
    x = -xx;
 5aa:	bf85                	j	51a <printint+0x16>

00000000000005ac <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5ac:	711d                	addi	sp,sp,-96
 5ae:	ec86                	sd	ra,88(sp)
 5b0:	e8a2                	sd	s0,80(sp)
 5b2:	e0ca                	sd	s2,64(sp)
 5b4:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5b6:	0005c903          	lbu	s2,0(a1)
 5ba:	26090863          	beqz	s2,82a <vprintf+0x27e>
 5be:	e4a6                	sd	s1,72(sp)
 5c0:	fc4e                	sd	s3,56(sp)
 5c2:	f852                	sd	s4,48(sp)
 5c4:	f456                	sd	s5,40(sp)
 5c6:	f05a                	sd	s6,32(sp)
 5c8:	ec5e                	sd	s7,24(sp)
 5ca:	e862                	sd	s8,16(sp)
 5cc:	e466                	sd	s9,8(sp)
 5ce:	8b2a                	mv	s6,a0
 5d0:	8a2e                	mv	s4,a1
 5d2:	8bb2                	mv	s7,a2
  state = 0;
 5d4:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 5d6:	4481                	li	s1,0
 5d8:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 5da:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 5de:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 5e2:	06c00c93          	li	s9,108
 5e6:	a005                	j	606 <vprintf+0x5a>
        putc(fd, c0);
 5e8:	85ca                	mv	a1,s2
 5ea:	855a                	mv	a0,s6
 5ec:	efbff0ef          	jal	4e6 <putc>
 5f0:	a019                	j	5f6 <vprintf+0x4a>
    } else if(state == '%'){
 5f2:	03598263          	beq	s3,s5,616 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 5f6:	2485                	addiw	s1,s1,1
 5f8:	8726                	mv	a4,s1
 5fa:	009a07b3          	add	a5,s4,s1
 5fe:	0007c903          	lbu	s2,0(a5)
 602:	20090c63          	beqz	s2,81a <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 606:	0009079b          	sext.w	a5,s2
    if(state == 0){
 60a:	fe0994e3          	bnez	s3,5f2 <vprintf+0x46>
      if(c0 == '%'){
 60e:	fd579de3          	bne	a5,s5,5e8 <vprintf+0x3c>
        state = '%';
 612:	89be                	mv	s3,a5
 614:	b7cd                	j	5f6 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 616:	00ea06b3          	add	a3,s4,a4
 61a:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 61e:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 620:	c681                	beqz	a3,628 <vprintf+0x7c>
 622:	9752                	add	a4,a4,s4
 624:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 628:	03878f63          	beq	a5,s8,666 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 62c:	05978963          	beq	a5,s9,67e <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 630:	07500713          	li	a4,117
 634:	0ee78363          	beq	a5,a4,71a <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 638:	07800713          	li	a4,120
 63c:	12e78563          	beq	a5,a4,766 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 640:	07000713          	li	a4,112
 644:	14e78a63          	beq	a5,a4,798 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 648:	07300713          	li	a4,115
 64c:	18e78a63          	beq	a5,a4,7e0 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 650:	02500713          	li	a4,37
 654:	04e79563          	bne	a5,a4,69e <vprintf+0xf2>
        putc(fd, '%');
 658:	02500593          	li	a1,37
 65c:	855a                	mv	a0,s6
 65e:	e89ff0ef          	jal	4e6 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 662:	4981                	li	s3,0
 664:	bf49                	j	5f6 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 666:	008b8913          	addi	s2,s7,8
 66a:	4685                	li	a3,1
 66c:	4629                	li	a2,10
 66e:	000ba583          	lw	a1,0(s7)
 672:	855a                	mv	a0,s6
 674:	e91ff0ef          	jal	504 <printint>
 678:	8bca                	mv	s7,s2
      state = 0;
 67a:	4981                	li	s3,0
 67c:	bfad                	j	5f6 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 67e:	06400793          	li	a5,100
 682:	02f68963          	beq	a3,a5,6b4 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 686:	06c00793          	li	a5,108
 68a:	04f68263          	beq	a3,a5,6ce <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 68e:	07500793          	li	a5,117
 692:	0af68063          	beq	a3,a5,732 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 696:	07800793          	li	a5,120
 69a:	0ef68263          	beq	a3,a5,77e <vprintf+0x1d2>
        putc(fd, '%');
 69e:	02500593          	li	a1,37
 6a2:	855a                	mv	a0,s6
 6a4:	e43ff0ef          	jal	4e6 <putc>
        putc(fd, c0);
 6a8:	85ca                	mv	a1,s2
 6aa:	855a                	mv	a0,s6
 6ac:	e3bff0ef          	jal	4e6 <putc>
      state = 0;
 6b0:	4981                	li	s3,0
 6b2:	b791                	j	5f6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6b4:	008b8913          	addi	s2,s7,8
 6b8:	4685                	li	a3,1
 6ba:	4629                	li	a2,10
 6bc:	000ba583          	lw	a1,0(s7)
 6c0:	855a                	mv	a0,s6
 6c2:	e43ff0ef          	jal	504 <printint>
        i += 1;
 6c6:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6c8:	8bca                	mv	s7,s2
      state = 0;
 6ca:	4981                	li	s3,0
        i += 1;
 6cc:	b72d                	j	5f6 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6ce:	06400793          	li	a5,100
 6d2:	02f60763          	beq	a2,a5,700 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 6d6:	07500793          	li	a5,117
 6da:	06f60963          	beq	a2,a5,74c <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 6de:	07800793          	li	a5,120
 6e2:	faf61ee3          	bne	a2,a5,69e <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6e6:	008b8913          	addi	s2,s7,8
 6ea:	4681                	li	a3,0
 6ec:	4641                	li	a2,16
 6ee:	000ba583          	lw	a1,0(s7)
 6f2:	855a                	mv	a0,s6
 6f4:	e11ff0ef          	jal	504 <printint>
        i += 2;
 6f8:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 6fa:	8bca                	mv	s7,s2
      state = 0;
 6fc:	4981                	li	s3,0
        i += 2;
 6fe:	bde5                	j	5f6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 700:	008b8913          	addi	s2,s7,8
 704:	4685                	li	a3,1
 706:	4629                	li	a2,10
 708:	000ba583          	lw	a1,0(s7)
 70c:	855a                	mv	a0,s6
 70e:	df7ff0ef          	jal	504 <printint>
        i += 2;
 712:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 714:	8bca                	mv	s7,s2
      state = 0;
 716:	4981                	li	s3,0
        i += 2;
 718:	bdf9                	j	5f6 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 71a:	008b8913          	addi	s2,s7,8
 71e:	4681                	li	a3,0
 720:	4629                	li	a2,10
 722:	000ba583          	lw	a1,0(s7)
 726:	855a                	mv	a0,s6
 728:	dddff0ef          	jal	504 <printint>
 72c:	8bca                	mv	s7,s2
      state = 0;
 72e:	4981                	li	s3,0
 730:	b5d9                	j	5f6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 732:	008b8913          	addi	s2,s7,8
 736:	4681                	li	a3,0
 738:	4629                	li	a2,10
 73a:	000ba583          	lw	a1,0(s7)
 73e:	855a                	mv	a0,s6
 740:	dc5ff0ef          	jal	504 <printint>
        i += 1;
 744:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 746:	8bca                	mv	s7,s2
      state = 0;
 748:	4981                	li	s3,0
        i += 1;
 74a:	b575                	j	5f6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 74c:	008b8913          	addi	s2,s7,8
 750:	4681                	li	a3,0
 752:	4629                	li	a2,10
 754:	000ba583          	lw	a1,0(s7)
 758:	855a                	mv	a0,s6
 75a:	dabff0ef          	jal	504 <printint>
        i += 2;
 75e:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 760:	8bca                	mv	s7,s2
      state = 0;
 762:	4981                	li	s3,0
        i += 2;
 764:	bd49                	j	5f6 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 766:	008b8913          	addi	s2,s7,8
 76a:	4681                	li	a3,0
 76c:	4641                	li	a2,16
 76e:	000ba583          	lw	a1,0(s7)
 772:	855a                	mv	a0,s6
 774:	d91ff0ef          	jal	504 <printint>
 778:	8bca                	mv	s7,s2
      state = 0;
 77a:	4981                	li	s3,0
 77c:	bdad                	j	5f6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 77e:	008b8913          	addi	s2,s7,8
 782:	4681                	li	a3,0
 784:	4641                	li	a2,16
 786:	000ba583          	lw	a1,0(s7)
 78a:	855a                	mv	a0,s6
 78c:	d79ff0ef          	jal	504 <printint>
        i += 1;
 790:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 792:	8bca                	mv	s7,s2
      state = 0;
 794:	4981                	li	s3,0
        i += 1;
 796:	b585                	j	5f6 <vprintf+0x4a>
 798:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 79a:	008b8d13          	addi	s10,s7,8
 79e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7a2:	03000593          	li	a1,48
 7a6:	855a                	mv	a0,s6
 7a8:	d3fff0ef          	jal	4e6 <putc>
  putc(fd, 'x');
 7ac:	07800593          	li	a1,120
 7b0:	855a                	mv	a0,s6
 7b2:	d35ff0ef          	jal	4e6 <putc>
 7b6:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7b8:	00000b97          	auipc	s7,0x0
 7bc:	2e8b8b93          	addi	s7,s7,744 # aa0 <digits>
 7c0:	03c9d793          	srli	a5,s3,0x3c
 7c4:	97de                	add	a5,a5,s7
 7c6:	0007c583          	lbu	a1,0(a5)
 7ca:	855a                	mv	a0,s6
 7cc:	d1bff0ef          	jal	4e6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7d0:	0992                	slli	s3,s3,0x4
 7d2:	397d                	addiw	s2,s2,-1
 7d4:	fe0916e3          	bnez	s2,7c0 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 7d8:	8bea                	mv	s7,s10
      state = 0;
 7da:	4981                	li	s3,0
 7dc:	6d02                	ld	s10,0(sp)
 7de:	bd21                	j	5f6 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 7e0:	008b8993          	addi	s3,s7,8
 7e4:	000bb903          	ld	s2,0(s7)
 7e8:	00090f63          	beqz	s2,806 <vprintf+0x25a>
        for(; *s; s++)
 7ec:	00094583          	lbu	a1,0(s2)
 7f0:	c195                	beqz	a1,814 <vprintf+0x268>
          putc(fd, *s);
 7f2:	855a                	mv	a0,s6
 7f4:	cf3ff0ef          	jal	4e6 <putc>
        for(; *s; s++)
 7f8:	0905                	addi	s2,s2,1
 7fa:	00094583          	lbu	a1,0(s2)
 7fe:	f9f5                	bnez	a1,7f2 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 800:	8bce                	mv	s7,s3
      state = 0;
 802:	4981                	li	s3,0
 804:	bbcd                	j	5f6 <vprintf+0x4a>
          s = "(null)";
 806:	00000917          	auipc	s2,0x0
 80a:	29290913          	addi	s2,s2,658 # a98 <malloc+0x186>
        for(; *s; s++)
 80e:	02800593          	li	a1,40
 812:	b7c5                	j	7f2 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 814:	8bce                	mv	s7,s3
      state = 0;
 816:	4981                	li	s3,0
 818:	bbf9                	j	5f6 <vprintf+0x4a>
 81a:	64a6                	ld	s1,72(sp)
 81c:	79e2                	ld	s3,56(sp)
 81e:	7a42                	ld	s4,48(sp)
 820:	7aa2                	ld	s5,40(sp)
 822:	7b02                	ld	s6,32(sp)
 824:	6be2                	ld	s7,24(sp)
 826:	6c42                	ld	s8,16(sp)
 828:	6ca2                	ld	s9,8(sp)
    }
  }
}
 82a:	60e6                	ld	ra,88(sp)
 82c:	6446                	ld	s0,80(sp)
 82e:	6906                	ld	s2,64(sp)
 830:	6125                	addi	sp,sp,96
 832:	8082                	ret

0000000000000834 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 834:	715d                	addi	sp,sp,-80
 836:	ec06                	sd	ra,24(sp)
 838:	e822                	sd	s0,16(sp)
 83a:	1000                	addi	s0,sp,32
 83c:	e010                	sd	a2,0(s0)
 83e:	e414                	sd	a3,8(s0)
 840:	e818                	sd	a4,16(s0)
 842:	ec1c                	sd	a5,24(s0)
 844:	03043023          	sd	a6,32(s0)
 848:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 84c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 850:	8622                	mv	a2,s0
 852:	d5bff0ef          	jal	5ac <vprintf>
}
 856:	60e2                	ld	ra,24(sp)
 858:	6442                	ld	s0,16(sp)
 85a:	6161                	addi	sp,sp,80
 85c:	8082                	ret

000000000000085e <printf>:

void
printf(const char *fmt, ...)
{
 85e:	711d                	addi	sp,sp,-96
 860:	ec06                	sd	ra,24(sp)
 862:	e822                	sd	s0,16(sp)
 864:	1000                	addi	s0,sp,32
 866:	e40c                	sd	a1,8(s0)
 868:	e810                	sd	a2,16(s0)
 86a:	ec14                	sd	a3,24(s0)
 86c:	f018                	sd	a4,32(s0)
 86e:	f41c                	sd	a5,40(s0)
 870:	03043823          	sd	a6,48(s0)
 874:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 878:	00840613          	addi	a2,s0,8
 87c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 880:	85aa                	mv	a1,a0
 882:	4505                	li	a0,1
 884:	d29ff0ef          	jal	5ac <vprintf>
}
 888:	60e2                	ld	ra,24(sp)
 88a:	6442                	ld	s0,16(sp)
 88c:	6125                	addi	sp,sp,96
 88e:	8082                	ret

0000000000000890 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 890:	1141                	addi	sp,sp,-16
 892:	e422                	sd	s0,8(sp)
 894:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 896:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 89a:	00000797          	auipc	a5,0x0
 89e:	7667b783          	ld	a5,1894(a5) # 1000 <freep>
 8a2:	a02d                	j	8cc <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8a4:	4618                	lw	a4,8(a2)
 8a6:	9f2d                	addw	a4,a4,a1
 8a8:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8ac:	6398                	ld	a4,0(a5)
 8ae:	6310                	ld	a2,0(a4)
 8b0:	a83d                	j	8ee <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8b2:	ff852703          	lw	a4,-8(a0)
 8b6:	9f31                	addw	a4,a4,a2
 8b8:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8ba:	ff053683          	ld	a3,-16(a0)
 8be:	a091                	j	902 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8c0:	6398                	ld	a4,0(a5)
 8c2:	00e7e463          	bltu	a5,a4,8ca <free+0x3a>
 8c6:	00e6ea63          	bltu	a3,a4,8da <free+0x4a>
{
 8ca:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8cc:	fed7fae3          	bgeu	a5,a3,8c0 <free+0x30>
 8d0:	6398                	ld	a4,0(a5)
 8d2:	00e6e463          	bltu	a3,a4,8da <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8d6:	fee7eae3          	bltu	a5,a4,8ca <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 8da:	ff852583          	lw	a1,-8(a0)
 8de:	6390                	ld	a2,0(a5)
 8e0:	02059813          	slli	a6,a1,0x20
 8e4:	01c85713          	srli	a4,a6,0x1c
 8e8:	9736                	add	a4,a4,a3
 8ea:	fae60de3          	beq	a2,a4,8a4 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 8ee:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8f2:	4790                	lw	a2,8(a5)
 8f4:	02061593          	slli	a1,a2,0x20
 8f8:	01c5d713          	srli	a4,a1,0x1c
 8fc:	973e                	add	a4,a4,a5
 8fe:	fae68ae3          	beq	a3,a4,8b2 <free+0x22>
    p->s.ptr = bp->s.ptr;
 902:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 904:	00000717          	auipc	a4,0x0
 908:	6ef73e23          	sd	a5,1788(a4) # 1000 <freep>
}
 90c:	6422                	ld	s0,8(sp)
 90e:	0141                	addi	sp,sp,16
 910:	8082                	ret

0000000000000912 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 912:	7139                	addi	sp,sp,-64
 914:	fc06                	sd	ra,56(sp)
 916:	f822                	sd	s0,48(sp)
 918:	f426                	sd	s1,40(sp)
 91a:	ec4e                	sd	s3,24(sp)
 91c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 91e:	02051493          	slli	s1,a0,0x20
 922:	9081                	srli	s1,s1,0x20
 924:	04bd                	addi	s1,s1,15
 926:	8091                	srli	s1,s1,0x4
 928:	0014899b          	addiw	s3,s1,1
 92c:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 92e:	00000517          	auipc	a0,0x0
 932:	6d253503          	ld	a0,1746(a0) # 1000 <freep>
 936:	c915                	beqz	a0,96a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 938:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 93a:	4798                	lw	a4,8(a5)
 93c:	08977a63          	bgeu	a4,s1,9d0 <malloc+0xbe>
 940:	f04a                	sd	s2,32(sp)
 942:	e852                	sd	s4,16(sp)
 944:	e456                	sd	s5,8(sp)
 946:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 948:	8a4e                	mv	s4,s3
 94a:	0009871b          	sext.w	a4,s3
 94e:	6685                	lui	a3,0x1
 950:	00d77363          	bgeu	a4,a3,956 <malloc+0x44>
 954:	6a05                	lui	s4,0x1
 956:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 95a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 95e:	00000917          	auipc	s2,0x0
 962:	6a290913          	addi	s2,s2,1698 # 1000 <freep>
  if(p == (char*)-1)
 966:	5afd                	li	s5,-1
 968:	a081                	j	9a8 <malloc+0x96>
 96a:	f04a                	sd	s2,32(sp)
 96c:	e852                	sd	s4,16(sp)
 96e:	e456                	sd	s5,8(sp)
 970:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 972:	00000797          	auipc	a5,0x0
 976:	69e78793          	addi	a5,a5,1694 # 1010 <base>
 97a:	00000717          	auipc	a4,0x0
 97e:	68f73323          	sd	a5,1670(a4) # 1000 <freep>
 982:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 984:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 988:	b7c1                	j	948 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 98a:	6398                	ld	a4,0(a5)
 98c:	e118                	sd	a4,0(a0)
 98e:	a8a9                	j	9e8 <malloc+0xd6>
  hp->s.size = nu;
 990:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 994:	0541                	addi	a0,a0,16
 996:	efbff0ef          	jal	890 <free>
  return freep;
 99a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 99e:	c12d                	beqz	a0,a00 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9a0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9a2:	4798                	lw	a4,8(a5)
 9a4:	02977263          	bgeu	a4,s1,9c8 <malloc+0xb6>
    if(p == freep)
 9a8:	00093703          	ld	a4,0(s2)
 9ac:	853e                	mv	a0,a5
 9ae:	fef719e3          	bne	a4,a5,9a0 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 9b2:	8552                	mv	a0,s4
 9b4:	b1bff0ef          	jal	4ce <sbrk>
  if(p == (char*)-1)
 9b8:	fd551ce3          	bne	a0,s5,990 <malloc+0x7e>
        return 0;
 9bc:	4501                	li	a0,0
 9be:	7902                	ld	s2,32(sp)
 9c0:	6a42                	ld	s4,16(sp)
 9c2:	6aa2                	ld	s5,8(sp)
 9c4:	6b02                	ld	s6,0(sp)
 9c6:	a03d                	j	9f4 <malloc+0xe2>
 9c8:	7902                	ld	s2,32(sp)
 9ca:	6a42                	ld	s4,16(sp)
 9cc:	6aa2                	ld	s5,8(sp)
 9ce:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9d0:	fae48de3          	beq	s1,a4,98a <malloc+0x78>
        p->s.size -= nunits;
 9d4:	4137073b          	subw	a4,a4,s3
 9d8:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9da:	02071693          	slli	a3,a4,0x20
 9de:	01c6d713          	srli	a4,a3,0x1c
 9e2:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9e4:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9e8:	00000717          	auipc	a4,0x0
 9ec:	60a73c23          	sd	a0,1560(a4) # 1000 <freep>
      return (void*)(p + 1);
 9f0:	01078513          	addi	a0,a5,16
  }
}
 9f4:	70e2                	ld	ra,56(sp)
 9f6:	7442                	ld	s0,48(sp)
 9f8:	74a2                	ld	s1,40(sp)
 9fa:	69e2                	ld	s3,24(sp)
 9fc:	6121                	addi	sp,sp,64
 9fe:	8082                	ret
 a00:	7902                	ld	s2,32(sp)
 a02:	6a42                	ld	s4,16(sp)
 a04:	6aa2                	ld	s5,8(sp)
 a06:	6b02                	ld	s6,0(sp)
 a08:	b7f5                	j	9f4 <malloc+0xe2>
