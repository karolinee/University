FLAGS= -pedantic -Wall -Werror -Wextra -std=c++11

main: main.o figury.o
	g++ -o main main.o figury.o -I. $(FLAGS)

main.o: main.cpp
	g++ -c main.cpp -I. $(FLAGS)

figury.o: figury.cpp figury.hpp
	g++ -c figury.cpp -I. $(FLAGS)
