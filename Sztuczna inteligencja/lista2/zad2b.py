from collections import deque
from heapq import heappush, heappop


directions_translate = {0: 'U', 1: 'R', 2: 'D', 3: 'L'}
directions = [(-1,0), (0, 1), (1, 0), (0, -1)]

def finished(positions):
    global goals
    return all(goal in positions for goal in goals)

def heuristic(boxes,player):
    sum = 0
    for box in boxes:
        bx, by = box
        nearest = width * height
        for goal in goals:
            gx,gy = goal
            distance = abs(gx - bx) + abs(gy - by)
            if distance < nearest:
                nearest = distance
        sum+= nearest

    return sum

def solve(boxes, player):
    global maze, width, height, goals
    visited = set()
    queue = []
    heappush(queue, (heuristic(boxes, player), tuple(sorted(list(boxes))), player, ''))
    visited.add((tuple(sorted(list(boxes))), player))
    states = 0
    
    while queue:
        _ , boxes, player, moves = heappop(queue)
        states += 1

        if finished(boxes):
            print('states checked: ', states)
            return moves
        
        
        for i in range(0,4):
            new_x = player[0] + directions[i][0]
            new_y = player[1] + directions[i][1]
            if maze[new_x][new_y] != 'W':
                pos = (new_x, new_y)
                if pos not in boxes:
                    if (boxes, pos) not in visited:
                        visited.add((boxes, pos))
                        queue.append((len(moves) + heuristic(boxes, player),boxes, pos, moves + directions_translate[i]))
                else: 
                    new_bx = new_x + directions[i][0]
                    new_by = new_y + directions[i][1]
                    bpos = (new_bx, new_by)
                    if maze[new_bx][new_by] != 'W' and bpos not in boxes:
                        b = []
                        for box in boxes:
                            if box != pos:
                                b.append(box)
                        b.append(bpos)
                        new_boxes = tuple(sorted(b))
                        if (new_boxes, pos) not in visited:
                            visited.add((new_boxes, pos))
                            queue.append((len(moves) + heuristic(new_boxes, player),new_boxes, pos, moves + directions_translate[i]))





boxes = set()
goals = set()
player = (0,0)

maze = []

with open("zad_input.txt", "r") as data:
    for line in data:
        maze.append(list(line.strip()))

width = len(maze[0])
height = len(maze)

for i in range(height):
    for j in range(width):
        if maze[i][j] == 'K' or maze[i][j] == '+':
            player = (i,j)
        if maze[i][j] == 'B' or maze[i][j] == '*':
            boxes.add((i,j))
        if maze[i][j] == 'G' or maze[i][j] == '*':
            goals.add((i,j))


result = solve(boxes, player)
print(len(result))
with open("zad_output.txt", "w") as output:
    print(result, file = output)