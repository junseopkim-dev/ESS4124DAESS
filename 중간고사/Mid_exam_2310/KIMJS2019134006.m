%% Q1-1
%-------------------------------------
%drillcore 1
xy1 = load('drillcore_1.txt');
dep1 = xy1(:,1);
str1 = xy1(:,2);

figure('Name','drillcore_1','NumberTitle','off');
plot(dep1,str1);
xlabel('depth [m]');
ylabel('암석의 강도');

%-------------------------------------
%drillcore 2
xy2 = load('drillcore_2.txt');
dep2 = xy2(:,1);
str2 = xy2(:,2);

figure('Name','drillcore_2','NumberTitle','off');
plot(dep2,str2);
xlabel('depth [m]');
ylabel('암석의 강도');

%% Q1-2 #T-test
%-------------------------------------
%drillcore 1 (6.5~9.5)
jk = 6.5 < dep1;
dep1 = dep1(jk);
str1 = str1(jk);

jk = 9.5 > dep1;
dep1 = dep1(jk);
str1 = str1(jk);

figure
h1=histogram(str1,10);

nn1 = length(str1); % 자료 갯수
mm1 = sum(str1)/nn1; % 평균
ss1 = sqrt(sum((str1 - mm1).^2) / (nn1-1)); % 표준편차


%-------------------------------------
%drillcore 2 (6.5~10)
jk = 6.5 < dep2;
dep2 = dep2(jk);
str2 = str2(jk);

jk = 10 > dep2;
dep2 = dep2(jk);
str2 = str2(jk);

figure
h2=histogram(str2,10);

nn2 = length(str2); % 자료 갯수
mm2 = sum(str2)/nn2; % 평균
ss2 = sqrt(sum((str2 - mm2).^2) / (nn2-1)); % 표준편차

%-------------------------------------
%drillcore 1 vs drillcore 2
t21A = (nn2+nn1)/(nn2*nn1);
t21B = ((nn2-1)*ss2^2+(nn1-1)*ss1^2)/(nn2+nn1-2);
t21 = abs(mm2-mm1)/sqrt(t21A*t21B);

alpha = 0.05;
df21 = (nn2-1)+(nn2-1);
tc21 = tinv(1-alpha/2,df21); % two-tailed => 1-alpha/2 적용
p21 = [-5:0.01:5];
q21 = tpdf(p21,df21);

figure('Name','drillcore_1 = drillcore_2?','NumberTitle','off');
plot(p21,q21,'linewidth',1.2);

jk21 = p21 >= tc21;
hold on,area(p21(jk21),q21(jk21),'FaceColor','b');
jk21 = p21 <= -tc21;
hold on,area(p21(jk21),q21(jk21),'FaceColor','b');

y21=tpdf(t21,df21);
hold on,stem(t21,y21,'rs','filled','LineWidth',1.2);

xlabel('t-value');
ylabel('pdf');

fprintf('---------------------------------------------- \n');
fprintf('* drillcore_1과 drillcore_2간 직접 t-test 수행 (alpha = %5.2f) \n',alpha);

fprintf('t값은 %5.3f이며, \nt_critical의 값은 %5.3f, %5.3f이므로, \n',t21,-tc21,tc21);

if t21 > -tc21 && t21 < tc21
    fprintf('t값이 파란 영역 외에 존재하므로, 같은 집단이라 볼 수 있습니다. \n');
else
    fprintf('t값이 파란 영역 내에 존재하므로, 같은 집단이라 보기 힘듭니다. \n');
end

fprintf('---------------------------------------------- \n')
fprintf('* ttest2 명령어 이용해 판별 \n')

if ttest2(str1,str2) == 0
    fprintf('drillcore_1은 drillcore_2과 일치한다고 볼 수 있습니다. \n') 
else
    fprintf('drillcore_1은 drillcore_2과 일치한다고 보기 힘듭니다. \n')
end

%% Q1-2 #Chi-square
alpha=0.05

% drillcore_1
figure
h1=histogram(str1,10);

v1 = h1.BinEdges(1:end-1)+h1.BinWidth/2;
nobs1 = h1.Values;

nhat1 = normpdf(v1,mm1,ss1); % expectation 구하는 식
nhat1 = nhat1*sum(nobs1)/sum(nhat1);

hold on,plot(v1,nhat1,'--r','linewidth',1.0)

chi2_1 = sum((nobs1-nhat1).^2 ./nhat1)
df1 = length(v1)-3;
chi2c_1 = chi2inv(1-alpha,df1)

if chi2_1 < chi2c_1,
	fprintf("\n normal distribution \n")
end

% drillcore_2
figure
h2=histogram(str2,10);

v2 = h2.BinEdges(1:end-1)+h2.BinWidth/2;
nobs2 = h2.Values;

nhat2 = normpdf(v2,mm2,ss2); % expectation 구하는 식
nhat2 = nhat2*sum(nobs2)/sum(nhat2);

hold on,plot(v2,nhat2,'--r','linewidth',1.0)

chi2_2 = sum((nobs2-nhat2).^2 ./nhat2)
df2 = length(v2)-3;
chi2c_2 = chi2inv(1-alpha,df2)

if chi2_2 < chi2c_2,
	fprintf("\n normal distribution \n")
end


t = [0:0.1:30];
z = chi2pdf(t,df1);
figure('Name','drillcore_1_chi','NumberTitle','off');
plot(t,z)
jk = t >= chi2c_1;
hold on,area(t(jk),z(jk),'Facecolor','b')
grid on

t0 = chi2_1;
y0 = chi2pdf(t0,df1);
hold on,stem(t0,y0,'r','filled') 

%[h,p] = chi2gof(y)


t = [0:0.1:30];
z = chi2pdf(t,df2);
figure('Name','drillcore_2_chi','NumberTitle','off');
plot(t,z)
jk = t >= chi2c_2;
hold on,area(t(jk),z(jk),'Facecolor','b')
grid on

t0 = chi2_2;
y0 = chi2pdf(t0,df2);
hold on,stem(t0,y0,'r','filled') 

%[h,p] = chi2gof(y)


%% Q1-3


%% Q2

%% Q2 세팅

xy = load('co2-mm-mlo.txt');
c1 = xy(:,1); % date
c2 = xy(:,2); % decimal date
c3 = xy(:,3); % interpolated
c4 = xy(:,4); % trend
c5 = xy(:,5); % num of days

jk = c3>=0;

c1=c1(jk);
c2=c2(jk);
c3=c3(jk);
c4=c4(jk);
c5=c5(jk);

N = length(c3);
%% Q2-1

figure('Name','decimal days - interpolated','NumberTitle','off');
plot(c2,c3);
xlabel('decimal date');
ylabel('interpolated');

%% Q2-2

%위에서 jk로 음수값을 없애는 필터링을 거쳤음. 생략
%% Q2-3

%1차식
%{
[p,S] = polyfit(c2,c3,1);
[y1,delta] = polyval(p,c2,S);
%}
X=[c2,ones(N,1)];
P = inv(X'*X)*(X'*c3);
y1=P(1)*c2+P(2);

hold on, plot(c2,y1,'--g','linewidth',1.0);


%2차식
%{
[p,S] = polyfit(c2,c3,2);
[y2,delta] = polyval(p,c2,S);
%}

X=[c2.^2,c2,ones(N,1)];
P = inv(X'*X)*(X'*c3);
y2=P(1)*c2.^2+P(2)*c2+P(3);
hold on, plot(c2,y2,'--r','linewidth',1.0);


rms = @(a,b) sqrt((a-b)'*(a-b)/length(a));
rms1 = rms(c3,y1)
rms2 = rms(c3,y2)


if rms1 > rms2
    fprintf('2차식(red)이 1차식(green)보다 rms가 작으므로, 2차식 모델이 더 적합하다고 볼 수 있습니다. \n') 
else
    fprintf('1차식(green)이 2차식(red)보다 rms가 작으므로, 1차식 모델이 더 적합하다고 볼 수 있습니다. \n')
end

hold on,stem(2018,P(1)*2018^2+P(2)*2018+P(3),'rs','filled','LineWidth',1.2);

%% Q2-4
%figure 참고. 생략

%% Q2-5

jk = c2 <1991;
c2 = c2(jk);
c3 = c3(jk);
N = length(c3);

xx=[1958:0.1:2018];

figure('Name','1990말까지 측정된 자료로부터 구해진 예측치','NumberTitle','off');
plot(c2,c3)


%1차식
%{
[p,S] = polyfit(c2,c3,1);
[y1,delta] = polyval(p,c2,S);
%}
X=[c2,ones(N,1)];
Q = inv(X'*X)*(X'*c3);
y11=Q(1)*xx+Q(2);

hold on, plot(xx,y11,'--g','linewidth',1.0);



%2차식
%{
[p,S] = polyfit(c2,c3,2);
[y2,delta] = polyval(p,c2,S);
%}

X=[c2.^2,c2,ones(N,1)];
Q = inv(X'*X)*(X'*c3);
y22=Q(1)*xx.^2+Q(2)*xx+Q(3);
hold on, plot(xx,y22,'--r','linewidth',1.0);


rms = @(a,b) sqrt((a-b)'*(a-b)/length(a));
rms1 = rms(c3,y11);
rms2 = rms(c3,y22);


if rms1 > rms2
    fprintf('2차식(red)이 1차식(green)보다 rms가 작으므로, 2차식 모델이 더 적합하다고 볼 수 있습니다. \n') 
else
    fprintf('1차식(green)이 2차식(red)보다 rms가 작으므로, 1차식 모델이 더 적합하다고 볼 수 있습니다. \n')
end

hold on,stem(2018,Q(1)*2018^2+Q(2)*2018+Q(3),'rs','filled','LineWidth',1.2);

observed2018 = P(1)*2018^2+P(2)*2018+P(3)
predicted2018from1990 = Q(1)*2018^2+Q(2)*2018+Q(3)
fprintf('두 사례 모두 이차식으로 표현했을 때 더 잘 맞으므로, 2차식 모델의 예측값으로 표현하겠음\n 2018에 실제 관측된 데이터로부터 얻어진 모델에서의 값은 406.6310을 띄는반면,\n1990년 말까지의 자료로부터 얻어진 2018년의 예측값은 420.3837이 나타났다') 


