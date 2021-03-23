#include "obliczenia.hpp"
#include <cmath>
#include <iostream>
#include <bits/stdc++.h>
#include <vector>

using namespace std;

bool jestOkresowy(int n)
{
    if(n%2 == 0 || n%5==0)
    {
        while(n%2 == 0)
            n/=2;
        while(n%5 == 0)
            n/=5;
    }

    return !(n == 1);
}

std::string make(int a, int b) noexcept
{
	std::vector<int> modulos;
	std::vector<char> numbers;
    a = abs(a);
	modulos.push_back(a = a % b);

	std::string res = std::to_string(a/b)+'.';

	while (true)
	{
	    a *= 10;

		numbers.push_back(a / b + '0');

        for(unsigned int i = 0; i < modulos.size() - 1; i++)
        {
            if(modulos[i] == modulos[modulos.size()-1])
            {
                for(unsigned int k = 0; k < numbers.size() - 1; k++)
                {
                    if(k==i)
                        res+='(';
                    res+= numbers[k];
                }
                res += ')';
                return res;
            }
        }
        modulos.push_back(a = a%b);
	}
}

std::ostream& obliczenia::operator<<(std::ostream &wy, const Wymierna &p) noexcept
{
    if(!jestOkresowy(p.mianownik))
    {
        wy << std::to_string(p.licznik / static_cast<double>(p.mianownik));
    }
    else
    {
        if(p.licznik < 0)
            wy << "-";

        wy << make(p.licznik,p.mianownik);
    }

    return wy;
}
int obliczenia::nwd(int a, int b) noexcept
{
    while(b != 0)
    {
        int t = b;
        b = a % b;
        a = t;
    }
    return a;
}
obliczenia::Wymierna::Wymierna(int licznik, int mianownik) throw(dzielenie_przez_0)
{
    if(mianownik == 0)  throw dzielenie_przez_0();

    if(mianownik < 0)
    {
        licznik *= -1;
        mianownik *= -1;
    }

    if(licznik != 0)
    {
        int dzielnik = nwd(std::abs(licznik),mianownik );

        licznik /= dzielnik;
        mianownik  /= dzielnik;
    }

    this->licznik = licznik;
    this->mianownik = mianownik ;
}

int obliczenia::Wymierna::getLicznik() noexcept
{
    return licznik;
}

int obliczenia::Wymierna::getMianownik() noexcept
{
    return mianownik;
}
obliczenia::Wymierna::operator int() noexcept
{
	return this->licznik / this->mianownik;
}
obliczenia::Wymierna::operator double() noexcept
{
	return static_cast<double>(this->licznik) / static_cast<double>(this->mianownik);
}

obliczenia::Wymierna obliczenia::operator-(const Wymierna &p) noexcept
{
    return Wymierna(-(p.licznik),p.mianownik);
}
obliczenia::Wymierna obliczenia::operator!(const Wymierna &p) throw(dzielenie_przez_0)
{
    if(p.licznik == 0)
        throw dzielenie_przez_0();

    return Wymierna(p.mianownik,p.licznik);
}

obliczenia::Wymierna obliczenia::operator+(const Wymierna &p, const Wymierna &q) throw(przekroczenie_zakresu)
{
    long long nww = static_cast<long long>(p.mianownik)* static_cast<long long>(q.mianownik) / nwd(std::abs(p.mianownik),q.mianownik);

    if(nww > INT_MAX)
        throw przekroczenie_zakresu();

    long long mnoznikPierwszy = nww / p.mianownik;
    long long mnoznikDrugi = nww / q.mianownik;

    long long nowyLicznik = mnoznikPierwszy * p.licznik + mnoznikDrugi * q.licznik;

    if(nowyLicznik > INT_MAX || nowyLicznik < INT_MIN)
        throw przekroczenie_zakresu();


    return Wymierna(static_cast<int>(nowyLicznik), static_cast<int>(nww));
}
obliczenia::Wymierna obliczenia::operator-(const Wymierna &p, const Wymierna &q) throw(przekroczenie_zakresu)
{
    return p+(-q);
}
obliczenia::Wymierna obliczenia::operator*(const Wymierna &p, const Wymierna &q) throw(przekroczenie_zakresu)
{
    long long nowyLicznik = static_cast<long long>(p.licznik) * static_cast<long long>(q.licznik);
    long long nowyMianownik = static_cast<long long>(p.mianownik) * static_cast<long long>(q.mianownik);

    if(nowyLicznik > INT_MAX || nowyLicznik < INT_MIN || nowyMianownik > INT_MAX)
        throw przekroczenie_zakresu();

    return Wymierna(static_cast<int>(nowyLicznik), static_cast<int>(nowyMianownik));
}
obliczenia::Wymierna obliczenia::operator/(const Wymierna &p, const Wymierna &q) throw(przekroczenie_zakresu, dzielenie_przez_0)
{
    return p*(!q);
}
