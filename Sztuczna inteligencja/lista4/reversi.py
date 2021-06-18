import time
import random
import copy
import math

M = 8
def initial_board():
    B = [ [None] * M for i in range(M)]
    B[3][3] = 1
    B[4][4] = 1
    B[3][4] = 0
    B[4][3] = 0
    return B

weights = [
    [100,-20,10,5,5,10,-20,100],
    [-20,-50,-2,-2,-2,-2,-50,-20],
    [10,-2,-1,-1,-1,-1,-2,10],
    [5,-2,-1,-1,-1,-1,-2,-5],
    [5,-2,-1,-1,-1,-1,-2,-5],
    [10,-2,-1,-1,-1,-1,-2,10],
    [-20,-50,-2,-2,-2,-2,-50,-20],
    [100,-20,10,5,5,10,-20,100],
]

    
def copy_board(board):
    new_board = Board()
    new_board.board = []
    for row in board.board:
        new_board.board.append(row[:])
    new_board.fields = board.fields.copy()
    new_board.move_list = board.move_list[:]
    new_board.history = []
    return new_board

def copy_and_move(board, move, player):
    new_board = copy_board(board)
    new_board.do_move(move, player)
    return new_board


    
class Node:
    def __init__(self, parent, state, move, player):
        self.parent = parent
        self.children = []
        self.possible_moves = state.moves(player)
        self.visits = 0
        self.wins = 0
        self.state = state
        self.move = move
        self.player = player
   
class Board:
    dirs  = [ (0,1), (1,0), (-1,0), (0,-1), (1,1), (-1,-1), (1,-1), (-1,1) ]
    
    def __init__(self):
        self.board = initial_board()
        self.fields = set()
        self.move_list = []
        self.history = []
        for i in range(M):
            for j in range(M):
                if self.board[i][j] == None:   
                    self.fields.add( (j,i) )
                                                
    def draw(self):
        for i in range(M):
            res = []
            for j in range(M):
                b = self.board[i][j]
                if b == None:
                    res.append('.')
                elif b == 1:
                    res.append('#')
                else:
                    res.append('o')
            print(''.join(res))
        print()            
                                   
    def moves(self, player):
        res = []
        for (x,y) in self.fields:
            if any( self.can_beat(x,y, direction, player) for direction in Board.dirs):
                res.append( (x,y) )
        if not res:
            return [None]
        return res               
    
    def can_beat(self, x,y, d, player):
        dx,dy = d
        x += dx
        y += dy
        cnt = 0
        while self.get(x,y) == 1-player:
            x += dx
            y += dy
            cnt += 1
        return cnt > 0 and self.get(x,y) == player
    
    def get(self, x,y):
        if 0 <= x < M and 0 <=y < M:
            return self.board[y][x]
        return None
                        
    def do_move(self, move, player):
        self.history.append([x[:] for x in self.board])
        self.move_list.append(move)
        
        if move == None:
            return
        x,y = move
        x0,y0 = move
        self.board[y][x] = player
        self.fields -= set([move])
        for dx,dy in self.dirs:
            x,y = x0,y0
            to_beat = []
            x += dx
            y += dy
            while self.get(x,y) == 1-player:
              to_beat.append( (x,y) )
              x += dx
              y += dy
            if self.get(x,y) == player:              
                for (nx,ny) in to_beat:
                    self.board[ny][nx] = player
                                                     
    def result(self):
        res = 0
        for y in range(M):
            for x in range(M):
                b = self.board[y][x]                
                if b == 0:
                    res -= 1
                elif b == 1:
                    res += 1
        return res
                
    def terminal(self):
        if not self.fields:
            return True
        if len(self.move_list) < 2:
            return False
        return self.move_list[-1] == self.move_list[-2] == None 

    def random_move(self, player):
        ms = self.moves(player)
        if ms:
            return random.choice(ms)
        return [None]    
    
    def heuristic_positional(self):
        res = 0
        for y in range(M):
            for x in range(M):
                b = self.board[y][x]                
                if b == 1:
                    res += weights[y][x]
                elif b == 0:
                    res -= weights[y][x]
        return res

    def heuristic_absolute(self):
        result = self.result()
        return result

    def heuristic_mobility(self):
        m_max = len(self.moves(1))
        m_min = len(self.moves(0))
        return (m_max - m_min)/(m_max + m_min)

    def heuristic_corners(self):
        corners_result = 0
        corners = [(0,0), (0,7), (7,0), (7,7)]
        for x,y in corners:
            if self.board[x][y] == 1:
                corners_result += 1
            elif self.board[x][y] == 0:
                corners_result -=1
        return corners_result


    def heuristic(self):
        moves = len(self.move_list)
        if self.terminal():
            return 1000000 * self.heuristic_absolute()
        if moves < 50:
            return self.heuristic_positional()
        
        return self.heuristic_absolute()

    def best_move(self, player):
        moves = len(self.move_list)

        #if moves < 15:
        #    return self.alpha_beta(player,1)
        #if moves < 20:
        #    return self.alpha_beta(player,2)
        #if moves < 50:
        #    return self.alpha_beta(player,3)

        return self.alpha_beta(player,5)



    def alpha_beta(self, player, depth):
        def minimax(board, depth, maximazing_player, player, alpha, beta):
            if depth == 0 or board.terminal():
                return board.heuristic()
            
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
                _, min_val = min(ms_heuristic.items(), key = lambda item: item[1])
                ms = [m for m,h in ms_heuristic.items() if h == min_val]
                return random.choice(ms)
            else:
                ms_heuristic = {m : minimax(copy_and_move(self, m, player), depth, False, 1 - player, -math.inf, math.inf) for m in ms}
                _, max_val = max(ms_heuristic.items(), key = lambda item: item[1])
                ms = [m for m,h in ms_heuristic.items() if h == max_val]
                return random.choice(ms)
        return [None]   

    def MCTS(self, player):
        max_time = 0.5
        t = 0
        def Q(node):
            return (node.wins/node.visits) + math.sqrt(math.log10(t)/node.visits)
        def selection(node):

            if not node.possible_moves:
                next_node = max(node.children, key = lambda child: Q(child))
                return selection(next_node)
            else:
                return node
            
        def expansion(node):
            next_move = node.possible_moves[0]
            next_state = copy_and_move(node.state, next_move, node.player)
            next_node = Node(node, next_state, next_move, 1 - node.player)
            node.possible_moves = node.possible_moves[1:]
            node.children.append(next_node)
            return next_node
        def simulation(node):
            simulation_board = copy_board(node.state)
            player = node.player
            while not simulation_board.terminal():
                move = simulation_board.random_move(player)
                simulation_board.do_move(move, player)
                player = 1 - player

            result = simulation_board.result()
            if result > 0: 
                return 1
            return 0

        def backup(node, win):
            node.visits += 1
            if win == player:
                node.wins += 1
            if node.parent != None:
                backup(node.parent, win)

        #Node(parent, board, move, player)
        root = Node(None, self, None, player)
        mcts_start_time = time.time()
        while (time.time() - mcts_start_time) < max_time:
            t += 1
            node = selection(root)
            next_node = expansion(node)
            result = simulation(next_node)
            backup(next_node,result)

        print(t)

        
        ms_mcts = {node.move : node.visits for node in root.children}
        _, max_val = max(ms_mcts.items(), key = lambda item: item[1])
        ms = [m for m,h in ms_mcts.items() if h == max_val]
        return random.choice(ms)

def play(player_number):
    player = 0
    board = Board()
    while not board.terminal():
        move = None
        if player == player_number:
            move = board.MCTS(player)
        else:
            move = board.random_move(player)
        board.do_move(move, player)
        player = 1 - player

    result = board.result()
    return result

print("MCTS first (mcts 0, random 1)")
player = 0
for i in range(5):
    result = play(player)
    if result == 0:
        print("draw")
    elif result > 0:
        print("random wins - " + str(result))
    else:
        print("mcst wins - " + str(result))


print("MCTS second (random 0, mcts 1)")
player = 1
for i in range(5):
    result = play(player)
    if result == 0:
        print("draw")
    elif result > 0:
        print("mcts wins - " + str(result))
    else:
        print("random wins - " + str(result))




