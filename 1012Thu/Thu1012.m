%% 

%{
에러, 교재 150
시스테마틱 에러
= 자의 길이가 잘못된 경우 ex 평행이동

랜덤 에러 : true 값으로부터 벌어진 정도

standard error = s/root(n)

평균이 6'+-1.2' <= standard error

교재 140 페이지

파라미터가 여러개일때
표준편차의 제곱으로 접근
파라미터간의 상관관계가 있을 경우

예를 들어 산사태, 
사면의 경사, 수목, 암석

암석과 수목 상관관계 없다면 각각의 측정된 것에 대한 표준편차를 구해서 더하면 되는데

상관관계가 있다면 '가우스 방법'

sf = sqrt(1.6^2+1.2^2 -2*1.5*1.2), 마치 뺄셈 거듭제곱의 제곱근 구하듯

흔히 저지르는 실수 중 하나인 유효숫자

데이터 정수라면
평균은 소숫점 1자리까지
표준편차는 소숫점 2자리까지

-Distribution fitting
일종의 regression
지난번 카이 스퀘어 테스트에서
꼭 normal 디스트리뷰션 아님

normfit

가우시안 믹스쳐 gaussian mixture

데이터가 노말 디스트리뷰션 하는 게 아니고(보아뱀 코끼리)
예시) 두개 이상 봉우리, 낙타형 << 환경이 바뀌기 전 후 
육지와 바다가 만나는 지점의 자료

책 133페이지

%}

xy = load('icecore_gripd18o.txt');

% 1열 = 깊이, 2열 : 산소동위원소 18, 3열 : 연대
%빙하 코어에서
%18 증가하면 더움
%16 증가하면 추움


x =xy(:,1) % depth
y =xy(:,2) % oxygen isotope
z =xy(:,3) % age

figure, plot(x,y) % 깊이 - 동위원
figure, plot(y)
figure, plot(z,y)
%1500 이후로 더워진다


y=y(2000:4300);

figure,hg = histogram(y,30)
%% 
mean(y)
std(y)

%평균, 표준편차가 의미가 있나? no, 
%히스토그램을 봐도 피크가 2개가 생김

%둘로 쪼개보자, 2800 3000 부근을 기준으로
% 왼쪽(날이 더울때), 오른쪽(날이 더워지기 전)

mean(y(1:950))
std(y(1:950))

mean(y(951:end))
std(y(951:end))
%% 
%임의로 나눈 것. 임의로 나누지 않고 의미있게 두개로 나누는 방법?
% 있다. 가우시안 믹스쳐 디스트리뷰션, 가우시안 믹스쳐 모델

help gmdistribution
help fitgmdist %가우시안 모델에 피팅

% x : 데이터, k : 몇개의 노드가 있는가

mdl = fitgmdist(y,2);
mdl

%0.61, 0.38 > 노말 디스트리뷰션 2개, 각 모델에 속하는 데이터 약 60%, 40%로 분포

properties(mdl)

%mdl.NumVariables, mdl.DistributionName, ... etc

mdl.DistributionName
mdl.NumVariables
mdl.mu % 평균
mdl.Sigma %
mdl.ComponentProportion %앞의 몇 퍼센트

mdl.PComponents

%%
t=[-45:0.2:-30];
m1 = mdl.mu(1)
m2 = mdl.mu(2)
s1 = mdl.Sigma(1)
s2 = mdl.Sigma(2)

y1=normpdf(t,m1,s1);
figure,plot(t,y1) %아까 히스토그램의 오른쪽에 해당
y2=normpdf(t,m2,s2);
figure,plot(t,y2) %아까 히스토그램의 왼쪽에 해당

%%
%면적 같게 만들기
sum(y1)
sum(y2)
%hg % 칸 간격 0.38
dh = hg.BinWidth
length(y)*dh % 면적

dt=0.2;

help trapz % numerical integration

v =  hg.BinEdges(1:end-1) + dh/2;
n=hg.Values

trapz(v,n)
length(y)*dh

trapz(t,y1)
sum(y1)*dt

trapz(t,y2)
sum(y2)*dt

y1 = y1/trapz(t,y1);
y2 = y2/trapz(t,y2);

sum(y1)
mdl

p1 = mdl.PComponents(1)
p2 = mdl.PComponents(2)

yy = y1*p1+y2*p2;
yy=yy/trapz(t,yy)*trapz(v,n);
trapz(v,n)
length(y)*dh
figure, hg = histogram(y,30)
hold on,plot(t,yy,'--r','linewidth',1.0)
