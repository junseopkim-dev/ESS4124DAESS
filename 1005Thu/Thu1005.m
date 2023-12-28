%% 1교시

% 과제 제출 시 주의사항:파일명 한글 금지, 영어 먼저 들어와야 함.

%{
과제2 설명
schist3가 schist1, schist2 중 어느 쪽에 가까운 지 찾아내기

** silicate를 중심으로 살펴보기
다만titanium으로도 수행해도 무관.

책 3.6, 99페이지
테스트 
1. t-test (스튜던트 T 테스트) <= 오늘 주로 다룰 것.
2. 카이 스퀘어 테스트


1. t-test(교재 101페이지)
"이게 어디에 더 가까운 지 판단"
만든 사람 : 기네스 맥주회사 퀄리티 컨트롤하던 사람 윌리엄 고셋이 맥주 품질 비교하기 위해 개발한 방법
저자를 Student로 기재. => Student T test

** 평균값을 기준으로 어떤 그룹에 속하는 지 판단함.


2. 카이 스퀘어 테스트
전통적으로 많이 쓰임. 
평균이 의미를 갖기 위해선 normal distribution을 가져야 의미가 있음.
카이 스퀘어 테스트는 서로 다른 데이터셋간 데이터 분포의 유사성을 판단(?)

과제2 : 
세 종류의 시스트 데이터, 1번과 2번은 grade 알고 있음.
세번째 종류는 1과 2 중 어디에 해당하는 지 파악하는 것.


3. F-test(마이너함. 안중요)

standard deviation(표준편차) 얼마나 퍼져있는가

"Standard error" : 시그마 나누기 루트 N

**강의자료 참고
교재 102페이지,
'정규분포와 T' 3) one-tailed test

t모자 = ....(분모에 standard error)


4page eg 1)
'10개의 암석 시료...'

%}

%eg 1

xm = 21.3; % mean
xs = 5.5; % standard deviation
n = 10; % 개수
xe = 17; % 지역 전체의 공극률 기대 값

%degree of freedom , 자유도, 100개 중 2개가 같으면, 자유도 99개

alpha = 0.05; % significance lever : one -tail (1-alpha)
df = n-1; % degree of freedom: one tail = n-1

t = (xm-xe)/(xs/sqrt(n)); % ** t-value of one-tailed test

tc = tinv(1-alpha,df);

% t =2.4723, tc = 1.8331

%95% 신뢰도, 1-alpha

help tinv %확률값과 degree of freedom 입력받음

% t가 tc보다 더 크다. reject
x = [-5:0.01:5]';
y = tpdf(x,df);
figure,plot(x,y)
xlabel('t-value'), ylabel('pdf')

%114페이지 그림과 유사하게 그리기

jk = x>=tc;
hold on, area(x(jk),y(jk),'Facecolor','b')

%t값이 파란색 영역에 속하면 reject

t = (xm-xe)/(xs/sqrt(n));

y0 = tpdf(t,df)

hold on,stem(t,y0,'rs','Linewidth',1.2) % t값 빨간색으로 표시
%reject
%따라서 17%보다 크거나 같다고 할 수 없음

% 밑 바운더리 값이 17이라 할 수 없다.

%help ttest


%% 쉬는시간 독학
% Eg 1의 cf : 19%인 경우?

xm = 21.3;
xs = 5.5;
n = 10;
xe = 19; % 기대치, 이 값 19로 변경

%degree of freedom , 자유도, 100개 중 2개가 같으면, 자유도 99개

alpha = 0.05; % significance lever : one -tail (1-alpha)
df = n-1; % degree of freedom: one tail = n-1

t = (xm-xe)/(xs/sqrt(n)) % ** t-value of one-tailed test

tc = tinv(1-alpha,df)

% t =2.4723, tc = 1.8331

%95% 신뢰도, 1-alpha


% t가 tc보다 더 크다. reject
x = [-5:0.01:5]';
y = tpdf(x,df);
figure,plot(x,y)
xlabel('t-value'), ylabel('pdf')

%114페이지 그림과 유사하게 그리기

jk = x>=tc;
hold on, area(x(jk),y(jk),'Facecolor','b')

y0 = tpdf(t,df)

hold on,stem(t,y0,'rs','Linewidth',1.2) % t값 빨간색으로 표시

%% 2교시

%Eg 2) 금광 문제

xm = 3.5;
xs = 1.5;
n = 20;
alpha = 0.05; % significance lever : one -tail (1-alpha)
df = n-1; % degree of freedom: one tail = n-1

% one - tail, 5%
tc = tinv(1-alpha,df)

xe = xm-tc*xs/sqrt(n) % 기대치

% t=tc로 생각하고 접근


% two taile, 양쪽에 2.5%
tc = tinv(1-alpha/2,df)

xe = xm-tc*xs/sqrt(n) % 기대치
%tc = 2.0930, xe = 2.7980
%% clear all

xy = load('dewijs1.txt');
x=xy(:,1);
y=xy(:,2);
%figure,plot(x,y)
jk = y>=0;
x = x(jk);
y = y(jk);
figure,plot(x,y)

xlabel('sample no'), ylabel('Zn %')

mm= mean(y) % 15.79
ss = std(y) % 7.9534

h = histogram(y,20); % y를 20개로 나눠서 그려라
figure,plot(x,y)
figure,plot(x,y,'linewidth',1.2)

%65번 기준으로 좌우 나눠보기

y1 = y(1:65);
y2 = y(66:end);
m1 = mean(y1)
m2 = mean(y2)
%m1, m2 다른 값, 3% 이상 차이
s1 = std(y1)
s2 = std(y2)
%s1,s2 서로 큰 차이 보임.

figure,histogram(y1,15) % y1 = blue

hold on, histogram(y2,15) % y2 = brown

%{
두 그래프가 같은 집단인지 판단
교과서 two-tailed 115페이지 공식, (분모 긴거)


%}

n1 = length(y1)
n2 = length(y2)

% 교과서 공식 적용, 보기쉽게 임시로 A,B 등으로 묶어서 
A = (n1+n2)/(n1*n2);
B = ((n1-1)*s1^2+(n2-1)*s2^2)/(n1+n2-2)
t = abs(m1-m2)/sqrt(A*B)


alpha = 0.05;
df = (n1-1)+(n2-1)
tc = tinv(1-alpha/2,df)%양쪽에 2.5%씩

t = abs(m1-m2)/sqrt(A*B)

p=[-5:0.01:5];
q=tpdf(p,df);
figure,plot(p,q,'linewidth',1.2)

tc

jk = p >= tc;
hold on,area(p(jk),q(jk),'FaceColor','r')
jk = p<= -tc;
hold on,area(p(jk),q(jk),'FaceColor','b')

t

y0=tpdf(t,df)

hold on,stem(t,y0,'rs','filled','LineWidth',1.2)

%t값이 파란 영역에 존재 => reject => 즉 두 집단은 서로 다른 집단이다. 
%서로 다른 집단으로 보는 것이 타당하다.

%이 과정 수행하는 명령어
help ttest2

[h,p,ci] = ttest2(y1,y2)
% h : 1이 나오면 rejection =>y1,y2는 서로 다른 집단임을 의미
% h : 0이 나오면 같은 모집단에서 나왔음을 의미 

% p : 확률 , 높을수록 매우 그렇다

% ci : m1 = 14.38

[h,p,ci] = ttest(y1,14.0)

%h = 0 => 가설 만족.
%ci = 양쪽 12.7324, 16.0276

%y1의 평균은 14.38, 평균값은 12.732부터 16.028 사이에 존재한다. 95% 확률로.

[h,p,ci] = ttest(y2,m2)
% p=1, 즉 100%