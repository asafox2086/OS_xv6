/*
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"
#include "kernel/fcntl.h"
void find(char *path,char *name){
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
        close(fd);
        return;
    }   
    strcpy(buf, path);
    p = buf+strlen(buf);
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
        if( de.inum == 0)
            continue;
        memmove(p, de.name, DIRSIZ);
        p[DIRSIZ] = 0;
        if(strcmp(p,".")==0 ||strcmp(p,"..")==0){
            continue;
        }
        
        if(stat(buf, &st) < 0){
            printf("find: cannot stat %s\n", buf);
            continue;
        }
        if(st.type==T_FILE){
            if(strcmp(p,name)==0){
                printf("%s\n",buf);
            }
        }else if(st.type==T_DIR){
            find(buf,name);
        }

    }
    close(fd);

}
int main(int argc, char *argv[])
{
    if(argc!=3){
        fprintf(2,"Usage:find <path> <name>\n");
        exit(0);
    }else{
        find(argv[1],argv[2]);
    }
    exit(0);
}
*/

#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"


void find_file(const char* dirpath, const char* filename) {
    int fd = open(dirpath, 0);
    if (fd < 0) {
        fprintf(2, "can't open %s\n", dirpath);
        exit(1);
    }
    
    struct dirent de;
    
    char buf[512], *p;
    if (strlen(dirpath) + 1 + DIRSIZ + 1 > sizeof(buf)) {
        fprintf(2, "find: path too long\n");
        exit(1);
    }
    strcpy(buf, dirpath);
    p = buf + strlen(buf);
    *p++ = '/';

    while (read(fd, &de, sizeof(de)) == sizeof(de)) {
        if (de.inum == 0 || strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0) {
            continue;
        }

        memmove(p, de.name, DIRSIZ);
        p[DIRSIZ] = 0;
        struct stat st;
        if (stat(buf, &st) < 0) {
            printf("cannot stat %s\n", buf);
            continue;
        }
        switch (st.type) {
            case T_DEVICE:
            case T_FILE:
                if (strcmp(de.name, filename) == 0) {
                    printf("%s\n", buf);
                }
                break;
            case T_DIR:
                find_file(buf, filename);
                break;
        }
    }
    close(fd);
}


int main(int argc, char* argv[]) {
    if (argc != 3) {
        fprintf(2, "Usage: find directory filename\n");
        exit(1);
    }

    find_file(argv[1], argv[2]);
    exit(0);
}