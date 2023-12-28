# -*- coding: utf-8 -*-
"""
Created on Tue Nov 14 16:24:45 2023

@author: kjs
"""

import numpy as np
import matplotlib.pyplot as plt

from numpy.fft import fft, ifft, fftshift, ifftshift

def nextpow2(N):
    n2 = 1
    while (n2 <N):
        n2 *= 2
    return n2

"""
def nextpow2_myway(N):
    return np.power(2,np.ceil(np.log2(N))) #log2(N)값 올림 후 2의 지수에 넣음.
"""

xy = np.loadtxt('..\data\cvcrk.txt',comments='%')

x=xy[:,0]
y=xy[:,1]

N=len(x)
print('\n length x = %d \n' %N)

[N1,N2] = xy.shape
#N1 # int
#N2 # int

print('\n size xy = %d, %d \n' %(N1,N2))

plt.figure(1)
plt.plot(x,y,linewidth=1.0,markersize=3.5)
plt.xlabel('year')
plt.ylabel('monthly runoff [cm]')

#N=216, N보다 큰 2의 거듭제곱수 = 256



nf = nextpow2(N)
print('\n next power of 2 = %d \n' %nf)


#푸리에
"""
fy=fft(y,nf)
plt.figure(2)
plt.plot(abs(fy))
"""

fy = fftshift(fft(y,nf))
f=np.arange(nf)/nf-0.5
plt.figure(2)
plt.plot(f,abs(fy)) #자주 일어난 홍수 주기

plt.xlabel('frequency')
plt.ylabel('Spectrum')
#peak =0.082

#1/0.082 = 12.195 # 1년에 1번 주기를 갖는다는 뜻
