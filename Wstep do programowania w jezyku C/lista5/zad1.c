#include <stdio.h>
#include <stdlib.h>
#include <math.h>
    int suma[2001];
    int suma2[2001];
int main(void)
{
    int n;

    scanf("%d",&n);



    suma[1000]=1;
    for(int i = 0 ; i < n ; i++)
    {
        int a;

        scanf("%d",&a);

        for(int j = 0 ; j < 2001 ;j++)
            if(suma[j])
                suma2[j+a]=1;


        for(int j = 0 ; j < 2001 ;j++)
            suma[j] = suma[j] || suma2[j];

    }

    for(int i = 0 ; i < 2001 ; i++)
        if(suma[i])
            printf("%d ",i-1000);



    return 0;
}


