# Experimental script to check rotation and flipping

import numpy as np

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

l = [[[1,2], [3,4]]]
x = np.array(l)
print x
print flip(x)
rot(x)
print x
print flip(x)
rot(x)
print x
print flip(x)
rot(x)
print x
print flip(x)
