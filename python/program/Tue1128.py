# -*- coding: utf-8 -*-
"""
Created on Tue Nov 28 15:05:16 2023

@author: kjs
"""

# 2배 이상으로 자료를 만들어
# 최소한 같은 길이만큼의 0이 들어가야 한다.
# 오늘은 콘볼루션 2가지

# N*N
# Nlog2N

# 우리 일상생활에 이용되는 것 : 처프, chirp

# 인공위성 500km에서 1킬로와트로 전파를 쐈다고 하자.

# 신호의 세기는 거리의 3승배로 줄어듬

# 5곱하기 10의 5승 미터

# 10의 15승분의 1

# 10의 마이너스 8승(?) 매우 경미한 신호, 그럼에도 어떻게 통신?

# 인공적인 파 : e^( +- i*pi*k*t^2) = e^(-+ i*pi* (f^2/k))

import numpy as np
from numpy.fft import fft, ifft, fftshift, ifftshift

import matplotlib.pyplot as plt

Ts = 50E-6 # 핸드폰에서 시그널 나갈 때 패킷 50ms

B = 200E+6 #bandwidth 200메가헤르츠

#샘플링 프리퀀시
Fs = 120E+6 #초당 120 곱하기 10의 6승, 1초당 12억개 샘플링

K = B/Ts #bandwidth / Ts     , slope

nt = 2800 # 샘플 개수

from numpy import pi, exp

t = (np.arange(nt)-nt/2)/Fs

t[0]

s = exp(-1j*pi*K*t**2)

plt.figure(1)
plt.plot(s.real)
#이게 chirp 신호. 

#가운데가 0이 되도록. 좌우로 갈수록 촘촘해진다. = 멀어질수록 주파수가 늘어난다. slope(K)에 비교해서
#에너지의 크기는 1

nextpow2 = lambda N: 1<<(N-1).bit_length()


len(s) #2800

nf = nextpow2(nt)

nf # 4096

fs = fftshift(fft(s,nf)) #푸리에 트랜스폼

plt.figure(2)
plt.plot(abs(fs))

f = np.arange(nf)/nf-0.5
#1/Fs #time 간격

f = f*Fs # f = f/dt

#chirp는 시험에 안나옴!

#플롯 결과, 특정 주파수 구간의 amplitude는 일정함을 보임.

#reference function 만들기

fr = exp(+1j*pi/K*f**2)

#convolution 수행, 따로 푸리에 후 곱하고 역푸리에
fc = fs * fr.conj()

zz = ifft(ifftshift(fc))

len(zz) # 4096

zz = zz[:nt]

plt.figure(3)
plt.plot(abs(zz))

plt.plot(abs(s)) #주황색, 해석? 보낸 신호를 크기가 1인 것을 보냄. 코릴레이션으로 증폭시킴
#power는 이것의 제곱. 