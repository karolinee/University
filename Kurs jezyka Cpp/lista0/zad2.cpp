#include <iostream>
#include <iomanip>
#include <string>
#include <cmath>


int main()
{
  std::clog << "Podaj pole kola\n";
  std::string a;
  double x;

  std::cin >> a;

  try
  {
    x = std::stod(a);

    if(x<=0)
      throw std::invalid_argument("pole nie moze byc ujemne!");

    x/=M_PI;
    x=sqrt(x);

    std::cout << x << std::endl;
  }
  catch(std::logic_error& e)
  {
    std::cerr<<"wyjatek: "<<e.what()<<std::endl;
  }

}
