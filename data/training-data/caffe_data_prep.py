# Prepares data by saving patches of size 'w' from the whole slide image. Also creates a
# meta text file for Caffe which has the patch name and it's corresponding label.
import numpy as np
import matplotlib.image as mpimg
import scipy.misc
import os

root = '/home/sanuj/Projects/'

def saveIm(im, label, h, i, j, k):
    path = root + 'nuclei-net/data/training-data/78_RLM_YR4_3_class_31/' + str(k) + '/'
    # path = root + 'nuclei-net/data/training-data/63_LLM_YR4_3_class_31/' + str(k) + '/'
    name = str(h)+'_'+str(i)+'_'+str(j)+'_'+str(label)+'.jpg'
    if not os.path.exists(path):
        os.makedirs(path)
    text_file = open(path + 'meta.txt', "a")
    scipy.misc.imsave(path + name, im)
    text_file.write(path + name + ' ' + str(label) + '\n')
    print 'saved ' + name + ' in ' + path
    text_file.close()

file_name = root + 'nuclei-net/data/training-data/78_RLM_YR4.jpg'
mask_name = root + 'nuclei-net/data/training-data/tm_78_RLM_YR4.png'
# file_name = root + 'nuclei-net/data/training-data/63_LLM_YR4.jpg'
# mask_name = root + 'nuclei-net/data/training-data/tm_63_LLM_YR4.png'
w = 31          #window size
p = (w-1)/2     #padding

im = mpimg.imread(file_name)
# mask = mpimg.imread(mask_name).astype(int) # 2 classes
mask = (mpimg.imread(mask_name)*2).astype(int)
# mask = mask/np.amax(mask)
height, width, channel = im.shape

image = np.pad(im, ((p,p),(p,p),(0,0)), 'constant', constant_values=255)
mask = np.pad(mask, p, 'constant') # default constant_values=0

h = 0;
k = 0;
# num_l = [0, 0] # 2 classes
num_l = [0, 0, 0] # 3 classes
for i in range(p, p+height):
    for j in range(p, p+width):
        if h >= 25000:
            k = k+1
            h = 0
        if not (image[i,j] >= [220, 220, 220]).all():
            temp_x = image[i-p:i+p+1, j-p:j+p+1, :]
            saveIm(temp_x, mask[i, j], h, i, j, k)
            h = h+1
            num_l[mask[i, j]] = num_l[mask[i, j]]+1
            if mask[i,j] == 1 or mask[i,j] == 2:
            # if mask[i,j] == 1:
                # saveIm(np.fliplr(temp_x), mask[i, j], h, i, j, k)
                # h = h+1
                # num_l[mask[i, j]] = num_l[mask[i, j]]+1
                temp_x = np.rot90(temp_x)
                saveIm(temp_x, mask[i, j], h, i, j, k)
                h = h+1
                num_l[mask[i, j]] = num_l[mask[i, j]]+1
                # saveIm(np.fliplr(temp_x), mask[i, j], h, i, j, k)
                # h = h+1
                # num_l[mask[i, j]] = num_l[mask[i, j]]+1
                temp_x = np.rot90(temp_x)
                saveIm(temp_x, mask[i, j], h, i, j, k)
                h = h+1
                num_l[mask[i, j]] = num_l[mask[i, j]]+1
                # saveIm(np.fliplr(temp_x), mask[i, j], h, i, j, k)
                # h = h+1
                # num_l[mask[i, j]] = num_l[mask[i, j]]+1
                temp_x = np.rot90(temp_x)
                saveIm(temp_x, mask[i, j], h, i, j, k)
                h = h+1
                num_l[mask[i, j]] = num_l[mask[i, j]]+1
                # saveIm(np.fliplr(temp_x), mask[i, j], h, i, j, k)
                # h = h+1
                # num_l[mask[i, j]] = num_l[mask[i, j]]+1
print num_l
