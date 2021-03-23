#include <stdio.h>
#include "figury.h"

int main()
{
  Figura *figura;
  figura = utworzKolo(5,0,0);

  float suma = pole(figura);
  printf("%f\n",suma);
  przesun(figura,2,-5.6);
  printf("%f %f\n",figura->punkt1.x,figura->punkt1.y);

  figura = utworzKwadrat(5,0,0);
  suma = pole(figura);
  printf("%f\n",suma);
  przesun(figura,2,-5.6);
  printf("%f %f\n",figura->punkt1.x,figura->punkt1.y);

  figura = utworzTrojkat(0,0,4,0,0,6);

  suma = pole(figura);
  printf("%f\n",suma);

  przesun(figura,2,-5.6);
  printf("%f %f, %f %f, %f %f\n",figura->punkt1.x,figura->punkt1.y,figura->punkt2.x,figura->punkt2.y,figura->punkt3.x,figura->punkt3.y);
}
