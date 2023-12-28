xy = load("co2-mm-mlo.txt");
x = xy(:,2);
y = xy(:,3);

jk =y>0;
x = x(jk);
y = y(jk);

figure 
plot(x,y)

%1990년대 말까지의 데이터만 추출

jx = x<=1990;
x1 =x(jx);
y1 =y(jx);

hold on
plot(x1, y1,'r.')

mfun = @(a,x) (a(1) + a(2)*exp(+a(3)*x));

%guessing, 찍기
a0 = [150, 150, 0.01];
alpha = nlinfit(x1,y1,mfun,a0)
alpha = nlinfit(x1,y1,mfun,alpha)
alpha = nlinfit(x1,y1,mfun,alpha)

%위의 추정 잘못된 듯. 다시 찍기

a0 = [1, 1, 1];
%alpha = nlinfit(x1,y1,mfun,a0)

x1 = x1-1958;

a0 = [100,100,0.5];
alpha = nlinfit(x1,y1,mfun,a0) % 여기와

a0 = [10,10,0.1];
alpha = nlinfit(x1,y1,mfun,a0) %여기가 값이 같다.

x2 =x -1958;
y2 = mfun(alpha,x2);
hold on
plot(x,y2,'--k')

y2(end) - y(end)

% 이번엔 모든 자료를 바탕으로, 앞으로 30년 뒤 값 예측해보기(2050)



a0 = [10,10,0.1];
x_temp = x-1958;


alpha = nlinfit(x_temp,y,mfun,a0) ;

x_long = [0:1/12:2050-1958] % 0.1간격 대신 1/12로 하면 월별로 구할 수 있다.


y_guess = mfun(alpha,x_long);



figure 
plot(x,y)
hold on
plot(x_long+ 1958,y_guess,'--k')

y_guess(end)

%% 교수님 풀이

x1 = x-1958;
alpha = nlinfit(x1,y,mfun,[200,50,0.01])

x2 = [0:1/12:90]';
%y3 = mfun(alpha,x3);
y3 = mfun(alpha,x2);
hold on
plot(x2+1958,y3,'--r','linewidth',1.2)
alpha = nlinfit(x1,y,mfun,[100,10,0.01])



%% 산소 동위원소

xy = load('icecore_gripd18o.txt');
x = xy(:,1);
y = xy(:,3);

figure
plot(x,y) %depth - age
xlabel ('depth [m]')
ylabel ('age [yr]')
% 개형을 보아하니 지수함수가 잘 맞을 듯 하다

exp(0.1*3000) % 매우 큰 값 나옴.
%x,y를 1000으로 나누어 모델 구한 뒤, 다시 1000배 확대시켜 구하자.

% figure, plot(y,x)
% xlabel ('age [yr]')
%ylabel ('depth [m]')

%두 부분으로 나눈다.
%compaction late 작은 부분(앞부분) : 일차식 혹은 이차식, linear
%compaction 일어난 부분(뒷부분) : exponential


%원래 과제로 낼 예정. 스스로 한번 해보기.

%다음주 목요일 휴강(11월 9일)

%다음 수업때 파이썬시작, 파이썬과 매틀랩 차이 설명할 예정, 주기변화에 대한 분석(푸리에 변환)
%기말고사는 파이썬으로 나옴.