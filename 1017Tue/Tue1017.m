%{
교재 145페이지
Bivariate statics

회귀분석

퇴적물의 뎁스와 연령의 상관성, 146페이지 예제
저 관계를 분석하면 앞으로 측정하지 않은 40m의 암석의 연령을 유추할 수 있음
Regression
least square 최적화 

1. 상관계수, correlation coefficients 146p
x는 퇴적물의 깊이, y:연령
각각의 평균을 뺀 것을 서로 곱해준다. 

variance = (1/n-1) * sigma((x-x평)*(x-x평))
correlation coefficient는 variance와 유사


%}

xy = load('agedepth_1.txt');
x=xy(:,1);
y =xy(:,2);

figure;
plot(x,y,'o','linewidth',2.0); % o는 동그라미 의미
xlabel('depth [m]');
ylabel('age [x1000 yr]');

%그려보면 깊이가 깊어질수록 연령은 비례해서 커짐을 관찰할 수 있다.
%correlation coefficient 구해보자 p146 공식

mx = mean(x);
my = mean(y);
sx = std(x);
sy = std(y);
rxy=sum((x-mx).*(y-my))/(sx*sy)/(length(x)-1);
rxy
rxy=sum((x-mx)'*(y-my))/(sx*sy)/(length(x)-1); % 위 방법과 동일
rxy
%0.9342 => 상당히 연관성이 높음을 의미

help cov % covariance 구하는명령어
cv = cov(x,y); % 4개의 variance (xx, xy, yx, yy)담긴 covariance matrix

cv

rho = corrcoef(x,y); %% correlation coefficient 구함. 2*2 행렬로. 조금전 구한 4개 variance로 나눈 것.

rho %%rxy와 동일, 자기 자신과의 유사도 나타내는 부분은 1로 나타남

%{
r =1이면 45도 기울기 우측상향 직선 그림
r=-1이면, 45도 기울기 우측하향 직선 그림
r=0이면 서로 관련없음 의미

직선이 아닌 곡선으로 변하는 경우도 값을 보여준다.
%}


%% ice core
xy = load("icecore_gripd18o.txt");

x = xy(:,1); % depth
y=xy(:,3); %age
figure;
plot(y,x,'o','linewidth',2.0); 
xlabel('age');
ylabel('depth');
%compaction때문에, 공극이 줄어들었기 때문에 이렇게 보임

corrcoef(x,y) % 0.7812, 상관관계가 있지만 
%2차함수처럼 그려질경우, 상관관계 낮게 나타남. 하나의 y에 대해 두개의 x 존재하는 경우 p147


%%
% figure d, 오류 발생하는 케이스, 
% 실제 데이터는 한 점에 모여있으나, 아웃라이어와 이어저 마치 직선관계를 이루는 것처럼 착각
x=randn(100,1);
y=randn(100,1);
close all
figure
plot(y,x,'o','linewidth',2.0);
rho = corrcoef(x,y);
x(101) = 99;
y(101) = 101;

plot(y,x,'o','linewidth',2.0); % outlier 추가

rho = corrcoef(x,y)

%p149, Kendall's 

help corrcoef

%corr이라는 명령어를 쓰자, p152
help corr

%help => Pearson, Kendall, Spearman

rho = corr(x,y,'Type','Spearman')
rho = corr(x,y,'Type','Kendall')
%%
xy = load('agedepth_1.txt');
x1=xy(:,1);
y1 =xy(:,2);

figure
plot(x1,y1,'o','linewidth',2.0)
rho = corr(x1,y1,'Type','Kendall')

%rho = corr(x1,y1,'Type','')
%rho = coffcoef(x1,y1)

rho = corr(x1,y1,'Type','Pearson')

%상관관계를 찾는법? bootstrp

help bootstrp %,랜덤하게 몇 개 빼고 수천번 반복

rho = bootstrp(1000,'corrcoef',x,y);

whos rho

figure
plot(rho(:,1))
figure
plot(rho(:,2))
figure
histogram(rho(:,2),20)
% 뽑은 것 중 outlier가 포함되면 corrcoef 1이 나옴., outliar

rho1 = bootstrp(1000,'corrcoef',x1,y1)

rho1 = bootstrp(10000,'corrcoef',x1,y1)
figure, histogram(rho1(:,2),20)

%% 1교시 끝

%{
regression 해보기
linear regression p155

age(x)와 depth(y)의 관계를 

y=a0+a1*x
(a0,a1)=?

y1=a0+a1x1
y2=a0+a1x2
...

column vector (y1, y2, y3, y4, ...)
=
n*2 matrix (1 x1, 1 x2, 1 x3, ...)
*
column vector (a0 a1)

x 인버스 y는  a, 개념적으론. 
(XtX)^-1 (XtY)
%}


help polyfit %x,y에 대한 변수를 몇차 polynomial함수
%%
clear all
xy = load('agedepth_1.txt');
x=xy(:,1);
y =xy(:,2);

figure;
plot(x,y,'o','linewidth',2.0);
[p,S] = polyfit(x,y,1); %1차식
p %2개의 값 (1번째 값 = 일차항 계수, 2번째 값 = 상수항 계수)
xlabel('depth [m]');
ylabel('age [x1000 yr]');
xx = [0:0.1:20];
yy = p(1)*xx+p(2); %% 일차식

hold on;
plot(xx,yy,'--r','linewidth',1.0);

%루트 민 에러

X=[xx',ones(length(xx),1)];
X
whos X %201*2 matrix
whos p % X와 p를 곱하기 위해선, 현재 row vector 상태인 p를 전치시켜야 함

Y = X*p'
plot(xx,Y,'--g','linewidth',0.3); % 앞서 그린 빨간 선과 같다.

%S가 뭘까?
S % df = 자유도
S.R %2*2 matrix


help polyval %p값을 넣어주고 새로운 x값을 넣어주면, 그에 대응하는 y값을 뱉는다
yy=polyval(p,x,S);
plot(xx,yy,'--r','linewidth',1.0)

%S를 추가로 넣어보자.
[yy,delta] = polyval(p,xx,S);

%figure
%plot(xx,delta) %왠 2차함수
hold on
plot(xx,yy+delta, '--b','linewidth',0.8)
plot(xx,yy-delta, '--b','linewidth',0.8)

y0 = polyval(p,x,S);
jk = abs(y-y0)>delta;
plot(x(jk),y(jk),'rs','linewidth',2.0)

%% again
clear all
xy = load('agedepth_1.txt');
x=xy(:,1);
y =xy(:,2);

figure
plot(x,y,'o','linewidth',2.0)
[p,S]=polyfit(x,y,1);
p % 계수,최고차항 부터 상수항 순
[yy,delta]= polyval(p,x,S);
%각각의 x에 대한 1차식?
hold on
plot(x,yy,'r','linewidth',1.2)
xx = [-2:0.1:25];
[yy,delta]=polyval(p,xx,S);
hold on
plot(xx,yy,'--r','linewidth',1.2)

hold on
plot(xx,yy+delta,'--k','linewidth',1.2)

hold on
plot(xx,yy-delta,'--k','linewidth',1.2)

p
%p값을 어떻게 구한건가?
%아까 매트릭스 X
X=[x,ones(length(x),1)];

D = inv(X'*X)

B = X'*y;

% whos y
B

D*B 
p

% D*B와 p는 서로 일치

p = inv(X'*X)*(X'*y);
p
% 위 식 : 교재 155페이지 아래 메모 참고.
% inv(X'*X) <<<< 계산하는데 오랜 시간 걸리는 부분, 변수 많아지면 시간 소요 증가
