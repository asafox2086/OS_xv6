#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/param.h"
int main(int argc, char *argv[])
{
    if(argc<2){
        fprintf(2,"Usage : xargs <command> [args...]\n");
        exit(0);
    }
    char *command=argv[1];
    char *new_argv[MAXARG];
    char buf[512];
    for (int i=1;i<argc;i++){
        new_argv[i-1]=argv[i];
    }
    while(1){
        int p=0;
        char c;
        int n;
        while((n=read(0,&c,1))>0){
            if(c=='\n'){
                break;
            }
            if(p+1<sizeof(buf)){
                buf[p++]=c;
            }
        }
        if(n<=0&&p==0) break;
        buf[p]='\0';
        new_argv[argc-1]=buf;
        new_argv[argc]=0;
        if(fork()==0){
            exec(command,new_argv);
            fprintf(2,"exec failed\n");
            exit(1);
        }else{
            wait(0);
        }
    }
    exit(0);
}
