#include "wyrazenia.hpp"
//liczba

liczba::liczba(double w): wartosc(w) {}
double liczba::oblicz()
{
    return wartosc;
}
std::string liczba::opis()
{
    return std::to_string(wartosc);
}
int liczba::getPriorytet() { return 3; }
int liczba::getPrzemienny() { return 1; }

//zmienna
std::vector<std::pair<std::string,double>> zmienna::zmienne;
zmienna::zmienna(std::string n): nazwa(n) {}
int zmienna::getPriorytet() { return 3; }
int zmienna::getPrzemienny() { return 1; }
void zmienna::dodaj_zmienna(std::string n, double w)
{
    zmienne.push_back(make_pair(n,w));
}
void zmienna::zmien_zmienna(std::string n, double w)
{
    bool f = false;
    for (auto itr = zmienne.begin(); itr != zmienne.end(); itr++)
    {
        if(n == (*itr).first)
        {
            (*itr).second = w;
            f = true;
        }
    }

    if(!f)
        throw std::invalid_argument("brak takiej zmiennej");
}

double zmienna::oblicz()
{
    for (auto itr = zmienne.begin(); itr != zmienne.end(); itr++)
    {
        if(nazwa == (*itr).first)
            return (*itr).second;
    }

    throw std::invalid_argument("brak takiej zmiennej");
}
std::string zmienna::opis()
{
    return  nazwa;
}
//stala
stala::stala(std::string n, double w): nazwa(n), wartosc(w) {}
double stala::oblicz()
{
    return wartosc;
}
std::string stala::opis()
{
    return nazwa;
}
int stala::getPriorytet() { return 3; }
int stala::getPrzemienny() { return 1; }

int unarne::getPriorytet(){return 3;}
int unarne::getPrzemienny() {return 1;}
//sin
sinus::sinus(wyrazenie *l): unarne(l) {}
double sinus::oblicz()
{
    return sin(lewe->oblicz());
}
std::string sinus::opis()
{
    return "sin(" + lewe->opis() + ")";
}

//cos
cosinus::cosinus(wyrazenie *l): unarne(l) {}
double cosinus::oblicz()
{
    return cos(lewe->oblicz());
}
std::string cosinus::opis()
{
    return "cos(" + lewe->opis() + ")";
}


//logarytm
logarytm::logarytm(wyrazenie *l): unarne(l) {}
double logarytm::oblicz()
{
    return log(lewe->oblicz());
}
std::string logarytm::opis()
{
    return "log(" + lewe->opis() + ")";
}

bezwzgledna::bezwzgledna(wyrazenie *l): unarne(l) {}
double bezwzgledna::oblicz()
{
    return abs(lewe->oblicz());
}
std::string bezwzgledna::opis()
{
    return "|" + lewe->opis() + "|";
}

przeciwna::przeciwna(wyrazenie *l): unarne(l) {}
double przeciwna::oblicz()
{
    return -lewe->oblicz();
}
std::string przeciwna::opis()
{
    return "-(" + lewe->opis() + ")";
}

odwrotna::odwrotna(wyrazenie *l): unarne(l) {}
double odwrotna::oblicz()
{
    double w = lewe->oblicz();

    if( w == 0 )
        throw std::invalid_argument("dzielenie przez 0!");

    return 1/w;
}
std::string odwrotna::opis()
{
    return "1/("+ lewe->opis() + ")";
}

/**********************************
BINARNE
***********************************/
int binarne::getPriorytet() {return priorytet;}
int binarne::getPrzemienny() {return przemienny;}
std::string binarne::opis()
{
    std::string opis;

    if(lewe->getPriorytet() < this->getPriorytet())
        opis = "(" + (lewe->opis()) + ")";
    else
        opis = lewe->opis();


    if(prawe->getPriorytet() < this->getPriorytet() || (!this->getPrzemienny() && this->getPriorytet() == prawe->getPriorytet()))
        opis += op + "(" + (prawe->opis()) + ")";
    else
        opis += op + prawe->opis();

    return opis;
}
//dodawanie
dodawanie::dodawanie(wyrazenie *l, wyrazenie *p): binarne(l,p,"+",1,1) {}
double dodawanie::oblicz()
{
    return lewe->oblicz() + prawe->oblicz();
}

odejmowanie::odejmowanie(wyrazenie *l, wyrazenie *p): binarne(l,p,"-",1,0) {}
double odejmowanie::oblicz()
{
    return lewe->oblicz() - prawe->oblicz();
}


mnozenie::mnozenie(wyrazenie *l, wyrazenie *p): binarne(l,p,"*",2,1) {}
double mnozenie::oblicz()
{
    return lewe->oblicz() * prawe->oblicz();
}



dzielenie::dzielenie(wyrazenie *l, wyrazenie *p): binarne(l,p,"/",2,0) {}
double dzielenie::oblicz()
{
    double mianownik = prawe->oblicz();

    if(mianownik == 0)
        throw std::invalid_argument("dzielenie przez 0!");

    return lewe->oblicz() / mianownik;
}



modulo::modulo(wyrazenie *l, wyrazenie *p): binarne(l,p,"%",2,0) {}
double modulo::oblicz()
{
    return std::fmod(lewe->oblicz(),prawe->oblicz());
}

potega::potega(wyrazenie *l, wyrazenie *p): binarne(l,p,"^",3,0) {}
double potega::oblicz()
{
    return pow(lewe->oblicz(),prawe->oblicz());
}
