#include <iostream>
#include <cmath>
#include <algorithm>
#include <limits>
#include "figury.hpp"

/******************************
    METODY PUNKTU
******************************/
punkt::punkt()
{
    this->x = 0;
    this->y = 0;
}
punkt::punkt(double x, double y)
{
    this->x = x;
    this->y = y;
}
punkt::punkt(const punkt &p)
{
    this->x = p.x;
    this->y = p.y;
}
punkt& punkt::operator=(const punkt &p)
{
    if(this == &p)
        return *this;

    this->~punkt();
    this->x = p.x;
    this->y = p.y;

    return *this;
}

bool punkt::operator==(const punkt &p)
{
    if(this->x == p.x && this->y == p.y)
        return true;

    return false;
}
void punkt::przesun(double x, double y)
{
    this->x += x;
    this->y += y;
}
void punkt::obroc(punkt a, double angle)
{
    double s = sin(angle * M_PI / 180.0);
    double c = cos(angle * M_PI / 180.0);

    double xnew = (this->x - a.getx()) * c - (this->y - a.gety()) * s + a.getx();
    double ynew = (this->x - a.getx()) * s + (this->y - a.gety()) * c + a.gety();

    this->x = xnew;
    this->y = ynew;
}


/******************************
    METODY ODCINKA
******************************/
odcinek::odcinek(punkt a, punkt b)
{
    if(a == b)
        throw std::invalid_argument("nie mozna utworzyc odcinka o dlugosci 0");
    this->a = a;
    this->b = b;
}
odcinek::odcinek(const odcinek &o)
{
    this->a = o.a;
    this->b = o.b;
}
odcinek& odcinek::operator=(const odcinek &o)
{
    if(this == &o)
        return *this;

    this->~odcinek();
    this->a = o.a;
    this->b = o.b;

    return *this;
}

void odcinek::przesun(double x, double y)
{
    this->a.przesun(x,y);
    this->b.przesun(x,y);
}
void odcinek::obroc(punkt a, double angle)
{
    this->a.obroc(a,angle);
    this->b.obroc(a,angle);
}

double odcinek::dlugosc()
{
    return odleglosc(this->a,this->b);
}
bool odcinek::naOdcinku(punkt c)
{
    double a1 = nachylenie(*this);
    if(a1 == INFINITY)
    {

        if(c.getx() == a.getx() && c.gety() >= std::min(this->a.gety(),this->b.gety()) && c.gety() <= std::max(this->a.gety(),this->b.gety()))
            return true;

        return false;
    }

    double b1 = this->a.gety() - a1*this->a.getx();
    double cy = a1*c.getx() + b1;
    if(((c.gety() - cy) < std::numeric_limits<double>::epsilon() && (cy - c.gety()) < std::numeric_limits<double>::epsilon())
        && c.gety() >= std::min(this->a.gety(),this->b.gety()) && c.gety() <= std::max(this->a.gety(),this->b.gety()))
        return true;


    return false;

}
punkt odcinek::srodek()
{
    return punkt((this->a.getx() + this->b.getx())/2, (this->a.gety() + this->b.gety())/2);
}
/******************************
    METODY TROJKATA
******************************/
trojkat::trojkat(punkt a, punkt b, punkt c)
{
    if(a == b || b == c || c == a)
        throw std::invalid_argument("nie mozna utworzyc takiego trojkata");

    if(a.getx() == b.getx() && b.getx() == c.getx())
        throw std::invalid_argument("nie mozna utworzyc takiego trojkata");

    odcinek o = odcinek(a,b);
    double a1 = nachylenie(o);
    double b1 = a.gety() - a1*a.getx();
    double cy = a1*c.getx() + b1;

    if((c.gety() - cy) < std::numeric_limits<double>::epsilon() && (cy - c.gety()) < std::numeric_limits<double>::epsilon())
        throw std::invalid_argument("nie mozna utworzyc takiego trojkata");



    this->a = a;
    this->b = b;
    this->c = c;
}
trojkat::trojkat(const trojkat &t)
{
    this->a = t.a;
    this->b = t.b;
    this->c = t.c;
}
trojkat& trojkat::operator=(const trojkat &t)
{
    if(this == &t)
        return *this;

    this->~trojkat();
    this->a = t.a;
    this->b = t.b;
    this->c = t.c;

    return *this;
}
void trojkat::przesun(double x, double y)
{
    this->a.przesun(x,y);
    this->b.przesun(x,y);
    this->c.przesun(x,y);
}
void trojkat::obroc(punkt a, double angle)
{
    this->a.obroc(a,angle);
    this->b.obroc(a,angle);
    this->c.obroc(a,angle);
}


double trojkat::obwod()
{
    return (odleglosc(this->a,this->b) + odleglosc(this->b,this->c) + odleglosc(this->c,this->a));
}
double trojkat::pole()
{
    double p = obwod()/2;
    double pole = sqrt(p*(p-odleglosc(this->a,this->b))*(p-odleglosc(this->b,this->c))*(p-odleglosc(this->c,this->a)));

    return pole;
}
/*bool trojkat::wSrodku(punkt p)
{

    odcinek o1 = odcinek(this->a,this->b);
    odcinek o2 = odcinek(this->c,this->a);
    odcinek o3 = odcinek(this->b,this->c);

    if(o1.naOdcinku(p) || o2.naOdcinku(p) || o3.naOdcinku(p))
        return true;


    double a1 = nachylenie(o1);
    double b1 = this->a.gety() - a1*this->a.getx();
    double py = a1*p.getx() + b1;
    if((p.gety() - py) < std::numeric_limits<double>::epsilon() && (py - p.gety()) < std::numeric_limits<double>::epsilon())
        return false;

    a1 = nachylenie(o2);
    b1 = c.gety() - a1*c.getx();
    py = a1*p.getx() + b1;
    if((p.gety() - py) < std::numeric_limits<double>::epsilon() && (py - p.gety()) < std::numeric_limits<double>::epsilon())
        return false;

    a1 = nachylenie(o3);
    b1 = b.gety() - a1*b.getx();
    py = a1*p.getx() + b1;
    if((p.gety() - py) < std::numeric_limits<double>::epsilon() && (py - p.gety()) < std::numeric_limits<double>::epsilon())
        return false;

    trojkat t1 = trojkat(this->a,this->b,p);
    trojkat t2 = trojkat(this->b,this->c,p);
    trojkat t3 = trojkat(this->c,this->a,p);

    if((pole() - t1.pole() + t2.pole() + t3.pole()) < std::numeric_limits<double>::epsilon())
        return true;

    return false;
}*/
float sign (punkt p1, punkt p2, punkt p3)
{
    return (p1.getx() - p3.getx()) * (p2.gety() - p3.gety()) - (p2.getx() - p3.getx()) * (p1.gety() - p3.gety());
}

bool trojkat::wSrodku(punkt p)
{
    float d1, d2, d3;
    bool has_neg, has_pos;

    d1 = sign(p, this->a, this->b);
    d2 = sign(p, this->b, this->c);
    d3 = sign(p, this->c, this->a);

    has_neg = (d1 < 0) || (d2 < 0) || (d3 < 0);
    has_pos = (d1 > 0) || (d2 > 0) || (d3 > 0);

    return !(has_neg && has_pos);
}
punkt trojkat::srodek()
{
    odcinek ab = odcinek(this->a,this->b);
    odcinek bc = odcinek(this->b,this->c);
    //odcinek ca = odcinek(this->c,this->a);

    odcinek srodkowa1 = odcinek(ab.srodek(),this->c);
    odcinek srodkowa2 = odcinek(bc.srodek(),this->a);

    return przecninaja(srodkowa1,srodkowa2);
}

/******************************
    FUNKCJE GLOBALNE
******************************/
double odleglosc(punkt a, punkt b)
{
    return sqrt(pow((b.getx() - a.getx()),2) + pow((b.gety() - a.gety()),2));
}

double nachylenie(odcinek p)
{
    if((p.getb().getx() - p.geta().getx()) == 0 ) return INFINITY;

    return ((p.getb().gety() - p.geta().gety())/(p.getb().getx() - p.geta().getx()));
}
bool rownolegle(odcinek a, odcinek b)
{
    if(nachylenie(a) == nachylenie(b)) return true;

    return false;
}
bool prostopadle(odcinek a, odcinek b)
{
    if(nachylenie(a) == INFINITY && (b.geta().gety() - b.getb().gety()) == 0)
        return true;

    if(nachylenie(b) == INFINITY && (a.geta().gety() - a.getb().gety()) == 0)
        return true;

    if(nachylenie(a) * nachylenie(b) == -1)
        return true;

    return false;
}
punkt przecninaja(odcinek a, odcinek b)
{
    //algorytm odrzuca możliwośc nakladania się
    //odniki pionowe
    if(rownolegle(a,b)) throw std::invalid_argument("brak punktu przeciecia");

    double a1 = nachylenie(a);
    double a2 = nachylenie(b);

    if(a1 == INFINITY)
    {
        double b2 = b.geta().gety() - a2*b.geta().getx();

        double x0 = a.geta().getx();
        double y0 = a2*x0 + b2;

        punkt p = punkt(x0,y0);

        if(a.naOdcinku(p))
        {
            return p;
        }

        throw std::invalid_argument("brak punktu przeciecia");
    }

    if(a2 == INFINITY)
    {
        double b1 = a.geta().gety() - a1*a.geta().getx();

        double x0 = b.geta().getx();
        double y0 = a1*x0 + b1;

        punkt p = punkt(x0,y0);

        if(a.naOdcinku(p))
        {
            return p;
        }

        throw std::invalid_argument("brak punktu przeciecia");
    }

    double b1 = a.geta().gety() - a1*a.geta().getx();
    double b2 = b.geta().gety() - a2*b.geta().getx();

    double x0 = (b2 - b1)/(a1 - a2);
    double y0 = a1*x0 + b1;

    punkt p = punkt(x0,y0);

    if(a.naOdcinku(p))
    {
        return p;
    }

    throw std::invalid_argument("brak punktu przeciecia");
}

bool rozlaczne(trojkat t1, trojkat t2)
{
    if(t1.wSrodku(t2.geta()) || t1.wSrodku(t2.getb()) || t1.wSrodku(t2.getc()) )
        return false;

    if(t2.wSrodku(t1.geta()) || t2.wSrodku(t1.getb()) || t2.wSrodku(t1.getc()) )
        return false;

    return true;

}
bool zawieranie(trojkat t1, trojkat t2)
{
    if(t1.wSrodku(t2.geta()) && t1.wSrodku(t2.getb()) && t1.wSrodku(t2.getc()) )
        return true;

    if(t2.wSrodku(t1.geta()) && t2.wSrodku(t1.getb()) && t2.wSrodku(t1.getc()) )
        return true;

    return false;
}
