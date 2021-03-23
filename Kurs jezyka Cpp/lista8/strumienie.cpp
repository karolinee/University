#include "strumienie.hpp"

std::istream& strumienie::clearline(std::istream &input)
{
	while (input.peek() != EOF && input.get() != '\n');
	return input;
}

std::ostream& strumienie::comma(std::ostream &output)
{
    output << ", ";
    return output;
}
std::ostream& strumienie::colon(std::ostream &output)
{
    output << ": ";
    return output;
}


strumienie::Wejscie::Wejscie(std::string path)
{
	file.open(path,std::ios::in|std::ios::binary);
	if(!file.is_open()) throw std::ios::failure("Can't open a file");
}

strumienie::Wejscie::~Wejscie()
{
	if(file.is_open())
		file.close();
}

strumienie::Wyjscie::Wyjscie(std::string path)
{
	file.open(path,std::ios::binary|std::ios::out);
	if(!file.is_open()) throw std::ios::failure("Can't open a file");
}

strumienie::Wyjscie::~Wyjscie()
{
	if(file.is_open())
		file.close();
}
