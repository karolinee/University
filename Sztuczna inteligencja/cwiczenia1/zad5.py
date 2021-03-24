from random import sample, randint
from itertools import combinations
import math

figures = [(suit, figure) for suit in range(0,4) for figure in range(11,15)] #11 = walet, 12 = dama, 13 = król, 14 = as
numerals = [(suit, numeral) for suit in range(0,4) for numeral in range(2,11)]


def number(hand, n):
    kinds = [0 for i in range(2,15)]
    for card in hand:
        kinds[card[1] - 2] += 1
    return kinds.count(n)

def straight_flush(hand):
    return flush(hand) and straight(hand)

def four_of_a_kind(hand):
    return number(hand, 4) == 1

def full_house(hand):
    return pair(hand) and triple(hand)

def flush(hand):
    suits = [0 for _ in range(0,4)]
    for card in hand:
        suits[card[0]] += 1
    return any(suits[i] == 5 for i in range(0,4))

def straight(hand):
    hand.sort(key = lambda x: x[1])
    for i in range(1,5):
        if hand[i][1] != hand[i-1][1] + 1:
            return False
    return True 

def triple(hand):
    return number(hand, 3) == 1

def double_pair(hand):
    return number(hand, 2) == 2

def pair(hand):
    return number(hand, 2) == 1


def calculate_prop():
    numerals_wins = 0

    numerals_all_hands = math.comb(9*4,5)
    figures_all_hands = math.comb(4*4,5)
    figures_tmp = figures_all_hands #pomocniczo do obliczania

    hands = [straight_flush, four_of_a_kind, full_house, flush, straight, triple, double_pair, pair]
    hands_numerals_count = {straight_flush: 0, four_of_a_kind: 0, full_house:0, flush: 0, straight: 0, triple: 0, double_pair: 0, pair: 0}
    hands_figures_count = {straight_flush: 0, four_of_a_kind: 0, full_house:0, flush: 0, straight: 0, triple: 0, double_pair: 0, pair: 0}

    #ile jest jakich ułożeń dla blotkarza
    for numeral_hand in combinations(numerals, 5):
        for hand in hands_numerals_count:
            if hand(list(numeral_hand)):
                hands_numerals_count[hand] += 1
                break

    #ile jest jakich ułożeń dla figuranta
    for figure_hand in combinations(figures, 5):
        for hand in hands_figures_count:
            if hand(list(figure_hand)):
                hands_figures_count[hand] += 1
                break
    
    #od wszystkich ułożeń dla figuratna odejmujemy aktualnie rozważane - te ułożenia figurata przegrywają z aktualnie rozważanym ułożeniem blotkarza
    for hand in hands_numerals_count:
        figures_tmp -= hands_figures_count[hand]
        numerals_wins += hands_numerals_count[hand] * figures_tmp


    print((numerals_wins/(numerals_all_hands * figures_all_hands))*100)
    

calculate_prop()