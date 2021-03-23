#include <iostream>
#include "wyrazenia.hpp"


using namespace std;
int main()
{
    wyrazenie *w1 = new dzielenie(
        new mnozenie(
            new odejmowanie(new zmienna("x"), new liczba(1)),
            new zmienna("x")),new liczba(2));

    cout<< w1->opis() <<endl;
    wyrazenie *w2 = new dzielenie(
        new dodawanie(new liczba(3),
                      new liczba(5)),new dodawanie(new liczba(2),new mnozenie(new zmienna ("x"), new liczba(7))));

    cout<< w2->opis() << endl;
//2+x*7-(y*3+5)
    wyrazenie *w3 = new odejmowanie(
                                new dodawanie(new liczba(2),
                                        new mnozenie(new zmienna("x"),new liczba(7))),
                                new dodawanie(new mnozenie(new zmienna("y"),new liczba(3)),new liczba(5)));

    cout<< w3->opis() <<endl;
//cos((x+1)*x)/e^x^2
    wyrazenie *w4 = new dzielenie(
                            new cosinus(
                                new mnozenie(
                                    new dodawanie(new zmienna("x"),new liczba(1)),
                                    new zmienna("x"))),
                            new potega(new e(),(new potega(new zmienna("x"),new liczba(2)))));

    cout<< w4->opis() <<endl;
    zmienna::dodaj_zmienna("x",0);
    for(double i= 0.1; i < 1; i+=0.1)
    {
        zmienna::zmien_zmienna("x",i);
        cout<< w2->oblicz() <<endl;
    }
}
