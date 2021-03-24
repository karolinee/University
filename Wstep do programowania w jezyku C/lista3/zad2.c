#include <stdio.h>
#include <ctype.h>
#include <math.h>

#define PASEK 10

int main(void)
{
    int c;
    int tab[128]={0};
    double d=0.0;

    while((c=getchar())!='\n')
        if(isgraph(c))
        {
            tab[c]++;
            d++;
        }


    for(int i=33 ; i < 128 ; i++)
        if(tab[i]>0)
        {
            printf("%c %.0f\% \% ", i , round((tab[i]/d)*100));
            for(int j=0 ; j < round((tab[i]/d)*PASEK) ; j++)
                putchar('*');
            putchar('\n');
        }



    return 0;

}

