#ifndef OBLICZENIA_HPP
#define OBLICZENIA_HPP

#include <exception>
#include <iostream>

namespace obliczenia
{
    class Wymierna;
    class wyjatek_wymierny: public std::exception
    {
    public:
        virtual const char* what() const noexcept
        {
            return "Wyjatek liczb wymiernych!";
        }
    };
    class dzielenie_przez_0: public wyjatek_wymierny
    {
    public:
        virtual const char* what() const noexcept
        {
            return "Dzielenie przez 0!";
        }
    };
    class przekroczenie_zakresu: public wyjatek_wymierny
    {
    public:
        virtual const char* what() const noexcept
        {
            return "Przekroczenie zakresu!";
        }
    };



    int nwd(int a, int b) noexcept;
    Wymierna operator+(const Wymierna &p, const Wymierna &q) throw(przekroczenie_zakresu);
    Wymierna operator-(const Wymierna &p, const Wymierna &q) throw(przekroczenie_zakresu);
    Wymierna operator*(const Wymierna &p, const Wymierna &q) throw(przekroczenie_zakresu);
    Wymierna operator/(const Wymierna &p, const Wymierna &q) throw(przekroczenie_zakresu, dzielenie_przez_0);
    std::ostream& operator<<(std::ostream &wy, const Wymierna &p) noexcept;
    Wymierna operator-(const Wymierna &p) noexcept;
    Wymierna operator!(const Wymierna &p) throw(dzielenie_przez_0);

    class Wymierna
    {
    private:
        int licznik, mianownik;


    public:
        Wymierna(int licznik, int mianownik = 1) throw(dzielenie_przez_0);
        int getLicznik() noexcept;
        int getMianownik() noexcept;

        explicit operator int() noexcept;
		explicit operator double() noexcept;

        friend Wymierna operator-(const Wymierna &p) noexcept;
		friend Wymierna operator!(const Wymierna &p) throw(dzielenie_przez_0);
		friend std::ostream& operator<<(std::ostream &wy, const Wymierna &p) noexcept;

        friend Wymierna operator+(const Wymierna &p, const Wymierna &q) throw(przekroczenie_zakresu);
        friend Wymierna operator-(const Wymierna &p, const Wymierna &q) throw(przekroczenie_zakresu);
        friend Wymierna operator*(const Wymierna &p, const Wymierna &q) throw(przekroczenie_zakresu);
        friend Wymierna operator/(const Wymierna &p, const Wymierna &q) throw(przekroczenie_zakresu, dzielenie_przez_0);

    };
}

#endif
