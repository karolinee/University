#ifndef WYRAZENIA_HPP
#define WYRAZENIA_HPP

#include <iostream>
#include <string>
#include <utility>
#include <vector>
#include <algorithm>
#include <cmath>


class wyrazenie
{

public:
    wyrazenie() = default;
    virtual double oblicz() = 0;
    virtual std::string opis() = 0;
    virtual int getPriorytet() = 0;
    virtual int getPrzemienny() = 0;
};


//OPERANDY
class liczba: public wyrazenie
{
private:
    double wartosc;
public:
    liczba(double w);
    double oblicz() override;
	std::string opis() override;
    int getPriorytet() override;
    int getPrzemienny() override;
};

class zmienna: public wyrazenie
{
private:
    static std::vector<std::pair<std::string,double>> zmienne;
    std::string nazwa;
public:
    zmienna(std::string n);
    double oblicz() override;
	std::string opis() override;
    int getPriorytet() override;
    int getPrzemienny() override;

    static void dodaj_zmienna(std::string n, double w);
    static void zmien_zmienna(std::string n, double w);
};

class stala: public wyrazenie
{
private:
    std::string nazwa;
    double wartosc;
public:
    stala(std::string n, double w);
    double oblicz() override;
	std::string opis() override;
    int getPriorytet() override;
    int getPrzemienny() override;
};

//STAŁE DZIEDZICZĄCE PO CLASS stala

class pi: public stala
{
public:
    pi(): stala("pi",3.14) {}
};

class e: public stala
{
public:
    e(): stala("e",2.71) {}
};

class stalaEulera: public stala
{
public:
    stalaEulera(): stala("stala Eulera",0.57) {}
};

class zlotyPodzial: public stala
{
public:
    zlotyPodzial(): stala("zloty podzial",1.61) {}
};

//OPERATORY
class unarne: public wyrazenie
{
protected:
    wyrazenie *lewe;
public:
    unarne(wyrazenie *l): lewe(l) {}
    int getPriorytet() override;
    int getPrzemienny() override;
};

class sinus: public unarne
{
public:
    sinus(wyrazenie *l);
    double oblicz() override;
	std::string opis() override;
};
class cosinus: public unarne
{
public:
    cosinus(wyrazenie *l);
    double oblicz() override;
	std::string opis() override;
};
class logarytm: public unarne
{
public:
    logarytm(wyrazenie *l);
    double oblicz() override;
	std::string opis() override;
};

class bezwzgledna: public unarne
{
public:
    bezwzgledna(wyrazenie *l);
    double oblicz() override;
    std::string opis() override;
};
class przeciwna: public unarne
{
public:
    przeciwna(wyrazenie *l);
    double oblicz() override;
    std::string opis() override;
};
class odwrotna: public unarne
{
public:
    odwrotna(wyrazenie *l);
    double oblicz() override;
    std::string opis() override;
};

class binarne: public unarne
{
protected:
    wyrazenie *prawe;
    std::string op;
    int priorytet;
    int przemienny;
public:
    binarne(wyrazenie *l, wyrazenie *p, std::string opr, int pr, int przem): unarne(l), prawe(p), op(opr), priorytet(pr), przemienny(przem) {}

	std::string opis() override;
    int getPriorytet() override;
    int getPrzemienny() override;
};

class dodawanie: public binarne
{
public:
    dodawanie(wyrazenie *l, wyrazenie *p);
    double oblicz() override;
};
class odejmowanie: public binarne
{
public:
    odejmowanie(wyrazenie *l, wyrazenie *p);
    double oblicz() override;
};
class mnozenie: public binarne
{
public:
    mnozenie(wyrazenie *l, wyrazenie *p);
    double oblicz() override;
};
class dzielenie: public binarne
{
public:
    dzielenie(wyrazenie *l, wyrazenie *p);
    double oblicz() override;
};


class modulo: public binarne
{
public:
    modulo(wyrazenie *l, wyrazenie *p);
    double oblicz() override;
};

class potega: public binarne
{
public:
    potega(wyrazenie *l, wyrazenie *p);
    double oblicz() override;
};

#endif
