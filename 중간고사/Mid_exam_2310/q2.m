%% 이 코드는 2번 문제를 풀기위해 임시로 작성했던 코드입니다. 전부KIMJS...로 복사된 상태입니다.

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
%% Q3

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

%% Q4
%figure 참고. 생략

%% Q5

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
