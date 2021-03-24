def doskonale_imperatywna(n):
    result = list()
    for i in range(2,n+1):
        sum = 0
        for j in range(1,i):
            if i%j == 0:
                sum += j
        if sum == i:
            result.append(i)
    return result

def doskonale_skladana(n):
    return [i for i in range(2,n+1) if i == sum([k for k in range(1,i) if i%k == 0])]


def doskonale_funkcyjna(n):
    return list(filter(lambda x: x == sum(filter(lambda y: x%y == 0, range(1,x))), range(2,n+1)))
