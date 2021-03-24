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
  
    #print(solution)
    return " ".join(reversed(solution))

with open("words_for_ai1.txt") as f:
    words = [word.strip() for word in f]

words_len_square = {word: len(word) ** 2 for word in words}
max_word_len = max(len(word) for word in words)
test_text = "tamatematykapustkinieznosi" 

with open("zad2_input.txt", "r") as input, open("zad2_output.txt", "w") as output:
    for line in input:
        result = split(line.strip())
        print(result, file = output)