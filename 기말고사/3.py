import numpy as np
import matplotlib.pyplot as plt
import functions
from numpy.fft import fft, ifft, fftshift, ifftshift

xy = np.loadtxt('series1.txt',comments='%')

x = xy[:,0]
y = xy[:,1]

N = len(x)
nf = functions.nextpow2(N)
# dt = 1

# fft생략


s1 =y
s2 = np.hamming(11) #부드럽게 (smoothing)해줌 => 노이즈 제거

#convolution 3가지 방법

#1. convolution 함수 사용
c1 = functions.convolution(s1,s2)
c1 = c1[0:N]

#2. np.convolve 함수 사용
c2 = np.convolve(s1,s2,mode='same') #mode='same' : convolution 결과의 길이를 입력과 동일하게 만들어줌

# mode{‘full’, ‘valid’, ‘same’}, optional
# same 입력시, convolution 결과의 길이를 입력, 특히 s1의 길이와 동일하게 만들어줌

#3. fft를 이용한 convolution
c3 = ifft(fft(s1,nf)*fft(s2,nf))
c3 = c3.real
c3 = c3[0:N]

plt.figure(1)
plt.plot(c1)
plt.plot(c2)
plt.plot(c3)

plt.show()