import sys
import math
from collections import deque


letters = {'a':1, 'b':2, 'c':3, 'd':4, 'e':5, 'f':6, 'g':7, 'h':8}
digits = {1: 'a', 2: 'b', 3: 'c', 4: 'd', 5: 'e', 6: 'f', 7: 'g', 8: 'h'}

king_moves = [(0,1),(1,1),(1,0),(1,-1),(0,-1),(-1,-1),(-1,0),(-1,1)]
rook_moves = [(0, y) for y in range(-7,0)] + [(0, y) for y in range(1,8)] + [(x,0) for x in range(-7,0)] + [(x,0) for x in range(1,8)]

def get_king_moves(king, white_rook, other_king, black):
    possible = []
    rook_capture = False

    for move in king_moves:
        new_x = king[0] + move[0]
        new_y = king[1] + move[1]
        
        valid = True
        #nowe koordynaty nie mieszcza sie w planszy
        if not(new_x in range(1,9) and new_y in range(1,9)):
            valid = False
        
        #sprawdzenie wiezy (bialy czy nie wejdzie, czarny + czy nie szachowany)
        if (new_x, new_y) == white_rook:
            valid = False
            if black:
                rook_capture = True

        if (new_x, new_y) == other_king:
            valid = False

        
        if black:
            if new_x == white_rook[0] or new_y == white_rook[1]:
                valid = False
            
        for move_other in king_moves:
            new_other_x = other_king[0] + move_other[0]
            new_other_y = other_king[1] + move_other[1]
            if (new_x, new_y) == (new_other_x, new_other_y):
                valid = False
                break

        if valid:
            possible.append((new_x, new_y))

    #zabezpieczenie przed zbiciem wieży
    if not possible and rook_capture:
        return -1

    return possible


def get_rook_moves(white_king, white_rook, black_king):
    possible = []
    for move in rook_moves:
        new_x = white_rook[0] + move[0]
        new_y = white_rook[1] + move[1]

        valid = True

        if not(new_x in range(1,9) and new_y in range(1,9)):
            valid = False

        if (new_x, new_y) == white_king or (new_x, new_y) == black_king:
            valid = False
        #do sprawdzenia przeskakiwanie + bicie /stanie na glowie
        if new_y == white_king[1] and ((white_rook[0] < white_king[0] and new_x >= white_king[0]) or (white_rook[0] > white_king[0] and new_x <= white_king[0])):
            valid = False

        if new_x == white_king[0] and ((white_rook[1] < white_king[1] and new_y >= white_king[1]) or (white_rook[1] > white_king[1] and new_y <= white_king[1])):
            valid = False

        if new_y == black_king[1] and ((white_rook[0] < black_king[0] and new_x >= black_king[0]) or (white_rook[0] > black_king[0] and new_x <= black_king[0])):
            valid = False

        if new_x == black_king[0] and ((white_rook[1] < black_king[1] and new_y >= black_king[1]) or (white_rook[1] > black_king[1] and new_y <= black_king[1])):
            valid = False

        for move_other in king_moves:
            new_other_x = black_king[0] + move_other[0]
            new_other_y = black_king[1] + move_other[1]
            if (new_x, new_y) == (new_other_x, new_other_y):
                valid = False
                break
        
        if valid:
            possible.append((new_x, new_y))
        
    return possible


def is_check(white_king, white_rook, black_king):
    for move in king_moves:
        new_x = white_king[0] + move[0]
        new_y = white_king[1] + move[1]
        if black_king == (new_x, new_y):
            return True

    return white_rook[0] == black_king[0] or white_rook[1] == black_king[1]

def print_checkmate(prev, state):
    path = [state]
    while state in prev:
        path.append(prev[state])
        state = prev[state]
    path.reverse()
    output = []
    length = len(path)
    for i in range(1,length):
        player = path[i][0]
        old = path[i-1][3]
        new = path[i][3]
        if player == 'black':
            old = path[i-1][1]
            new = path[i][1]
            if old == new:
                old = path[i-1][2]
                new = path[i][2]
        output.append(digits[old[0]] + str(old[1]) + digits[new[0]] + str(new[1]))
    print(' '.join(output))

def solve(starting_state):
    visited = set()
    prev = dict()
    queue = deque()
    queue.append((starting_state, 0))
    visited.add(starting_state)
    while queue:
        state = queue.popleft()
        current_state, steps = state

        player, white_king, white_rook, black_king = current_state
            
        if player == 'black':
            moves = get_king_moves(black_king, white_rook, white_king, True)
            if moves == -1:
                continue
            if not moves and is_check(white_king, white_rook, black_king):
                print_checkmate(prev, current_state)
                return steps
        
            for move in moves:
                new_state = ("white", white_king, white_rook, move)
                if new_state not in visited:
                    visited.add(new_state)
                    prev[new_state] = current_state
                    queue.append((new_state, steps + 1))

        else:
            moves = get_king_moves(white_king, white_rook, black_king, False)
            for move in moves:
                new_state = ("black", move, white_rook, black_king)
                if new_state not in visited:
                    visited.add(new_state)
                    prev[new_state] = current_state
                    queue.append((new_state, steps + 1))
              
            movesr = get_rook_moves(white_king, white_rook, black_king)
            for move in movesr:
                new_state = ("black", white_king, move, black_king)
                if new_state not in visited:
                    visited.add(new_state)
                    prev[new_state] = current_state
                    queue.append((new_state, steps + 1))


player, white_king, white_rook, black_king = input().split()      
state = (player, (letters[white_king[0]],int(white_king[1])), (letters[white_rook[0]],int(white_rook[1])), (letters[black_king[0]],int(black_king[1])))
result = solve(state)
print(result, file=sys.stderr, flush=True)