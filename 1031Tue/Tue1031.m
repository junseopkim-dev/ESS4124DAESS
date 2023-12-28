%{
시험 채점 좀 오래 걸릴것.
중간고사 remind

1번, 2번 대부분 맞음 다만 3번 

y=a0+a1x+a2x2+...
그동안 했던 건 linear,

논 리니어
y = a0+'a1x1x2' << 서로 곱으로 구성된 경우

논리니어 대표적으로 익스포넨셜 함수
y=a0+a1e^(+a2x)

%}

xy = load("asmax.txt");
x = xy(:,1);
y = xy(:,2);

figure
plot(x,y)
d = 2.^(-y)/10;

figure
plot (x,d,'bo','MarkerFaceColor','b')
xlabel('distance [m]')
ylabel('grain size [mm]')

% 2차식으로 근사하자니, 이후 값은 상승할 것. 직관적으로 이는 맞지 않음. 2차식이 아닌 지수식으로 모델을 만들자.

%y = a0 + a1 e^ (- a2 x) 라는 함수로 만들자.

%function 정의 1. 인라인, 2. 함수 하나를 .m파일로 저장해서 쓰는 방법

%인라인으로 구현
mfun = @(a,x) (a(1) + a(2)*exp(-a(3)*x)); % 함수 'mfun' 정의

help nlinfit % nonlinear list squared regression
% beta = nlinfit(X,Y,modlefun, beta0), modelfun : 추정되는 모델함수, beta0 : ?설명 놓침

mfun

%a1, a2,a3 찍기. 아무거나. a1 = 50 a2 = 100 a3 = -1

a0 = [50, 100, -1]
alpha = nlinfit(x,y,mfun,a0)

%에러 발생, 

z = mfun(a0,x);
figure, plot(x,z)

%값 수정

a0 = [50, 50, 0.1];

z = mfun(a0,x);
figure
plot(x,z)

alpha = nlinfit(x,y,mfun,a0)
%이젠 에러 발생하지 않고 잘 나온다.
%alpha값 적용해보자.

z= mfun(alpha,x);
figure
plot (x,d,'bo','MarkerFaceColor','b')

alpha = nlinfit(x,d,mfun,a0)


%% 2교시




x(end)

x1 = [0:20];
z1 = mfun(alpha,x1);
hold on, plot(x1,z1,'--k', 'linewidth', 1.2)