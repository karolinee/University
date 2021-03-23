#include "kolejka.hpp"

kolejka::kolejka(): kolejka(1) {}

kolejka::kolejka(int poj): pojemnosc(poj), ile(0), poczatek(0), kol(new std::string[poj]) {}

kolejka::kolejka(std::initializer_list<std::string> lista): kolejka(lista.size())
{
    for(auto elem : lista)
    {
        wloz(elem);
    }
}

kolejka::kolejka(const kolejka& k): pojemnosc(k.pojemnosc), ile(k.ile), poczatek(k.poczatek), kol(new std::string[k.pojemnosc])
{
    for(int i = 0 ; i < pojemnosc ; i++)
    {
        kol[(poczatek + i) % pojemnosc] = k.kol[(poczatek + i) % pojemnosc];
    }
}
kolejka::kolejka(kolejka&& k): pojemnosc(k.pojemnosc), ile(k.ile), poczatek(k.poczatek), kol(k.kol)
{
    k.kol = nullptr;
}
kolejka& kolejka::operator=(const kolejka& k)
{
    if(this != &k)
    {
        this->~kolejka();
        poczatek = k.poczatek;
        pojemnosc = k.pojemnosc;
        ile = k.ile;
        kol = new std::string[k.pojemnosc];

        for(int i = 0 ; i < pojemnosc ; i++)
        {
            kol[(poczatek + i) % pojemnosc] = k.kol[(poczatek + i) % pojemnosc];
        }
    }

    return *this;
}
kolejka& kolejka::operator=(kolejka&& k)
{
    this->~kolejka();
    poczatek = k.poczatek;
    pojemnosc = k.pojemnosc;
    ile = k.ile;
    kol = k.kol;

    k.kol = nullptr;

    return *this;
}
kolejka::~kolejka()
{
    delete[] kol;
}

void kolejka::wloz(std::string s)
{
    if(ile == pojemnosc)
        throw std::string("Kolejka jest pelna, nie mozna dolozyc kolejnego elementu");

    kol[(poczatek + ile) % pojemnosc] = s;
    ile++;
}
std::string kolejka::wyciagnij()
{
    std::string s = sprawdz();

    ile--;
    poczatek = (poczatek + 1) % pojemnosc;

    return s;
}
std::string kolejka::sprawdz()
{
    if(ile == 0)
        throw std::string("Kolejka jest pusta, nie ma czego pobrac");

    return kol[poczatek];
}
int kolejka::rozmiar()
{
    return ile;
}
