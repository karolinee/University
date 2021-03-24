from random import sample, randint


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


def numerals_win_propability(numerals_deck, figures_deck = figures):
    numerals_win = 0
    games = 10000
    hands = [straight_flush, four_of_a_kind, full_house, flush, straight, triple, double_pair, pair]
    for _ in range(0, games):
        figures_hand = sample(figures_deck, 5)
        numerals_hand = sample(numerals_deck, 5)

        #jeżeli figurant ma jakiś układ to wygrywa z blotkarzem
        #dodatkowo figurant w najgorszym wypadku będzie miał co najmniej parę
        for hand in hands:
            if hand(figures_hand):
                break
            if hand(numerals_hand):
                numerals_win += 1
                break
        

    return numerals_win/games

def best_numeral_deck_random(n):  
    best_deck = []
    best_result = 0
        
    for _ in range(0, * 100):
        deck = sample(numerals, n)
        result = numerals_win_propability(deck)
        if result > best_result:
            best_result = result
            best_deck = deck
        

    print(best_deck)
    print(best_result)

def check_deck_sizes():
    for i in range(5, 36):
        print("deck with " + str(i) + " cards: ")
        best_numeral_deck_random(i)

def best_numeral_deck_determined():
    deck1 = [(0, x) for x in range(2, 11)]
    print("one suit deck (with " + str(len(deck1)) + " cards)")
    print(numerals_win_propability(deck1))

    deck2 = [(x,y) for x in range(0,4) for y in range(8,11)]
    print("all suits deck, only 8,9,10 (with " + str(len(deck2)) + " cards)")
    print(numerals_win_propability(deck2))



print("no modificatations to numerals deck: ")        
print(numerals_win_propability(numerals))
print("best deck: ")
#print(best_numeral_deck_random(9))
best_numeral_deck_determined()
#check_deck_sizes()

#przy 9 losowych kartach mamy prawdopodobieństo na poziomie ~50%, jednak możemy wybrać też 12 nielosowych kart - 8,9,10 wszystkich kolorów co daje nam szansę wygranej powyżej 50% (mamy pewną szansę na co najgorzej dwie pary),
#albo też możemy wziać talię z 9 kartami, cały jeden kolor, co zapewnia wygraną na poziomie 90%