n=2
for i in range(2**(n)):
        perm = bin(i)[2:].zfill(n)
        var_eval = {j: int(perm[j]) for j in range(n)}
        print(var_eval)
