nominaly = [20, 10, 5, 2, 1]
kwota = int(input("Jaką masz kwote do zapłacenia? "))
i = 0
while kwota > 0:
    if kwota >= nominaly[i]:
        ile = kwota//nominaly[i]
        kwota -= ile*nominaly[i]
        print(ile," x ", nominaly[i], "zł")
    i += 1
