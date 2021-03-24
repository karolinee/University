//Karolina Jeziorska 308220 lista 5 zad 2
#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <math.h>

int suma(int i);
int elementow(int i);

int sekwencja[30];



int main(void)
{
    int n;

    scanf("%d",&n);
    int max = 0;
    int maska_koncowa;

    for(int i = 0; i < n ; i++)
       scanf("%d", &sekwencja[i]);

    int maska;

    for(maska = (1<<n) - 1; maska > 0 ; maska--)
        if(suma(maska) == 0)
        {
            int pom1 = elementow(maska);
            if(pom1>max)
            {
                    max=pom1;
                    maska_koncowa = maska;
            }

        }


    int i = 0;

    while(maska_koncowa > 0)
    {
        if(maska_koncowa&1)
            printf("%d ",sekwencja[i]);
        maska_koncowa>>=1;
        i++;
    }

    return 0;
}

int suma(int i)
{
    int suma = 0;
    int j = 0;

    while(i > 0)
    {
        if(i&1)
            suma+=sekwencja[j];
        i>>=1;
        j++;
    }

    return suma;
}
int elementow(int i)
{
    int e = 0;

    while(i > 0)
    {
        if(i&1)
            e++;
        i>>=1;
    }

    return e;
}
