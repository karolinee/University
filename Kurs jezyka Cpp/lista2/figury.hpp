#ifndef FIGURY_H
#define FIGURY_H

class punkt;
class odcinek;
class trojkat;
double odleglosc(punkt a, punkt b);



bool rownolegle(odcinek a, odcinek b);
bool prostopadle(odcinek a, odcinek b);
punkt przecninaja(odcinek a, odcinek b);

bool rozlaczne(trojkat t1, trojkat t2);
bool zawieranie(trojkat t1, trojkat t2);


double nachylenie(odcinek p);

class punkt
{
private:
    double x;
    double y;

public:
    punkt();
    punkt(double x, double y);
    punkt(const punkt &p);
    punkt& operator=(const punkt &p);
    bool operator==(const punkt &p);
    double getx() const  { return this->x; };
    double gety() const  { return this->y; };
    void przesun(double x, double y);
    void obroc(punkt a, double angle);

    //friend class odcinek;
    //friend class trojkat;
    //friend double odleglosc(punkt a, punkt b);
    //friend double nachylenie(odcinek p);
    //friend bool prostopadle(odcinek a, odcinek b);
    //friend punkt przecninaja(odcinek a, odcinek b);
};

class odcinek
{
private:
    punkt a;
    punkt b;

public:
    odcinek(punkt a, punkt b);
    odcinek(const odcinek &o);
    odcinek& operator=(const odcinek &o);
    void przesun(double a, double b);
    void obroc(punkt a, double angle);
    punkt geta() const  { return this->a; };
    punkt getb() const  { return this->b; };

    double dlugosc();
    bool naOdcinku(punkt c);
    punkt srodek();

    /*friend class trojkat;
    friend double nachylenie(odcinek p);
    friend bool prostopadle(odcinek a, odcinek b);
    friend punkt przecninaja(odcinek a, odcinek b);*/

};

class trojkat
{
private:
    punkt a;
    punkt b;
    punkt c;

public:
    trojkat(punkt a, punkt b, punkt c);
    trojkat(const trojkat &t);
    trojkat& operator=(const trojkat &t);
    punkt geta() const   { return this->a; };
    punkt getb() const   { return this->b; };
    punkt getc() const   { return this->c; };
    void przesun(double x, double y);
    void obroc(punkt a, double angle);

    double obwod();
    double pole();
    bool wSrodku(punkt p);
    punkt srodek();

    //friend bool rozlaczne(trojkat t1, trojkat t2);
    //friend bool zawieranie(trojkat t1, trojkat t2);
};


#endif
