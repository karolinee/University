import chess
import chess.engine
import random
import math
import time

class AgentHillClimbing:
    def __init__(self, board):
        self.board = board
        self.pieces_values = {
            chess.PAWN: 1,
            chess.KNIGHT: 2,
            chess.BISHOP: 3,
            chess.ROOK: 5,
            chess.QUEEN: 9,
            chess.KING: 200}

    def make_move(self):
        legal_moves = self.board.legal_moves
        if self.board.fullmove_number == 1 and chess.Move.from_uci("e2e4") in legal_moves:
            return chess.Move.from_uci("e2e4")
        if self.board.fullmove_number == 2 and chess.Move.from_uci("f1c4") in legal_moves:
            return chess.Move.from_uci("f1c4")
        if self.board.fullmove_number == 3 and chess.Move.from_uci("d1h5") in legal_moves:
            return chess.Move.from_uci("d1h5")

        ms_heuristic = {move : self.score(move) for move in legal_moves}
        _, max_score = max(ms_heuristic.items(), key = lambda x: x[1])
        ms = [m for m,h in ms_heuristic.items() if h == max_score]
        return random.choice(ms)
    def score(self, move):
        result = 0
        self.board.push(move)

        if self.board.outcome() is not None:
            winner = self.board.outcome().winner
            if winner is None:
                result = -math.inf
            elif winner == chess.WHITE:
                result =  math.inf
            else:
                result = -math.inf
        else:
            for piece, score in self.pieces_values.items():
                result += len(self.board.pieces(piece, chess.WHITE)) * score
                result -= len(self.board.pieces(piece, chess.BLACK)) * score

        self.board.pop()
        return result
    def quit(self):
        pass

class AgentRandom:
    def __init__(self, board):
        self.board = board

    def make_move(self):
        return self.make_move_random()

    def make_move_random(self):
        legal_moves = list(self.board.legal_moves)
        return random.choice(legal_moves)

class AgentStockfish:
    def __init__(self, board):
        self.board = board
        self.engine = chess.engine.SimpleEngine.popen_uci("/usr/games/stockfish")
        self.limit = chess.engine.Limit(time=0.002)

    def make_move(self):
        return self.engine.play(self.board, self.limit).move

    def quit(self):
        self.engine.quit()


def play(white_agent, games = 50):
    score = 0
    for _ in range(games):
        board = chess.Board()
        white = white_agent(board)
        black = AgentRandom(board)
        fullmoves_correction = 0
        for i in range(100):
            move = white.make_move()
            board.push(move)
            if board.outcome() is not None:
                fullmoves_correction = 1
                break
            board.push(black.make_move())
            if board.outcome() is not None:
                break
        if board.outcome() is None:
            score -= 100 
        elif board.outcome().winner is None:
            score -= 100 
        elif board.outcome().winner == chess.WHITE:
            score += (100 - board.fullmove_number - fullmoves_correction)
        else:
            score -= 1000
        white.quit()
    return score/games

print("My agent " + str(play(AgentHillClimbing)))
print("Stockfish " + str(play(AgentStockfish)))


