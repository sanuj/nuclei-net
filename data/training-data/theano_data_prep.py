import numpy as np
import matplotlib.image as mpimg
import scipy.misc
import cPickle
import os

root = '/home/sanuj/Projects/'

def dump(x, y, f):
    x = np.array(x, dtype='uint8')
    y = np.array(y, dtype='uint8')
    data = {'x' : x, 'y' : y}
    if not os.path.exists(path):
        os.makedirs(path)
    fi = file(f + '.save', 'wb')
    cPickle.dump(data, fi, protocol=cPickle.HIGHEST_PROTOCOL)
    fi.close()

def rot(x):
    channel = x.shape[0]
    for i in range(channel):
        x[i] = np.rot90(x[i])

def flip(x):
    channel = x.shape[0]
    a = np.copy(x)
    for i in range(channel):
        a[i] = np.fliplr(a[i])
    return a

file_name = root + 'nuclei-net/data/training-data/78_RLM_YR4.jpg'
mask_name = root + 'nuclei-net/data/training-data/bm_78_RLM_YR4.png'
# file_name = root + 'nuclei-net/data/training-data/63_LLM_YR4.jpg'
# mask_name = root + 'nuclei-net/data/training-data/bm_63_LLM_YR4.png'
w = 55
p = (w-1)/2

im = mpimg.imread(file_name)
mask = mpimg.imread(mask_name).astype(int)
mask = mask/np.amax(mask)
height, width, channel = im.shape
image = []
for i in range(channel):
    image.append(im[:,:,i])
image = np.array(image)
image = np.pad(image, ((0,0),(p,p),(p,p)), 'constant', constant_values=255)
mask = np.pad(mask, p, 'constant') # default constant_values=0

path = root + 'nuclei-net/data/training-data/78_RLM_YR4_33_pkl/78_RLM_YR4_'
x = []
y = []
h = 0;
for i in range(p, p+height):
    for j in range(p, p+width):
        if not (image[0,i,j] >= 220 and image[1,i,j] >= 220 and image[2,i,j] >= 220):
            temp_x = image[:, i-p:i+p+1, j-p:j+p+1]
            x.append(temp_x)
            y.append(mask[i,j])
            if mask[i,j] == 1:
                x.append(flip(temp_x))
                y.append(mask[i,j])
                rot(temp_x)
                x.append(temp_x)
                y.append(mask[i,j])
                x.append(flip(temp_x))
                y.append(mask[i,j])
                rot(temp_x)
                x.append(temp_x)
                y.append(mask[i,j])
                x.append(flip(temp_x))
                y.append(mask[i,j])
                rot(temp_x)
                x.append(temp_x)
                y.append(mask[i,j])
                x.append(flip(temp_x))
                y.append(mask[i,j])

            if len(x) >= 100000:
                dump(x, y, path + str(h) + '_' + str(i) + '_' + str(j))
                del x[:]
                del y[:]
                print "dumped " + str(h)
                h = h+1
