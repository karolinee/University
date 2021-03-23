#include "figury.h"

float poleKola(Figura *figura)
{
  return PI*figura->promien*figura->promien;
}
float poleKwadratu(Figura *figura)
{
  return figura->bok*figura->bok;
}
float poleTrojkata(Figura *figura)
{
  if(figura->punkt1.x==figura->punkt2.x)
    return abs(figura->punkt1.y-figura->punkt2.y)*abs(figura->punkt1.x-figura->punkt3.x);

  if(figura->punkt1.x==figura->punkt3.x)
    return abs(figura->punkt1.y-figura->punkt3.y)*abs(figura->punkt1.x-figura->punkt2.x);

  if(figura->punkt2.x==figura->punkt3.x)
    return abs(figura->punkt2.y-figura->punkt3.y)*abs(figura->punkt1.x-figura->punkt2.x);

  if(figura->punkt1.y==figura->punkt2.y)
    return abs(figura->punkt1.x-figura->punkt2.x)*abs(figura->punkt1.y-figura->punkt3.y);

  if(figura->punkt1.y==figura->punkt3.y)
    return abs(figura->punkt1.x-figura->punkt3.x)*abs(figura->punkt1.y-figura->punkt2.y);

  if(y2==figura->punkt3.y)
    return abs(figura->punkt2.x-figura->punkt3.x)*abs(figura->punkt1.y-figura->punkt2.y);
}

void przesunKolo(Figura *figura, float x, float y)
{
  figura->punkt1.x+=x;
  figura->punkt1.y+=y;
}

void przesunKwadrat(Figura *figura, float x, float y)
{
  figura->punkt1.x+=x;
  figura->punkt1.y+=y;
}

void przesunTrojkat(Figura *figura, float x, float y)
{
  figura->punkt1.x+=x;
  figura->punkt1.y+=y;
  figura->punkt2.x+=x;
  figura->punkt2.y+=y;
  figura->punkt3.x+=x;
  figura->punkt3.y+=y;
}


Figura *utworzTrojkat(float x1,float y1, float x2, float y2, float x3, float y3)
{

  if((x1==x2 && y1==y2) || (x2==x3 && y2==y3) || (x1==x3 && y1==y3) || (x1==x2 && x2==x3) || (y1==y2 && y2==y3))
  {
    printf("Zle dane!\n");
    exit(0);
  }

  Figura *nowaFigura = malloc(sizeof(Figura));

  nowaFigura->typFig = trojkat;

  nowaFigura->punkt1.x = x1;
  nowaFigura->punkt1.y = y1;
  nowaFigura->punkt2.x = x2;
  nowaFigura->punkt2.y = y2;
  nowaFigura->punkt3.x = x3;
  nowaFigura->punkt3.y = y3;

  return nowaFigura;
}
Figura *utworzKolo(int a,float x, float y)
{
  if(a <= 0)
  {
    printf("Zle dane!\n");
    exit(0);
  }

  Figura *nowaFigura = malloc(sizeof(Figura));

  nowaFigura->typFig = kolo;
  nowaFigura->promien = a;

  nowaFigura->punkt1.x = x;
  nowaFigura->punkt2.y = y;

  return nowaFigura;
}
Figura *utworzKwadrat(int a,float x, float y)
{
  if(a <= 0)
  {
    printf("Zle dane!\n");
    exit(0);
  }

  Figura *nowaFigura = malloc(sizeof(Figura));

  nowaFigura->typFig = kwadrat;

  nowaFigura->bok = a;

  nowaFigura->punkt1.x = x;
  nowaFigura->punkt2.y = y;

  return nowaFigura;
}

float pole(Figura *figura)
{
  switch(figura->typFig){
    case kolo:
      return poleKola(figura);
      break;
    case kwadrat:
      return poleKwadratu(figura);
      break;
    case trojkat:
      return poleTrojkata(figura);
      break;
    default:
      break;
  }
}
void przesun(Figura *figura, float x, float y)
{
  switch(figura->typFig){
    case kolo:
      przesunKolo(figura,x,y);
      break;
    case kwadrat:
      przesunKwadrat(figura,x,y);
      break;
    case trojkat:
      przesunTrojkat(figura,x,y);
      break;
  }
}
float sumaPol(Figura *figura, int size)
{

}
