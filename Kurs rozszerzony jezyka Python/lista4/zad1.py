def pierwsze_imperatywna(n):
    result = list()
    for i in range(2,n+1):
        for j in result:
            if i % j == 0:
                break
        else: result.append(i)
    return result

def pierwsze_skladana(n):
    return [i for i in range(2,n+1) if not 0 in [i%k for k in range(2,i)]]


def pierwsze_funkcyjna(n):
    return list(filter(lambda x: not 0 in map(lambda y: x%y, range(2,x)),range(2,n+1)))
