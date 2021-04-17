from heapq import heappush, heappop
from collections import deque

directions_translate = {0: 'U', 1: 'L', 2: 'R', 3: 'D'}
directions = [(-1,0), (0, -1), (0, 1), (1, 0)]

def finished(positions):
    global goals
    return all(pos in goals for pos in positions)


def fill():
    global paths, maze
    for goal in goals:
        queue = deque()
        paths[goal] = 0
        queue.append((goal, 0))
        while queue:
            pos, steps = queue.popleft()

            for direction in directions:
                new_x = pos[0] + direction[0]
                new_y = pos[1] + direction[1]
                if maze[new_x][new_y] != '#':
                    new_pos = (new_x, new_y)
                    if new_pos not in paths or paths[new_pos] > (steps + 1):
                        paths[new_pos] = steps + 1
                        queue.append((new_pos, steps + 1))
               

                    

def heuristic(positions):
    global maze, width, height, goals, paths
    max_path = 0
    for position in positions:
        if paths[position] > max_path:
            max_path = paths[position]

    return max_path


def solve(positions):
    global maze, width, height, goals

    visited = set()
    queue = []
    heappush(queue, (heuristic(positions), positions, ''))
    visited.add(tuple(sorted(list(positions))))
    while queue:
        f, state, moves = heappop(queue)
        #print(queue)
        #input()

        if finished(state):
            #print(len(moves))
            return moves
        
        for i in range(0,4):
            new_state = set()
            for pos in state:
                new_x = pos[0] + directions[i][0]
                new_y = pos[1] + directions[i][1]
                if maze[new_x][new_y] == '#':
                    new_pos = pos
                else:
                    new_pos = (new_x, new_y)

                new_state.add(new_pos)
            new_state = tuple(sorted(list(new_state)))
            if new_state not in visited:
                visited.add(new_state)
                heappush(queue, (len(moves) + 1 + heuristic(new_state), new_state, moves + directions_translate[i]))



positions = set()
goals = set()

maze = []
paths = dict()

with open("zad_input.txt", "r") as data:
    for line in data:
        maze.append(list(line.strip()))

width = len(maze[0])
height = len(maze)

for i in range(height):
    for j in range(width):
        if maze[i][j] == 'G':
            goals.add((i,j))
        if maze[i][j] == 'S':
            positions.add((i,j))
        if maze[i][j] == 'B':
            goals.add((i,j))
            positions.add((i,j))
fill()
result = solve(positions)
with open("zad_output.txt", "w") as output:
    print(result, file = output)




