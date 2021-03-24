from random import choice
from random import randint

def split(str):
    word_len = len(str)

    #start_idx, end_idx, len_square
    dp = [[0, 0, 0]]
    for i in range (1, word_len + 1):
        splits = dp[max(0, i - max_word_len):i]
        max_split = [0, i, 0]
        for s in splits:
            sufix = str[s[1]:i]
            if sufix in words_len_square:
                new_val = s[2] + words_len_square[sufix]
                if(new_val > max_split[2]):
                    max_split = [s[1], i, new_val]
        dp.append(max_split)

    #print(dp)
    end_idx = word_len
    solution = []
    while end_idx > 0:
       start_idx = dp[end_idx][0]
       solution.append(str[start_idx:end_idx])
       end_idx = start_idx
  
    return " ".join(reversed(solution))

def random_split(str):
    word_len = len(str)

    #start_idx, end_idx, len_square
    dp = [[0, 0, 1]]
    for i in range (1, word_len + 1):
        splits = dp[max(0, i - max_word_len):i]
        new_splits = []
        flag = False
        for s in splits:
            if s[2]:
                sufix = str[s[1]:i]
                if sufix in words_len_square:
                    flag = True
                    new_splits.append([s[1], i, 1])
        if flag:
            dp.append(choice(new_splits))
        else:
            dp.append([0,i,0])


    end_idx = word_len
    solution = []
    while end_idx > 0:
       start_idx = dp[end_idx][0]
       solution.append(str[start_idx:end_idx])
       end_idx = start_idx
  
    #print(solution)
    
    #print(solution)
    return " ".join(reversed(solution))

with open("words_for_ai1.txt") as f:
    words = [word.strip() for word in f]

words_len_square = {word: len(word) ** 2 for word in words}
max_word_len = max(len(word) for word in words)

all_lines = 0
lines_score_split = 0
lines_score_random = 0
with open("pan_tadeusz.txt", "r") as inp:
    for line in inp:
        line = line.strip()
        result = split(line.replace(" ", ""))
        result_random = random_split(line.replace(" ", ""))
        #print(line.strip())
        #print(result_random)
        #input()
        if line.strip() == result:
            lines_score_split += 1

        if line.strip() == result_random:
            lines_score_random += 1
        
        all_lines += 1

print(lines_score_split/all_lines)
print(lines_score_random/all_lines)