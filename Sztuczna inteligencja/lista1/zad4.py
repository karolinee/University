def opt_dist(block, D):
    ones = 0
    for bit in block:
        if bit == '1':
            ones += 1

    min = ones + D #naiwnie, wszystko na zera i dodajemy jedynki
    
    for i in range(0, len(block) - D + 1):
        window = 0
        for j in range(0, D):
            if block[i + j] == '1':
                window += 1
        result = (ones - window) + (D - window) #jak wcześniej, ale teraz ustawiamy okno o długości D na wszystkie możliwe miejsca
        if result < min:
            min = result

    return min

with open("zad4_input.txt", "r") as input, open("zad4_output.txt", "w") as output:
    for line in input:
        line = line.split()
        result = opt_dist(line[0], int(line[1]))
        print(result, file = output)
    
