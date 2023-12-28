import numpy as np
import matplotlib.pyplot as plt
import functions
from numpy.fft import fft, ifft, fftshift, ifftshift
from scipy.signal import find_peaks
from scipy.interpolate import pchip_interpolate as pchip

filename = 'sample.txt'
xy = np.loadtxt(filename,comments='%')

x = xy[:,0]
y = xy[:,1]


#1. interpolation
mx = np.ceil(np.max(x))
x1 = np.arange(mx+1)
y1 = pchip(x,y,x1)


plt.figure(1)
plt.plot(x,y)
plt.plot(x1,y1, 'r')
plt.xlabel('age [1000 yrs]')
plt.ylabel('variation (%)')
plt.legend(['Raw, Before Interpolation','After Interpolation'])

#2. fft 수행
N=len(x)
nf=functions.nextpow2(N)

dt = 1000 #시간간격 1000, 단위(년)
Fs = 1/dt

f = (np.arange(nf)/nf-0.5)*Fs
f1 = fftshift(fft(y1,nf))

plt.figure(2)
plt.plot(f,abs(f1))
plt.xlabel('Frequency, [1/yrs]')
plt.ylabel('Amplitude')
plt.title('dt = 1000, After Interpolation')

peaks, properties = find_peaks(abs(f1), height=110) # peak 찾아주는 명령어

p_peaks = f[peaks][4:7]
p_properties = properties['peak_heights'][4:7]

freq1 = p_peaks[0] #9.766e-06
freq2 = p_peaks[1] #2.539e-05
freq3 = p_peaks[2] #5.078e-05

plt.plot(freq1,p_properties[0],'rs')
plt.plot(freq2,p_properties[1],'rs')
plt.plot(freq3,p_properties[2],'rs')

print('------------------------------------------------------------------')
print('경향성 제거 전')


print(freq1,freq2,freq3)

T1=1/freq1
T2=1/freq2
T3=1/freq3

print('\n가장 뚜렷한 주파수 = 대략 %.10f/years \n' %(freq1))
print('2번째로 뚜렷한 주파수 = 대략 %.10f/years \n' %(freq2))
print('3번째로 뚜렷한 주파수 = 대략 %.10f/years \n' %(freq3))

print('\n가장 뚜렷한 주기 = 대략 %d years \n' %(T1))
print('2번째로 뚜렷한 주기 = 대략 %d years \n' %(T2))
print('3번째로 뚜렷한 주기 = 대략 %d years \n' %(T3))

print('------------------------------------------------------------------')



# 3. 다항식 경향성 찾고 제거
# 3.1 알맞은 다항식 찾기
#2차식
P = np.polyfit(x,y,2)
y2 = np.polyval(P,x)

plt.figure(3)
plt.plot(x,y)
plt.plot(x,y2,'--r')

P = np.polyfit(x,y,1)
y1 = np.polyval(P,x)

plt.plot(x,y1,'--g')


# RMSE 구하기 Root mean square error
print('2차식 모델 rmse = ', functions.rmse(y, y2))


plt.plot(x,y1,'--g')
print('1차식 모델 rmse = ', functions.rmse(y, y1))


if(functions.rmse(y, y2)>functions.rmse(y, y1)):
    print('1차식 채택')
else:
    print('2차식 채택')


x = xy[:,0]
ynew = y-y2
plt.plot(x,ynew)

#x,ynew로 진행


#-----------------
#3.2. interpolation
#interpolation : 불규칙한 x간격을 등간격으로 변경
mx = np.ceil(np.max(x))
x1 = np.arange(mx+1)
ynew1 = pchip(x,ynew,x1)

plt.figure(4)
plt.plot(x,ynew)
plt.plot(x1,ynew1, '--r')
plt.xlabel('age [1000 yrs]')
plt.ylabel('variation (%)')
plt.legend(['Raw, Before Interpolation','After Interpolation'])


#-----------------
#3.3. fft 수행
N=len(x)
nf=functions.nextpow2(N)

dt = 1000 #시간간격 1000, 단위(년)
Fs = 1/dt

f = (np.arange(nf)/nf-0.5)*Fs
f2 = fftshift(fft(ynew1,nf))

plt.figure(5)
plt.plot(f,abs(f2))
plt.xlabel('Frequency, [1/yrs]')
plt.ylabel('Amplitude')
plt.title('dt = 1000, After Interpolation')

peaks, properties = find_peaks(abs(f2), height=100) # peak 찾아주는 명령어

p_peaks = f[peaks][3:6]
p_properties = properties['peak_heights'][3:6]

newfreq1 = p_peaks[0] #9.766e-06
newfreq2 = p_peaks[1] #2.539e-05
newfreq3 = p_peaks[2] #5.078e-05

plt.plot(newfreq1,p_properties[0],'rs')
plt.plot(newfreq2,p_properties[1],'rs')
plt.plot(newfreq3,p_properties[2],'rs')


print('------------------------------------------------------------------')
print('경향성 제거 후')

print(newfreq1,newfreq2,newfreq3)

newT1=1/newfreq1
newT2=1/newfreq2
newT3=1/newfreq3

print('\n가장 뚜렷한 주파수 = 대략 %.10f/years \n' %(newfreq1))
print('2번째로 뚜렷한 주파수 = 대략 %.10f/years \n' %(newfreq2))
print('3번째로 뚜렷한 주파수 = 대략 %.10f/years \n' %(newfreq3))

print('\n가장 뚜렷한 주기 = 대략 %d years \n' %(newT1))
print('2번째로 뚜렷한 주기 = 대략 %d years \n' %(newT2))
print('3번째로 뚜렷한 주기 = 대략 %d years \n' %(newT3))



#-----------------
#4. 경향성 제거 전 후 주기 비교

print('------------------------------------------------------------------')

print('경향성 제거 전 데이터에 fft로 구해진 주기')
print('가장 뚜렷한 주파수 = 대략 %.10f/years \n' %(freq1))
print('2번째로 뚜렷한 주파수 = 대략 %.10f/years \n' %(freq2))
print('3번째로 뚜렷한 주파수 = 대략 %.10f/years \n' %(freq3))

print('가장 뚜렷한 주기 = 대략 %d years \n' %(T1))
print('2번째로 뚜렷한 주기 = 대략 %d years \n' %(T2))
print('3번째로 뚜렷한 주기 = 대략 %d years \n' %(T3))

print('------------------------------------------------------------------')

print('경향성 제거 후 데이터에 fft로 구해진 주기')
print('가장 뚜렷한 주파수 = 대략 %.10f/years \n' %(newfreq1))
print('2번째로 뚜렷한 주파수 = 대략 %.10f/years \n' %(newfreq2))
print('3번째로 뚜렷한 주파수 = 대략 %.10f/years \n' %(newfreq3))

print('가장 뚜렷한 주기 = 대략 %d years \n' %(newT1))
print('2번째로 뚜렷한 주기 = 대략 %d years \n' %(newT2))
print('3번째로 뚜렷한 주기 = 대략 %d years \n' %(newT3))



print('------------------------------------------------------------------')
print('경향성 제거 전 후 주기는 거의 일치한다. \n')


plt.show()