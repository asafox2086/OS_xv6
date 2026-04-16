#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"
#include "kernel/fcntl.h"


int compare(char *a,char *b){
    int lena=strlen(a);
    int lenb=strlen(b);
    if(b[0]=='*'){
        if(b[lenb-1]=='*'){
            for(int i=0;i<lena-lenb+2;i++){
                char tmpa[512],tmpb[512];
                memmove(tmpa,a+i,lenb-2);
                memmove(tmpb,b+1,lenb-2);
                if(strcmp(tmpa,tmpb)==0){
                    return 1;
                }
            }
        }else{
            char tmpa[512],tmpb[512];
            memmove(tmpa,a+lena-lenb+1,lenb-1);
            memmove(tmpb,b+1,lenb-1);
            if(strcmp(tmpa,tmpb)==0){
                return 1;
            }
        }

    }else if(b[lenb-1]=='*'){
        char tmpa[512];
        char tmpb[512];
        memmove(tmpa,a,lenb-1);
        memmove(tmpb,b,lenb-1);
        if(strcmp(tmpa,tmpb)==0){
            return 1;
        }
    }else{
        if(strcmp(a,b)==0){
            return 1;
        }
    }
    return 0;
}
void findx(char *path,char *name){
    char buf[512], *p;
    int fd;
    struct dirent de;
    struct stat st;
    if((fd = open(path, O_RDONLY)) < 0){
        fprintf(2, "find: cannot open %s\n", path);
        return;
    }
    if(fstat(fd, &st) < 0){
        fprintf(2, "find: cannot stat %s\n", path);
        close(fd);
        return;
    }
    if(st.type!=T_DIR){
        close(fd);
        return;
    }
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
        printf("find: path too long\n");
        return;
    }   
    strcpy(buf, path);
    p = buf+strlen(buf);
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
        if( de.inum == 0)
            continue;
        if(strcmp(de.name,".")==0 ||strcmp(de.name,"..")==0){
            continue;
        }
        memmove(p, de.name, DIRSIZ);
        p[DIRSIZ] = 0;
        if(stat(buf, &st) < 0){
            printf("find: cannot stat %s\n", buf);
            continue;
        }
        if(st.type==T_FILE){
            if(compare(de.name,name)){
                printf("%s\n",buf);
            }
        }else if(st.type==T_DIR){
            findx(buf,name);
        }

    }
    close(fd);

}
int main(int argc, char *argv[])
{
    if(argc!=3){
        fprintf(2,"Usage:findx <path> <name>");
        exit(0);
    }else{
        findx(argv[1],argv[2]);
    }
    exit(0);
}
