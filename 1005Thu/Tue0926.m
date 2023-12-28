%% chapter 3 : Univariate Statistics
% 샘플 수 적지만 평균이라 할 수 있는 전제조건 : 
% 1. 모집단이 normal distribution
% 2. 샘플을 random sampling
% 피크 : Mode, 평균 : Mean, 중간값 : Median
% bimodal : 피크가 2개
% mode, mean, median이 모두 일치하는 경우 이상적
% mode, mean, median 다른 경우 존재

xy=load('dewijs1.txt');
x=xy(:,1);
y=xy(:,2);
jk = y>=0;
yy=y(jk);
xx=x(jk);
figure,plot(xx,yy)
xlabel('sample no')
ylabel('Zn weight %')

%60~80 기준으로 달라지는 것 같다(직관)
%우측이 농집도가 더 높다

%히스토그램 보기
figure,histogram(yy,20) 
% 히스토그램 그리기, x축은, 20개로 쪼갬.
min(yy)
max(yy)
%10~15 근처에 최대 = mode
mean(yy) %평균 15.8
median(yy) %중간값, median 13.75
figure,histogram(yy,20)
h=histogram(yy,20);
h
whos h % 구조화된 데이터, structured, 데이터 타입 여러개

h.BinWidth %히스토그램 가로 : 값, 세로 : 빈도
%values : 3 8 8 ...
% BinEdges 3~ 4.8200 사이에 3개
%Binwidth = 1.82(value 사이 등간격)

a=h.BinEdges;
b=h.Values;

length(a)
length(b)

a=a(1:end-1)+h.BinWidth/2
%h.BinWidth/2 히스토그램 중간값

length(a)

%막대그래프 그려라
figure,bar(a,b,'r')
figure,bar(a,b,1.0,'red')
figure,bar(a,b,0.8,'r')

h=histogram(yy,20);
min(yy)
max(yy)
p=[3:1:40];
h=histogram(yy,p)
[a,b]=hist(yy,20);
figure,bar(b,a)
h=histogram(yy,20);
a=h.BinEdges;
a=a(1:end-1)+h.BinWidth/2;
b=h.Values;

%분석할 때 히스토그램 먼저 만들기
%x축이 weight %
xlabel('Zn wt%')
ylabel('Frequency')
sum(b) %116
length(yy) %116

mean(yy)
median(yy)
%normal하다면 좌우대칭
help skewness

skewness(yy) %0.8173, 0이면 symmetric, 왼쪽으로 치우치면 양수, 오른쪽으로 치우치면 음수

%현재 히스토그램은 왼쪽으로 치우침 , 양수

var(yy) % 분산

std(yy) % 표준편차

%std 구현

sqrt(sum((yy-mean(yy)).^2)/(length(yy)-1))

yhat=mean(yy)
nn=length(yy)

sqrt(sum((yy-yhat).^2)/(nn-1))

%% 2교시

sum(yy.^2)
size(y) % column vector

yy'*yy

yy'*yy-sum(y)^2/nn

sqrt((yy'*yy-sum(yy)^2/nn)/(nn-1))
std(yy)

kurtosis(yy)
%3.0을 기준으로 쭈그러들었는지 넓게 퍼져있는지 비교


%random sample generate
t=randn(1000,1); %randn 정규분포를 하는 랜덤, 평균 0
figure,histogram(t,20)
mean(t) % ideal mean = 0
std(t) % ideal std =1
skewness(t) % ideal =0
kurtosis(t) % ideal = 3

%normal distribution 하는 지 여부 판단 필요
%normal distribution = 평균 중앙, 


%산사태 확률 결정요소 : 강우량, 경사도, 토질...
%y = a1x1 + a2x2 + a3x3 + ... +anxn = ?
%x1의 범위는 0~1000000, x2의 범위는 -10~10 ....

%여러 test 존재, 예습 필요
%Student's t test distribution

%pdf, probability density function
%cdf, 누적분포함수, cumulative distribution function

p=[-3:0.1:3];

help normpdf
mu=0
sigma =1
q=normpdf(p,mu,sigma);

figure,plot(p,q)


q=normcdf(p,mu,sigma);
figure,plot(p,q)

%icdf, morminv는? 

help norminv % ~확률을 가질 ~의 값은 얼마? 누적분포그래프에서.(S자 그래프)
%0.5를 가질 x값의 확률

norminv(0.5,mu,sigma)
norminv(0.2,mu,sigma)

help quantile % 어떤 샘플에서 누적확률에서 ~%까지 있는게 얼마냐

quantile(yy,0.7) % 70%에 해당하는 값이 얼마냐?

quantile(yy,[0.25,0.75]) % 25%~75%에 해당하는 값은 얼마냐

quantile(yy,0.68) %이상적인 정규분포라면 표준편차만큼
std(yy)

help ksdensity % 
p=ksdensity(yy)%!
figure,plot(p) % 히스토그램과 유사

[q,p] = ksdensity(yy);
figure,plot(p,q)

sum(q)
h=histogram(yy,20)
d=h.BinWidth

qq=q*d*length(yy);
figure(1),histogram(yy,20)
figure(1),hold on,plot(p,qq,'--r','linewidth',1.2)

%nonparametric statistics : 계산이 가능한 모델만 사용했던 과거와 달리 
% 시험문제 t-test