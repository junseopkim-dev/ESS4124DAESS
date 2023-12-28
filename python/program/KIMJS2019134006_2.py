import numpy as np
import matplotlib.pyplot as plt
import functions
from numpy.fft import fft, ifft, fftshift, ifftshift
from scipy.signal import find_peaks
from scipy.interpolate import pchip_interpolate as pchip
import numpy.linalg as nl

filename = 'jeju_geochems.txt'
xy = np.loadtxt(filename,comments='%')



#1번째 column은 단순한 샘플번호이므로 무시
Na = xy[:,1]
Ca = xy[:,2]
K = xy[:,3]
Mg = xy[:,4]
SiO2 = xy[:,5]
Cl = xy[:,6]
SO4 = xy[:,7]
HCO3 = xy[:,8]
NO3 = xy[:,9]
Sr = xy[:,10]

# plt.figure(1)
# plt.plot(Na,Ca,'bo')
# plt.plot(Na,K,'rs')
# plt.plot(Na,Mg,'g^')
# plt.plot(Na,SiO2,'y*')
# plt.plot(Na,Cl,'m+')
# plt.plot(Na,SO4,'k.')
# plt.plot(Na,HCO3,'c<')
# plt.plot(Na,NO3,'b>')
# plt.plot(Na,Sr,'r1')
# plt.legend(['Ca','K','Mg','SiO2','Cl','SO4','HCO3','NO3','Sr'])

#xy에서 첫번째 column 제거한 새로운 xy1 생성

xy1 = xy[:,1:11]

# print('xy1값')
# print(xy1)

#1. 10개 원소간 covariance 및 correlation 계산
#covariance 계산
cv = np.cov(xy1,rowvar=False) #covariance 계산
print(cv.shape) #(10,10)

cc = np.corrcoef(xy1,rowvar=False) #rowvar =false >> colum으로 계산
print(cc.shape) #(10,10)

#2. Correlation matrix 출력
plt.figure(2)
plt.imshow(cc)
plt.colorbar()



#3. Correlation matrix 이용해 eigenvalue, eigenvector 계산

D, U = nl.eig(cv) 

#D = eigenvalue 값 집어넣어놓은 것
#U = eigenvector 값 집어넣어놓은 것



#4. eigenvalue, eigenvector 내림차순 정렬



id = np.argsort(D)[::-1] #[::-1] : 오름차순을 내림차순으로 정렬
U=U[:,id]

[U,D,V] = nl.svd(cv) 

var_pct = D/np.sum(D)*100 #variance percentage

print(var_pct)

plt.figure(4)
plt.bar(range(10),var_pct)
# plt.xlabel('Principal Component')
# plt.ylabel('Explained variance [%]')

print(var_pct[0])
print(var_pct[0]+var_pct[1])
print(var_pct[0]+var_pct[1]+var_pct[2])
print('var_pct[0]+var_pct[1]+var_pct[2], 즉 PC3까지 사용하면 95%이상 정보 설명가능')

#5.
# xy1을 새로운 principal component로 변환(projection)후, PC1과 PC2쌍과 PC1과 PC3쌍을 다른 색 점으로 도시하라

z=xy1@U

#PC1과 PC2쌍

PC1=z[:,0]
PC2=z[:,1]
PC3=z[:,2]

plt.figure(5)
plt.plot(PC1,PC2,'bo')
plt.xlabel('PC1')
plt.ylabel('PC2')

#PC1과 PC3쌍
plt.figure(6)
plt.plot(PC1,PC3,'bo')
plt.xlabel('PC1')
plt.ylabel('PC3')

plt.figure(7)
plt.plot(PC1,PC2,'bo')
plt.plot(PC1,PC3,'rs')
plt.xlabel('PC1')
plt.legend(['PC1,PC2','PC1,PC3'])


plt.show()