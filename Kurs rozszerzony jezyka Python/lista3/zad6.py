def komp_zdanie(w):
    l = [(1,a) for a in w]
    i = 1
    while i < len(l):
        if l[i][1] == l[i-1][1]:
            l[i-1] = (l[i-1][0] + 1, l[i-1][1])
            del l[i]
        else:
            i += 1
    w = [a if x == 1 else str(x) + a for (x,a) in l ]
    return "".join(w)

def komperesja(tekst):
    words = tekst.split()
    for i in range(len(words)):
        words[i] = komp_zdanie(words[i])
    return " ".join(words)

def dekomp_zdanie(w):
    nowy = ''
    i = 0
    dl = len(w)
    while i < dl:
        if w[i].isnumeric() and i+1 < dl and w[i+1].isalpha():
            nowy += int(w[i]) * w[i+1]
            i += 2
        else:
            nowy += w[i]
            i += 1
    return nowy

def dekompresja(tekst):
    words = tekst.split()
    for i in range(len(words)):
        words[i] = dekomp_zdanie(words[i])
    return " ".join(words)




w = komperesja("aaaalla ma koooota")
print(w)
print(dekompresja(w))
