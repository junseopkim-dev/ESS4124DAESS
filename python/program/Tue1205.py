# -*- coding: utf-8 -*-
"""
Created on Tue Dec  5 15:06:37 2023

@author: kjs
"""

# PCA :Principal Component Analysis

import numpy as np
import matplotlib.pyplot as plt
import numpy.linalg as nl

# magmatic rock
# amp, pyr, pla
# Arkosic sandstone : 근원지로부터 가까이 존재, 갑자기 구조활동에 의해 산맥이 형성된 경우

# Hydrothermal vein

xy = np.loadtxt('..\data\sediments.txt',comments='%')

xy.shape
plt.figure(1)
plt.plot(xy[:,0],xy[:,1],'bo') #amp, pyr, 높은 상관관계
plt.plot(xy[:,0],xy[:,4],'rs') #amp, qtz, 낮은 상관관계

cv = np.cov(xy,rowvar=False) #covariance 계산

cv.shape #(9,9)

cv[0,:]

cc = np.corrcoef(xy,rowvar=False) #rowvar =false >> colum으로 계산
cc[0,:]

cc.shape # (9,9)


plt.figure(2)
plt.imshow(cc)
plt.colorbar()

# 대각선은 전부 1.0  
# 1,2,3 번째 column
# 4,5,6 
# 7,8,9 

D, U = nl.eig(cv) #

U.shape #(9,9)

U[:,0]

# D = eigenvalue 값 집어넣어놓은 것

D

plt.figure(3)
plt.plot(D)

#첫번째 값이 제일 크고 갈수록 작아짐 그런데 뒤에서 2번째꺼는 맨 마지막 것 보다 큼

id = np.argsort(D)

id = np.argsort(D)[::-1] #[::-1] : 오름차순을 내림차순으로 변경

id

U=U[:,id]

# [U,D,V] = nl.svd(cv)



# U : vector
# D : diagonal, 자동으로 내림차순, 추가적인 정렬작업 불필요 혹시모르니 정렬 작업 해도 무방
# V : vertical vector

#var %
var_pct = D/np.sum(D)*100

plt.figure(4)
plt.bar(range(9),var_pct)

plt.xlabel('PCs component number.')
plt.ylabel('Explained variance [%]')

var_pct #80, 17, 0.8, 

z = xy @ U #matrix 곱하기
z[:,0]
z[:,1]

plt.figure(5)
plt.plot(z[:,0],z[:,1],'bs')

plt.xlabel('PC 1')
plt.ylabel('PC 2')


plt.figure(6)
plt.plot(z[:,1],z[:,3],'ro')

plt.xlabel('PC 2')
plt.ylabel('PC 4')

plt.axis([-0.3,0.2, -0.1, 0.2])

p = xy
# p[0,0] #0.1702

# p[0,0] = 0

# xy[0,0] # 0.0

#파이썬은 속도 높이고 메모리 아끼고자 =(equal)을 assign으로 인식
# 같은 메모리를 쓰기 때문에 P값을 변경해도 오리지널 xy값도 변경됨
# 서브루틴(function)을 불러올때도 마찬가지

p = np.copy(xy)

xy[0,0]

p[0,0] = 1

xy[0,0]

#p에는 xy를 복사한 값을 새로운 메모리에 저장. xy와 분리된 상태. p에 무슨 짓을 해도 본체 xy에는 영향없음

#이번 주 목요일 와서 질문할 것. 안와도 결석 아님
# 다음 주 화요일도 교수님 와계실 것. 질문 받으실 것, 안와도 결석 아님

# 푸리에, Principal Component 2곳에서 냄