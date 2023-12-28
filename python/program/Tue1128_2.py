# -*- coding: utf-8 -*-
"""
Created on Tue Nov 28 15:36:44 2023

@author: kjs
"""

import numpy as np
import matplotlib.pyplot as plt

from numpy.fft import fft,fftshift
from scipy.signal import find_peaks


def nextpow2(N): 
    return  int(np.power(2,np.ceil(np.log2(N))))

xy = np.loadtxt('..\data\series1.txt',comments='%')

x = xy[:,0]
y = xy[:,1]

plt.figure(1)
plt.plot(x,y)
plt.xlabel('age [1000 yrs]')
plt.ylabel('Oxygen isotope measured from foraminifera')

#fast 푸리에 변환 : N*N 연산을 Nlog2N으로 획기적으로 줄인 알고리즘
#단점. 들어가는 샘플의 샘플링이 모두 등간격이어야한다.

#현재 이 자료는 간격이 일정하지 않다. 
#등간격으로 만들어야 한다.(interpolation)


#2교시
#scipy.interpolate.pchip_interpolate << interpolation하는 함수

#scipy.interpolate.interp1d << 퇴물, 가급적 사용 하지 말기.

# 대신 CubicSpline? > 별로.
#"Pchip" 사용

# x1 = x[520:540]

# y1 = y[520:540]

# plt.figure(2)
# plt.plot(y)

x1 = x[175:181]

y1 = y[175:181]

plt.figure(2)
plt.plot(x1,y1)

from scipy.interpolate import pchip_interpolate as pchip

z1 = pchip(x1,y1,525) #x = 525의 값을 알고싶을 때
print(z1)

plt.plot(525,z1,'rs')

print(np.min(x))
print(np.max(x))

mx = np.ceil(np.max(x))
print(mx)
x1 = np.arange(mx+1)

y1 = pchip(x,y,x1) # 불규칙했던 x간격을 등간격 x로 변경

plt.plot(x1,y1, '--r')

#dt = 1000yrs

len(y1)

N=len(y1)

nf = nextpow2(N)

nf = 2* nextpow2(N) #굿노트 21:31 녹화 내용 복기

f0 = fftshift(fft(y,nf))
    
plt.figure(3)

plt.plot(abs(f0))

f = np.arange(nf)/nf-0.5 #normalized

dt = 1000

Fs = 1/dt

f = (np.arange(nf)/nf-0.5)*Fs

plt.figure(4)
plt.plot(f,abs(f0))

1/2.93E-5
1/7.374E-5
1/0.00014750

f1 = fftshift(fft(y1,nf)) #1000년 간격으로 된 샘플

plt.plot(f,abs(f1))

1/1E-5
1/2.49E-5
1/5E-5