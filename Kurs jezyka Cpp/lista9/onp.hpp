#include <string>
#include <map>
#include <vector>
#include <algorithm>
#include <cmath>
#include <stack>
#include <functional>
namespace kalkulator
{
    class symbol
    {
    protected:
        static std::stack<symbol*> stos;
    public:
        symbol() = default;
        virtual void oblicz() = 0;
        virtual double wynik() = 0;
        static double wynikOstateczny();
    };

    class liczba: public symbol
    {
    private:
        double wartosc;
    public:
        liczba(double w);
        void oblicz();
        double wynik();
    };
    class zmienna: public symbol
    {
    private:
        std::string nazwa;
        static std::map<std::string, double> zmienne;
    public:
        zmienna(std::string n);
        void oblicz();
        double wynik();

        static void wyczysc();
        static void dodaj(std::string nazwa, double wartosc);
    };
    class stala: public symbol
    {
    private:
        std::string nazwa;
        static std::map<std::string, double> stale;
    public:
        stala(std::string n);
        void oblicz();
        double wynik();

        static bool jestStala(std::string n);
    };
    class funkcja: public symbol
    {
    private:
        std::string nazwa;
        static std::map<std::string, std::function<double(double,double)>> binarne;
        static std::map<std::string, std::function<double(double)>> unarne;
    public:
        funkcja(std::string n);
        void oblicz();
        double wynik() { return 0;};

        static bool jestFunkcja(std::string n);
    };
}
