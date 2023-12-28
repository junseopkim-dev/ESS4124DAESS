#1. 포맷팅

 print('\n length x = %d \n' %N)

#2. vscode : Shift + enter = 인터프리터 실행

#3. 푸리에 변환에서, 단위는 dt, 
#같은 한 달이라도, 1 month, 30 days, 1/12 years 등 데이터의 단위에 따라 다르게 표현됨을 유의한다.
#이때 month, days, year중 무엇에 해당하는 지는 바로 주어진 데이터의 header를 확인하면 된다.

#4. 피크 찾기

f1 = fftshift(fft(y1,nf))
plt.plot(f,abs(f1))
peaks, properties = find_peaks(abs(f1), height=230) # peak 찾아주는 명령어

p_peaks = f[peaks]


frq1i = f[peaks][3] # 대략 0.0099275
frq2i = f[peaks][4] # 대략 0.0251497
frq3i = f[peaks][5] # 대략 0.0496375