function [m,jk] = average(x) % 중요: 함수 이름 average와 파일 이름과 동일해야 함
%
%This program compute mean value
%이 프로그램은 평균 계산
%input : x - 1d data
%output : n = mean value

jk = x>=0;

nn = length(x);

if sum(jk)<nn,
	nn=sum(jk);
	ss=sum(x(jk));
else
	ss = sum(x);
end


m=ss/nn;

return

%만약 리턴값 두개(m,nn)하고 싶다면, function [m,nn]