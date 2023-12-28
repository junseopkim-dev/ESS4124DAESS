xy = load('dewijs1.txt'); %xy = dewijs1.txt의 내용
x=xy(:,1); % x = xy의 1번째 column
y=xy(:,2); % y = xy의 2번째 column

jk = y>0;
x=x(jk);
y=y(jk);

h = histogram(y,10);
%%
xx=[-3:0.1:3];
yy=normpdf(xx,0,1);
figure, plot(xx,yy)

