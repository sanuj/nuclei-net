import numpy as np
import matplotlib.image as mpimg
import scipy.misc
import os

root = '/home/sanuj/Projects/'
file_name = '9.jpg'
label = 9
window_size = 33

def saveIm(im, label, num, i, j):
    path = root + 'nuclei-net/data/whole-slide-classes/' + str(label) + '/'
    name = str(num) + '_' + str(i) + '_' + str(j) + '_' + str(label) + '.jpg'
    if not os.path.exists(path):
        os.makedirs(path)
    text_file = open(path + 'meta.txt', "a")
    scipy.misc.imsave(path + name, im)
    text_file.write(path + name + ' ' + str(label) + '\n')
    print 'saved ' + name + ' in ' + path
    text_file.close()

pad = (window_size - 1) / 2
im = mpimg.imread(file_name)
height, width, channel = im.shape

im_num = 0
for i in range(pad, height-pad, pad/3):
    for j in range(pad, width-pad, pad/3):
        im_window = im[i-pad : i+pad+1, j-pad : j+pad+1, :]
        saveIm(im_window, label, im_num, i, j)
        im_num = im_num + 1
