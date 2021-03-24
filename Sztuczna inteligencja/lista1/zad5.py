from random import randint
from random import choice
import copy

def opt_dist(block, D):
    ones = 0
    for bit in block:
        if bit == 1:
            ones += 1

    min = ones + D 
    
    for i in range(0, len(block) - D + 1):
        window = 0
        for j in range(0, D):
            if block[i + j] == 1:
                window += 1
        result = (ones - window) + (D - window) 
        if result < min:
            min = result

    return min


def generate_random(rows, columns):
    return [[randint(0,1) for _ in range(0, columns)] for _ in range(0, rows)]

def get_unfinished(solution):
    global rows, columns, rows_desc, columns_desc
    unfinished_rows = set(filter(lambda i: opt_dist(solution[i], rows_desc[i]) > 0,range(0, rows)))

    columns_tmp = []
    for i in range(0, columns):
        c_tmp = []
        for j in range(0, rows):
            c_tmp.append(j)
        columns_tmp.append(c_tmp)
   
    unfinished_columns = set(filter(lambda i: opt_dist(columns_tmp, columns_desc[i]) > 0,range(0, columns)))

    return unfinished_rows, unfinished_columns
    


def make_better(solution, to_change, change_choice):
    global columns, rows, columns_desc, rows_desc
    if change_choice == 'r':
        best = float('inf')
        idx = -1
        for i in range(0, columns):
            old = -1
            if solution[to_change][i] == 1:
                solution[to_change][i] = 0
                old = 1
            else:
                solution[to_change][i] = 1
                old = 0
            new_opt_row = opt_dist(solution[to_change], rows_desc[to_change])
            new_opt_column = opt_dist([solution[j][i] for j in range(0, rows)], columns_desc[i])
            score = (new_opt_row ** 2) + (new_opt_column ** 2)
            if score < best:
                best = score
                idx = i
            solution[to_change][i] = old

        #zmiana na najlepszy
        if solution[to_change][idx] == 1:
            solution[to_change][idx] = 0
        else:
            solution[to_change][idx] = 1

        return to_change, idx

    if change_choice == 'c':
        best = float('inf')
        idx = -1
        for i in range(0, rows):
            old = -1
            if solution[i][to_change] == 1:
                solution[i][to_change] = 0
                old = 1
            else:
                solution[i][to_change] = 1
                old = 0
            new_opt_row = opt_dist(solution[i], rows_desc[i])
            new_opt_column = opt_dist([solution[j][to_change] for j in range(0, rows)], columns_desc[to_change])
            score = (new_opt_row ** 2) + (new_opt_column ** 2)
            if score < best:
                best = score
                idx = i
            solution[i][to_change] = old

        if solution[idx][to_change] == 1:
            solution[idx][to_change] = 0
        else:
            solution[idx][to_change] = 1
        
        return idx, to_change


def solve():
    global rows, columns, rows_desc, columns_desc

    solution = generate_random(rows, columns)
    unfinished_rows, unfinished_columns = get_unfinished(solution)
    iterations = 0

    while unfinished_rows or unfinished_columns:
        if(iterations > 1000):
            return solve()
            
        change_choice = ''
        to_change = -1
        #wybieramy czy zmieniamy wiersz czy kolumnę
        if not unfinished_columns:
            change_choice = 'r'
        elif not unfinished_rows:
            change_choice = 'c'
        else:
            change_choice = choice(['r', 'c'])
        
        #losujemy dokładny wiersz/kolumnę
        if change_choice == 'c':
            to_change = choice(tuple(unfinished_columns))
        elif change_choice == 'r':
            to_change = choice(tuple(unfinished_rows))

        #poprawiamy wiersz/kolumnę i zapamiętujemy co poprawiliśmy
        row_changed, column_changed = make_better(solution, to_change, change_choice)

        #sprawdzamy czy poprawiony wiersz i kolumnę należy dodać/usunąć ze zbioru niedokończonych wierszy i kolumn
        row_opt_dist = opt_dist(solution[row_changed], rows_desc[row_changed]) #sprawdzam czy row jest już skończony czy może teraz zepsuty
        if row_opt_dist == 0 and row_changed in unfinished_rows:
            unfinished_rows.remove(row_changed)
        if row_opt_dist > 0:
            unfinished_rows.add(row_changed)

        column_opt_dist = opt_dist([solution[i][column_changed] for i in range(0, rows)], columns_desc[column_changed])
        if column_opt_dist == 0 and column_changed in unfinished_columns:
            unfinished_columns.remove(column_changed)
        if column_opt_dist > 0:
            unfinished_columns.add(column_changed)

        iterations += 1

    return solution



inpu = open("zad5_input.txt", "r")
output = open("zad5_output.txt", "w")

first_line = inpu.readline()
first_line = first_line.split()
rows, columns = int(first_line[0]), int(first_line[1])

rows_desc = []
columns_desc = []

for i in range(0, rows):
    line = inpu.readline()
    line = line.strip()
    rows_desc.append(int(line))

for i in range(0, columns):
    line = inpu.readline()
    line = line.strip()
    columns_desc.append(int(line))

solution = solve()
for i in range(0,rows):
    stri = ''
    for j in range(0,columns):
        if solution[i][j] == 1:
            stri += '#'
        else:
            stri += '.'
    print(stri, file=output)