#ifndef KOLEJKA_H
#define KOLEJKA_H

#include <utility>
#include <iostream>

class kolejka
{
private:
    int pojemnosc;
    int ile;
    int poczatek;
    std::string *kol;

public:
    kolejka();
    kolejka(int poj);
    kolejka(std::initializer_list<std::string> lista);
    kolejka(const kolejka& k);
    kolejka(kolejka&& k);
    kolejka& operator=(const kolejka& k);
    kolejka& operator=(kolejka&& k);
    ~kolejka();

    void wloz(std::string s);
    std::string wyciagnij();
    std::string sprawdz();
    int rozmiar();
};
#endif
