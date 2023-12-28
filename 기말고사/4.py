
import numpy as np
import matplotlib.pyplot as plt
import functions


xy = np.loadtxt('mauna.txt',comments='%')

x = xy[:,0]
y = xy[:,1]

plt.figure(1)
plt.plot(x,y)
plt.xlabel('Decimal Date')
plt.ylabel('CO2 mole fraction')

# 특정 트렌드를 갖는 경우
# - 여기서는 우상향 경향성 보임

# normal equation
# y=Ax (A는 매트릭스)
# A를 구하기 위해서는 A= (X^T * X)^-1 (X^T * Y)
# 내장 함수 polyfit 사용해도 가능하나. 학생 입장에서 이는 비추

# polyfit은 퇴물, 이젠 
# numpy.polynomial.polynomial.polyfit으로 사용할 것.

# 1차, 2차 둘 다 해보고, RMSE 작은 쪽으로 채택

P = np.polyfit(x,y,2) #2차원식 계수 
#polyfit : 다항식 계수 구하는 함수

# polyval도 퇴물, 
# 이젠 numpy.polynomial.polyval 사용할 것

y2 = np.polyval(P,x)
#polyval : 다항식 계산하는 함수

plt.plot(x,y2,'--r')

# RMSE 구하기 Root mean square error

# remind that :
#     nextpow2 = lambda N: 1<<(N-1).bit_length()
    
#     lambda : 함수라는 뜻, N을 변수로 받는 함수 정의한다는 뜻


print('2차식 모델 rmse = ', functions.rmse(y, y2))

P = np.polyfit(x,y,1)
y1 = np.polyval(P,x)

plt.plot(x,y1,'--g')
print('1차식 모델 rmse = ', functions.rmse(y, y1))

print(functions.rmse(y, y2)>functions.rmse(y, y1))
#2차식 채택




P = np.polyfit(x,y,2) #2차원식 계수 
y2 = np.polyval(P,x)

plt.plot(x,y2,'--r')

ynew = y-y2

plt.figure(2)
plt.plot(x,ynew)
N = len(ynew)

print(N)


nf = functions.nextpow2(N)
nf = nf*4

print(nf)

from numpy.fft import fft,ifft,fftshift,ifftshift

fy = fftshift(fft(ynew,nf))
#dt = 14/365 # 14일 년단위로
dt = 14/30 # 월단위

f = (np.arange(nf)/nf-0.5)
F=1/dt #1달에 2.14회만큼 측정

f = (np.arange(nf)/nf-0.5)*F #monthly, dt가 월단위로 설정했기 때문

plt.figure(3)
plt.plot(f,abs(fy))

freq1 = 0.08161
period1 = 1/freq1
print('가장 뚜렷한 주기운동 주기 = ',period1,'개월')

nf = nf*4

f = (np.arange(nf)/nf-0.5)*F
fy = fftshift(fft(ynew,nf))
plt.plot(f,abs(fy))

# 왜 안선명해지지???????????????????????????????????????

x.shape




#numpy.vstacking

X = np.vstack((x,np.ones(N)))

X.shape #(2,230)

X[0,:] # 1st row
X[1,:] # 2nd row

X = X.T #transpose

X.shape

X = np.ones(N)
X = np.vstack((X*x,np.ones(N)))

X[:,0]

X = np.vstack((X*x,np.ones(N)))

X.shape #(3,230)

norder = 2 #2차식
z0 = np.ones(N)
X = z0
X.shape #(230,)

for k in range(norder):
    X = np.vstack((X*x,z0))
    
X.shape #(3,230)

A = X @ X.T #@ ; at, 매트릭스 곱하기

A.shape
 #(3,3), 3*3matrix    

B = A.T


# 현재 y는 row vector
# normal equation을 위해선 col vector로 바꿔야 함.

y.shape
y = y.T #안바뀜
y.shape

#2가지 방법 존재

#1st, reshape, 길이를 알아야 함
y = y.reshape(N,1)

y.shape #matrix가 됨

#2nd
B = X@ y

B


import numpy.linalg as nl #선형 대수

# 이번 시험에서 polyfit 사용해도 무방
# 다만 linear algebra는 수학적으로 구현해야 할 것

nl.inv(A)

P

P1 = nl.inv(X @ X.T) @ (X @ y)
# A= (X^T * X)^-1 (X^T * Y)

P1 # col

P # row

#y2 = X @ P1

y2 = X.T @ P1
y2