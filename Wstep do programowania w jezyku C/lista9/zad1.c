#include <stdio.h>
#include <sys/stat.h>
#include <string.h>

int main(int argc, char *argv[]) {

    FILE *fmain = fopen(argv[0],"rb");

    char tmpname[strlen(argv[0])+5];
    strcpy(tmpname,argv[0]);
    strcat(tmpname,".tmp");
    FILE *ftmp = fopen(tmpname,"wb+");
    chmod(tmpname,0777);

    int ch;
    while ((ch = fgetc(fmain)) != EOF)
        fputc(ch, ftmp);

    fseek(ftmp,-2*sizeof(int),SEEK_END);

    int x = getw(ftmp);

    int iterator = 0;

    if(x == 666)
    {
        iterator = getw(ftmp);
        fseek(ftmp,-sizeof(int),SEEK_END);
        putw(iterator+1,ftmp);
    }
    else
    {
        fseek(ftmp,0,SEEK_END);
        putw(666,ftmp);
        putw(1,ftmp);
    }
    printf("%d\n",iterator+1);

    fclose(fmain);
    fclose(ftmp);
    rename(tmpname,argv[0]);
}
