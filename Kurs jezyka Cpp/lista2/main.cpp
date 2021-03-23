#include <iostream>
#include "figury.hpp"
#include <math.h>
#include <iomanip>
using namespace std;

int main()
{
    /*******TESTY PUNKTU*******/
    cout << "TESTY PUNKTU--------------------------------------------------" << endl;
    punkt p1 = punkt(1,2);
    cout << "Tworzenie punktu - konstruktor zwykly - punkt p1: " << "(" << p1.getx() << "," << p1.gety() << ")" << endl;

    punkt p2 = punkt(p1);
    cout << "Tworzenie punktu - konstruktor kopiujacy - punkt p2: " << "(" << p2.getx() << "," <<  p2.gety() << ")" << endl;
    p2.przesun(2,3);
    cout << "Przesuniecie punktu p2: " << "("<< p2.getx() << "," << p2.gety() << ")"<< endl;

    punkt p3;
    p3 = p1;
    cout << "Tworzenie punktu - konstruktor przypisania - punkt p3: " << "("<<p3.getx() << "," << p3.gety() << ")"<< endl;
    p3.obroc(punkt(0,0),90);
    cout << "Obrot punktu p3: " <<"("<< p3.getx() << "," << p3.gety() << ")"<< endl;

    cout << "Odleglosc punktu p1 i p2: " << odleglosc(p1,p2) << endl;
    cout << endl;
    /*******TESTY ODCINKA*******/
    cout << "TESTY ODCINKA--------------------------------------------------" << endl;

    try
    {
        odcinek o = odcinek(p1,p1);
        cout << "(" << o.geta().getx() << "," <<  o.geta().gety() << ") (" << o.getb().getx() << "," <<  o.getb().gety() << ")" << endl;
    }
    catch(const invalid_argument& e)
    {
        std::cout << e.what() << endl;
    }

    odcinek o1 = odcinek(p1,p2);
    cout << "Tworzenie odcinka - konstruktor zwykly - odcinek o1: " << "(" << o1.geta().getx() << "," <<  o1.geta().gety() << ") (" << o1.getb().getx() << "," <<  o1.getb().gety() << ")" << endl;

    odcinek o2 = odcinek(o1);
    cout << "Tworzenie odcinka - konstruktor kopiujacy - odcinek o1: " << "(" << o2.geta().getx() << "," <<  o2.geta().gety() << ") (" << o2.getb().getx() << "," <<  o2.getb().gety() << ")" << endl;
    o2.obroc(punkt(0,0),90);
    cout << "Obrot odcinka o2: " << "(" << o2.geta().getx() << "," <<  o2.geta().gety() << ") (" << o2.getb().getx() << "," <<  o2.getb().gety() << ")" << endl;

    odcinek o3 = odcinek(o2);;
    o3 = o1;
    cout << "Tworzenie odcinka - konstruktor przypisania - odcinek o1: " << "(" << o3.geta().getx() << "," <<  o3.geta().gety() << ") (" << o3.getb().getx() << "," <<  o3.getb().gety() << ")" << endl;
    o3.przesun(1,1);
    cout << "Przesuniecie odcinka o3: "<< "(" << o3.geta().getx() << "," <<  o3.geta().gety() << ") (" << o3.getb().getx() << "," <<  o3.getb().gety() << ")" << endl;

    cout << "Dlugosc odcinka o3: "<< o3.dlugosc() << endl;
    cout << "Srodek odcinka o3: "<< "(" << o3.srodek().getx() << "," << o3.srodek().gety() << ")" << endl;

    cout << "Czy p1 lezy na o3? ";
    if(o3.naOdcinku(p1)) cout << "tak" << endl;
    else cout << "nie" << endl;

    cout << "Czy p1 lezy na o1? ";
    if(o1.naOdcinku(p1)) cout << "tak" << endl;
    else cout << "nie" << endl;

    cout << "Czy o1 i o3 sa rownolegle? ";
    if(rownolegle(o1,o3)) cout<< "tak" << endl;
    else cout << "nie" << endl;

    cout << "Czy o1 i o2 sa rownolegle? ";
    if(rownolegle(o1,o2)) cout<< "tak" << endl;
    else cout << "nie" << endl;

    cout << "Czy o1 i o3 sa prostopadle? ";
    if(prostopadle(o1,o3)) cout<< "tak" << endl;
    else cout << "nie" << endl;

    cout << "Czy o1 i o2 sa prostopadle? ";
    if(prostopadle(o1,o2)) cout<< "tak" << endl;
    else cout << "nie" << endl;

    punkt p4 = punkt(1,3);
    punkt p5 = punkt(3,1);
    odcinek o4 = odcinek(p4,p5);
    punkt p6;


    try
    {
        cout << "Spradwzenie czy odcinki o1 i o3 sie przecinaja: ";
        p6 = przecninaja(o1,o3);
        cout<< p6.getx() << " " << p6.gety() << endl;
    }
    catch(const invalid_argument& e)
    {
        std::cout << e.what() << endl;
    }
    try
    {
        cout << "Spradwzenie czy odcinki o1 i o4 sie przecinaja: ";
        p6 = przecninaja(o1,o4);
        cout<< p6.getx() << " " << p6.gety() << endl;
    }
    catch(const invalid_argument& e)
    {
        std::cout << e.what() << endl;
    }

    cout<<endl;

    /*******TESTY TROJKATA*******/
    cout << "TESTY TROJKATA--------------------------------------------------" << endl;
    trojkat t1 = trojkat(p1,p2,p3);
    cout << "Tworzenie trojkata - konstruktor zwykly - trojkat t1:  (" << t1.geta().getx() << "," <<  t1.geta().gety() << ") (" << t1.getb().getx() << "," <<  t1.getb().gety() << ") (" << t1.getc().getx() << "," <<  t1.getc().gety() << ")" << endl;

    trojkat t2 = trojkat(t1);
    cout << "Tworzenie trojkata - konstruktor kopiujacy - trojkat t2: (" << t2.geta().getx() << "," <<  t2.geta().gety() << ") (" << t2.getb().getx() << "," <<  t2.getb().gety() << ") (" << t2.getc().getx() << "," <<  t2.getc().gety() << ")" << endl;
    t2.przesun(1,1);
    cout << "Trojkat t2 po przesunieciu : (" << t2.geta().getx() << "," <<  t2.geta().gety() << ") (" << t2.getb().getx() << "," <<  t2.getb().gety() << ") (" << t2.getc().getx() << "," <<  t2.getc().gety() << ")" << endl;
    t2.obroc(punkt(0,0),90);
    cout << "Trojkat t2 po obrocie : (" << t2.geta().getx() << "," <<  t2.geta().gety() << ") (" << t2.getb().getx() << "," <<  t2.getb().gety() << ") (" << t2.getc().getx() << "," <<  t2.getc().gety() << ")" << endl;

    trojkat t3 = trojkat(t2);
    t3 = t1;
    cout << "Tworzenie trojkata - konstruktor przypisania - trojkat t3:  (" << t3.geta().getx() << "," <<  t3.geta().gety() << ") (" << t3.getb().getx() << "," <<  t3.getb().gety() << ") (" << t3.getc().getx() << "," <<  t3.getc().gety() << ")" << endl;
    cout << "Obwod trojkata t1: " << t1.obwod() << " i jego pole: " << t1.pole() << endl;

    punkt p7 = t1.srodek();
    cout << "Srodek trojkata t1: " << p7.getx() << " " << p7.gety() << endl;

    cout << "Czy punkt  jest w srodku t1? : ";
    if(t1.wSrodku(punkt(p7))) cout<< "tak" << endl;
    else cout << "nie" << endl;

    cout << "Czy trojkaty t1 i t2 sa rozlaczne? : ";
    if(rozlaczne(t1,t2)) cout<< "tak" << endl;
    else cout << "nie" << endl;
    cout << "Czy trojkaty t1 i t1 sa rozlaczne? : ";
    if(rozlaczne(t1,t1)) cout<< "tak" << endl;
    else cout << "nie" << endl;

    cout << "Czy trojkaty t1 i t2 zawieraja sie? : ";
    if(zawieranie(t1,t2)) cout<< "tak" << endl;
    else cout << "nie" << endl;
    cout << "Czy trojkaty t1 i t1 zawieraja sie? : ";
    if(zawieranie(t1,t1)) cout<< "tak" << endl;
    else cout << "nie" << endl;

}
