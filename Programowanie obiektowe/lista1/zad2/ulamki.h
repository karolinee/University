#ifndef ULAMKI_H
#define ULAMKI_H

#include <stdlib.h>

typedef struct ulamek{
  int mianownik;
  int licznik;
} Ulamek;


Ulamek *utworz(int licznik, int mianownik);

Ulamek *dodawanie(Ulamek *x, Ulamek *y);
Ulamek *odejmowanie(Ulamek *x, Ulamek *y);
Ulamek *mnozenie(Ulamek *x, Ulamek *y);
Ulamek *dzielenie(Ulamek *x, Ulamek *y);

void dodawanie2(Ulamek *x, Ulamek *y);
void odejmowanie2(Ulamek *x, Ulamek *y);
void mnozenie2(Ulamek *x, Ulamek *y);
void dzielenie2(Ulamek *x, Ulamek *y);

#endif
