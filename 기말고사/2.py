import numpy as np
import matplotlib.pyplot as plt
import functions
from numpy.fft import fft, ifft, fftshift, ifftshift

xy=np.loadtxt('cvcrk.txt',comments='%')
x=xy[:,0]
y=xy[:,1]

N=len(x) #216
nf=functions.nextpow2(N) #256
dt=1.0 #1month

f=np.arange(nf)/nf-0.5
f=f*(1/dt)
fy=fftshift(fft(y,nf))

fy.dtype #complex128 -> 절댓값 사용

plt.figure(1)
plt.plot(f,abs(fy))
plt.xlabel('frequency [Hz')
plt.ylabel('Amplitude')

# y1=ifft(ifftshift(fy)) 

# plt.figure(2)
# y=xy[:,1]
# plt.plot(y)
# plt.plot(y1) #y1은 복소수,

# y1=y1[:N]
# y.dtype#float
# y1.dtype#complex
# plt.figure(3)
# plt.plot(y1.real)
# plt.plot(y1.imag) 

# -----------------------------------------

fy1=fftshift(fft(y,2*nf))
fy1.shape #(512,)
f1=np.arange(2*nf)/(2*nf)-0.5
f1=f1*(1/dt)

fy2=fftshift(fft(y,4*nf))
f2=np.arange(4*nf)/(4*nf)-0.5
f2=f2*(1/dt)




plt.figure(5)
plt.plot(f,abs(fy))
plt.plot(f1,abs(fy1))
plt.plot(f2,abs(fy2)) 



# #주파수 그래프 양쪽을 0으로 채우기
# fy=fftshift(fft(y,nf))
# fy.shape #(256,)
# z=np.zeros(int(nf/2))
# z.shape #(128,)

# fy1=np.hstack((z,fy,z)) 
# fy1.shape #(512,)

# plt.figure(6)
# plt.plot(abs(fy1))
# plt.plot(abs(fy))

# y1=ifft(ifftshift(fy1))
# y1.shape #(512,)
# y1.dtype #(complex128)

# y1=y1.real
# plt.figure(7)
# plt.plot(y)
# plt.figure(8)
# plt.plot(y1) 

# y1=y1[:2*N]
# len(y1) #432
# plt.figure(9)
# plt.plot(y1)
# y1=y1*N2
# plt.plot(y1,'c--')

# t0=np.arange(N)
# t1=np.arange(0,N,0.5)
# len(t0) 
# len(t1) 

# plt.figure(10)
# plt.plot(t0,y,'c--')
# plt.plot(t1,y1,'k--')
# #%%
# import numpy as np
# import matplotlib.pyplot as plt


    
#%%
import numpy as np
import matplotlib.pyplot as plt
import functions as f
from numpy.fft import fft, ifft, fftshift, ifftshift

xy=np.loadtxt('cvcrk.txt',comments='%')
x=xy[:,0]
y=xy[:,1]

s1=y
s2=np.bartlett(11)

plt.figure(1)
plt.plot(s2)
plt.figure(2)
plt.plot(s1)


z=f.convolution(s1,s2)
plt.figure(3)
plt.plot(z)

#방법2 numpy의 convolve 사용
z1=np.convolve(s1,s2) 
plt.plot(z1,'o') 

plt.show()