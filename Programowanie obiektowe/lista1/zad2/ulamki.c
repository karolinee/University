#include "ulamki.h"

int NWD(int a, int b)
{
  while(b)
  {
    int tmp = b;
    b = a % b;
    a = tmp;
  }

  return a;
}



Ulamek *utworz(int licznik, int mianownik)
{
  Ulamek *nowyUlamek = malloc(sizeof(Ulamek));

  nowyUlamek->mianownik = mianownik;
  nowyUlamek->licznik = licznik;

  return nowyUlamek;
}


Ulamek *dodawanie(Ulamek *x, Ulamek *y)
{
  int mianownik = (x->mianownik*y->mianownik)/NWD(x->mianownik,y->mianownik);
  int licznik = ((x->licznik * mianownik)/x->mianownik) + ((y->licznik * mianownik)/y->mianownik);

  return utworz(licznik,mianownik);
}

Ulamek *odejmowanie(Ulamek *x, Ulamek *y)
{
  int mianownik = (x->mianownik*y->mianownik)/NWD(x->mianownik,y->mianownik);
  int licznik = ((x->licznik * mianownik)/x->mianownik) - ((y->licznik * mianownik)/y->mianownik);

  return utworz(licznik,mianownik);
}

Ulamek *mnozenie(Ulamek *x, Ulamek *y)
{
  int licznik = x->licznik * y->licznik;
  int mianownik = x->mianownik * y->mianownik;

  return utworz(licznik, mianownik);
}
Ulamek *dzielenie(Ulamek *x, Ulamek *y)
{
  int licznik = x->licznik * y->mianownik;
  int mianownik = x->mianownik * y->licznik;

  return utworz(licznik, mianownik);
}



void dodawanie2(Ulamek *x, Ulamek *y)
{
  int mianownik = (x->mianownik*y->mianownik)/NWD(x->mianownik,y->mianownik);
  y->licznik = ((x->licznik * mianownik)/x->mianownik) + ((y->licznik * mianownik)/y->mianownik);
  y->mianownik = mianownik;
}
void odejmowanie2(Ulamek *x, Ulamek *y)
{
  int mianownik = (x->mianownik*y->mianownik)/NWD(x->mianownik,y->mianownik);
  y->licznik = ((x->licznik * mianownik)/x->mianownik) - ((y->licznik * mianownik)/y->mianownik);
  y->mianownik = mianownik;
}
void mnozenie2(Ulamek *x, Ulamek *y)
{
  y->licznik = x->licznik * y->licznik;
  y->mianownik = x->mianownik * y->mianownik;
}
void dzielenie2(Ulamek *x, Ulamek *y)
{
  int tmp = y -> licznik;
  y->licznik = x->licznik * y->mianownik;
  y->mianownik = x->mianownik * tmp;
}
