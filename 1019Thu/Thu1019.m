%{
y1=a1x1+a0
y2=a1x2+a0

yn=a1xn+a0

(an,a0) = ?
y1   x1 1   a1
y2   x2 1   a0
y3   x3 1
.  = .  1 *
.    .  1
.    .  1
yn   xn 1

Y=XA
XtY=XtXA

asmax.txt 가져오기
%}   

%% 상류부터 거리에 따른 grain size를 파이 값으로 
xy = load("asmax.txt");
x = xy(:,1);
y = xy(:,2);

d=2.^(-y)/10; %cobble pebble
figure
plot(x,d,'bo','MarkerFaceColor','b');
xlabel('distance');
ylabel('grain size [mm]');

hold on
plot([1,11],[64,64],'--k'); % cobble pebble 경계선
% 1차식으로 만들기

[p,S] = polyfit(x,d,1);
[y1,delta] = polyval(p,x,S);
plot(x,y1,'--g','linewidth',1.0);
%그럴듯하지만.. 2차식으로 해보자
[p,S] = polyfit(x,d,2);
[y2,delta] = polyval(p,x,S);
plot(x,y2,'--r','linewidth',1.0);
%2차식이 더 잘 맞는 듯 하지만, 정량적으로 기준이 필요하다. RMS Error 필요
% 'RMSE' Root mean square error

%d는 관측치
%y1, y2는 모델측정치

N=length(d);
rms2 = sqrt(sum((d-y2).^2)/N);
rms2
rms1 = sqrt(sum((d-y1).^2)/N);
rms1

%2차식으로 한 것의 rms가 더 작다 = 모델과 데이터 간 거리의 제곱의 합이 더 작다. 

rms2 = sqrt(sum((d-y2)'*(d-y2))/N); %%다른 방식 transpose로 표기하는법

%edit rmse

%inline function, 서브루틴 내, 현재 내 세션 안에서만 사용

rms = @(a,b) sqrt((a-b)'*(a-b)/length(a));
%inline function 정의, 매개변수 a,b 정의, 이름은 자유
whos rms
%a가 row 벡터면 원하는 값을 얻을 수 없음

rms1 = rms(d,y1)
rms1 = rms(d,y2)

X=[x.^2,x,ones(N,1)];
p = inv(X'*X)*(X'*d);
p

[p,S] = polyfit(x,d,2);
p

%칠판의 이상한 식, 가운데 제곱근 나누기 있는거
X=[x,1./sqrt(x),ones(N,1)];
P = inv(X'*X)*(X'*d)
yy=P(1)*x+P(2)./sqrt(x)+P(3);

yy=X*P;
rms3 = rms(d,yy)

rms1
rms2
rms3

hold on,plot(x,yy,'--k','linewidth',1.0)
%rms2가 가장 잘 맞음, RMS가 제일 작기 때문.

%어떤 곳의 값을 구하고 싶다
[p,S] = polyfit(x,d,2);
y20 = polyval(p,20)

xx = [0:20]';
y20 = polyval(p,xx);
hold on, plot(xx,y20,'--k','linewidth',1.5) 
% 멀어질수록 갑자기 커진다? 틀리다. 즉 20에서는 맞지 않는 모델임을 의미
[p,S] = polyfit(x,d,1);
y21 = polyval(p,xx);
hold on, plot(xx,y21,'--g','linewidth',1.5) 

yy20 = P(1)*xx + P(2)./sqrt(xx) +P(3);

hold on, plot(xx,yy20,'--r','linewidth',1.5) 


%지수함수 모델 만들기 
modelfun = @(b,x) (b(1)+b(2)*exp(-b(3)*x));

beta = nlinfit(x,d,modelfun, [10.,100.,1])
ye = beta(1) + beta(2)*exp(-beta(3)*xx);
hold on, plot(xx,ye,'--b','linewidth',1.5) 