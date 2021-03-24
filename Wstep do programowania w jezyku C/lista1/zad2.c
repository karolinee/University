//Karolina Jeziorska 308220 zadanie 2 lista 1

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <stdbool.h>

int najmniejsza_reszta(int m, int n);
bool pierwsza(int p);

int main()
{
    int m1,n1;
    double max= -1.0; //bo wszystkie wartosci max beda >0

    for(int m=3; m < 1000 ; m++)
        for(int n=m+1; n <= 1000; n++)
        {
            double dzielenie = najmniejsza_reszta(m,n)/log(n);
            if(dzielenie>max)
            {
                max=dzielenie;
                n1=n;
                m1=m;
            }
        }

    printf("%i, %i",m1,n1);


    return 0;
}

bool pierwsza(int p)
{
    for(int i=2 ; i<=sqrt(p) ; i++)
        if(p%i==0)
            return false;

    return true;
}

int najmniejsza_reszta(int m, int n)
{
    for(int i=2; i < n ; i++)
        if(pierwsza(i))
            if(m%i!=n%i)
                return i;

    return 0;
}
