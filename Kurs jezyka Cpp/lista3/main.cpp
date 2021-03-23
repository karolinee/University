#include "kolejka.hpp"
#include <iostream>

using namespace std;
//caly switch w try catch???

int main()
{

    int check = 1;
    int n;

    cout << "Podaj rozmiar kolejki: ";
    cin >> n;
    kolejka *k = new kolejka(n);

    cout << "Podaj co chcesz zrobic:" <<endl;
    cout << "1. Dodaj element do koeljki" <<endl;
    cout << "2. Wyciagnij element z kolejki" <<endl;
    cout << "3. Zakoncz" <<endl;
    while(check)
    {
        int s;
        string elem;
        cin >> s;
        try
        {
            switch(s)
            {
                case 1:
                    cout<< "Podaj wartosc do dodania: ";
                    cin >> elem;
                    k->wloz(elem);
                    break;

                case 2:
                    cout << k->wyciagnij() << endl;
                    break;

                case 3:
                    check = 0;
                    break;
            }
        }
        catch(const string m)
        {
            cout << m << endl;
        }
    }

    delete k;
}
