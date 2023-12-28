import numpy as np # 별명은 np
import matplotlib.pyplot as plt
from numpy.fft import fft, ifft, fftshift, ifftshift

#--------------------------------------------------------
# 1. average, 평균

def average(x): # 함수 정의는 def
    ss=sum(x) #매틀랩
    mm=ss/len(x) #divide by length
    
    return mm

#--------------------------------------------------------
# 2. standard deviation, 표준편차

def standard(x): 
    mm = average(x)
    #N = len(x)
    ss = sum((x-mm)**2) #제곱 : **2로 표시
    ss = ss/(len(x)-1)
    ss = np.sqrt(ss)
    
    return ss

#--------------------------------------------------------
# 3. next power of 2, N보다 큰 2의 거듭제곱수 중 가장 작은 수

# def nextpow2(N):
#     n2 = 1
#     while (n2 <N):
#         n2 *= 2
#     return n2


# def nextpow2(N):
#     return int(np.power(2,np.ceil(np.log2(N)))) #log2(N)값 올림 후 2의 지수에 넣음.


def nextpow2(N):
    return 1<<(N-1).bit_length()




#--------------------------------------------------------
# . convolution : s1과 s2의 convolution을 구하는 함수, s1과 s2의 길이가 같아야 함. 합성곱

def convolution(s1,s2):
    n=len(s1)
    m=len(s2)
    nm=n+m-1
    
    cn = np.zeros(nm)
    
    for k in range(n):
        for l in range(m):
            cn[k+l] += s1[k]*s2[l]
    return cn


#--------------------------------------------------------
# . convolution2 : fft

def convolution2(s1,s2):
    N = len(s1)
    nf = nextpow2(N)
    
    cn = ifft(fft(s1,nf)*fft(s2,nf))
    cn = cn.real

    return cn[:N]
#--------------------------------------------------------
def myfft(xy,dt):
    x = xy[:,0]
    y = xy[:,1]

    N = len(x)
    nf = nextpow2(N)

    f = (np.arange(nf)/nf)-0.5
    f = f*(1/dt)

    fy = fftshift(fft(y,nf))

    plt.figure
    plt.plot(f,abs(fy))
    plt.xlabel('frequency [Hz]')
    plt.ylabel('Amplitude')

    return f,fy

#--------------------------------------------------------
# . rmse : root mean square error, 평균 제곱근 오차
def rmse(y1, y2):
    return np.sqrt(sum((y1 - y2) ** 2) / len(y1))