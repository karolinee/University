#include "wielomian.hpp"
#include <algorithm>
//KONSTRUKTORY
wielomian::wielomian(int st, double w)
{
    if(st < 0)
        throw std::invalid_argument("Stopien wielomianu nie moze byc ujemny!");
    if(st != 0 && w == 0)
        throw std::invalid_argument("Wspolczynnik przy najwyzszej potedze nie moze wynosic 0!");

    stopien = st;
    wsp = new double[st + 1];
    wsp[st] = w;
}
wielomian::wielomian(int st, const double w[])
{
    if(st < 0)
        throw std::invalid_argument("Stopien wielomianu nie moze byc ujemny!");
    if(w[st] == 0)
        throw std::invalid_argument("Wspolczynnik przy najwyzszej potedze nie moze wynosic 0!");

    stopien = st;
    wsp = new double[st + 1];
    for(int i = 0; i <= stopien ; i++)
    {
        wsp[i] = w[i];
    }
}
wielomian::wielomian(std::initializer_list<double> w)
{
    if(*(w.end() - 1) == 0)
        throw std::invalid_argument("Wspolczynnik przy najwyzszej potedze nie moze wynosic 0!");

    stopien = w.size()-1;
    wsp = new double[w.size()];
    int i = 0;
    for(auto iterator = w.begin(); iterator != w.end(); iterator++, i++)
    {
        wsp[i] = *iterator;
    }
}
wielomian::wielomian(const wielomian& w): stopien(w.stopien), wsp(new double[w.stopien + 1])
{
    for(int i = 0 ; i <= stopien ; i++)
    {
        wsp[i] = w.wsp[i];
    }
}
wielomian::wielomian(wielomian&& w): stopien(w.stopien), wsp(w.wsp)
{
    w.wsp = nullptr;
}
wielomian& wielomian::operator=(const wielomian& w)
{
    if(this != &w)
    {
        this->~wielomian();
        stopien = w.stopien;
        wsp = new double[stopien + 1];

        for(int i = 0 ; i <= stopien ; i++)
        {
            wsp[i] = w.wsp[i];
        }
    }

    return *this;
}
wielomian& wielomian::operator=(wielomian&& w)
{
    if(this != &w)
    {
        this->~wielomian();
        stopien = w.stopien;
        wsp = w.wsp;
        w.wsp = nullptr;
    }

    return *this;
}
//OPERACJE NA WIELOMIANACH (ZAPRZYJAZNIONE)
wielomian operator + (const wielomian &u, const wielomian &w)
{
    int stopien = std::max(u.stopien,w.stopien);

    if(u.stopien == w.stopien)
    {
        while(stopien >= 0 && u.wsp[stopien] == -w.wsp[stopien])
            stopien--;
    }

    if(stopien < 0)
        return wielomian();

    double *wsp = new double[stopien+1]();

    int i;
    for(i = 0; i <= u.stopien && i <= w.stopien && i <= stopien ; i++)
    {
        wsp[i] = u.wsp[i] + w.wsp[i];
    }

    if(u.stopien > w.stopien)
    {
        for(; i <=u.stopien && i <= stopien; i++)
        {
            wsp[i] = u.wsp[i];
        }
    }
    else if(u.stopien < w.stopien)
    {
        for(; i <=w.stopien && i <= stopien; i++)
        {
            wsp[i] = w.wsp[i];
        }
    }

    wielomian wynik = wielomian(stopien,wsp);
    delete[] wsp;

    return wynik;
}
wielomian operator - (const wielomian &u, const wielomian &w)
{
    /*int stopien = std::max(u.stopien,w.stopien);

    if(u.stopien == w.stopien)
    {
        while(stopien >= 0 && u.wsp[stopien] == w.wsp[stopien])
            stopien--;
    }

    if(stopien < 0)
        return wielomian(0,0);

    double *wsp = new double[stopien+1]();

    int i;
    for(i = 0; i <= u.stopien && i <= w.stopien && i <= stopien ; i++)
    {
        wsp[i] = u.wsp[i] - w.wsp[i];

    }
    if(u.stopien > w.stopien)
    {
        for(; i <=u.stopien && i <= stopien; i++)
        {
            wsp[i] = u.wsp[i];

        }
    }
    else if(u.stopien < w.stopien)
    {
        for(; i <=w.stopien && i <= stopien; i++)
        {
            wsp[i] = -w.wsp[i];

        }
    }

    wielomian wynik = wielomian(stopien,wsp);

    delete[] wsp;
*/
    return u+((-1)*w);
}
wielomian operator * (const wielomian &u, const wielomian &w)
{

    if(u.stopien == 0 || w.stopien == 0)
        return wielomian();

    int stopien = u.stopien + w.stopien;
    //sprawdzenie czy nie jest 0

    double *wsp = new double[stopien+1]();


    for(int i = 0; i <= u.stopien ; i++)
    {
        for(int j = 0 ; j <= w.stopien ; j++)
        {
            wsp[i+j] += u.wsp[i] * w.wsp[j];
        }
    }


    wielomian wynik = wielomian(stopien,wsp);
    delete[] wsp;

    return wynik;
}
wielomian operator * (const wielomian &u, double c)
{
    if(c == 0)
        return wielomian();

    wielomian wynik = u;

    for(int i = 0; i <= wynik.stopien ; i++)
    {
        wynik.wsp[i] *= c;
    }

    return wynik;
}
wielomian operator * (double c, const wielomian &u)
{
    return u*c;
}

//OPERACJE JEDNOARGUMENTOWE
wielomian& wielomian::operator += (const wielomian &w)
{
    return *this = std::move(*this + w);
    /*int st= std::max(this->stopien,w.stopien);

    if(this->stopien == w.stopien)
    {
        while(st >= 0 && this->wsp[st] == -w.wsp[st])
            st--;
    }

    if(st < 0)
    {
        *this = wielomian(0,0);
    }
    else
    {
        double *ws = new double[st+1]();

        int i;
        for(i = 0; i <= this->stopien && i <= w.stopien && i <= st ; i++)
        {
            ws[i] = wsp[i] + w.wsp[i];
        }
        if(this->stopien > w.stopien)
        {

            for(; i <= this->stopien && i <= st; i++)
            {

                ws[i] = this->wsp[i];
            }
        }
        else if(this->stopien < w.stopien)
        {
            for(; i <=w.stopien && i <= st; i++)
            {
                ws[i] = w.wsp[i];
            }
        }
        *this = wielomian(st,ws);
        delete[] ws;
    }
    return *this;*/
}
wielomian& wielomian::operator -= (const wielomian &w)
{
    return *this = std::move(*this - w);
    /*int st= std::max(this->stopien,w.stopien);

    if(this->stopien == w.stopien)
    {
        while(st >= 0 && this->wsp[st] == w.wsp[st])
            st--;
    }

    if(st < 0)
    {
        *this = wielomian();
    }
    else
    {
        double *ws = new double[st+1]();

        int i;
        for(i = 0; i <= this->stopien && i <= w.stopien && i <= st ; i++)
        {
            ws[i] = wsp[i] - w.wsp[i];
        }
        if(this->stopien > w.stopien)
        {

            for(; i <= this->stopien && i <= st; i++)
            {

                ws[i] = this->wsp[i];
            }
        }
        else if(this->stopien < w.stopien)
        {
            for(; i <=w.stopien && i <= st; i++)
            {
                ws[i] = -w.wsp[i];
            }
        }
        *this = wielomian(st,ws);
        delete[] ws;
    }
    return *this;*/
}
wielomian& wielomian::operator *= (const wielomian &w)
{
    return *this = std::move(*this * w);
    /*int st= this->stopien + w.stopien;
    double *ws = new double[st+1]();

    for(int i = 0 ; i <= this->stopien ; i++)
    {
        for(int j = 0 ; j<= w.stopien ; j++)
        {
            ws[i+j] += this->wsp[i] * w.wsp[j];
        }
    }

    *this = wielomian(st,ws);
    delete[] ws;

    return *this;*/
}
wielomian& wielomian::operator *= (double c)
{
    return *this = std::move(*this * c);
    /*for (int i = 0; i <= stopien; i++)
	{
        this->wsp[i] *= c;
    }
	return *this;*/
}

//LICZNENIE WARTOSCI wielomianu
double wielomian::operator () (double x) const
{
    double wynik = 0;

    for(int i = this->stopien; i >= 0 ; i--)
    {
        wynik = wynik * x + wsp[i];
    }

    return wynik;
}
//STRUMIENIE
std::istream& operator>>(std::istream &we, wielomian &w)
{
    //std::cout << "Podaj stopin wielomianu: ";
    we>>w.stopien;

	w.~wielomian();

	w.wsp = new double[w.stopien + 1];
    //std::cout << "Podaj wspolczynniki wielomianu: " << std::endl;
	for (int i = 0; i <= w.stopien; i++)
		we >> w.wsp[i];

	return we;
}
std::ostream& operator<<(std::ostream &wy, const wielomian &w)
{
    wy << w.wsp[0];

    if(w.stopien > 0)
    {
        for(int i = 1; i <= w.stopien; i++)
        {
            wy << std::showpos << w.wsp[i] << "x^" << std::noshowpos << i;
        }
    }
	return wy;
}

//INDEKSOWANIE
check wielomian::operator [] (int i)
{
    if(i > stopien || i < 0)
        throw std::invalid_argument("Bledny indeks");

    return check(&wsp[i],i,stopien);
}
const double& wielomian::operator [] (int i) const
{
    if(i > stopien || i < 0)
        throw std::invalid_argument("Bledny indeks");

    return wsp[i];
}
wielomian::~wielomian()
{
    delete[] wsp;
}

void check::operator=(const double v)
{
    if(i == s && v ==0)
        throw std::invalid_argument("Wspolczynnik przy najwyzszej potedze nie moze byc 0!");

    *d = v;
}
