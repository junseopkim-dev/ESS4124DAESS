# -*- coding: utf-8 -*-
"""
Created on Thu Nov 16 15:46:38 2023

@author: kjs
"""

import numpy as np
import matplotlib.pyplot as plt

from conv import convolution


nextpow2 = lambda N: 1<<(N-1).bit_length()


xy = np.loadtxt('..\data\cvcrk.txt',comments='%')

x=xy[:,0]
y=xy[:,1]

N = len(x)
nf = nextpow2(N)

dt = 1.0

np.arange(5)
f = np.arange(nf)/nf-0.5
f1 = np.arange(2*nf)/(2*nf)-0.5
f2 = np.arange(4*nf)/(4*nf)-0.5

f=f*(1/dt)
f1=f1*(1/dt)
f2=f2*(1/dt)

from numpy.fft import fft, ifft, fftshift, ifftshift

a = np.arange(0,2,0.25)
b = ifftshift(a)

fy = fftshift(fft(y,nf)) #주파수

fy.dtype

plt.figure
plt.plot(f,abs(fy))
plt.xlabel('frequency [Hz]')
plt.ylabel('Amplitude')

fy = fftshift(fft(y,nf))

fy.shape



fy1 = fftshift(fft(y,2*nf))

fy2 = fftshift(fft(y,4*nf))

plt.figure(2)
plt.plot(f,abs(fy))
plt.plot(f1,abs(fy1))
plt.plot(f2,abs(fy2))

#촘촘해질수록 interpolation, 정밀해짐
#0 채우기?

z=np.zeros(int(nf/2))

fy1 = np.hstack((z,fy,z))
plt.figure(3)
y1 = ifft(ifftshift(fy1))
y1=y1.real
plt.plot(y)
y1=y1[:2*N]
y1.shape

y1=y1.real


plt.figure(4)
plt.plot(y1)

y0 = ifft(ifftshift(fy))

y1=y1*2
plt.figure(5)
plt.plot(y)
plt.plot(y1)

t0=np.arange(N)
t1=np.arange(0,N,0.5)
t0[:3]
#array([0, 1, 2])
t1[:3]
#array([0. , 0.5, 1. ])

plt.figure(6)

plt.plot(t0,y)
plt.plot(t1,y1)
#interporation 한 것 같은 효과
#0 근처에서 oscillation 심해지나, 의미있는 값은 정밀하게 됨

s1=y
s2 = np.bartlett(11) 
#삼각형
z = convolution(s1,s2)
plt.figure(7)
plt.plot(z)

plt.show()

#------------------

# import numpy as np
# import matplotlib.pyplot as plt

# xy=np.loadtxt('..\data\cvcrk.txt',comments='%')
# x=xy[:,0]
# y=xy[:,1]
# x.shape #(216,)

# nextpow2=lambda N: 1<<(N-1).bit_length()
# N=len(x) #216

# nf=nextpow2(N) #256
# dt=1.0 #1month
# f=np.arange(nf)/nf-0.5
# f=f*(1/dt)

# from numpy.fft import fft, ifft, fftshift, ifftshift

# a=np.random.randn(6) 
# b=fftshift(a)

# fy=fftshift(fft(y,nf))
# fy.dtype #complex128 -> 절댓값 사용
# plt.figure(1)
# plt.plot(f,abs(fy))
# plt.xlabel('frequency [Hz')
# plt.ylabel('Amplitude')

# y1=ifft(ifftshift(fy)) 

# plt.figure(2)
# y=xy[:,1]
# plt.plot(y)
# plt.plot(y1) 

y1=y1[:N]
y.dtype#float
y1.dtype#complex
plt.figure(3)
plt.plot(y1.real)
plt.plot(y1.imag) 

fy1=fftshift(fft(y,2*nf))
fy1.shape #(512,)

# f1=np.arange(2*nf)/(2*nf)-0.5
# f1=f1*(1/dt)

# plt.figure(4)
# plt.plot(f1,abs(fy1))

# #fy:256개, fy1: 512개

# plt.figure(5)
# plt.plot(f,abs(fy))
# plt.plot(f1,abs(fy1))

# fy2=fftshift(fft(y,4*nf))
# f2=np.arange(4*nf)/(4*nf)-0.5
# f2=f2*(1/dt)
# plt.plot(f2,abs(fy2)) 


# #주파수 그래프 양쪽을 0으로 채우기
# fy=fftshift(fft(y,nf))
# fy.shape #(256,)
# z=np.zeros(int(nf/2))
# z.shape #(128,)

# fy1=np.hstack((z,fy,z)) 
# fy1.shape #(512,)

# plt.figure(6)
# plt.plot(abs(fy1))
# plt.plot(abs(fy))

# y1=ifft(ifftshift(fy1))
# y1.shape #(512,)
# y1.dtype #(complex128)

# y1=y1.real
# plt.figure(7)
# plt.plot(y)
# plt.figure(8)
# plt.plot(y1) 

# y1=y1[:2*N]
# len(y1) #432
# plt.figure(9)
# plt.plot(y1)
# y1=y1*N2
# plt.plot(y1,'c--')

# t0=np.arange(N)
# t1=np.arange(0,N,0.5)
# len(t0) 
# len(t1) 

# plt.figure(10)
# plt.plot(t0,y,'c--')
# plt.plot(t1,y1,'k--')
# #%%
# import numpy as np
# import matplotlib.pyplot as plt

# def convolution(s1,s2):
#     n=len(s1)
#     m=len(s2)
#     nm=n+m-1
    
#     cn=np.zeros(nm)
    
#     for k in range(n):
#         for l in range(m):
#             cn[k+l]+=s1[k]*s2[l]
        
#     return cn
    
# #%%
# import numpy as np
# import matplotlib.pyplot as plt

# xy=np.loadtxt('..\data\cvcrk.txt',comments='%')
# x=xy[:,0]
# y=xy[:,1]

s1=y
s2=np.bartlett(11)

plt.figure(1)
plt.plot(s2)
plt.figure(2)
plt.plot(s1)

# from conv import convolution

z=convolution(s1,s2)
plt.figure(3)
plt.plot(y)
plt.plot(z)

# z1=np.convolve(s1,s2) 
# plt.plot(z1,'o') 
# #%%
# #main program

# import numpy as np
# import matplotlib.pyplot as plt
# from conv import convolution
# #-----------------------------------------
# xy=np.loadtxt('..\data\cvcrk.txt',comments='%')
# x=xy[:,0]
# y=xy[:,1]

# s1=y
# s2=np.hamming(11)
# plt.plot(s2)