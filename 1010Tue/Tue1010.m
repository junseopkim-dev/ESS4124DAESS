%중간고사 날짜 10월 26일 중 하나

%% 1교시
%t-test : 어떤 샘플이 정규분포 가정, 두 집단이 같은 모집단에서 왔는지 판단하는 테스트
%평균값 기준으로 판별
%{
1. one tail test : 최소 몇보다는 크다 ..., 
2. two tail test : 두 종류의 집단이 같은 모집단인지 판별할 때
사용

student t test 상당히 오래된 방법이지만 샘플 수가 적을 때 효과적.
카이테스트
코글로모프 어쩌구 테스트


정규분포인지 모르겠다? 그래도 두 집단이 같은 집단에서 왔는지 알고싶다? 
median 값으로 비교한다. = 카이 스퀘어?

전공 117페이지 맨 휘트니 테스트 혹은 윌코존 랭크 섬 테스트로 알려짐

두 샘플이 같은 모집단에서 왔는지, null hypothesis
t-test는 정규분포의 평균 이용.
그러나 정규분포한다는 가정 없이 median을 이용해서 비교한다.
%}

help ranksum % 두개의 자료를 랭크썸
xy = load('dewijs1.txt');
x=xy(:,1);
y=xy(:,2);
jk = y>=0;
x = x(jk);
y=y(jk);
x=xy(:,1);

figure, histogram(y,20)
y1=y(1:65);
y2=y(66:end);
[h,p,kstats] = ttest2(y1,y2)
%h =1, 0이 나오면 mean이 같다. 1이 나오면 다르다. (신뢰도 95%)

[h,p,kstats] = ttest2(y2,y1) %반대로 하면 케이스텟 양수로

[p,h]=ranksum(y1,y2)
%h = 0, 테스트 성공 
%p = 확률 0.06... 작은 값. 정확하지 않을 수 있음 의미

%{
variance로 따지는 test = F-Test, 많이 사용되고 있지는 않음. 분산 이용.
2개의 스탠다드 

%}
s1=std(y1)
s2=std(y2)
%106페이지 
F=max(s1^2,s2^2)/min(s1^2,s2^2)

help finv

alpha = 0.05

v1 = length(y1)-1

v2 = length(y2)-1

fc=finv(1-alpha/2,v1,v2)

F

% y1, y2는 같은 분포를 가진다고 볼 수 없다
help vartest2 %variance test하는 명령어

h = vartest2(y1,y2)

% h=1 아니다.

%% 카이 스퀘어 테스트
%{
교과서 110페이지
%}

h=vartest2(y1,y2)
yhat = mean(y)

ysig = std(y)

t = [0:0.1:40];

v = length(y)-1

q = normpdf(t,yhat,ysig); %normal distribution 그리기
figure,plot(t,q) %normal distribution을 갖는다면 이런 양상일 것.

hp = histogram(y,20)
q=normpdf(t,yhat,ysig);
q=q*length(y)/sum(q);
figure(2), hold on, plot(t,q,'--r','linewidth',1.2)
q = q/0.01;
%figure(q)

sum(q)
figure, histogram(y,20) %데이터 빈 20개

figure,plot(t,q)

%number of observation = histotram의 value, 각 data bin에 쌓인 값, 빈도
%정규분포상 그 위치의 빈도 = expected

%Q = K -Z
%K : number of classes, bin?
%Z : 가우시안 디스트리뷰션 

% close all


hg = histogram(y,10);

%Values: [11 20 31 13 13 14 4 5 3 2] <==observation 값
%numofob = hg.values
nobs = hg.Values;
nobs

%bin edge, 각 bin의 최대 최소 경곗값, 즉 중간값은 그 평균으로 구하면 됨
v=hg.BinEdges(1:end-1) + (hg.BinEdges(2:end) - hg.BinEdges(1:end-1))/2


%expectation 구하기
mm = mean(y)
ss = std(y)
nhat = normpdf(v,mm,ss); % expectation 구하는 식
nhat = nhat*sum(nobs)/sum(nhat);
figure(1), hold on, plot(v,nhat,'--r', 'linewidth', 1.0)

%카이 값 구하기
chi2 = sum((nobs-nhat).^2 ./nhat) % 공식

%degree of freedom = K(=v가 몇개냐,각각의 중앙점)-Z
df = length(v)-3

 

help chi2inv

alpha = 0.05
chi2c = chi2inv(1-alpha,df) %critical, 14.067

if chi2 > chi2c,
    fprintf("\n NOT a normal distribution \n")
end

t = [0:0.1:30];
q = chi2pdf(t,df)
figure,plot(t,q)
jj=t>=chi2c;
hold on, area(t(jj),q(jj),'Facecolor','b')
t0=chi2;
y0=chi2pdf(t0,df)

hold on,stem(t0,y0,'r','filled')

%% 2교시
%y1, y2로 해보기


%% y1
hg1 = histogram(y1,10);
nobs1 = hg1.Values;
v1=hg1.BinEdges(1:end-1) + (hg1.BinEdges(2:end) - hg1.BinEdges(1:end-1))/2;
mm1 = mean(y1);
ss1 = std(y1);
nhat1 = normpdf(v1,mm1,ss1); % expectation 구하는 식
nhat1 = nhat1*sum(nobs1)/sum(nhat1);
figure(100),histogram(y1,10)
hold on, plot(v1,nhat1,'--r', 'linewidth', 1.0)

%카이 값 구하기
chi21 = sum((nobs1-nhat1).^2 ./nhat1) % 공식

%degree of freedom = K(=v가 몇개냐,각각의 중앙점)-Z
df1 = length(v1)-3
chi2c1 = chi2inv(1-alpha,df1);

if chi21 > chi2c1,
    fprintf("\n NOT a normal distribution \n")
end

%% y2
hg2 = histogram(y2,10);
nobs2 = hg2.Values;
v2=hg2.BinEdges(1:end-1) + (hg2.BinEdges(2:end) - hg2.BinEdges(1:end-1))/2;
mm2 = mean(y2);
ss2 = std(y2);
nhat2 = normpdf(v2,mm2,ss2); % expectation 구하는 식
nhat2 = nhat2*sum(nobs2)/sum(nhat2);
figure(101),histogram(y2,10)
hold on, plot(v2,nhat2,'--r', 'linewidth', 1.0)

%카이 값 구하기
chi22 = sum((nobs2-nhat2).^2 ./nhat2) % 공식

%degree of freedom = K(=v가 몇개냐,각각의 중앙점)-Z
df2 = length(v2)-3
chi2c2 = chi2inv(1-alpha,df2);

if chi22 > chi2c2,
    fprintf("\n NOT a normal distribution \n")
end

%두번째 껀 normal distribution, 첫번째껀 아님.

%% 위에건 스스로 해보기

[h,p] = chi2gof(y1)

[h,p] = chi2gof(y2)

hg = histogram(y,20);
nobs = hg.Values;
%각 bin의 중앙값 v
v = hg.BinEdges(1:end-1)+(hg.BinEdges(2:end)-hg.BinEdges)
df = length(v)-3
mm = mean(y)
ss = std(y)

nhat = normpdf(v,mm,ss);
nhat = nhat*sum(nobs)/sum(nhat);
hold on, plot(v,nhat,'--r','linewidth',1.0)
chi2 = sum((nobs-nhat).^2 ./nhat)
df = length(v)-3
chi2c = chi2inv(1-alpha,df1)

%빈을 몇개 잡느냐에 따라 결과가 달라질 수 있다. 빈 수를 너무 많이 잡지 말고
%특정 빈에 너무 적지 않도록

%[h,p,st] = chi2(ㅍ)


%이외에도 앤더슨, 달링 테스트 adtest