# -*- coding: utf-8 -*-
"""
Created on Tue Nov 21 23:14:15 2023

@author: kjs
"""

import numpy as np
import matplotlib.pyplot as plt

from numpy.fft import fft,fftshift
from scipy.signal import find_peaks
from scipy.interpolate import pchip_interpolate as pchip


def nextpow2(N): 
    return  int(np.power(2,np.ceil(np.log2(N))))

xy = np.loadtxt('series1.txt',comments='%')

x = xy[:,0]
y = xy[:,1]

plt.figure(1)
plt.plot(x,y)
plt.title('Raw Data')
plt.xlabel('age [1000 yrs]')
plt.ylabel('Oxygen isotope measured from foraminifera')

N=len(x)
nf = nextpow2(N)


print('방법 1. dt = 1, \n즉 1000년으로 가정한 경우 (dt =1)')
dt1 = 1 


fy = fftshift(fft(y,nf))
f=np.arange(nf)/nf-0.5
f=f*(1/dt1)

peaks, properties = find_peaks(abs(fy), height=50) # peak 찾아주는 명령어



p_peaks = f[peaks]


frq1 = f[peaks][3] # 대략 0.02930
frq2 = f[peaks][4] # 대략 0.07422
frq3 = f[peaks][5] # 대략 0.14648

 # 주기- 주파수 관계식 적용해 주기 계산
T1=1/frq1*1000
T2=1/frq2*1000
T3=1/frq3*1000


plt.figure(2)
plt.title('dt = 1')
plt.plot(f,abs(fy))
plt.xlabel('Frequency, [1/1000 yrs]')

print('\n가장 뚜렷한 주파수 = 대략 %.10f/1000yrs \n' %(frq1))
print('2번째로 뚜렷한 주파수 = 대략 %.10f/1000yrs \n' %(frq2))
print('3번째로 뚜렷한 주파수 = 대략 %.10f/1000yrs \n' %(frq3))

print('\n가장 뚜렷한 주기 = 대략 %d years \n' %(T1))
print('2번째로 뚜렷한 주기 = 대략 %d years \n' %(T2))
print('3번째로 뚜렷한 주기 = 대략 %d years \n' %(T3))


print('------------------------------------------------------------------')

print('방법 2. dt를 x값의 간격을 x값들 간 차이의 평균, 즉 \ndt = np.mean(np.diff(x))*1000년으로 가정한 경우 (dt = np.mean(np.diff(x)))')
dt2 = np.mean(np.diff(x)) #샘플링 간격 (년)


fy = fftshift(fft(y,nf))
f=np.arange(nf)/nf-0.5
f=f*(1/dt2)

peaks, properties = find_peaks(abs(fy), height=50) # peak 찾아주는 명령어



p_peaks = f[peaks]


frq1 = f[peaks][3] # 대략 0.0099275
frq2 = f[peaks][4] # 대략 0.0251497
frq3 = f[peaks][5] # 대략 0.0496375


 # 주기- 주파수 관계식 적용해 주기 계산
T1=1/frq1*1000
T2=1/frq2*1000
T3=1/frq3*1000


plt.figure(3)
plt.title('dt = np.mean(np.diff(x)) = 2.95.. ≈ 3')
plt.plot(f,abs(fy))
plt.xlabel('Frequency, [1/1000 yrs]')

print('\n가장 뚜렷한 주파수 = 대략 %.10f/1000 yrs \n' %(frq1))
print('2번째로 뚜렷한 주파수 = 대략 %.10f/1000 yrs \n' %(frq2))
print('3번째로 뚜렷한 주파수 = 대략 %.10f/1000 yrs \n' %(frq3))

print('\n가장 뚜렷한 주기 = 대략 %d years \n' %(T1))
print('2번째로 뚜렷한 주기 = 대략 %d years \n' %(T2))
print('3번째로 뚜렷한 주기 = 대략 %d years \n' %(T3))


print('------------------------------------------------------------------')
print("방법 3 : dt=1000, interpolation 이용해 등간격으로 만든 후 fft 수행")
mx = np.ceil(np.max(x))
x1 = np.arange(mx+1)
y1 = pchip(x,y,x1) # 불규칙했던 x간격을 등간격 x로 변경

plt.figure(4)
plt.plot(x,y)
plt.plot(x1,y1, '--r')
plt.xlabel('age [1000 yrs]')
plt.ylabel('Oxygen isotope measured from foraminifera')
plt.legend(['Raw, Before Interpolation','After Interpolation'])


plt.figure(5)
dt = 1000 #시간간격 1000년
Fs = 1/dt

# f = (np.arange(nf)/nf-0.5)*Fs
# f1 = fftshift(fft(y1,nf))
# plt.plot(f,abs(f1))

nf = nf*4

f = (np.arange(nf)/nf-0.5)*Fs
f1 = fftshift(fft(y1,nf))
plt.plot(f,abs(f1))
plt.xlabel('Frequency, [1/yrs]')
plt.title('dt = 1000, After Interpolation')

peaks, properties = find_peaks(abs(f1), height=230) # peak 찾아주는 명령어

p_peaks = f[peaks]


frq1i = f[peaks][3] # 대략 0.0099275
frq2i = f[peaks][4] # 대략 0.0251497
frq3i = f[peaks][5] # 대략 0.0496375

# print(frq1,frq2,frq3)

T1i=1/frq1i
T2i=1/frq2i
T3i=1/frq3i

print('\n가장 뚜렷한 주파수 = 대략 %.10f/1000yrs \n' %(frq1i))
print('2번째로 뚜렷한 주파수 = 대략 %.10f/1000yrs \n' %(frq2i))
print('3번째로 뚜렷한 주파수 = 대략 %.10f/1000yrs \n' %(frq3i))

print('\n가장 뚜렷한 주기 = 대략 %d years \n' %(T1i))
print('2번째로 뚜렷한 주기 = 대략 %d years \n' %(T2i))
print('3번째로 뚜렷한 주기 = 대략 %d years \n' %(T3i))

print('------------------------------------------------------------------')
print('(방법 1)과 (방법 2,방법 3)의 주기가 다르게 나타난다. (2번,3번)으로 구해진 주기는 (방법 1)로 구해진 주기의 약 3배에 해당한다.\ndt는 샘플링 간격, 즉 주어진 데이터의 x값의 간격과 일치해야만 하므로, \n방법2 혹은 방법3의 방식으로 구해진 주기가 올바르게 구해진 값이라고 할 수 있다.\n실제로 Figure 1의 그래프에서 보여지는 반복주기는 방법2, 방법3으로 계산된 주기와 잘 일치함을 볼 수 있다.')


print('\n또한 방법 2, 방법 3의 방식으로 구해진 주기는 밀란코비치 주기와 잘 맞는다. \n')
print('%d년, %d년 = Earth\'s Eccentricity 변화 주기 100,000년과 유사 \n' %(T1,T1i))
print('%d년, %d년 = Earth\'s axis''s Obliquity 변화 주기 41,000년과 유사 \n' %(T2,T2i))
print('%d년, %d년 = Earth\'s Axial Precession 주기 26000년과 유사 \n' %(T3,T3i))

print('출처 : https://climate.nasa.gov/news/2948/milankovitch-orbital-cycles-and-their-role-in-earths-climate/ \n')
#출처 : https://climate.nasa.gov/news/2948/milankovitch-orbital-cycles-and-their-role-in-earths-climate/
