from random import randint
from collections import deque

directions_translate = {0: 'U', 1: 'R', 2: 'D', 3: 'L'}
directions = [(-1,0), (0, 1), (1, 0), (0, -1)]

def finished(positions):
    global goals
    return all(pos in goals for pos in positions)


def lower_uncertainity(old_positions, uncertain, moves, limit):
    global maze

    if len(old_positions) <= uncertain or len(moves) > limit:
        return old_positions, moves
    
    move = randint(0,3)
    changed = False
    new_positions = set()
    for position in old_positions:
        new_x = position[0] + directions[move][0]
        new_y = position[1] + directions[move][1]

        if maze[new_x][new_y] == '#':
            new_positions.add(position)
        else:
            new_positions.add((new_x, new_y))
            changed = True

    if changed:
        moves += directions_translate[move]

    return lower_uncertainity(new_positions, uncertain, moves, limit)

def lower_rand(old_positions, uncertain, moves, limit):
    best_len = 150
    best_pos = old_positions
    best_moves = moves
    for _ in range(10000):
        position, m = lower_uncertainity(old_positions, uncertain, moves, limit)
        if len(position) <= uncertain and len(m) < best_len:
            best_len = len(m)
            best_pos = position
            best_moves = m

    return best_pos, best_moves

def lower(positions, uncertain, limit):
    global maze, width, height
    moves = ''
    visited = set()
    queue = deque()
    queue.append((positions, ''))
    shortes = len(positions)
    visited.add(tuple(positions))
    while queue:
        state, moves = queue.popleft()

        if len(state) <= uncertain or len(moves) > limit:
            #print(len(state))
            #print(len(moves))
            #print(limit)
            return state, moves
        
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
            new_state = tuple(new_state)
            if new_state not in visited:
                if len(new_state) < shortes:
                    queue.clear()
                    visited.clear()
                    visited.add(new_state)
                    shortes = len(new_state)
                    queue.append((new_state, moves + directions_translate[i]))
                    break

                visited.add(new_state)
                queue.append((new_state, moves + directions_translate[i]))
    
    
    return positions, moves


def solve(positions):
    global maze, width, height, goals
    moves = []
    new_positions, moves_random = lower(positions, 2, 150 - 2*(height + width))
    #new_positions, moves_random = lower_rand(positions, 3, '',150 - 2*(height + width))
    print(new_positions)

    visited = set()
    queue = deque()
    queue.append((new_positions, ''.join(moves_random)))
    visited.add(tuple(new_positions))
    while queue:
        state, moves = queue.popleft()

        if finished(state):
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
            new_state = tuple(new_state)
            if new_state not in visited:
                visited.add(new_state)
                queue.append((new_state, moves + directions_translate[i]))



positions = set()
goals = set()

maze = []

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

result = solve(positions)
#print(len(result))
with open("zad_output.txt", "w") as output:
    print(result, file = output)




