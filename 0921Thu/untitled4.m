xy = load('dewijs1.txt');

x=xy(:,1);
y=xy(:,2);

jk = y>=0;

ss=sum(y(jk)); %% 조건 jk 만족하는 값들의 합을 ss에 저장

nn=sum(jk); % 조건 jk 만족하는 데이터 갯수를 nn에 저장

mm=ss/nn;

fprintf("\n Mean =  %g (wt%) \n",mm);

% display figure, 세미콜론 없어도 상관없음

figure,plot(2*x(jk),y(jk),'linewidth',2.0) 
xlabel('distance (m)', 'Fontsize',15)
ylabel('Zn weight \%', 'Fontsize',15)
title('Zn weight \% in Qz vein', 'Fontsize',20)
