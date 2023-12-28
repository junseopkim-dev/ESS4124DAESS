import numpy as np
import matplotlib.pyplot as plt
import functions
from numpy.fft import fft, ifft, fftshift, ifftshift
from scipy.signal import find_peaks

filename = 'cvcrk.txt'
xy = np.loadtxt(filename,comments='%')

x = xy[:,0]
y = xy[:,1]

functions.myfft(xy,1) 

f = functions.myfft(xy,1) 
f1 = functions.myfft(xy,1)


plt.show()