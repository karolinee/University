
import itertools

threes_domain = [list(p) for p in itertools.product([0,1], repeat=3)]
threes_domain.remove([0,1,0])
threes_domain = str(threes_domain)

fours_domain = [list(p) for p in itertools.product([0,1], repeat=4)]
fours_domain_remove = [[0,1,1,0], [1,0,0,1], [0,1,1,1], [1,0,1,1], [1,1,0,1], [1,1,1,0]]
for r in fours_domain_remove:
    fours_domain.remove(r)
fours_domain = str(fours_domain)

def B(i,j):
    return 'B_%d_%d' % (i,j)

def domains(Bs):
    return [b + ' in 0..1' for b in Bs]

def sum(Bs, val):
    return 'sum([' + ', '.join(Bs) + '], #=, ' + str(val) + ')'

def get_row(i, c):
    return [B(i,j) for j in range(c)]

def horizontal(rows, c):
    return [sum(get_row(i, c), r) for i,r in enumerate(rows)]

def get_column(j, r):
    return [B(i,j) for i in range(r)]

def vertical(columns, r):
    return [sum(get_column(j, r), c) for j,c in enumerate(columns)]

def tuple_in_three_row(i, k):
    return 'tuples_in([[' + ', '.join([B(i, j) for j in range(k, k+3)]) + ']], ' + threes_domain + ')'

def threes_horizontal(row, c):
    return [tuple_in_three_row(row, j) for j in range(c-2)]

def tuple_in_three_col(j, k):
    return 'tuples_in([[' + ', '.join([B(i, j) for i in range(k, k+3)]) + ']], ' + threes_domain + ')'

def threes_vertical(col, r):
    return [tuple_in_three_col(col, i) for i in range(r-2)]

def tuple_in_four(i, j):
    dom = [B(i,j), B(i, j+1), B(i+1, j), B(i+1, j+1)]
    
    return 'tuples_in([[' + ', '.join(dom) + ']], ' + fours_domain + ')'
    
def fours(rows, cols):
    return [tuple_in_four(i,j) for i in range(rows-1) for j in range(cols-1)]

def print_constraints(Cs, indent, d):
    position = indent
    writeln (indent * ' ', end='')
    for c in Cs:
        writeln (c + ',', end=' ')
        position += len(c)
        if position > d:
            position = indent
            writeln ('')
            writeln (indent * ' ', end='')  

def storms(rows, cols, triples):    
    writeln(':- use_module(library(clpfd)).')
    
    R = len(rows)
    C = len(cols)
    
    bs = [B(i,j) for i in range(R) for j in range(C)]
    
    writeln('solve([' + ', '.join(bs) + ']) :- ')
    
    cs = domains(bs) + horizontal(rows, C) + vertical(cols, R) + fours(R, C)

    for row in range(R):
        cs += threes_horizontal(row, C)

    for col in range(C):
        cs += threes_vertical(col, R)

    for i,j,v in triples:
        cs.append('%s #= %d' % (B(i,j), v))
    
    print_constraints(cs, 4, 70)

    writeln('')
    writeln('    labeling([ff], [' +  ', '.join(bs) + ']).' )
    writeln('')
    writeln(':-solve(X), write(X), nl.')

def writeln(s, end = '\n'):
    output.write(s + end)

txt = open('zad_input.txt').readlines()
output = open('zad_output.txt', 'w')

rows = map(int, txt[0].split())
cols = map(int, txt[1].split())
triples = []

for i in range(2, len(txt)):
    if txt[i].strip():
        triples.append(map(int, txt[i].split()))

storms(list(rows), list(cols), triples)            
        
