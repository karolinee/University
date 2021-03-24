import itertools

def image_reconstruction(horizontal, vertical):
    l = len(horizontal)
    image = [[0]*5 for y in range(l)]
    products = itertools.product([1,0],repeat = l)
    r = c = 0
    while r < l:
        for i in products:
            if sum(i) == horizontal[r]:
                image[r] = list(i)
                break
            #else: return "błąd danych" gdy nie znajdzie takiego ustawienia
        r += 1

    while c < l:
        if sum(image[c] == vertical[c]):
            c += 1
        else:
    

    print(image)


vector_h = [int(x) for x in input().split()]
vector_v = [int(x) for x in input().split()]
image_reconstruction(vector_h, vector_v)
