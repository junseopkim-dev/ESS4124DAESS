import numpy as np
import matplotlib.pyplot as plt
import functions as f
from numpy.fft import fft, ifft, fftshift, ifftshift

xy = np.loadtxt('cvcrk.txt',comments='%')

dt = 1/12 # 샘플링 간격(단위 : x축 단위)

x = xy[:,0]
y = xy[:,1]

N=len(x)
nf1=f.nextpow2(N)
nf2 = 2*nf1
nf4 = 4*nf1

fy1 = fftshift(fft(y,nf1))
fy2 = fftshift(fft(y,nf2))
fy3 = fftshift(fft(y,nf4))

f1 = np.arange(nf1)/nf1-0.5
f2 = np.arange(nf2)/nf2-0.5
f3 = np.arange(nf4)/nf4-0.5

f1 = f1*(1/dt)
f2 = f2*(1/dt)
f3 = f3*(1/dt)

plt.figure(1)
plt.plot(f1,abs(fy1))
plt.plot(f2,abs(fy2))
plt.plot(f3,abs(fy3))


#----------------------------------------
#기존의 f1, fy1 대상

t1=np.arange(0,N,0.5)
z = np.zeros(int(nf1/2))
fy1 = np.hstack((z,fy1,z))
y1=ifft(ifftshift(fy1))
y1=y1.real
y1=y1[:2*N]
y1=y1*2
#(t1, y1)

t0=np.arange(N)
y = xy[:,1]
#(t0, y)

plt.figure(2)
plt.plot(t0,y)
plt.plot(t1,y1)





plt.show()

