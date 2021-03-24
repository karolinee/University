import itertools

def solver(words):
    letters = set(''.join(words))
    values = [0,0,0]

    numbers = '0123456789'
    product = itertools.permutations(numbers, len(letters))

    result = {i: 0 for i in letters}
    for p in product:
        i = 0
        for key in result.keys():
            result[key] = p[i]
            i += 1
        for j in range(3):
            s = words[j]
            for key in result.keys():
                s = s.replace(key, result[key])
            values[j] = int(s)

        if values[0] + values[1] == values[2]:
            print(str(values[0]).rjust(len(words[1]) + 1))
            print('+' + str(values[1]))
            print('-'*(len(words[1]) + 1))
            print(str(values[2]).rjust((len(words[1]) + 1)))
            return result


words = list()
for i in range(3):
    words.append(input())

result = solver(words)
