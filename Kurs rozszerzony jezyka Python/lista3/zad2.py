def pierwiastek(n):
    i = 0
    wynik = 0
    while wynik <= n:
        i += 1
        wynik += (2*i - 1)
    return i - 1


print(pierwiastek(9))
