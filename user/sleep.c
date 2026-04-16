#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char *argv[])
{
    if(argc<2){
        fprintf(2,"Wrong usage.It should be like:sleep <ticks>\n");
        exit(0);
    }
    int ticks=atoi(argv[1]);
    sleep(ticks);
    exit(0);
}
