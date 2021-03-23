#include "wielomian.hpp"
#include <iostream>

using namespace std;

int main()
{
    wielomian w1 = wielomian{1,2,5,6};
    wielomian w2;
    cin>>w2;
    cout <<w2 <<endl;
    cout<<w2.get_stopien()<<endl;
    try
    {
        wielomian w3 = wielomian{1,2,0};
    }
    catch(const std::invalid_argument &e)
    {
        cerr << e.what() << endl;
    }
    cout<<w2 + w1<<endl;
    cout<<w2 - w1<<endl;
    cout<<w2 * w1<<endl;
    cout<<w2 * 2<<endl;
    cout<<2*w2<<endl;
    cout<< 0* w2 <<endl;

    w2 += w1;
    cout<<w2<<endl;
    w2-=w1;
    cout<<w2<<endl;
    w2*=2;
    cout<<w2<<endl;
    w2*=w1;
    cout<<w2<<endl;

    cout<<w1(0)<<endl;
    cout<<w1(1)<<endl;
    cout<<w1(2)<<endl;
    cout<<w1[2] <<endl;
    w1[1] = 1;
    cout<<w1[1]<<endl;
    try
    {
        w1[3] = 0;
    }
    catch(const std::invalid_argument &e)
    {
        cerr << e.what() << endl;
    }
}
