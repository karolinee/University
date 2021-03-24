#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <math.h>

char operatory[10000];
int tab[10000];

bool czy_jeden(int i, int b);

   int n;

int main(void)
{


    scanf("%d",&n);

    for(int i = 0 ; i < n ; i++)
        scanf("%d",&tab[i]);

    if(czy_jeden(0,tab[0]))
    {
        for(int i=0; i < n - 1 ; i++)
        {
            printf(" %d %c",tab[i],operatory[i]);
            if(operatory[i] == '<' || operatory[i] == '>')
                printf("%c",operatory[i]);
        }

        printf(" %d",tab[n-1]);
    }
    else
        printf("Nie da sie");


}

bool czy_jeden(int i, int b)
{
    if(i==n-1)
    {
        return (b==1);
    }

    operatory[i]='&';
    if(czy_jeden(i+1,b&tab[i+1])) return true;

    operatory[i]='|';
    if(czy_jeden(i+1,b|tab[i+1])) return true;

    operatory[i]='^';
    if(czy_jeden(i+1,b^tab[i+1])) return true;

    operatory[i]='<';
    if(czy_jeden(i+1,b<<tab[i+1])) return true;

    operatory[i]='>';
    if(czy_jeden(i+1,b>>tab[i+1])) return true;

    return false;
}

