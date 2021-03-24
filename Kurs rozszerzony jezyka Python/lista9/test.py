import matplotlib.image as mpimg
import matplotlib.pyplot as plt
import numpy as np
import matplotlib._png as png #do czytania jako int


def code(text):

    #rozłożenie tekstu na dwie części - każda litera dzielona na 2
    texts = [[],[]]
    for c in text:
        texts[0].append((ord(c) & (15 << 4))>>4)
        texts[1].append(ord(c) & 15)

    #odczytanie oryginalnego obrazka i stworzenie 2 kopii
    img = png.read_png_int('new-york-city.png')
    img1 = np.copy(img.reshape(-1,4))
    img2 = np.copy(img.reshape(-1,4))
    cell = [None] * 2

    #zmiana LSB na nowe dane (w pierwszym kolorze zmieniamy 2 LSB)
    for cell[0],cell[1] in zip(img1,img2):
        for j in range(2):
            if texts[j]:
                byte = texts[j].pop(0)
            else:
                byte = 0
            cell[j][0] = (cell[j][0] & ~(1 << 1)) | ((byte >> 3) << 1)
            for i in range(3):
                cell[j][i] = (cell[j][i] & ~(1)) | ((byte & (1 << (2 - i))) >> (2-i))
    plt.imsave('img1.png',img1.reshape(300,600,4))
    plt.imsave('img2.png',img2.reshape(300,600,4))

    plt.subplot(3,1, 1)
    plt.imshow(img)
    plt.axis('off')
    plt.subplot(3,1, 2)
    plt.imshow(img1.reshape(300,600,4))
    plt.axis('off')
    plt.subplot(3,1, 3)
    plt.imshow(img2.reshape(300,600,4))
    plt.axis('off')
    plt.show()


def decode():
    img1 = png.read_png_int('img1.png')
    img2 = png.read_png_int('img2.png')
    texts = [[],[]]
    cell = [None] * 2
    #wyciąganie wartości LSB i zapisywanie
    for cell[0],cell[1] in zip(img1.reshape(-1,4),img2.reshape(-1,4)):
        for j in range(2):
            result = ((cell[j][0] >> 1) & 1) << 3
            for i in range(3):
                temp = (cell[j][i] & 1)
                result |= temp << (2-i)
            texts[j].append(result)

    text = []
    for c,d in zip(texts[0],texts[1]):
        text.append(c << 4| d)
    return "".join(chr(c) for c in text)

code("Hello world!")
print(decode())
