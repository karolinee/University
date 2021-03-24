import random

def uprosc_zdanie(tekst, dl_slowa, liczba_slow):
    words = tekst.split()

    words = [w for w in words if len(w) <= dl_slowa]
    l = len(words)
    while l > liczba_slow:
        r = random.randint(0,l-1)
        del words[r]
        l -= 1
    words[0] = words[0].capitalize()
    return " ".join(words)

def uprosc_tekst(tekst, dl_slowa, liczba_slow):
    sentences = tekst.split(".")
    sentences = [uprosc_zdanie(s, dl_slowa, liczba_slow) for s in sentences[:-1]]
    return ". ".join(sentences)



i = input()
print(uprosc_tekst(i,8,5))
