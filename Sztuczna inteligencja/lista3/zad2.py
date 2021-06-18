from collections import deque
import copy

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
    
    if len(domain) > 0:
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

            

def solve(domain_rows, domain_columns, finished_rows, finished_columns, row_start = -1, column_start = -1 ):
    global rows, columns, rows_desc, columns_desc
        
    if row_start != -1:
        queue_rows = deque([(row_start, -1, -1)])
        queue_columns = deque()
    elif column_start != -1:
        queue_rows = deque()
        queue_columns = deque([(column_start, -1, -1)])
    else:
        queue_rows = deque([(i, -1, -1) for i in range(0,rows)])
        queue_columns = deque([(i, -1, -1) for i in range(0, columns)])


    while queue_rows or queue_columns:
        if queue_rows:
            to_change, idx, new_val  = queue_rows.popleft()
            revised = revise(domain_rows[to_change], finished_rows[to_change], idx, new_val, to_change, columns)
            queue_columns.extend(revised)
            if len(domain_rows[to_change]) == 0:
                return
        
        if queue_columns:
            to_change, idx, new_val  = queue_columns.popleft()
            revised = revise(domain_columns[to_change], finished_columns[to_change], idx, new_val, to_change, rows)
            queue_rows.extend(revised)
            if len(domain_columns[to_change]) == 0:
                return


def deepcopy_domain(domain_list):
    new_domain_list = []
    for domain in domain_list:  
        new_domain_list.append(domain.copy())
    return new_domain_list


def backtracking(domain_rows, domain_columns, finished_rows, finished_columns):
    global rows, columns, rows_desc, columns_desc
    min_domain = None
    min_len = columns*columns
    idx = -1
    for i, domain in enumerate(domain_rows):
        tmp_len = len(domain)
        if  tmp_len > 1 and tmp_len < min_len:
            min_domain = domain
            min_len = tmp_len
            idx = i

    c = False
    for i, domain in enumerate(domain_columns):
        tmp_len = len(domain)
        if  tmp_len > 1 and tmp_len < min_len:
            min_domain = domain
            min_len = tmp_len
            idx = i
            c = True
    
    for elem in list(min_domain):
        new_domain_rows = deepcopy_domain(domain_rows)
        new_domain_columns = deepcopy_domain(domain_columns)
        new_finished_rows = deepcopy_domain(finished_rows)
        new_finished_columns = deepcopy_domain(finished_columns)
        new_domain = set()
        new_domain.add(elem)
        start_row = -1
        start_column = -1
        if c:
            new_domain_columns[idx] = new_domain
            start_column = idx
        else:
            new_domain_rows[idx] = new_domain
            start_row = idx
        
        solve(new_domain_rows, new_domain_columns, new_finished_rows, new_finished_columns, start_row, start_column)
        if all(len(domain) == 1 for domain in new_domain_rows):
            domain_rows = new_domain_rows
            domain_columns = new_domain_columns
            for domain in domain_rows:
                print(''.join(map(lambda x: '#' if x else '.',list(domain.pop()))), file = output)
            exit()
        if any(len(domain) == 0 for domain in new_domain_rows) or any(len(domain) == 0 for domain in new_domain_columns):
            continue
        backtracking(new_domain_rows, new_domain_columns, new_finished_rows, new_finished_columns)

        
        

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

domain_rows = [set(tuple(x) for x in gen_segment(columns, desc)) for desc in rows_desc]
domain_columns = [set(tuple(x) for x in gen_segment(rows, desc)) for desc in columns_desc]
finished_rows = [[-1] * columns for _ in range(rows)]
finished_columns = [[-1] * rows for _ in range(columns)]

solve(domain_rows, domain_columns, finished_rows, finished_columns)

backtracking(domain_rows, domain_columns, finished_rows, finished_columns)



