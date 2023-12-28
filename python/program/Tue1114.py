# -*- coding: utf-8 -*-
"""
Created on Tue Nov 14 16:07:00 2023

@author: kjs
"""

import numpy as np

#나눠준 데이터 중 cvcrk.txt 가져오기
#xy = np.loadtxt('cvcrk.txt',comments='%') # 주석 %로 표기되었다는 뜻
xy = np.loadtxt('..\data\cvcrk.txt',comments='%')

xy.shape #216 samples, 2 lines

# 1952년부터 1970까지 켄터키 runoff 수량

x=xy[:,0]
y=xy[:,1]


# shape, len의 혼동 주의
x.shape #shape는 numpy의 커맨드, (216,)
y.shape #(216,)

N=x.shape
N
print(N)

N=len(x)
print(N)

N=x.shape
type(N) # tuple

N=len(x)
N
type(N) # int

# 데이터 플롯
import matplotlib.pyplot as plt

plt.figure(1)
plt.plot(x,y,linewidth=1.0,markersize=3.5)

plt.xlabel('year')
plt.ylabel('monthly runoff [cm]')
#그래프상, 수위는 주기적으로 변화함. 

#plt.close(1) #코드로 그래프 닫는 명령어
#plt.close('all')