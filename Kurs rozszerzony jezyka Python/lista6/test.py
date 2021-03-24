import re
d = "Na przykład nie testuje się praw dostępu do pliku przed jego otwarciem. Styl programowania w Pythonie zaleca stosowanie wyjątków zawsze, gdy może pojawić się błąd wykonania.  lecz po prostu próbuje się go otworzyć, przechwytując wyjątek w razie braku dostępu.  Dekoratory [ edytuj | edytuj kod ]  W wersji 2.4 wprowadzono nowy element składni – notację dekoratora ."

pattern = re.compile(r'([A-Z][^.!?]*Python[^.!?]*[.!?])')
result = pattern.findall(d)

print(result)
