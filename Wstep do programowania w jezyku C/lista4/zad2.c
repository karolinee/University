//Karolina Jeziorska 308220 Lista 4 zad 2
#include <stdio.h>
#include <stdlib.h>
#include <math.h>


#define PROMIEN 10
#define PI 3.14159265



int main(void)
{

    int godz, min;

    scanf("%d %d",&godz ,&min);

    double x_godzina = sin((90-godz*30)* PI / 180);
    double y_godzina = cos((90-godz*30)* PI / 180);

    int pom1g = y_godzina < 0 ? -1 : 1;
    int pom2g = x_godzina < 0 ? -1 : 1;

    double x_min = sin((90-min*6)* PI / 180);
    double y_min = cos((90-min*6)* PI / 180);

    int pom1min = y_min < 0 ? -1 : 1;
    int pom2min = x_min < 0 ? -1 : 1;




    for(int y=PROMIEN; y > -PROMIEN ; y--)
    {
        for(int x=-PROMIEN; x < PROMIEN ; x++)
        {
            if(((x+0.5)*(x+0.5))+((y+0.5)*(y+0.5)) <= PROMIEN * PROMIEN)
            {


                    if(round(x*x_godzina) == round(y*y_godzina) && x*pom1g >= 0 && y*pom2g >= 0 && x*pom1g <5 && y*pom2g <5) putchar('g');
                    else if(round(x*x_min) == round(y*y_min) && x*pom1min >=0 && y*pom2min >=0) putchar('m');
                    else putchar('.');

            }
            else
                putchar(' ');


        }
        putchar('\n');
    }




    return 0;
}


