# -*- coding: utf-8 -*-
"""
Created on Tue Nov 21 16:49:28 2023

@author: kjs
"""

import numpy as np
import matplotlib.pyplot as plt

from conv import convolution


nextpow2 = lambda N: 1<<(N-1).bit_length()


xy = np.loadtxt('..\data\cvcrk.txt',comments='%')

x = xy[:,0]
y = xy[:,1]
s1 = y
s2 = np.hamming(11)

z = convolution(s1,s2)

plt.figure
plt.plot(z)