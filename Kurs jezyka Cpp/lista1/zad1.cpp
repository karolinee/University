/*Karolina Jeziorska 308220
lista 1 zadanie 1
*/
#include <iostream>
#include <string>
#include <utility>
#include <vector>

using namespace std;


string bin2rzym(int x)
{
  static const vector<pair<int, string>> rzym = {
  {1000, "M"},
  {900, "CM"}, {500, "D"}, {400, "CD"}, {100, "C"},
  {90, "XC"}, {50, "L"}, {40, "XL"}, {10, "X"},
  {9, "IX"}, {5, "V"}, {4, "IV"}, {1, "I"}
  };

  string s = "";
  int i = 0;

  while(x > 0)
  {
    while(x-rzym[i].first >= 0)
    {
      x-=rzym[i].first;
      s+=rzym[i].second;
    }
    i++;
  }

  return s;
}


int main(int argc, char *argv[])
{
  for(int i = 1 ; i < argc; i++)
  {
    try
    {
      int x = stoi(argv[i]);
      if(x > 3999 || x<=0) throw invalid_argument("zly argument");
      cout<<argv[i]<< " -> "<< bin2rzym(x) << endl;
    }
    catch(const logic_error& e)
    {
      clog << argv[0] << ": blad: " <<e.what()<<endl;
    }
  }

  return 0;
}
