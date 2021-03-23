#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <utility>
#include <fstream>
#include <cmath>
#include "strumienie.hpp"
#define _flipbit(x,b) ((x)| (1<<b) )

using namespace std;
using namespace strumienie;
void testy1()
{
    vector<pair<string,int>> lines;

    string line = "";
    int i = 1;


    while(getline(cin,line))
    {
        lines.push_back(make_pair(line,i++));
    }
    sort(lines.begin(),lines.end());
    cout << endl;
    for(int j = 0 ; j < i - 1 ; j++)
    {
        cout << index(lines[j].second,5) << lines[j].first <<endl;
    }


}
void testy2()
{
    Wejscie input("file.txt");
    vector<int> data;

    int temp = 0;
    try
    {
        while(!input.eof())
        {
            input >> temp;
            if(temp == EOF) break;
            data.push_back(_flipbit(temp,1));
        }


        Wyjscie output("file2.txt");
        for(unsigned i = 0; i < data.size()-1 ; i++)
        {
            output << data[i];
        }
    }
    catch(std::ios::failure message)
    {
		std::cerr << message.what() << endl;
    }
}
int main()
{
    testy1();
    testy2();
}
