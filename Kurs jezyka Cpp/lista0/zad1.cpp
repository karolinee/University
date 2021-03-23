#include <iostream>
#include <iomanip>
#include <string>
#include <cmath>

int main()
{
  std::clog << "Podaj boki trojkata\n";
  std::string a, b, c;
  double x, y, z;

  std::cin >> a >> b >> c;

  try
  {
    x = std::stod(a);
    y = std::stod(b);
    z = std::stod(c);

    if(x<=0 || y<=0 || z<=0 || x+y<=z || x+z<=y || y+z<=x)
      throw std::invalid_argument("zle dlugosci bokow");

    double polowaObwodu = (x + y + z)/2.0;
    double pole = sqrt(polowaObwodu * (polowaObwodu - x) * (polowaObwodu - y) * (polowaObwodu - z));
    std::cout << std::fixed << std::setprecision(3) << pole << std::endl;

  }
  catch(std::logic_error& e)
  {
    std::cerr<<"wyjatek!"<<e.what()<<std::endl;
  }

}
