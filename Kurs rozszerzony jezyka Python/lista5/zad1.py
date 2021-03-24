import timeit

#implementacja listy liczb pierwszych z listy 4
def pierwsze_imperatywna(n):
    result = list()
    for i in range(2,n+1):
        for j in result:
            if i % j == 0:
                break
        else: result.append(i)
    return result

def pierwsze_skladana(n):
    return [i for i in range(2,n+1) if all(i%x != 0 for x in range(2,i))]


def pierwsze_funkcyjna(n):
    return list(filter(lambda x: not 0 in map(lambda y: x%y, range(2,x)),range(2,n+1)))

#lista 5
def prime(n):
    if n%2 == 0: return False
    for i in range(3,n,2):
        if n%i == 0:
            return False
    return True

def pierwsze_iterator(n):
    p = 2
    while p <=n:
        if p == 2 or prime(p):
            yield p
        p += 1

def pretty_print():
    titles = ['','imperatywnie', 'skladana', 'funkcyjnie', 'iterator']
    pierwsze_imp = list()
    pierwsze_skl = list()
    pierwsze_fun = list()
    pierwsze_ite = list()
    steps = [10,100,1000,10000]
    for i in steps:
        pierwsze_imp.append(format(timeit.timeit(setup = "from __main__ import pierwsze_imperatywna",stmt = f"pierwsze_imperatywna({i})", number = 1),'f'))
        pierwsze_skl.append(format(timeit.timeit(setup = "from __main__ import pierwsze_skladana",stmt = f"pierwsze_skladana({i})", number = 1),'f'))
        pierwsze_fun.append(format(timeit.timeit(setup = "from __main__ import pierwsze_funkcyjna",stmt = f"pierwsze_funkcyjna({i})", number = 1),'f'))
        pierwsze_ite.append(format(timeit.timeit(setup = "from __main__ import pierwsze_iterator",stmt = f"list(pierwsze_iterator({i}))", number = 1),'f'))

    data = [titles] + list(zip(steps,pierwsze_imp,pierwsze_skl,pierwsze_fun,pierwsze_ite))
    for i, d in enumerate(data):
        print('|'.join(str(x).ljust(25) for x in d))

pretty_print()
