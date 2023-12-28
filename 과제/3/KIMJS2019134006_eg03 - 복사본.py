# -*- coding: utf-8 -*-
"""
Created on Tue Nov 21 23:14:15 2023

@author: kjs
"""

import numpy as np
import matplotlib.pyplot as plt

from numpy.fft import fft,fftshift
from scipy.signal import find_peaks


def nextpow2(N): 
    return  int(np.power(2,np.ceil(np.log2(N))))

xy = np.loadtxt('series1.txt',comments='%')

x = xy[:,0]
y = xy[:,1]

plt.figure(1)
plt.plot(x,y)
plt.xlabel('age [1000 yrs]')
plt.ylabel('Oxygen isotope measured from foraminifera')

N=len(x)
nf = nextpow2(N)
dt = np.mean(np.diff(x)) * 1000 #샘플링 간격 (년)


fy = fftshift(fft(y,nf))
f=np.arange(nf)/nf-0.5
f=f*(1/dt)

peaks, properties = find_peaks(abs(fy), height=50) # peak 찾아주는 명령어



p_peaks = f[peaks]

frq1 = f[peaks][3]
frq2 = f[peaks][4]
frq3 = f[peaks][5]


T1=1/frq1
T2=1/frq2
T3=1/frq3


plt.figure(2)
plt.plot(f,abs(fy))
plt.xlabel('Frequency, [1/yrs]')

print('\n 가장 뚜렷한 주파수 = 대략 %.10f/year \n' %(frq1))
print('2번째로 뚜렷한 주파수 = 대략 %.10f/year \n' %(frq2))
print('3번째로 뚜렷한 주파수 = 대략 %.10f/year \n' %(frq3))

print('\n 가장 뚜렷한 주기 = 대략 %d years \n' %(T1))
print('2번째로 뚜렷한 주기 = 대략 %d years \n' %(T2))
print('3번째로 뚜렷한 주기 = 대략 %d years \n' %(T3))

print('\n 밀란코비치 주기. \n')
print('%d년 = Earth\'s Eccentricity 변화 주기 100,000년과 유사 \n' %(T1))
print('%d년 = Earth\'s axis''s Obliquity 변화 주기 41,000년과 유사 \n' %(T2))
print('%d년 = Earth\'s Axial Precession 주기 26000년과 유사 \n' %(T3))

print('출처 : https://climate.nasa.gov/news/2948/milankovitch-orbital-cycles-and-their-role-in-earths-climate/ \n')
#출처 : https://climate.nasa.gov/news/2948/milankovitch-orbital-cycles-and-their-role-in-earths-climate/



# interpolation 불필요
# 연대는 1000년 간격으로. 
# foraminifera : 유공충
# 


