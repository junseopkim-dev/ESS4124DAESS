# -*- coding: utf-8 -*-
"""
Created on Thu Nov 23 15:05:42 2023

@author: kjs
"""

import numpy as np
import matplotlib.pyplot as plt
from numpy.fft import fft, ifft, fftshift, ifftshift



nextpow2 = lambda N: 1<<(N-1).bit_length()


xy = np.loadtxt('./data/series1.txt',comments='%')

x = xy[:,0]
y = xy[:,1]

N = len(x)

nf = nextpow2(N)
s1 = y
s2 = np.hamming(11)

fy = fftshift(fft(y,nf))

f = np.arange(nf)/nf-0.5

#dt = 1

plt.figure(1)
plt.plot(f,abs(fy))

plt.figure(2)
plt.plot(x,y)




s1 =y
s2 = np.hamming(11) #부드럽게 (smoothing)해줌 => 노이즈 제거
plt.figure(3)
plt.plot(s2)

from conv import convolution

c1 = convolution(s1,s2)

plt.figure(4)
plt.plot(c1) #s1자료에 hamming과 convolution(필터링)한 결과 출력

print(len(s1))
print(len(c1))
c2 = np.convolve(s1,s2)

plt.figure(5)
plt.plot(c2) # figure 4와 동일

# mode{‘full’, ‘valid’, ‘same’}, optional
# same 입력시 ?

c2 = np.convolve(s1,s2,mode='same')
print(len(c2)) #s1의 길이, 원래 데이터 중 긴 것의 길이가 됨


N = len(s1)
nf = nextpow2(N)
print(nf)

print(len(s2))

c3 = ifft(fft(s1,nf)*fft(s2,nf)) # (s1을 nf에 대해 푸리에 변환 * s2를 nf에 대해 푸리에 변환)을 inverse transform
plt.figure(6)
print(c3.dtype)

c3 = c3.real

plt.plot(c3)

c1 = convolution(s1,s2)

plt.plot(c1) # convoltuion한 결과와 일치

#c3의 길이 512, 푸리에 변환을 nf의 길이로 수행했기 때문
print(len(c1))
nm = len(s1)+len(s2)-1
print(nm)
c3 = c3[:nm]
plt.plot(c3,'--g')

#주의할 점
#s1을 첫번째 사이클만 잡자. 75까지
s1 = y[:64]
s2 = np.hamming(64)
#plt.close('all')

plt.figure(7)
c1 = convolution(s1,s2)
plt.plot(c1)

n=len(s1)
m=len(s2)
nf = nextpow2(n)
print(nf)

c3 = ifft(fft(s1,nf)*fft(s2,nf))

plt.figure(8)
c3 = c3.real

plt.plot(c3)

# 

n = len(s1)

m = len(s2)

nf = nextpow2(2*n) #데이터 길이 2배 이상 후 0으로 설정

c3 = ifft(fft(s1,nf)*fft(s2,nf))

c3 = c3.real
nm = len(s1)+len(s2)-1

c3 = c3[:nm] #제일 큰 자리의 2배만큼만 푸리에 트랜스폼
#취하는 거를 오리지날 데이터만큼 취하기

plt.figure(9)
plt.plot(c3) #figure 7과 일치

#둘 중 가장 큰 자료보다 2배 이상 사이즈로 잡아야 함.****
plt.close('all') #필요시 주석처리

plt.figure(1)
plt.plot(y)

s1 = y
s2 = np.hamming(11)

c1 = convolution(s1, s2)
#c1 = np.convolve(s1,s2)
plt.figure(2)
plt.plot(c1)

#코릴레이션

s3 = c1[99:136]

len(s3) # 37
len(s1) # 339

#코릴레이션은 어떻게? 코릴레이션은 닮은 꼴을 찾는 것.
s3.conj()

plt.figure(3)
plt.plot(s3)
#figure 1에서 figure3와 비슷한 부분 찾기  = 코릴레이션

n = len(s1)
m = len(s3)

nf = nextpow2(n)
nf #512

cc = ifft(fft(s1,nf)*fft(s3,nf).conj())

cc = cc.real

plt.figure(4)
plt.plot(cc)
#코릴레이션에서는 코릴레이션 값이 크다 = 유사도가 높다 의미, -는 역의 상관관계
# peak점들을 찾아보면 figure1에서 figure3와 거의 일치하는 모양이 나타난다.
#코릴레이션 값(figure4) 높을수록 figure1이 figure2와 일치함을 의미

#다음 시간 맛보기
#xy = np.loadtxt('..\data\mauna.txt',comments='%')

#plt.close('all')
#x = xy[:,0]
#y = xy[:,1]
#plt.plot(x,y)

#다음주
#데이터 간격이 균등하지 않을 경우
#주기가 특정한 경향성을 갖는 경우 = regression으로 해결