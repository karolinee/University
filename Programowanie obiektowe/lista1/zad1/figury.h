#ifndef FIGURY_H
#define FIGURY_H

#include <math.h>
#include <stdlib.h>
#include <stdio.h>

#define PI 3.14

enum typFigury {trojkat, kolo, kwadrat};

typedef struct punkt{
  float x;
  float y;
}Punkt;

typedef struct figura{
  int typFig;
  Punkt punkt1;
  Punkt punkt2;
  Punkt punkt3;
  float promien;
  float bok;
}Figura;


Figura *utworzTrojkat(float x1,float y1, float x2, float y2, float x3, float y3);
Figura *utworzKolo(int a,float x, float y);
Figura *utworzKwadrat(int a,float x, float y);

float pole(Figura *figura);
void przesun(Figura *figura, float x, float y);
float sumaPool(Figura *figura, int size);
#endif
