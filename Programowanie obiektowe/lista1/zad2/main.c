#include <stdio.h>
#include "ulamki.h"

int main()
{
  int licznik, mianownik;

  printf("Podaj licznik 1 ulamka ");
  scanf("%d",&licznik);
  printf("Podaj mianownik 1 ulamka ");
  scanf("%d",&mianownik);
  Ulamek *a = utworz(licznik,mianownik);

  printf("Podaj licznik 2 ulamka ");
  scanf("%d",&licznik);
  printf("Podaj mianownik 2 ulamka ");
  scanf("%d",&mianownik);
  Ulamek *b = utworz(licznik,mianownik);

  Ulamek *wynik;

  wynik = mnozenie(a,b);
  printf("%d/%d * %d/%d = %d/%d\n",a->licznik,a->mianownik,b->licznik,b->mianownik,wynik->licznik,wynik->mianownik);

  wynik = dzielenie(a,b);
  printf("%d/%d / %d/%d = %d/%d\n",a->licznik,a->mianownik,b->licznik,b->mianownik,wynik->licznik,wynik->mianownik);

  wynik = dodawanie(a,b);
  printf("%d/%d + %d/%d = %d/%d\n",a->licznik,a->mianownik,b->licznik,b->mianownik,wynik->licznik,wynik->mianownik);

  wynik = odejmowanie(a,b);
  printf("%d/%d - %d/%d = %d/%d\n\n",a->licznik,a->mianownik,b->licznik,b->mianownik,wynik->licznik,wynik->mianownik);


  Ulamek *tmp = utworz(b->licznik,b->mianownik);
  mnozenie2(a,tmp);
  printf("%d/%d * %d/%d = %d/%d\n",a->licznik,a->mianownik,b->licznik,b->mianownik,tmp->licznik,tmp->mianownik);

  tmp->licznik = b->licznik;
  tmp->mianownik = b->mianownik;
  dzielenie2(a,tmp);
  printf("%d/%d / %d/%d = %d/%d\n",a->licznik,a->mianownik,b->licznik,b->mianownik,tmp->licznik,tmp->mianownik);

  tmp->licznik = b->licznik;
  tmp->mianownik = b->mianownik;
  dodawanie2(a,tmp);
  printf("%d/%d + %d/%d = %d/%d\n",a->licznik,a->mianownik,b->licznik,b->mianownik,tmp->licznik,tmp->mianownik);

  tmp->licznik = b->licznik;
  tmp->mianownik = b->mianownik;
  odejmowanie2(a,tmp);
  printf("%d/%d - %d/%d = %d/%d\n",a->licznik,a->mianownik,b->licznik,b->mianownik,tmp->licznik,tmp->mianownik);


  return 0;
}
