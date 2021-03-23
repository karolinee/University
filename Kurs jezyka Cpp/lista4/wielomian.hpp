#ifndef WIELOMIAN_H
#define WIELOMIAN_H

#include <utility>
#include <iostream>

class check
{
    double *d;
    int i;
    int s;

public:
    check(double *dd, int ii, int ss): d(dd), i(ii), s(ss){}
    operator double() const{ return *d; }
    void operator=(const double v);
};
class wielomian
{
private:
    int stopien;
    double *wsp;


public:
    wielomian(int st=0, double wsp=0.0);
    wielomian(int st, const double wsp[]);
    wielomian(std::initializer_list<double> wsp);
    wielomian(const wielomian& w);
    wielomian(wielomian&& w);
    wielomian& operator=(const wielomian& w);
    wielomian& operator=(wielomian&& w);
    ~wielomian();

    int get_stopien(){ return stopien; }

    wielomian& operator += (const wielomian &w);
    wielomian& operator -= (const wielomian &w);
    wielomian& operator *= (const wielomian &w);
    wielomian& operator *= (double c);
    double operator () (double x) const;
    const double& operator [] (int i) const;
    check operator [] (int i);

    friend wielomian operator + (const wielomian &u, const wielomian &w);
    friend wielomian operator - (const wielomian &u, const wielomian &w);
    friend wielomian operator * (const wielomian &u, const wielomian &w);
    friend wielomian operator * (const wielomian &u, double c);
    friend wielomian operator * (double c, const wielomian &u);
    friend std::istream& operator>>(std::istream &we, wielomian &w);
    friend std::ostream& operator<<(std::ostream &wy, const wielomian &w);
};


#endif
