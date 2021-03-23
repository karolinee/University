#include "onp.hpp"
#include <iostream>
#include <memory>
#include <vector>

using namespace std;
using namespace kalkulator;
double print(string wyrazenie)
{
    std::vector<symbol*> wektor;
    int index = 0;
    int koniec;

    do
    {
        koniec = wyrazenie.find(' ', index);
        std::string s = wyrazenie.substr(index, koniec-index);
        index += s.length()+1;

        symbol *sym;
        if (isdigit(s.at(0)) || (s.length() > 1 && s.at(0) == '-'))
        {
            double wartosc = stoi(s);
            sym = new liczba(wartosc);
        }
        else if(stala::jestStala(s))
        {
            sym = new stala(s);
        }
        else if(funkcja::jestFunkcja(s))
        {
            sym = new funkcja(s);
        }
        else
        {
            sym = new zmienna(s);
        }
        wektor.push_back(sym);
    } while (koniec != -1);

    for (auto it = wektor.begin(); it != wektor.end(); it++)
    {
        (*it)->oblicz();
    }
    return stala::wynikOstateczny();
}

int main()
{
    cout << "Kalkulator ONP - wprowadź komende" << endl;
    cout << "print - wylicz wartosc wyrazenie ONP" << endl;
    cout << "assign .. to .. - wylicz i przypisz wartosc wyrazenia do zmiennej" <<endl;
    cout << "clear - wyczysc zmienne" << endl;
    cout << "exit - wyjdź z programu" << endl;
    while (true)
    {
        string komenda;
        getline(cin, komenda);
        try
        {
            int miejscePodzialu = komenda.find(' ');
            string pierwszyElement = komenda.substr(0, miejscePodzialu);

            if (pierwszyElement == "print")
            {
                double wynik = print(komenda.substr(6, komenda.length()));
                cout << wynik << endl;
            }
            else if (pierwszyElement == "assign")
            {
                string reszta = komenda.substr(7, komenda.length());
                miejscePodzialu = reszta.find(" to ");
                string wyrazenie = reszta.substr(0, miejscePodzialu);
                string zmienna = reszta.substr(miejscePodzialu + 4, reszta.length());
                double wynik = print(wyrazenie);
                zmienna::dodaj(zmienna,wynik);
                cout << "Przypisano " << wynik << " do zmiennej " <<zmienna <<  endl;
            }
            else if (pierwszyElement == "clear")
            {
                zmienna::wyczysc();
                cout << "Wyczyszczono zmienne" << endl;
            }
            else if (pierwszyElement == "exit")
            {
                cout << "Koniec programu" << endl;
                break;
            }
            else
            {
                clog << "Nieprawidlowa komenda!" << endl;
            }
        }
        catch(const std::exception &e)
        {
            clog << "Blad w wyrazeniu!" << endl;
            clog << e.what() << endl;
        }
    }

}
