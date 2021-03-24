import matplotlib.image as mpimg
import matplotlib.pyplot as plt
import numpy as np
import matplotlib._png as png #do czytania jako int


def code(text):
    text_first = []
    text_second = []
    for c in text:
        text_first.append((ord(c) & (15 << 4))>>4)
        text_second.append(ord(c) & 15)

    img = png.read_png_int('new-york-city.png')
    img1 = np.copy(img)
    img2 = np.copy(img)
    for column in img1:
        for cell in column:
            if text_first:
                byte = text_first.pop(0)
            else:
                byte = 0
            cell[0] = (cell[0] & ~(1 << 1)) | ((byte >> 3) << 1)
            for i in range(3):
                cell[i] = (cell[i] & ~(1)) | ((byte & (1 << (2 - i))) >> (2-i))
    plt.imsave('img1.png',img1)

    for column in img2:
        for cell in column:
            if text_second:
                byte = text_second.pop(0)
            else:
                byte = 0
            cell[0] = (cell[0] & ~(1 << 1)) | ((byte >> 3) << 1)
            for i in range(3):
                cell[i] = (cell[i] & ~(1)) | ((byte & (1 << (2 - i))) >> (2-i))
    plt.imsave('img2.png',img2)
    plt.subplot(3,1, 1)
    plt.imshow(img)
    plt.axis('off')
    plt.subplot(3,1, 2)
    plt.imshow(img1)
    plt.axis('off')
    plt.subplot(3,1, 3)
    plt.imshow(img2)
    plt.axis('off')
    plt.show()


def decode():
    img1 = png.read_png_int('img1.png')
    img2 = png.read_png_int('img2.png')
    text_first = []
    text_second = []
    for column in img1:
        for cell in column:
            result = ((cell[0] >> 1) & 1) << 3
            for i in range(3):
                temp = (cell[i] & 1)
                result |= temp << (2-i)
            text_first.append(result << 4)
    for column in img2:
        for cell in column:
            result = ((cell[0] >> 1) & 1) << 3
            for i in range(3):
                temp = (cell[i] & 1)
                result |= temp << (2-i)
            text_second.append(result)
    text = []
    for c,d in zip(text_first,text_second):
        text.append(c | d)
    return "".join(chr(c) for c in text)

code("Hello world!")
print(decode())
