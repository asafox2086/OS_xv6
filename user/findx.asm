
user/_findx:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <compare>:
#include "user/user.h"
#include "kernel/fs.h"
#include "kernel/fcntl.h"


int compare(char *a,char *b){
   0:	bc010113          	addi	sp,sp,-1088
   4:	42113c23          	sd	ra,1080(sp)
   8:	42813823          	sd	s0,1072(sp)
   c:	42913423          	sd	s1,1064(sp)
  10:	43213023          	sd	s2,1056(sp)
  14:	41313c23          	sd	s3,1048(sp)
  18:	41413823          	sd	s4,1040(sp)
  1c:	44010413          	addi	s0,sp,1088
  20:	8a2a                	mv	s4,a0
  22:	84ae                	mv	s1,a1
    int lena=strlen(a);
  24:	364000ef          	jal	388 <strlen>
  28:	0005099b          	sext.w	s3,a0
    int lenb=strlen(b);
  2c:	8526                	mv	a0,s1
  2e:	35a000ef          	jal	388 <strlen>
  32:	0005091b          	sext.w	s2,a0
    if(b[0]=='*'){
  36:	0004c703          	lbu	a4,0(s1)
  3a:	02a00793          	li	a5,42
  3e:	02f70f63          	beq	a4,a5,7c <compare+0x7c>
            if(strcmp(tmpa,tmpb)==0){
                return 1;
            }
        }

    }else if(b[lenb-1]=='*'){
  42:	012487b3          	add	a5,s1,s2
  46:	fff7c703          	lbu	a4,-1(a5)
  4a:	02a00793          	li	a5,42
  4e:	0cf70a63          	beq	a4,a5,122 <compare+0x122>
        memmove(tmpb,b,lenb-1);
        if(strcmp(tmpa,tmpb)==0){
            return 1;
        }
    }else{
        if(strcmp(a,b)==0){
  52:	85a6                	mv	a1,s1
  54:	8552                	mv	a0,s4
  56:	306000ef          	jal	35c <strcmp>
  5a:	00153513          	seqz	a0,a0
            return 1;
        }
    }
    return 0;
}
  5e:	43813083          	ld	ra,1080(sp)
  62:	43013403          	ld	s0,1072(sp)
  66:	42813483          	ld	s1,1064(sp)
  6a:	42013903          	ld	s2,1056(sp)
  6e:	41813983          	ld	s3,1048(sp)
  72:	41013a03          	ld	s4,1040(sp)
  76:	44010113          	addi	sp,sp,1088
  7a:	8082                	ret
    int lena=strlen(a);
  7c:	2981                	sext.w	s3,s3
        if(b[lenb-1]=='*'){
  7e:	012487b3          	add	a5,s1,s2
  82:	fff7c703          	lbu	a4,-1(a5)
  86:	02a00793          	li	a5,42
  8a:	04f71d63          	bne	a4,a5,e4 <compare+0xe4>
            for(int i=0;i<lena-lenb+2;i++){
  8e:	412989bb          	subw	s3,s3,s2
  92:	57fd                	li	a5,-1
  94:	0af9cd63          	blt	s3,a5,14e <compare+0x14e>
  98:	41513423          	sd	s5,1032(sp)
  9c:	8ad2                	mv	s5,s4
                memmove(tmpa,a+i,lenb-2);
  9e:	3979                	addiw	s2,s2,-2
                memmove(tmpb,b+1,lenb-2);
  a0:	0485                	addi	s1,s1,1
                memmove(tmpa,a+i,lenb-2);
  a2:	864a                	mv	a2,s2
  a4:	85d6                	mv	a1,s5
  a6:	bc040513          	addi	a0,s0,-1088
  aa:	440000ef          	jal	4ea <memmove>
                memmove(tmpb,b+1,lenb-2);
  ae:	864a                	mv	a2,s2
  b0:	85a6                	mv	a1,s1
  b2:	dc040513          	addi	a0,s0,-576
  b6:	434000ef          	jal	4ea <memmove>
                if(strcmp(tmpa,tmpb)==0){
  ba:	dc040593          	addi	a1,s0,-576
  be:	bc040513          	addi	a0,s0,-1088
  c2:	29a000ef          	jal	35c <strcmp>
  c6:	c919                	beqz	a0,dc <compare+0xdc>
            for(int i=0;i<lena-lenb+2;i++){
  c8:	0a85                	addi	s5,s5,1
  ca:	414a87bb          	subw	a5,s5,s4
  ce:	37fd                	addiw	a5,a5,-1
  d0:	fcf9d9e3          	bge	s3,a5,a2 <compare+0xa2>
    return 0;
  d4:	4501                	li	a0,0
  d6:	40813a83          	ld	s5,1032(sp)
  da:	b751                	j	5e <compare+0x5e>
                    return 1;
  dc:	4505                	li	a0,1
  de:	40813a83          	ld	s5,1032(sp)
  e2:	bfb5                	j	5e <compare+0x5e>
  e4:	41513423          	sd	s5,1032(sp)
            memmove(tmpa,a+lena-lenb+1,lenb-1);
  e8:	fff90a9b          	addiw	s5,s2,-1
  ec:	0985                	addi	s3,s3,1
  ee:	412985b3          	sub	a1,s3,s2
  f2:	8656                	mv	a2,s5
  f4:	95d2                	add	a1,a1,s4
  f6:	bc040513          	addi	a0,s0,-1088
  fa:	3f0000ef          	jal	4ea <memmove>
            memmove(tmpb,b+1,lenb-1);
  fe:	8656                	mv	a2,s5
 100:	00148593          	addi	a1,s1,1
 104:	dc040513          	addi	a0,s0,-576
 108:	3e2000ef          	jal	4ea <memmove>
            if(strcmp(tmpa,tmpb)==0){
 10c:	dc040593          	addi	a1,s0,-576
 110:	bc040513          	addi	a0,s0,-1088
 114:	248000ef          	jal	35c <strcmp>
                return 1;
 118:	00153513          	seqz	a0,a0
 11c:	40813a83          	ld	s5,1032(sp)
 120:	bf3d                	j	5e <compare+0x5e>
        memmove(tmpa,a,lenb-1);
 122:	397d                	addiw	s2,s2,-1
 124:	864a                	mv	a2,s2
 126:	85d2                	mv	a1,s4
 128:	bc040513          	addi	a0,s0,-1088
 12c:	3be000ef          	jal	4ea <memmove>
        memmove(tmpb,b,lenb-1);
 130:	864a                	mv	a2,s2
 132:	85a6                	mv	a1,s1
 134:	dc040513          	addi	a0,s0,-576
 138:	3b2000ef          	jal	4ea <memmove>
        if(strcmp(tmpa,tmpb)==0){
 13c:	dc040593          	addi	a1,s0,-576
 140:	bc040513          	addi	a0,s0,-1088
 144:	218000ef          	jal	35c <strcmp>
            return 1;
 148:	00153513          	seqz	a0,a0
 14c:	bf09                	j	5e <compare+0x5e>
    return 0;
 14e:	4501                	li	a0,0
 150:	b739                	j	5e <compare+0x5e>

0000000000000152 <findx>:
void findx(char *path,char *name){
 152:	d9010113          	addi	sp,sp,-624
 156:	26113423          	sd	ra,616(sp)
 15a:	26813023          	sd	s0,608(sp)
 15e:	25213823          	sd	s2,592(sp)
 162:	25313423          	sd	s3,584(sp)
 166:	1c80                	addi	s0,sp,624
 168:	892a                	mv	s2,a0
 16a:	89ae                	mv	s3,a1
    char buf[512], *p;
    int fd;
    struct dirent de;
    struct stat st;
    if((fd = open(path, O_RDONLY)) < 0){
 16c:	4581                	li	a1,0
 16e:	46a000ef          	jal	5d8 <open>
 172:	04054063          	bltz	a0,1b2 <findx+0x60>
 176:	24913c23          	sd	s1,600(sp)
 17a:	84aa                	mv	s1,a0
        fprintf(2, "find: cannot open %s\n", path);
        return;
    }
    if(fstat(fd, &st) < 0){
 17c:	d9840593          	addi	a1,s0,-616
 180:	470000ef          	jal	5f0 <fstat>
 184:	04054063          	bltz	a0,1c4 <findx+0x72>
        fprintf(2, "find: cannot stat %s\n", path);
        close(fd);
        return;
    }
    if(st.type!=T_DIR){
 188:	da041703          	lh	a4,-608(s0)
 18c:	4785                	li	a5,1
 18e:	04f70963          	beq	a4,a5,1e0 <findx+0x8e>
        close(fd);
 192:	8526                	mv	a0,s1
 194:	42c000ef          	jal	5c0 <close>
        return;
 198:	25813483          	ld	s1,600(sp)
        }

    }
    close(fd);

}
 19c:	26813083          	ld	ra,616(sp)
 1a0:	26013403          	ld	s0,608(sp)
 1a4:	25013903          	ld	s2,592(sp)
 1a8:	24813983          	ld	s3,584(sp)
 1ac:	27010113          	addi	sp,sp,624
 1b0:	8082                	ret
        fprintf(2, "find: cannot open %s\n", path);
 1b2:	864a                	mv	a2,s2
 1b4:	00001597          	auipc	a1,0x1
 1b8:	9bc58593          	addi	a1,a1,-1604 # b70 <malloc+0x104>
 1bc:	4509                	li	a0,2
 1be:	7d0000ef          	jal	98e <fprintf>
        return;
 1c2:	bfe9                	j	19c <findx+0x4a>
        fprintf(2, "find: cannot stat %s\n", path);
 1c4:	864a                	mv	a2,s2
 1c6:	00001597          	auipc	a1,0x1
 1ca:	9c258593          	addi	a1,a1,-1598 # b88 <malloc+0x11c>
 1ce:	4509                	li	a0,2
 1d0:	7be000ef          	jal	98e <fprintf>
        close(fd);
 1d4:	8526                	mv	a0,s1
 1d6:	3ea000ef          	jal	5c0 <close>
        return;
 1da:	25813483          	ld	s1,600(sp)
 1de:	bf7d                	j	19c <findx+0x4a>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1e0:	854a                	mv	a0,s2
 1e2:	1a6000ef          	jal	388 <strlen>
 1e6:	2541                	addiw	a0,a0,16
 1e8:	20000793          	li	a5,512
 1ec:	0aa7eb63          	bltu	a5,a0,2a2 <findx+0x150>
 1f0:	25413023          	sd	s4,576(sp)
 1f4:	23513c23          	sd	s5,568(sp)
 1f8:	23613823          	sd	s6,560(sp)
    strcpy(buf, path);
 1fc:	85ca                	mv	a1,s2
 1fe:	dc040513          	addi	a0,s0,-576
 202:	13e000ef          	jal	340 <strcpy>
    p = buf+strlen(buf);
 206:	dc040513          	addi	a0,s0,-576
 20a:	17e000ef          	jal	388 <strlen>
 20e:	1502                	slli	a0,a0,0x20
 210:	9101                	srli	a0,a0,0x20
 212:	dc040793          	addi	a5,s0,-576
 216:	00a78933          	add	s2,a5,a0
    *p++ = '/';
 21a:	00190b13          	addi	s6,s2,1
 21e:	02f00793          	li	a5,47
 222:	00f90023          	sb	a5,0(s2)
        if(strcmp(de.name,".")==0 ||strcmp(de.name,"..")==0){
 226:	00001a17          	auipc	s4,0x1
 22a:	992a0a13          	addi	s4,s4,-1646 # bb8 <malloc+0x14c>
 22e:	00001a97          	auipc	s5,0x1
 232:	992a8a93          	addi	s5,s5,-1646 # bc0 <malloc+0x154>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 236:	4641                	li	a2,16
 238:	db040593          	addi	a1,s0,-592
 23c:	8526                	mv	a0,s1
 23e:	372000ef          	jal	5b0 <read>
 242:	47c1                	li	a5,16
 244:	0af51063          	bne	a0,a5,2e4 <findx+0x192>
        if( de.inum == 0)
 248:	db045783          	lhu	a5,-592(s0)
 24c:	d7ed                	beqz	a5,236 <findx+0xe4>
        if(strcmp(de.name,".")==0 ||strcmp(de.name,"..")==0){
 24e:	85d2                	mv	a1,s4
 250:	db240513          	addi	a0,s0,-590
 254:	108000ef          	jal	35c <strcmp>
 258:	dd79                	beqz	a0,236 <findx+0xe4>
 25a:	85d6                	mv	a1,s5
 25c:	db240513          	addi	a0,s0,-590
 260:	0fc000ef          	jal	35c <strcmp>
 264:	d969                	beqz	a0,236 <findx+0xe4>
        memmove(p, de.name, DIRSIZ);
 266:	4639                	li	a2,14
 268:	db240593          	addi	a1,s0,-590
 26c:	855a                	mv	a0,s6
 26e:	27c000ef          	jal	4ea <memmove>
        p[DIRSIZ] = 0;
 272:	000907a3          	sb	zero,15(s2)
        if(stat(buf, &st) < 0){
 276:	d9840593          	addi	a1,s0,-616
 27a:	dc040513          	addi	a0,s0,-576
 27e:	1ea000ef          	jal	468 <stat>
 282:	02054963          	bltz	a0,2b4 <findx+0x162>
        if(st.type==T_FILE){
 286:	da041783          	lh	a5,-608(s0)
 28a:	4709                	li	a4,2
 28c:	02e78d63          	beq	a5,a4,2c6 <findx+0x174>
        }else if(st.type==T_DIR){
 290:	4705                	li	a4,1
 292:	fae792e3          	bne	a5,a4,236 <findx+0xe4>
            findx(buf,name);
 296:	85ce                	mv	a1,s3
 298:	dc040513          	addi	a0,s0,-576
 29c:	eb7ff0ef          	jal	152 <findx>
 2a0:	bf59                	j	236 <findx+0xe4>
        printf("find: path too long\n");
 2a2:	00001517          	auipc	a0,0x1
 2a6:	8fe50513          	addi	a0,a0,-1794 # ba0 <malloc+0x134>
 2aa:	70e000ef          	jal	9b8 <printf>
        return;
 2ae:	25813483          	ld	s1,600(sp)
 2b2:	b5ed                	j	19c <findx+0x4a>
            printf("find: cannot stat %s\n", buf);
 2b4:	dc040593          	addi	a1,s0,-576
 2b8:	00001517          	auipc	a0,0x1
 2bc:	8d050513          	addi	a0,a0,-1840 # b88 <malloc+0x11c>
 2c0:	6f8000ef          	jal	9b8 <printf>
            continue;
 2c4:	bf8d                	j	236 <findx+0xe4>
            if(compare(de.name,name)){
 2c6:	85ce                	mv	a1,s3
 2c8:	db240513          	addi	a0,s0,-590
 2cc:	d35ff0ef          	jal	0 <compare>
 2d0:	d13d                	beqz	a0,236 <findx+0xe4>
                printf("%s\n",buf);
 2d2:	dc040593          	addi	a1,s0,-576
 2d6:	00001517          	auipc	a0,0x1
 2da:	8f250513          	addi	a0,a0,-1806 # bc8 <malloc+0x15c>
 2de:	6da000ef          	jal	9b8 <printf>
 2e2:	bf91                	j	236 <findx+0xe4>
    close(fd);
 2e4:	8526                	mv	a0,s1
 2e6:	2da000ef          	jal	5c0 <close>
 2ea:	25813483          	ld	s1,600(sp)
 2ee:	24013a03          	ld	s4,576(sp)
 2f2:	23813a83          	ld	s5,568(sp)
 2f6:	23013b03          	ld	s6,560(sp)
 2fa:	b54d                	j	19c <findx+0x4a>

00000000000002fc <main>:
int main(int argc, char *argv[])
{
 2fc:	1141                	addi	sp,sp,-16
 2fe:	e406                	sd	ra,8(sp)
 300:	e022                	sd	s0,0(sp)
 302:	0800                	addi	s0,sp,16
    if(argc!=3){
 304:	470d                	li	a4,3
 306:	00e50c63          	beq	a0,a4,31e <main+0x22>
        fprintf(2,"Usage:findx <path> <name>");
 30a:	00001597          	auipc	a1,0x1
 30e:	8c658593          	addi	a1,a1,-1850 # bd0 <malloc+0x164>
 312:	4509                	li	a0,2
 314:	67a000ef          	jal	98e <fprintf>
        exit(0);
 318:	4501                	li	a0,0
 31a:	27e000ef          	jal	598 <exit>
 31e:	87ae                	mv	a5,a1
    }else{
        findx(argv[1],argv[2]);
 320:	698c                	ld	a1,16(a1)
 322:	6788                	ld	a0,8(a5)
 324:	e2fff0ef          	jal	152 <findx>
    }
    exit(0);
 328:	4501                	li	a0,0
 32a:	26e000ef          	jal	598 <exit>

000000000000032e <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 32e:	1141                	addi	sp,sp,-16
 330:	e406                	sd	ra,8(sp)
 332:	e022                	sd	s0,0(sp)
 334:	0800                	addi	s0,sp,16
  extern int main();
  main();
 336:	fc7ff0ef          	jal	2fc <main>
  exit(0);
 33a:	4501                	li	a0,0
 33c:	25c000ef          	jal	598 <exit>

0000000000000340 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 340:	1141                	addi	sp,sp,-16
 342:	e422                	sd	s0,8(sp)
 344:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 346:	87aa                	mv	a5,a0
 348:	0585                	addi	a1,a1,1
 34a:	0785                	addi	a5,a5,1
 34c:	fff5c703          	lbu	a4,-1(a1)
 350:	fee78fa3          	sb	a4,-1(a5)
 354:	fb75                	bnez	a4,348 <strcpy+0x8>
    ;
  return os;
}
 356:	6422                	ld	s0,8(sp)
 358:	0141                	addi	sp,sp,16
 35a:	8082                	ret

000000000000035c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 35c:	1141                	addi	sp,sp,-16
 35e:	e422                	sd	s0,8(sp)
 360:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 362:	00054783          	lbu	a5,0(a0)
 366:	cb91                	beqz	a5,37a <strcmp+0x1e>
 368:	0005c703          	lbu	a4,0(a1)
 36c:	00f71763          	bne	a4,a5,37a <strcmp+0x1e>
    p++, q++;
 370:	0505                	addi	a0,a0,1
 372:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 374:	00054783          	lbu	a5,0(a0)
 378:	fbe5                	bnez	a5,368 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 37a:	0005c503          	lbu	a0,0(a1)
}
 37e:	40a7853b          	subw	a0,a5,a0
 382:	6422                	ld	s0,8(sp)
 384:	0141                	addi	sp,sp,16
 386:	8082                	ret

0000000000000388 <strlen>:

uint
strlen(const char *s)
{
 388:	1141                	addi	sp,sp,-16
 38a:	e422                	sd	s0,8(sp)
 38c:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 38e:	00054783          	lbu	a5,0(a0)
 392:	cf91                	beqz	a5,3ae <strlen+0x26>
 394:	0505                	addi	a0,a0,1
 396:	87aa                	mv	a5,a0
 398:	86be                	mv	a3,a5
 39a:	0785                	addi	a5,a5,1
 39c:	fff7c703          	lbu	a4,-1(a5)
 3a0:	ff65                	bnez	a4,398 <strlen+0x10>
 3a2:	40a6853b          	subw	a0,a3,a0
 3a6:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 3a8:	6422                	ld	s0,8(sp)
 3aa:	0141                	addi	sp,sp,16
 3ac:	8082                	ret
  for(n = 0; s[n]; n++)
 3ae:	4501                	li	a0,0
 3b0:	bfe5                	j	3a8 <strlen+0x20>

00000000000003b2 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3b2:	1141                	addi	sp,sp,-16
 3b4:	e422                	sd	s0,8(sp)
 3b6:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 3b8:	ca19                	beqz	a2,3ce <memset+0x1c>
 3ba:	87aa                	mv	a5,a0
 3bc:	1602                	slli	a2,a2,0x20
 3be:	9201                	srli	a2,a2,0x20
 3c0:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 3c4:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 3c8:	0785                	addi	a5,a5,1
 3ca:	fee79de3          	bne	a5,a4,3c4 <memset+0x12>
  }
  return dst;
}
 3ce:	6422                	ld	s0,8(sp)
 3d0:	0141                	addi	sp,sp,16
 3d2:	8082                	ret

00000000000003d4 <strchr>:

char*
strchr(const char *s, char c)
{
 3d4:	1141                	addi	sp,sp,-16
 3d6:	e422                	sd	s0,8(sp)
 3d8:	0800                	addi	s0,sp,16
  for(; *s; s++)
 3da:	00054783          	lbu	a5,0(a0)
 3de:	cb99                	beqz	a5,3f4 <strchr+0x20>
    if(*s == c)
 3e0:	00f58763          	beq	a1,a5,3ee <strchr+0x1a>
  for(; *s; s++)
 3e4:	0505                	addi	a0,a0,1
 3e6:	00054783          	lbu	a5,0(a0)
 3ea:	fbfd                	bnez	a5,3e0 <strchr+0xc>
      return (char*)s;
  return 0;
 3ec:	4501                	li	a0,0
}
 3ee:	6422                	ld	s0,8(sp)
 3f0:	0141                	addi	sp,sp,16
 3f2:	8082                	ret
  return 0;
 3f4:	4501                	li	a0,0
 3f6:	bfe5                	j	3ee <strchr+0x1a>

00000000000003f8 <gets>:

char*
gets(char *buf, int max)
{
 3f8:	711d                	addi	sp,sp,-96
 3fa:	ec86                	sd	ra,88(sp)
 3fc:	e8a2                	sd	s0,80(sp)
 3fe:	e4a6                	sd	s1,72(sp)
 400:	e0ca                	sd	s2,64(sp)
 402:	fc4e                	sd	s3,56(sp)
 404:	f852                	sd	s4,48(sp)
 406:	f456                	sd	s5,40(sp)
 408:	f05a                	sd	s6,32(sp)
 40a:	ec5e                	sd	s7,24(sp)
 40c:	1080                	addi	s0,sp,96
 40e:	8baa                	mv	s7,a0
 410:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 412:	892a                	mv	s2,a0
 414:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 416:	4aa9                	li	s5,10
 418:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 41a:	89a6                	mv	s3,s1
 41c:	2485                	addiw	s1,s1,1
 41e:	0344d663          	bge	s1,s4,44a <gets+0x52>
    cc = read(0, &c, 1);
 422:	4605                	li	a2,1
 424:	faf40593          	addi	a1,s0,-81
 428:	4501                	li	a0,0
 42a:	186000ef          	jal	5b0 <read>
    if(cc < 1)
 42e:	00a05e63          	blez	a0,44a <gets+0x52>
    buf[i++] = c;
 432:	faf44783          	lbu	a5,-81(s0)
 436:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 43a:	01578763          	beq	a5,s5,448 <gets+0x50>
 43e:	0905                	addi	s2,s2,1
 440:	fd679de3          	bne	a5,s6,41a <gets+0x22>
    buf[i++] = c;
 444:	89a6                	mv	s3,s1
 446:	a011                	j	44a <gets+0x52>
 448:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 44a:	99de                	add	s3,s3,s7
 44c:	00098023          	sb	zero,0(s3)
  return buf;
}
 450:	855e                	mv	a0,s7
 452:	60e6                	ld	ra,88(sp)
 454:	6446                	ld	s0,80(sp)
 456:	64a6                	ld	s1,72(sp)
 458:	6906                	ld	s2,64(sp)
 45a:	79e2                	ld	s3,56(sp)
 45c:	7a42                	ld	s4,48(sp)
 45e:	7aa2                	ld	s5,40(sp)
 460:	7b02                	ld	s6,32(sp)
 462:	6be2                	ld	s7,24(sp)
 464:	6125                	addi	sp,sp,96
 466:	8082                	ret

0000000000000468 <stat>:

int
stat(const char *n, struct stat *st)
{
 468:	1101                	addi	sp,sp,-32
 46a:	ec06                	sd	ra,24(sp)
 46c:	e822                	sd	s0,16(sp)
 46e:	e04a                	sd	s2,0(sp)
 470:	1000                	addi	s0,sp,32
 472:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 474:	4581                	li	a1,0
 476:	162000ef          	jal	5d8 <open>
  if(fd < 0)
 47a:	02054263          	bltz	a0,49e <stat+0x36>
 47e:	e426                	sd	s1,8(sp)
 480:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 482:	85ca                	mv	a1,s2
 484:	16c000ef          	jal	5f0 <fstat>
 488:	892a                	mv	s2,a0
  close(fd);
 48a:	8526                	mv	a0,s1
 48c:	134000ef          	jal	5c0 <close>
  return r;
 490:	64a2                	ld	s1,8(sp)
}
 492:	854a                	mv	a0,s2
 494:	60e2                	ld	ra,24(sp)
 496:	6442                	ld	s0,16(sp)
 498:	6902                	ld	s2,0(sp)
 49a:	6105                	addi	sp,sp,32
 49c:	8082                	ret
    return -1;
 49e:	597d                	li	s2,-1
 4a0:	bfcd                	j	492 <stat+0x2a>

00000000000004a2 <atoi>:

int
atoi(const char *s)
{
 4a2:	1141                	addi	sp,sp,-16
 4a4:	e422                	sd	s0,8(sp)
 4a6:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4a8:	00054683          	lbu	a3,0(a0)
 4ac:	fd06879b          	addiw	a5,a3,-48
 4b0:	0ff7f793          	zext.b	a5,a5
 4b4:	4625                	li	a2,9
 4b6:	02f66863          	bltu	a2,a5,4e6 <atoi+0x44>
 4ba:	872a                	mv	a4,a0
  n = 0;
 4bc:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 4be:	0705                	addi	a4,a4,1
 4c0:	0025179b          	slliw	a5,a0,0x2
 4c4:	9fa9                	addw	a5,a5,a0
 4c6:	0017979b          	slliw	a5,a5,0x1
 4ca:	9fb5                	addw	a5,a5,a3
 4cc:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 4d0:	00074683          	lbu	a3,0(a4)
 4d4:	fd06879b          	addiw	a5,a3,-48
 4d8:	0ff7f793          	zext.b	a5,a5
 4dc:	fef671e3          	bgeu	a2,a5,4be <atoi+0x1c>
  return n;
}
 4e0:	6422                	ld	s0,8(sp)
 4e2:	0141                	addi	sp,sp,16
 4e4:	8082                	ret
  n = 0;
 4e6:	4501                	li	a0,0
 4e8:	bfe5                	j	4e0 <atoi+0x3e>

00000000000004ea <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4ea:	1141                	addi	sp,sp,-16
 4ec:	e422                	sd	s0,8(sp)
 4ee:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4f0:	02b57463          	bgeu	a0,a1,518 <memmove+0x2e>
    while(n-- > 0)
 4f4:	00c05f63          	blez	a2,512 <memmove+0x28>
 4f8:	1602                	slli	a2,a2,0x20
 4fa:	9201                	srli	a2,a2,0x20
 4fc:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 500:	872a                	mv	a4,a0
      *dst++ = *src++;
 502:	0585                	addi	a1,a1,1
 504:	0705                	addi	a4,a4,1
 506:	fff5c683          	lbu	a3,-1(a1)
 50a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 50e:	fef71ae3          	bne	a4,a5,502 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 512:	6422                	ld	s0,8(sp)
 514:	0141                	addi	sp,sp,16
 516:	8082                	ret
    dst += n;
 518:	00c50733          	add	a4,a0,a2
    src += n;
 51c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 51e:	fec05ae3          	blez	a2,512 <memmove+0x28>
 522:	fff6079b          	addiw	a5,a2,-1
 526:	1782                	slli	a5,a5,0x20
 528:	9381                	srli	a5,a5,0x20
 52a:	fff7c793          	not	a5,a5
 52e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 530:	15fd                	addi	a1,a1,-1
 532:	177d                	addi	a4,a4,-1
 534:	0005c683          	lbu	a3,0(a1)
 538:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 53c:	fee79ae3          	bne	a5,a4,530 <memmove+0x46>
 540:	bfc9                	j	512 <memmove+0x28>

0000000000000542 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 542:	1141                	addi	sp,sp,-16
 544:	e422                	sd	s0,8(sp)
 546:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 548:	ca05                	beqz	a2,578 <memcmp+0x36>
 54a:	fff6069b          	addiw	a3,a2,-1
 54e:	1682                	slli	a3,a3,0x20
 550:	9281                	srli	a3,a3,0x20
 552:	0685                	addi	a3,a3,1
 554:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 556:	00054783          	lbu	a5,0(a0)
 55a:	0005c703          	lbu	a4,0(a1)
 55e:	00e79863          	bne	a5,a4,56e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 562:	0505                	addi	a0,a0,1
    p2++;
 564:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 566:	fed518e3          	bne	a0,a3,556 <memcmp+0x14>
  }
  return 0;
 56a:	4501                	li	a0,0
 56c:	a019                	j	572 <memcmp+0x30>
      return *p1 - *p2;
 56e:	40e7853b          	subw	a0,a5,a4
}
 572:	6422                	ld	s0,8(sp)
 574:	0141                	addi	sp,sp,16
 576:	8082                	ret
  return 0;
 578:	4501                	li	a0,0
 57a:	bfe5                	j	572 <memcmp+0x30>

000000000000057c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 57c:	1141                	addi	sp,sp,-16
 57e:	e406                	sd	ra,8(sp)
 580:	e022                	sd	s0,0(sp)
 582:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 584:	f67ff0ef          	jal	4ea <memmove>
}
 588:	60a2                	ld	ra,8(sp)
 58a:	6402                	ld	s0,0(sp)
 58c:	0141                	addi	sp,sp,16
 58e:	8082                	ret

0000000000000590 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 590:	4885                	li	a7,1
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <exit>:
.global exit
exit:
 li a7, SYS_exit
 598:	4889                	li	a7,2
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5a0:	488d                	li	a7,3
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5a8:	4891                	li	a7,4
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <read>:
.global read
read:
 li a7, SYS_read
 5b0:	4895                	li	a7,5
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <write>:
.global write
write:
 li a7, SYS_write
 5b8:	48c1                	li	a7,16
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <close>:
.global close
close:
 li a7, SYS_close
 5c0:	48d5                	li	a7,21
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5c8:	4899                	li	a7,6
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5d0:	489d                	li	a7,7
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <open>:
.global open
open:
 li a7, SYS_open
 5d8:	48bd                	li	a7,15
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5e0:	48c5                	li	a7,17
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5e8:	48c9                	li	a7,18
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5f0:	48a1                	li	a7,8
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <link>:
.global link
link:
 li a7, SYS_link
 5f8:	48cd                	li	a7,19
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 600:	48d1                	li	a7,20
 ecall
 602:	00000073          	ecall
 ret
 606:	8082                	ret

0000000000000608 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 608:	48a5                	li	a7,9
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <dup>:
.global dup
dup:
 li a7, SYS_dup
 610:	48a9                	li	a7,10
 ecall
 612:	00000073          	ecall
 ret
 616:	8082                	ret

0000000000000618 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 618:	48ad                	li	a7,11
 ecall
 61a:	00000073          	ecall
 ret
 61e:	8082                	ret

0000000000000620 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 620:	48b1                	li	a7,12
 ecall
 622:	00000073          	ecall
 ret
 626:	8082                	ret

0000000000000628 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 628:	48b5                	li	a7,13
 ecall
 62a:	00000073          	ecall
 ret
 62e:	8082                	ret

0000000000000630 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 630:	48b9                	li	a7,14
 ecall
 632:	00000073          	ecall
 ret
 636:	8082                	ret

0000000000000638 <hello>:
.global hello
hello:
 li a7, SYS_hello
 638:	48d9                	li	a7,22
 ecall
 63a:	00000073          	ecall
 ret
 63e:	8082                	ret

0000000000000640 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 640:	1101                	addi	sp,sp,-32
 642:	ec06                	sd	ra,24(sp)
 644:	e822                	sd	s0,16(sp)
 646:	1000                	addi	s0,sp,32
 648:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 64c:	4605                	li	a2,1
 64e:	fef40593          	addi	a1,s0,-17
 652:	f67ff0ef          	jal	5b8 <write>
}
 656:	60e2                	ld	ra,24(sp)
 658:	6442                	ld	s0,16(sp)
 65a:	6105                	addi	sp,sp,32
 65c:	8082                	ret

000000000000065e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 65e:	7139                	addi	sp,sp,-64
 660:	fc06                	sd	ra,56(sp)
 662:	f822                	sd	s0,48(sp)
 664:	f426                	sd	s1,40(sp)
 666:	0080                	addi	s0,sp,64
 668:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 66a:	c299                	beqz	a3,670 <printint+0x12>
 66c:	0805c963          	bltz	a1,6fe <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 670:	2581                	sext.w	a1,a1
  neg = 0;
 672:	4881                	li	a7,0
 674:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 678:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 67a:	2601                	sext.w	a2,a2
 67c:	00000517          	auipc	a0,0x0
 680:	57c50513          	addi	a0,a0,1404 # bf8 <digits>
 684:	883a                	mv	a6,a4
 686:	2705                	addiw	a4,a4,1
 688:	02c5f7bb          	remuw	a5,a1,a2
 68c:	1782                	slli	a5,a5,0x20
 68e:	9381                	srli	a5,a5,0x20
 690:	97aa                	add	a5,a5,a0
 692:	0007c783          	lbu	a5,0(a5)
 696:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 69a:	0005879b          	sext.w	a5,a1
 69e:	02c5d5bb          	divuw	a1,a1,a2
 6a2:	0685                	addi	a3,a3,1
 6a4:	fec7f0e3          	bgeu	a5,a2,684 <printint+0x26>
  if(neg)
 6a8:	00088c63          	beqz	a7,6c0 <printint+0x62>
    buf[i++] = '-';
 6ac:	fd070793          	addi	a5,a4,-48
 6b0:	00878733          	add	a4,a5,s0
 6b4:	02d00793          	li	a5,45
 6b8:	fef70823          	sb	a5,-16(a4)
 6bc:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 6c0:	02e05a63          	blez	a4,6f4 <printint+0x96>
 6c4:	f04a                	sd	s2,32(sp)
 6c6:	ec4e                	sd	s3,24(sp)
 6c8:	fc040793          	addi	a5,s0,-64
 6cc:	00e78933          	add	s2,a5,a4
 6d0:	fff78993          	addi	s3,a5,-1
 6d4:	99ba                	add	s3,s3,a4
 6d6:	377d                	addiw	a4,a4,-1
 6d8:	1702                	slli	a4,a4,0x20
 6da:	9301                	srli	a4,a4,0x20
 6dc:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6e0:	fff94583          	lbu	a1,-1(s2)
 6e4:	8526                	mv	a0,s1
 6e6:	f5bff0ef          	jal	640 <putc>
  while(--i >= 0)
 6ea:	197d                	addi	s2,s2,-1
 6ec:	ff391ae3          	bne	s2,s3,6e0 <printint+0x82>
 6f0:	7902                	ld	s2,32(sp)
 6f2:	69e2                	ld	s3,24(sp)
}
 6f4:	70e2                	ld	ra,56(sp)
 6f6:	7442                	ld	s0,48(sp)
 6f8:	74a2                	ld	s1,40(sp)
 6fa:	6121                	addi	sp,sp,64
 6fc:	8082                	ret
    x = -xx;
 6fe:	40b005bb          	negw	a1,a1
    neg = 1;
 702:	4885                	li	a7,1
    x = -xx;
 704:	bf85                	j	674 <printint+0x16>

0000000000000706 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 706:	711d                	addi	sp,sp,-96
 708:	ec86                	sd	ra,88(sp)
 70a:	e8a2                	sd	s0,80(sp)
 70c:	e0ca                	sd	s2,64(sp)
 70e:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 710:	0005c903          	lbu	s2,0(a1)
 714:	26090863          	beqz	s2,984 <vprintf+0x27e>
 718:	e4a6                	sd	s1,72(sp)
 71a:	fc4e                	sd	s3,56(sp)
 71c:	f852                	sd	s4,48(sp)
 71e:	f456                	sd	s5,40(sp)
 720:	f05a                	sd	s6,32(sp)
 722:	ec5e                	sd	s7,24(sp)
 724:	e862                	sd	s8,16(sp)
 726:	e466                	sd	s9,8(sp)
 728:	8b2a                	mv	s6,a0
 72a:	8a2e                	mv	s4,a1
 72c:	8bb2                	mv	s7,a2
  state = 0;
 72e:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 730:	4481                	li	s1,0
 732:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 734:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 738:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 73c:	06c00c93          	li	s9,108
 740:	a005                	j	760 <vprintf+0x5a>
        putc(fd, c0);
 742:	85ca                	mv	a1,s2
 744:	855a                	mv	a0,s6
 746:	efbff0ef          	jal	640 <putc>
 74a:	a019                	j	750 <vprintf+0x4a>
    } else if(state == '%'){
 74c:	03598263          	beq	s3,s5,770 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 750:	2485                	addiw	s1,s1,1
 752:	8726                	mv	a4,s1
 754:	009a07b3          	add	a5,s4,s1
 758:	0007c903          	lbu	s2,0(a5)
 75c:	20090c63          	beqz	s2,974 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 760:	0009079b          	sext.w	a5,s2
    if(state == 0){
 764:	fe0994e3          	bnez	s3,74c <vprintf+0x46>
      if(c0 == '%'){
 768:	fd579de3          	bne	a5,s5,742 <vprintf+0x3c>
        state = '%';
 76c:	89be                	mv	s3,a5
 76e:	b7cd                	j	750 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 770:	00ea06b3          	add	a3,s4,a4
 774:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 778:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 77a:	c681                	beqz	a3,782 <vprintf+0x7c>
 77c:	9752                	add	a4,a4,s4
 77e:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 782:	03878f63          	beq	a5,s8,7c0 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 786:	05978963          	beq	a5,s9,7d8 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 78a:	07500713          	li	a4,117
 78e:	0ee78363          	beq	a5,a4,874 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 792:	07800713          	li	a4,120
 796:	12e78563          	beq	a5,a4,8c0 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 79a:	07000713          	li	a4,112
 79e:	14e78a63          	beq	a5,a4,8f2 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 7a2:	07300713          	li	a4,115
 7a6:	18e78a63          	beq	a5,a4,93a <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 7aa:	02500713          	li	a4,37
 7ae:	04e79563          	bne	a5,a4,7f8 <vprintf+0xf2>
        putc(fd, '%');
 7b2:	02500593          	li	a1,37
 7b6:	855a                	mv	a0,s6
 7b8:	e89ff0ef          	jal	640 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 7bc:	4981                	li	s3,0
 7be:	bf49                	j	750 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 7c0:	008b8913          	addi	s2,s7,8
 7c4:	4685                	li	a3,1
 7c6:	4629                	li	a2,10
 7c8:	000ba583          	lw	a1,0(s7)
 7cc:	855a                	mv	a0,s6
 7ce:	e91ff0ef          	jal	65e <printint>
 7d2:	8bca                	mv	s7,s2
      state = 0;
 7d4:	4981                	li	s3,0
 7d6:	bfad                	j	750 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 7d8:	06400793          	li	a5,100
 7dc:	02f68963          	beq	a3,a5,80e <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 7e0:	06c00793          	li	a5,108
 7e4:	04f68263          	beq	a3,a5,828 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 7e8:	07500793          	li	a5,117
 7ec:	0af68063          	beq	a3,a5,88c <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 7f0:	07800793          	li	a5,120
 7f4:	0ef68263          	beq	a3,a5,8d8 <vprintf+0x1d2>
        putc(fd, '%');
 7f8:	02500593          	li	a1,37
 7fc:	855a                	mv	a0,s6
 7fe:	e43ff0ef          	jal	640 <putc>
        putc(fd, c0);
 802:	85ca                	mv	a1,s2
 804:	855a                	mv	a0,s6
 806:	e3bff0ef          	jal	640 <putc>
      state = 0;
 80a:	4981                	li	s3,0
 80c:	b791                	j	750 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 80e:	008b8913          	addi	s2,s7,8
 812:	4685                	li	a3,1
 814:	4629                	li	a2,10
 816:	000ba583          	lw	a1,0(s7)
 81a:	855a                	mv	a0,s6
 81c:	e43ff0ef          	jal	65e <printint>
        i += 1;
 820:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 822:	8bca                	mv	s7,s2
      state = 0;
 824:	4981                	li	s3,0
        i += 1;
 826:	b72d                	j	750 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 828:	06400793          	li	a5,100
 82c:	02f60763          	beq	a2,a5,85a <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 830:	07500793          	li	a5,117
 834:	06f60963          	beq	a2,a5,8a6 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 838:	07800793          	li	a5,120
 83c:	faf61ee3          	bne	a2,a5,7f8 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 840:	008b8913          	addi	s2,s7,8
 844:	4681                	li	a3,0
 846:	4641                	li	a2,16
 848:	000ba583          	lw	a1,0(s7)
 84c:	855a                	mv	a0,s6
 84e:	e11ff0ef          	jal	65e <printint>
        i += 2;
 852:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 854:	8bca                	mv	s7,s2
      state = 0;
 856:	4981                	li	s3,0
        i += 2;
 858:	bde5                	j	750 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 85a:	008b8913          	addi	s2,s7,8
 85e:	4685                	li	a3,1
 860:	4629                	li	a2,10
 862:	000ba583          	lw	a1,0(s7)
 866:	855a                	mv	a0,s6
 868:	df7ff0ef          	jal	65e <printint>
        i += 2;
 86c:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 86e:	8bca                	mv	s7,s2
      state = 0;
 870:	4981                	li	s3,0
        i += 2;
 872:	bdf9                	j	750 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 874:	008b8913          	addi	s2,s7,8
 878:	4681                	li	a3,0
 87a:	4629                	li	a2,10
 87c:	000ba583          	lw	a1,0(s7)
 880:	855a                	mv	a0,s6
 882:	dddff0ef          	jal	65e <printint>
 886:	8bca                	mv	s7,s2
      state = 0;
 888:	4981                	li	s3,0
 88a:	b5d9                	j	750 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 88c:	008b8913          	addi	s2,s7,8
 890:	4681                	li	a3,0
 892:	4629                	li	a2,10
 894:	000ba583          	lw	a1,0(s7)
 898:	855a                	mv	a0,s6
 89a:	dc5ff0ef          	jal	65e <printint>
        i += 1;
 89e:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 8a0:	8bca                	mv	s7,s2
      state = 0;
 8a2:	4981                	li	s3,0
        i += 1;
 8a4:	b575                	j	750 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8a6:	008b8913          	addi	s2,s7,8
 8aa:	4681                	li	a3,0
 8ac:	4629                	li	a2,10
 8ae:	000ba583          	lw	a1,0(s7)
 8b2:	855a                	mv	a0,s6
 8b4:	dabff0ef          	jal	65e <printint>
        i += 2;
 8b8:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 8ba:	8bca                	mv	s7,s2
      state = 0;
 8bc:	4981                	li	s3,0
        i += 2;
 8be:	bd49                	j	750 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 8c0:	008b8913          	addi	s2,s7,8
 8c4:	4681                	li	a3,0
 8c6:	4641                	li	a2,16
 8c8:	000ba583          	lw	a1,0(s7)
 8cc:	855a                	mv	a0,s6
 8ce:	d91ff0ef          	jal	65e <printint>
 8d2:	8bca                	mv	s7,s2
      state = 0;
 8d4:	4981                	li	s3,0
 8d6:	bdad                	j	750 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 8d8:	008b8913          	addi	s2,s7,8
 8dc:	4681                	li	a3,0
 8de:	4641                	li	a2,16
 8e0:	000ba583          	lw	a1,0(s7)
 8e4:	855a                	mv	a0,s6
 8e6:	d79ff0ef          	jal	65e <printint>
        i += 1;
 8ea:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 8ec:	8bca                	mv	s7,s2
      state = 0;
 8ee:	4981                	li	s3,0
        i += 1;
 8f0:	b585                	j	750 <vprintf+0x4a>
 8f2:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 8f4:	008b8d13          	addi	s10,s7,8
 8f8:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 8fc:	03000593          	li	a1,48
 900:	855a                	mv	a0,s6
 902:	d3fff0ef          	jal	640 <putc>
  putc(fd, 'x');
 906:	07800593          	li	a1,120
 90a:	855a                	mv	a0,s6
 90c:	d35ff0ef          	jal	640 <putc>
 910:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 912:	00000b97          	auipc	s7,0x0
 916:	2e6b8b93          	addi	s7,s7,742 # bf8 <digits>
 91a:	03c9d793          	srli	a5,s3,0x3c
 91e:	97de                	add	a5,a5,s7
 920:	0007c583          	lbu	a1,0(a5)
 924:	855a                	mv	a0,s6
 926:	d1bff0ef          	jal	640 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 92a:	0992                	slli	s3,s3,0x4
 92c:	397d                	addiw	s2,s2,-1
 92e:	fe0916e3          	bnez	s2,91a <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 932:	8bea                	mv	s7,s10
      state = 0;
 934:	4981                	li	s3,0
 936:	6d02                	ld	s10,0(sp)
 938:	bd21                	j	750 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 93a:	008b8993          	addi	s3,s7,8
 93e:	000bb903          	ld	s2,0(s7)
 942:	00090f63          	beqz	s2,960 <vprintf+0x25a>
        for(; *s; s++)
 946:	00094583          	lbu	a1,0(s2)
 94a:	c195                	beqz	a1,96e <vprintf+0x268>
          putc(fd, *s);
 94c:	855a                	mv	a0,s6
 94e:	cf3ff0ef          	jal	640 <putc>
        for(; *s; s++)
 952:	0905                	addi	s2,s2,1
 954:	00094583          	lbu	a1,0(s2)
 958:	f9f5                	bnez	a1,94c <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 95a:	8bce                	mv	s7,s3
      state = 0;
 95c:	4981                	li	s3,0
 95e:	bbcd                	j	750 <vprintf+0x4a>
          s = "(null)";
 960:	00000917          	auipc	s2,0x0
 964:	29090913          	addi	s2,s2,656 # bf0 <malloc+0x184>
        for(; *s; s++)
 968:	02800593          	li	a1,40
 96c:	b7c5                	j	94c <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 96e:	8bce                	mv	s7,s3
      state = 0;
 970:	4981                	li	s3,0
 972:	bbf9                	j	750 <vprintf+0x4a>
 974:	64a6                	ld	s1,72(sp)
 976:	79e2                	ld	s3,56(sp)
 978:	7a42                	ld	s4,48(sp)
 97a:	7aa2                	ld	s5,40(sp)
 97c:	7b02                	ld	s6,32(sp)
 97e:	6be2                	ld	s7,24(sp)
 980:	6c42                	ld	s8,16(sp)
 982:	6ca2                	ld	s9,8(sp)
    }
  }
}
 984:	60e6                	ld	ra,88(sp)
 986:	6446                	ld	s0,80(sp)
 988:	6906                	ld	s2,64(sp)
 98a:	6125                	addi	sp,sp,96
 98c:	8082                	ret

000000000000098e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 98e:	715d                	addi	sp,sp,-80
 990:	ec06                	sd	ra,24(sp)
 992:	e822                	sd	s0,16(sp)
 994:	1000                	addi	s0,sp,32
 996:	e010                	sd	a2,0(s0)
 998:	e414                	sd	a3,8(s0)
 99a:	e818                	sd	a4,16(s0)
 99c:	ec1c                	sd	a5,24(s0)
 99e:	03043023          	sd	a6,32(s0)
 9a2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 9a6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9aa:	8622                	mv	a2,s0
 9ac:	d5bff0ef          	jal	706 <vprintf>
}
 9b0:	60e2                	ld	ra,24(sp)
 9b2:	6442                	ld	s0,16(sp)
 9b4:	6161                	addi	sp,sp,80
 9b6:	8082                	ret

00000000000009b8 <printf>:

void
printf(const char *fmt, ...)
{
 9b8:	711d                	addi	sp,sp,-96
 9ba:	ec06                	sd	ra,24(sp)
 9bc:	e822                	sd	s0,16(sp)
 9be:	1000                	addi	s0,sp,32
 9c0:	e40c                	sd	a1,8(s0)
 9c2:	e810                	sd	a2,16(s0)
 9c4:	ec14                	sd	a3,24(s0)
 9c6:	f018                	sd	a4,32(s0)
 9c8:	f41c                	sd	a5,40(s0)
 9ca:	03043823          	sd	a6,48(s0)
 9ce:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 9d2:	00840613          	addi	a2,s0,8
 9d6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 9da:	85aa                	mv	a1,a0
 9dc:	4505                	li	a0,1
 9de:	d29ff0ef          	jal	706 <vprintf>
}
 9e2:	60e2                	ld	ra,24(sp)
 9e4:	6442                	ld	s0,16(sp)
 9e6:	6125                	addi	sp,sp,96
 9e8:	8082                	ret

00000000000009ea <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9ea:	1141                	addi	sp,sp,-16
 9ec:	e422                	sd	s0,8(sp)
 9ee:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9f0:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9f4:	00001797          	auipc	a5,0x1
 9f8:	60c7b783          	ld	a5,1548(a5) # 2000 <freep>
 9fc:	a02d                	j	a26 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9fe:	4618                	lw	a4,8(a2)
 a00:	9f2d                	addw	a4,a4,a1
 a02:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a06:	6398                	ld	a4,0(a5)
 a08:	6310                	ld	a2,0(a4)
 a0a:	a83d                	j	a48 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a0c:	ff852703          	lw	a4,-8(a0)
 a10:	9f31                	addw	a4,a4,a2
 a12:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a14:	ff053683          	ld	a3,-16(a0)
 a18:	a091                	j	a5c <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a1a:	6398                	ld	a4,0(a5)
 a1c:	00e7e463          	bltu	a5,a4,a24 <free+0x3a>
 a20:	00e6ea63          	bltu	a3,a4,a34 <free+0x4a>
{
 a24:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a26:	fed7fae3          	bgeu	a5,a3,a1a <free+0x30>
 a2a:	6398                	ld	a4,0(a5)
 a2c:	00e6e463          	bltu	a3,a4,a34 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a30:	fee7eae3          	bltu	a5,a4,a24 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 a34:	ff852583          	lw	a1,-8(a0)
 a38:	6390                	ld	a2,0(a5)
 a3a:	02059813          	slli	a6,a1,0x20
 a3e:	01c85713          	srli	a4,a6,0x1c
 a42:	9736                	add	a4,a4,a3
 a44:	fae60de3          	beq	a2,a4,9fe <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 a48:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a4c:	4790                	lw	a2,8(a5)
 a4e:	02061593          	slli	a1,a2,0x20
 a52:	01c5d713          	srli	a4,a1,0x1c
 a56:	973e                	add	a4,a4,a5
 a58:	fae68ae3          	beq	a3,a4,a0c <free+0x22>
    p->s.ptr = bp->s.ptr;
 a5c:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a5e:	00001717          	auipc	a4,0x1
 a62:	5af73123          	sd	a5,1442(a4) # 2000 <freep>
}
 a66:	6422                	ld	s0,8(sp)
 a68:	0141                	addi	sp,sp,16
 a6a:	8082                	ret

0000000000000a6c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a6c:	7139                	addi	sp,sp,-64
 a6e:	fc06                	sd	ra,56(sp)
 a70:	f822                	sd	s0,48(sp)
 a72:	f426                	sd	s1,40(sp)
 a74:	ec4e                	sd	s3,24(sp)
 a76:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a78:	02051493          	slli	s1,a0,0x20
 a7c:	9081                	srli	s1,s1,0x20
 a7e:	04bd                	addi	s1,s1,15
 a80:	8091                	srli	s1,s1,0x4
 a82:	0014899b          	addiw	s3,s1,1
 a86:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 a88:	00001517          	auipc	a0,0x1
 a8c:	57853503          	ld	a0,1400(a0) # 2000 <freep>
 a90:	c915                	beqz	a0,ac4 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a92:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a94:	4798                	lw	a4,8(a5)
 a96:	08977a63          	bgeu	a4,s1,b2a <malloc+0xbe>
 a9a:	f04a                	sd	s2,32(sp)
 a9c:	e852                	sd	s4,16(sp)
 a9e:	e456                	sd	s5,8(sp)
 aa0:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 aa2:	8a4e                	mv	s4,s3
 aa4:	0009871b          	sext.w	a4,s3
 aa8:	6685                	lui	a3,0x1
 aaa:	00d77363          	bgeu	a4,a3,ab0 <malloc+0x44>
 aae:	6a05                	lui	s4,0x1
 ab0:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 ab4:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ab8:	00001917          	auipc	s2,0x1
 abc:	54890913          	addi	s2,s2,1352 # 2000 <freep>
  if(p == (char*)-1)
 ac0:	5afd                	li	s5,-1
 ac2:	a081                	j	b02 <malloc+0x96>
 ac4:	f04a                	sd	s2,32(sp)
 ac6:	e852                	sd	s4,16(sp)
 ac8:	e456                	sd	s5,8(sp)
 aca:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 acc:	00001797          	auipc	a5,0x1
 ad0:	54478793          	addi	a5,a5,1348 # 2010 <base>
 ad4:	00001717          	auipc	a4,0x1
 ad8:	52f73623          	sd	a5,1324(a4) # 2000 <freep>
 adc:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 ade:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 ae2:	b7c1                	j	aa2 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 ae4:	6398                	ld	a4,0(a5)
 ae6:	e118                	sd	a4,0(a0)
 ae8:	a8a9                	j	b42 <malloc+0xd6>
  hp->s.size = nu;
 aea:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 aee:	0541                	addi	a0,a0,16
 af0:	efbff0ef          	jal	9ea <free>
  return freep;
 af4:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 af8:	c12d                	beqz	a0,b5a <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 afa:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 afc:	4798                	lw	a4,8(a5)
 afe:	02977263          	bgeu	a4,s1,b22 <malloc+0xb6>
    if(p == freep)
 b02:	00093703          	ld	a4,0(s2)
 b06:	853e                	mv	a0,a5
 b08:	fef719e3          	bne	a4,a5,afa <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 b0c:	8552                	mv	a0,s4
 b0e:	b13ff0ef          	jal	620 <sbrk>
  if(p == (char*)-1)
 b12:	fd551ce3          	bne	a0,s5,aea <malloc+0x7e>
        return 0;
 b16:	4501                	li	a0,0
 b18:	7902                	ld	s2,32(sp)
 b1a:	6a42                	ld	s4,16(sp)
 b1c:	6aa2                	ld	s5,8(sp)
 b1e:	6b02                	ld	s6,0(sp)
 b20:	a03d                	j	b4e <malloc+0xe2>
 b22:	7902                	ld	s2,32(sp)
 b24:	6a42                	ld	s4,16(sp)
 b26:	6aa2                	ld	s5,8(sp)
 b28:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 b2a:	fae48de3          	beq	s1,a4,ae4 <malloc+0x78>
        p->s.size -= nunits;
 b2e:	4137073b          	subw	a4,a4,s3
 b32:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b34:	02071693          	slli	a3,a4,0x20
 b38:	01c6d713          	srli	a4,a3,0x1c
 b3c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b3e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b42:	00001717          	auipc	a4,0x1
 b46:	4aa73f23          	sd	a0,1214(a4) # 2000 <freep>
      return (void*)(p + 1);
 b4a:	01078513          	addi	a0,a5,16
  }
}
 b4e:	70e2                	ld	ra,56(sp)
 b50:	7442                	ld	s0,48(sp)
 b52:	74a2                	ld	s1,40(sp)
 b54:	69e2                	ld	s3,24(sp)
 b56:	6121                	addi	sp,sp,64
 b58:	8082                	ret
 b5a:	7902                	ld	s2,32(sp)
 b5c:	6a42                	ld	s4,16(sp)
 b5e:	6aa2                	ld	s5,8(sp)
 b60:	6b02                	ld	s6,0(sp)
 b62:	b7f5                	j	b4e <malloc+0xe2>
