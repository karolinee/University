//Karolina Jeziorska 308220 lista 2 zad 2
#include <stdio.h>

int main(void)
{
    int a,b;
    scanf("%d %d",&a, &b);

    for(int y=-b; y <= b ; y++)
    {
        for(int x=-a ; x <= a ; x++)
        {
            if(((x+0.5)*(x+0.5))/(a*a)+((y+0.5)*(y+0.5))/(b*b) <= 1)
                putchar('#');
            else
                putchar(' ');
        }
        printf("\n");
    }

    return 0;
}
