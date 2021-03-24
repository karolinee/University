def szyfruj(tekst, klucz):
    szyfr = ""
    for e in tekst:
        szyfr += chr(ord(e)^klucz)
    return szyfr

def odszyfruj(szyfr, klucz):
    return szyfruj(szyfr, klucz)


print(szyfruj("Python",7))

print(odszyfruj(szyfruj("Python",7),7))
