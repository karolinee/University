#include <iostream>
#include "obliczenia.hpp"

using namespace obliczenia;
using namespace std;
int main()
{
    try{
        Wymierna w2(0,0);
    }
    catch(wyjatek_wymierny &e)
    {
        cout << "Tworzenie zmiennej: " << e.what() <<endl;
    }
    Wymierna w1(1);
    Wymierna w2(7);

    cout << w1 <<endl;
    cout<< w1 - w2 <<endl;
    cout<< w1 + w2 <<endl;
    cout<< w1 * w2 <<endl;
    cout<< w1 / w2 <<endl;
    cout<< -w1 <<endl;
    cout<< !w2 <<endl;

    Wymierna w4(0,1);

    try{
        cout << !w4 <<endl;
    }
    catch(wyjatek_wymierny &e)
    {
        cout << "Liczba odwrotna: " << e.what() <<endl;
    }

    Wymierna w3(-1,6);
    cout << w3 <<endl;
}
