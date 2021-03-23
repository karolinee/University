#include "onp.hpp"
#include <iostream>
using namespace std;
std::stack<kalkulator::symbol*> kalkulator::symbol::stos;
double kalkulator::symbol::wynikOstateczny()
{
    if (symbol::stos.size() != 1)
    {
        while(!symbol::stos.empty())
        {
            symbol *s = stos.top();
            stos.pop();
            delete[] s;
        }
        throw std::invalid_argument("Zbyt duzo wartosci na stosie!");
    }
    double wynik = static_cast<liczba*>(symbol::stos.top())->wynik();
    stos.pop();
    return wynik;

}
kalkulator::liczba::liczba(double w): wartosc(w) {}
void kalkulator::liczba::oblicz()
{
    symbol::stos.push(this);
}
double kalkulator::liczba::wynik()
{
    return this->wartosc;
}

kalkulator::zmienna::zmienna(std::string n): nazwa(n) {}
void kalkulator::zmienna::oblicz()
{
    symbol::stos.push(this);
}
double kalkulator::zmienna::wynik()
{
    std::map<std::string, double>::iterator it;

    it = zmienne.find(nazwa);
    if (it != zmienne.end())
        return kalkulator::zmienna::zmienne[this->nazwa];
    throw std::invalid_argument("Brak takiej zmiennej!");
}
std::map<std::string, double> kalkulator::zmienna::zmienne;
void kalkulator::zmienna::wyczysc()
{
    zmienne.clear();
}
void kalkulator::zmienna::dodaj(std::string nazwa, double wartosc)
{
    std::vector<std::string> zleNazwy = {"print", "aasign", "exit", "clear", "to"};
    if (std::find(zleNazwy.begin(), zleNazwy.end(), nazwa) != zleNazwy.end() || nazwa.length() > 7)
    {
        throw std::invalid_argument("Niepoprawna nazwa zmiennej!");
    }

    zmienne[nazwa] = wartosc;
}

kalkulator::stala::stala(std::string n): nazwa(n) {}
void kalkulator::stala::oblicz()
{
    symbol::stos.push(this);
}
double kalkulator::stala::wynik()
{
    return stale[this->nazwa];
}
std::map<std::string, double> kalkulator::stala::stale = { {"pi", 3.14}, {"e", 2.71}, {"fi", 1.61}};
bool kalkulator::stala::jestStala(std::string n)
{
    std::map<std::string, double>::iterator it;

    it = stale.find(n);
    return (it != stale.end());
}

kalkulator::funkcja::funkcja(std::string n): nazwa(n) {}
void kalkulator::funkcja::oblicz()
{
    std::map<std::string, std::function<double(double)>>::iterator it;
    it = unarne.find(this->nazwa);
    if(it != unarne.end())
    {
	if(symbol::stos.size() < 1)
    	{
       	    while(!symbol::stos.empty())
            {
                symbol *s = stos.top();
                stos.pop();
                delete[] s;
            }
            throw std::invalid_argument("Zbyt mało wartości na stosie!");
    	}
        symbol *s = kalkulator::symbol::stos.top();
        double x = s->wynik();
        kalkulator::symbol::stos.pop();
        delete[] s;
        auto f = unarne[this->nazwa];
        stala::stos.push(new liczba(f(x)));
    }
    else
    {
        if(symbol::stos.size() < 2)
    	{
       	    while(!symbol::stos.empty())
            {
                symbol *s = stos.top();
                stos.pop();
                delete[] s;
            }
            throw std::invalid_argument("Zbyt mało wartości na stosie!");
    	}
        symbol *s = kalkulator::symbol::stos.top();
        double x = s->wynik();
        kalkulator::symbol::stos.pop();
        delete[] s;
        symbol *s2 = kalkulator::symbol::stos.top();
        double y = s2->wynik();
        kalkulator::symbol::stos.pop();
        delete[] s2;

        auto f = binarne[this->nazwa];
        stala::stos.push(new liczba(f(y,x)));
    }
}
std::map<std::string, std::function<double(double,double)>> kalkulator::funkcja::binarne = {
    {"+", [] (double x, double y) {return x+y;}},
    {"-", [] (double x, double y) {return x-y;}},
    {"*", [] (double x, double y) {return x*y;}},
    {"/", [] (double x, double y) {return x/y;}},
    {"modulo", [] (double x, double y) {return fmod(x,y);}},
    {"min", [] (double x, double y) {return std::min(x,y);}},
    {"max", [] (double x, double y) {return std::max(x,y);}},
    {"log", [] (double x, double y) {return log(y)/log(x);}},
    {"pow", [] (double x, double y) {return pow(x,y);}}
};
std::map<std::string, std::function<double(double)>> kalkulator::funkcja::unarne = {
    {"abs", [] (double x) {return abs(x);}},
    {"sgn", [] (double x) {return (x > 0) ? 1 : ((x < 0) ? -1 : 0);}},
    {"floor", [] (double x) {return floor(x);}},
    {"ceil", [] (double x) {return ceil(x);}},
    {"sin", [] (double x) {return sin(x);}},
    {"cos", [] (double x) {return cos(x);}},
    {"atan", [] (double x) {return atan(x);}},
    {"acot", [] (double x) {return atan(x);}},
    {"ln", [] (double x) {return log(x);}},
    {"exp", [] (double x) {return std::exp(x);}}
};

bool kalkulator::funkcja::jestFunkcja(std::string n)
{
    std::map<std::string, std::function<double(double,double)>>::iterator it;
    std::map<std::string, std::function<double(double)>>::iterator it2;

    it = binarne.find(n);
    it2 = unarne.find(n);
    return ((it != binarne.end()) || (it2 != unarne.end()));
}
