def vat_faktura(lista):
    return sum(lista)*0.23

def vat_paragon(lista):
    suma = 0
    for e in lista:
        suma += e*0.23
    return suma


zakupy = [0.2, 0.5, 4.59, 6]
zakupy2 = [1, 2, 3]

print(vat_faktura(zakupy) == vat_paragon(zakupy))
print(vat_faktura(zakupy2) == vat_paragon(zakupy2))
