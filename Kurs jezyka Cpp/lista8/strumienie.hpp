#ifndef STRUMIENIE_HPP
#define STRUMIENIE_HPP

#include <iostream>
#include <string>
#include <fstream>


namespace strumienie
{
    std::istream& clearline(std::istream &input);

    class ignore
    {
    private:
        int ile;
    public:
        ignore(int x = 0): ile(x) {}
        friend std::istream& operator>>(std::istream &input, const ignore &licz)
        {
            int ile = licz.ile;

        	while (ile-- > 0 && input.peek() != EOF && input.get() != '\n');
        	return input;
        }
    };

    std::ostream& comma(std::ostream &output);
    std::ostream& colon(std::ostream &output);

    class index
    {
    private:
	       int number;
           int positions;
    public:
	       index(int x, int w = 0) : number(x), positions(w) {}
           friend std::ostream& operator<<(std::ostream &output, const index &licz)
           {
               output << "[";
               int spaces = licz.positions - std::to_string(licz.number).length();
               while(spaces-- > 0)
                   output << " ";
               output << licz.number;
               output << "]";
           	return output;
           }
    };

    class Wejscie
    {
    private:
        std::ifstream file;
    public:
        Wejscie(std::string path);
        ~Wejscie();
        friend Wejscie &operator>>(Wejscie &input, int &num)
        {
            num = static_cast<int>(input.file.get());
            if (!input.file.eof() && input.file.fail())
		          throw std::ios::failure("Read error\n");
            return input;
        }
        bool eof()
        {
            return file.eof();
        }
    };

    class Wyjscie
    {
    private:
        std::ofstream file;
    public:
        Wyjscie(std::string path);
        ~Wyjscie();
        friend Wyjscie &operator<<(Wyjscie &plik, const int &num)
        {
            plik.file.write((const char*)&num,1);
            if (plik.file.fail())
		          throw std::ios::failure("Write error\n");
            return plik;
        }

    };
}

#endif
