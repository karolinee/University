from collections import deque

def gen_segment(size, desc):
    if not desc: 
        return [[0] * size]
    
    end = 0
    if len(desc) > 1:
        end = 1

    all_segments = []
    for i in range(0,size - sum(desc) - (len(desc) - 2)*end + 1):
        prefix = [0] * i + [1] * desc[0] + [0] * end
        sufixes = gen_segment(size - i - desc[0] - end, desc[1:])
        for sufix in sufixes:
            all_segments.append(prefix + sufix)
    return all_segments

    

def revise(domain, finished, idx, new_val, own_idx, size):
    revised = []

    if idx > -1 :
        finished[idx] = new_val
        domain -= {x for x in domain if x[idx] != new_val}

    for i in range(size):
        if finished[i] == -1:
            segment = [seg[i] for seg in domain]
            if all(segment):
                finished[i] = 1
                revised.append((i, own_idx, 1))
            if all(x == 0 for x in segment):
                finished[i] = 0
                revised.append((i, own_idx, 0))
    
    return revised

            

def solve():
    global rows, columns, rows_desc, columns_desc
    all_rows = [set(tuple(x) for x in gen_segment(columns, desc)) for desc in rows_desc]
    all_columns = [set(tuple(x) for x in gen_segment(rows, desc)) for desc in columns_desc]

    queue_rows = deque([(i, -1, -1) for i in range(0,rows)])
    queue_columns = deque([(i, -1, -1) for i in range(0, columns)])

    finished_rows = [[-1] * columns for _ in range(rows)]
    finished_columns = [[-1] * rows for _ in range(columns)]

    while queue_rows or queue_columns:
        if queue_rows:
            to_change, idx, new_val  = queue_rows.popleft()
            revised = revise(all_rows[to_change], finished_rows[to_change], idx, new_val, to_change, columns)
            queue_columns.extend(revised)
        
        if queue_columns:
            to_change, idx, new_val  = queue_columns.popleft()
            revised = revise(all_columns[to_change], finished_columns[to_change], idx, new_val, to_change, rows)
            queue_rows.extend(revised)

    for row in finished_rows:
        if any(x == -1 for x in row):
            raise Exception('Cant solve')

        
    for row in finished_rows:
            print(''.join(map(lambda x: '#' if x else '.',row)), file = output)
    




data = open("zad_input.txt", "r")
output = open("zad_output.txt", "w")

first_line = data.readline()
first_line = first_line.split()
rows, columns = int(first_line[0]), int(first_line[1])



rows_desc = []
columns_desc = []

for i in range(0, rows):
    line = data.readline()
    line = line.split()
    rows_desc.append([int(i) for i in line])

for i in range(0, columns):
    line = data.readline()
    line = line.split()
    columns_desc.append([int(i) for i in line])



solve()
