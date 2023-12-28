xy = load('dewijs1.txt')
x = xy(:,1);
y = xy(:,2);

jk = y>=0;

yy = y(jk)
xx = x(jk)

figure
plot(xx,yy)
xlabel("sample no")
ylabel("Zn weight percent")

%% 히스토그램
figure
h=histogram(yy,20);

nn=length(yy);

%% 평균
mean(yy)
mm = sum(yy)/nn

%% 표준편차
std(yy)
ss = sqrt(sum((yy-mm).^2)/(nn-1))

min(yy)
max(yy)

%% 막대그래프 그리기
a = h.BinEdges;
b = h.Values;

a = a(1:end-1)+h.BinWidth/2

figure
bar(a,b,0.5)

%% skewness
skewness(yy)

%% 분산
var(yy)
vv = sum((yy-mm).^2)/(nn-1)

%% kurtosis

kurtosis(yy)

%% ttest - one tailed

xm = 21.3; % 평균
xs = 5.5; % 표준편차
n = 10; % 표본 수
df = n-1 % 자유도

xe = 17 % 기대치

alpha = 0.05; % significant level, 신뢰도 = 1-alpha (%)

t = (xm-xe)/(xs/sqrt(n))
tc = tinv(1-alpha,df)

%그림그리기
p = [-5:0.1:5];
q = tpdf(p,df);
figure
plot(p,q)

jk = p>=tc;
hold on
area(p(jk),q(jk),'facecolor','b')
y=tpdf(t,df)
stem(t,y,'rs')

%% ttest - one tailed Eg2

xm = 3.5;
xs = 1.5;
n = 20;
df = n-1;
alpha = 0.05;


tc = tinv(1-alpha,df)

xe = xm - tc*xs/sqrt(n)

%% ttest - two-tailed 
%-------------------------------------schist1
sch1 = load('schist1.txt');
sch1x = sch1(:,1); %silicate wt%

figure
h_sch1_silicate=histogram(sch1x,10);

nn1 = length(sch1x); % 자료 갯수
mm1 = sum(sch1x)/nn1; % 평균
ss1 = sqrt(sum((sch1x - mm1).^2) / (nn1-1)); % 표준편차

%-------------------------------------schist3
sch3 = load('schist3.txt');
sch3x = sch3(:,1); %silicate wt%

figure
h_sch3_silicate=histogram(sch3x,10);

nn3 = length(sch3x); % 자료 갯수
mm3 = sum(sch3x)/nn3; % 평균
ss3 = sqrt(sum((sch3x - mm3).^2) / (nn3-1)); % 표준편차

%방법 1 

%*************************************************************
t31A = (nn3+nn1)/(nn3*nn1);
t31B = ((nn3-1)*ss3^2+(nn1-1)*ss1^2)/(nn3+nn1-2);
t31 = abs(mm3-mm1)/sqrt(t31A*t31B);
%*************************************************************

alpha = 0.05;
df31 = (nn3-1)+(nn1-1);
%*************************************************************
tc31 = tinv(1-alpha/2,df31); % two-tailed => 1-alpha/2 적용
%*************************************************************
p31 = [-5:0.01:5];
q31 = tpdf(p31,df31);

figure('Name','Schist3 = Schist1?','NumberTitle','off');
plot(p31,q31,'linewidth',1.2);

jk31 = p31 >= tc31;
hold on,area(p31(jk31),q31(jk31),'FaceColor','b');
jk31 = p31 <= -tc31;
hold on,area(p31(jk31),q31(jk31),'FaceColor','b');

y31=tpdf(t31,df31);

hold on,stem(t31,y31,'rs','filled','LineWidth',1.2);

%% F-test
xy = load('dewijs1.txt');
x= xy(:,1);
y= xy(:,2);
jk = y>=0;
x=x(jk);
y=y(jk);

y1=y(1:65);
y2=y(66:end);

%help vattest2 % F-test 명령어


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

h = vartest2(y1,y2)

% F > fc 
% %vartest2 결과 =1이므로
% y1,y2는 같은 분포 갖는다고 볼 수 없음

%% 윌콕슨 순위합
[p,h]=ranksum(y1,y2) % 윌콕슨 순위합
%% 카이 스퀘어 테스트 : normal distribution 여부 파악



xy = load('dewijs1.txt');
x= xy(:,1);
y= xy(:,2);
jk = y>=0;
x=x(jk);
y=y(jk);

hg = histogram(y,10);
hg

%bin edge, 각 bin의 최대 최소 경곗값, 즉 중간값은 그 평균으로 구하면 됨
v = hg.BinEdges(1:end-1)+hg.BinWidth/2;
nobs = hg.Values;
mm = mean(y)
ss = std(y)


nhat = normpdf(v,mm,ss); % expectation 구하는 식
nhat = nhat*sum(nobs)/sum(nhat);

%figure
hold on
plot(v,nhat,'--r', 'linewidth', 1.0)




%degree of freedom = K(=v가 몇개냐,각각의 중앙점)-Z
df = length(v)-3

alpha = 0.05

chi2 = sum((nobs-nhat).^2 ./nhat) % 공식
chi2c = chi2inv(1-alpha,df) %critical, 14.067

help chi2inv

if chi2 > chi2c,
    fprintf("\n NOT a normal distribution \n")
end


t = [0:0.1:30];
z = chi2pdf(t,df);

figure,plot(t,z)
jk = t >= chi2c;
hold on,area(t(jk),z(jk),'Facecolor','b')
grid on

t0 = chi2;
y0 = chi2pdf(t0,df);
hold on,stem(t0,y0,'r','filled') 

% cf) try y1, y2
[h,p] = chi2gof(y);