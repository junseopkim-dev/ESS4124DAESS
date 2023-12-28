# -*- coding: utf-8 -*-
"""
Created on Thu Nov 16 15:46:38 2023

@author: kjs
"""

import numpy as np
import matplotlib.pyplot as plt

from numpy.fft import fft, ifft, fftshift, ifftshift

xy = np.loadtxt('..\data\cvcrk.txt',comments='%')

x=xy[:,0]
y=xy[:,1]

plt.plot(x,y)

plt.xlabel('year')
plt.ylabel('monthly runoff [cm]')

#delta t = 1 month
#나이키스트 frequency = 플마 1/2*델타t
#= 2*(1/month)

#fft = forward fast 푸리에 변환
#ifft = inverse fast 푸리에 변환
N=len(x)
print(N)


#3가지 구현방법


def nextpow2_default(N):
    n2 =1
    while (n2<N):
        n2 *=2
    return n2

def nextpow2_using_ceil(N):
    return int(np.power(2,np.ceil(np.log2(N)))) #log2(N)값 올림 후 2의 지수에 넣음.

def nextpow2_using_bits(N):
    return lambda N: 1<<(N-1).bit_length()
    

nf = nextpow2_using_ceil(N)
print(nf)

fy1 = fftshift(fft(y,nf)) ##fft(y,nf)의 반을 잘라서 왼쪽으로 붙여라.

#y 푸리에 변환, 

plt.figure(2)
plt.plot(abs(fy1))


fy2 = fft(y,nf)
plt.figure(3)
plt.plot(abs(fy2))

f=np.arange(nf)/nf-0.5 #np.arange
#0,1,2,3....nf-1을 nf로 나눈 뒤 0.5만큼 빼기

print(f[0])
print(f[-1]) # 맨 끝값이 처음 값과 같지 않도록.


#a = np.arange(0,2,0.25)
#a = array([0.  , 0.25, 0.5 , 0.75, 1.  , 1.25, 1.5 , 1.75])

#파이썬 기본 내장된 range는 정수 간격만 가능. 
#numpy의 arange는 소숫점 간격도 가능. 끝 점은 포함하지 않음.


fy1 = fftshift(fft(y,nf))
plt.figure(4)
plt.plot(f,abs(fy1))
#가로 주파수 세로는 
T=1/0.082

plt.xlabel("1/month")

#가운데 값은 모든 값들의 합이다. 각 데이터를 평균만큼 빼고 더하면, 가운데 값 없앨 수 있다.
mm = np.mean(y) #mean
fy1 = fftshift(fft(y-mm,nf))

plt.plot(f,abs(fy1)) #오렌지색, 가운데 0이 됨.