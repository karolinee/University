from enum import Enum
import random
import time
import math

width = 7
height = 9
#steps = 0

def copy_board(board):
    new_board = Board()
    new_board.board = []
    for row in board.board:
        new_board.board.append(row[:])
    new_board.move_list = board.move_list[:]
    new_board.moves_without_eating= board.moves_without_eating
    return new_board

def copy_and_move(board, move, player):
    new_board = copy_board(board)
    new_board.do_move(move, player)
    return new_board

class Animals(Enum):
    R = 1 #rat
    C = 2 #cat
    D = 3 #dog
    W = 4 #wolf
    J = 5 #panther?
    T = 6 #tiger
    L = 7 #lion
    E = 8 #elephant

def initial_board():
    board = [ [None] * width for i in range(height)]
    
    board[0][0] = (1, Animals.L)
    board[0][6] = (1, Animals.T)
    board[1][1] = (1, Animals.D)
    board[1][5] = (1, Animals.C)
    board[2][0] = (1, Animals.R)
    board[2][2] = (1, Animals.J)
    board[2][4] = (1, Animals.W)
    board[2][6] = (1, Animals.E)

    board[8][6] = (0, Animals.L)
    board[8][0] = (0, Animals.T)
    board[7][5] = (0, Animals.D)
    board[7][1] = (0, Animals.C)
    board[6][6] = (0, Animals.R)
    board[6][4] = (0, Animals.J)
    board[6][2] = (0, Animals.W)
    board[6][0] = (0, Animals.E)
    return board




class Board:
    dirs  = [ (0,1), (1,0), (-1,0), (0,-1)]
    animals = ['R', 'C', 'D', 'W', 'J', 'T', 'L', 'E']

    traps = {(0,2),(0,4),(1,3), (7,3), (8,2), (8,4)}
    rivers = {(3,1), (3,2), (3,4), (3,5),
             (4,1), (4,2), (4,4), (4,5),
             (5,1), (5,2), (5,4), (5,5)}
    dens = [(8, 3), (0,3)]
    #dens[0] - dolna
    #dens[1] - górna

    def __init__(self):
        self.board = initial_board()
        self.move_list = []
        self.moves_without_eating = 0

    def draw(self):
        print(''.join([' ']+[str(i) for i in range(7)]))
        for x in range(height):
            res = []
            res.append(str(x))
            for y in range(width):
                if self.board[x][y] is None:
                    if (x,y) in Board.dens:
                        res.append('*')
                    elif (x,y) in Board.rivers:
                        res.append('~')
                    elif (x,y) in Board.traps:
                        res.append('#')
                    else:
                        res.append('.')
                else:
                    player, piece = self.board[x][y]
                    if player == 0:
                        res.append(piece.name.lower())
                    else:
                        res.append(piece.name)
            print(''.join(res))
        print()

    def moves(self, player):
        result = []
        for x in range(height):
            for y in range(width):
                if self.board[x][y] is None:
                    continue
                _player, _piece = self.board[x][y]
                if _player == player:
                    for dir in Board.dirs:
                        dx, dy = dir
                        nx, ny = x + dx, y + dy
                        #sprawdzamy czy jesteśmy w planszy
                        if 0 <= nx < height and 0 <= ny < width:
                            #nie można wejść do swojej jamy
                            if Board.dens[player] == (nx, ny):
                                continue
                            #wejście lub przeskoczenie wody
                            if (nx, ny) in Board.rivers:
                                if _piece != Animals.R and _piece != Animals.T and _piece != Animals.L:
                                    continue
                                if _piece == Animals.T or _piece == Animals.L:
                                    blocked = False
                                    while (nx,ny) in Board.rivers:
                                        #na wikipedii informacja ze nie wolno skakać nad żadnym szczurem?
                                        if self.board[nx][ny] is not None:
                                            blocked = True
                                            break
                                        nx, ny = nx + dx, ny + dy
                                    #czy szczur blokuje    
                                    if blocked:
                                        continue
                            if self.board[nx][ny] is not None:
                                if not self.can_beat((x,y),(nx,ny)):
                                    continue
                            result.append(((x,y),(nx,ny)))
        if not result:
            return [None]
        return result

    def can_beat(self, p, o):
        px, py = p
        ox, oy = o
        player, player_piece = self.board[px][py]
        opponent, opponent_piece = self.board[ox][oy]
        if player == opponent:
            return False
        if p in Board.rivers and o in Board.rivers:
            return True
        if p in Board.rivers:
            return False
        if player_piece == Animals.R and opponent_piece == Animals.E:
            return True
        if player_piece == Animals.E and opponent_piece == Animals.R:
            return False
        if player_piece.value >= opponent_piece.value:
            return True
        if o in Board.traps:
            return True

        return False

    def do_move(self, move, player):
        if move == None:
            return
        move_from, move_to = move
        x, y = move_from
        dx, dy = move_to

        _player, _piece = self.board[x][y]

        # dodatkowe zasady
        if self.board[dx][dy]:
            self.moves_without_eating = 0
        else:
            self.moves_without_eating += 1

        self.board[x][y] = None
        self.board[dx][dy] = (_player, _piece)


    def result(self):
        for i in [0,1]:
            x, y = Board.dens[i]
            if self.board[x][y] is not None:
                return 1 - i
        
        pieces_0 = 0
        oldest_0 = 0
        pieces_1 = 0
        oldest_1 = 0

        for x in range(height):
            for y in range(width):
                if self.board[x][y] is None:
                    continue
                player, piece = self.board[x][y]
                if player == 0:
                    pieces_0 += 1
                    if piece.value > oldest_0:
                        oldest_0 = piece.value
                if player == 1:
                    pieces_1 += 1
                    if piece.value > oldest_1:
                        oldest_1 = piece.value

        if pieces_0 == 0:
            return 1
        
        if pieces_1 == 0:
            return 0

        if oldest_0 > oldest_1:
            return 0

        return 1

    def terminal(self):
        if self.moves_without_eating > 30:
            return True
        for i in [0,1]:
            x, y = Board.dens[i]
            if self.board[x][y] is not None:
                return True

        pieces_0 = 0
        pieces_1 = 0

        for x in range(height):
            for y in range(width):
                if self.board[x][y] is None:
                    continue
                player, piece = self.board[x][y]
                if player == 0:
                    pieces_0 += 1
                if player == 1:
                    pieces_1 += 1
        
        if pieces_0 == 0 or pieces_1 == 0:
            return True

        return False
    
    def random_move(self, player):
        ms = self.moves(player)
        if ms:
            return random.choice(ms)
        return [None] 

    def agent1(self, player):
        def simulation(board, p):
            global steps
            result = 0
            for _ in range(4):
                b = copy_board(board)
                while not b.terminal():
                    move = b.random_move(p)
                    b.do_move(move, p)
                    p = 1-p
                    steps+=1
                if player == b.result():
                    result += 1
            return result
            
        ms = self.moves(player)
        ms_heuristic = {m : simulation(copy_and_move(self, m,player),1-player) for m in ms}
        ms = [m for m,h in sorted(ms_heuristic.items(), key = lambda x: x[1], reverse = True)]
        return ms[0]

    def agent2(self, player):
        return self.alpha_beta(player,3)

    def heuristic(self, player):
        def dist(x0, y0, x1, y1):
            return abs(x0-x1) + abs(y0-y1)

        pieces_0 = 0
        oldest_0 = 0
        pieces_1 = 0
        oldest_1 = 0

        for x in range(height):
            for y in range(width):
                if self.board[x][y] is None:
                    continue
                player, piece = self.board[x][y]
                if player == 0:
                    pieces_0 += dist(x,y,0,3)
                    if piece.value > oldest_0:
                        oldest_0 = piece.value
                if player == 1:
                    pieces_1 += dist(x,y,8,3)
                    if piece.value > oldest_1:
                        oldest_1 = piece.value
        pieces_dist = 0
        if player == 1:
            pieces_dist = pieces_1
        else:
            pieces_dist = -pieces_0

        return oldest_1 - oldest_0 - pieces_dist

    
    def alpha_beta(self, player, depth):
        def minimax(board, depth, maximazing_player, player, alpha, beta):
            if depth == 0 or board.terminal():
                return board.heuristic(player)
            
            moves = board.moves(player)
            if maximazing_player:
                max_eval = -math.inf
                for move in moves:
                    eval = minimax(copy_and_move(board, move, player),depth - 1, False, 1 - player, alpha, beta)
                    max_eval = max(max_eval, eval)
                    alpha = max(alpha, eval)
                    if beta <= alpha:
                        break
                return max_eval
            else:
                min_eval = math.inf
                for move in moves:
                    eval = minimax(copy_and_move(board, move, player),depth - 1, True, 1 - player, alpha, beta)
                    min_eval = min(min_eval, eval)
                    beta = min(beta, eval)
                    if beta <= alpha:
                        break
                return min_eval

        ms = self.moves(player)
        if ms:
            if player == 0:
                ms_heuristic = {m : minimax(copy_and_move(self, m, player), depth, True, 1 - player, -math.inf, math.inf) for m in ms}
                ms = [m for m,h in sorted(ms_heuristic.items(), key = lambda x: x[1], reverse = False)]
                return ms[0]
            else:
                ms_heuristic = {m : minimax(copy_and_move(self, m, player), depth, False, 1 - player, -math.inf, math.inf) for m in ms}
                ms = [m for m,h in sorted(ms_heuristic.items(), key = lambda x: x[1], reverse = True)]
                return ms[0]
        return [None]  




a1 = 0
a2 = 0
a1_steps = 0
a2_steps = 0

steps = 0
steps_sum = 0

def play(player_number):
    global a1, a2, a1_steps, a2_steps
    player = 0
    board = Board()
    
    while True:
        move = None
        if player == player_number:
            a2_start = time.time()
            move = board.agent2(player)
            a2_end = time.time() - a2_start
            a2 += a2_end
            a2_steps += 1
        else:
            a1_start = time.time()
            move = board.agent1(player)
            a1_end = time.time() - a1_start
            a1 += a1_end
            a1_steps += 1
        board.do_move(move, player)
        player = 1 - player
        if board.terminal():
            break
    result = board.result()
    if (player_number == 1 and result > 0) or (player_number == 0 and result == 0):
        return 1
    else:
        return 0




start = time.time()
result = 0
for i in range(1000):
    steps = 0
    player = random.randint(0,1)
    result += play(player)
    steps_sum += steps
    if (i + 1) % 100 == 0:
        print(str(result) + '/' + str(i + 1))

game_time = time.time() - start
print('Wins - ' + str(result) + '/1000')
print('Time - ' + str(game_time))
print('Avg a1 time - ' + str(a1/a1_steps))
print('Avg a1 steps in simul - ' + str(steps/1000))
print('Avg a2 time - ' + str(a2/a2_steps))