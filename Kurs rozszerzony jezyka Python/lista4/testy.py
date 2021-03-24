import timeit

print("Znajdowanie liczb pierwszych nie większych od 10000: ")
print("imperatywnie ", timeit.timeit(setup = "import zad1",stmt = "zad1.pierwsze_imperatywna(10000)", number = 1))
print("lista składana ", timeit.timeit(setup = "import zad1",stmt = "zad1.pierwsze_skladana(10000)", number = 1))
print("funkcyjnie ", timeit.timeit(setup = "import zad1",stmt = "zad1.pierwsze_funkcyjna(10000)", number = 1))

print("Znajdowanie liczb doskonałych nie większych od 10000: ")
print("imperatywnie ", timeit.timeit(setup = "import zad2",stmt = "zad2.doskonale_imperatywna(10000)", number = 1))
print("lista składana ", timeit.timeit(setup = "import zad2",stmt = "zad2.doskonale_skladana(10000)", number = 1))
print("funkcyjnie ", timeit.timeit(setup = "import zad2",stmt = "zad2.doskonale_funkcyjna(10000)", number = 1))
