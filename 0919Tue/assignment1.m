fprintf("무작위 정수 갖는 4*4 행렬 A,B 생성\n");


A = randi([-20,20],4,4);

B = randi([-20,20],4,4);

A

B


% 구하고자 하는 것  =  A*B'
%---------------------------
%방법 1 : 
%temp = B'로 정의 후, A*temp를 for문을 이용한 일반적인 행렬 곱셉 수행
fprintf("구하고자 하는 것 = A*B' \n");
fprintf("------------------------------------------------\n");
fprintf("방법 1 : B를 Transpose한 뒤, 일반적인 행렬곱 수행 \n\n");

temp = B';

temp 

fprintf("  ① : B를 Transpose한 행렬을 temp에 저장 \n");



for k = 1:length(A)
      for l = 1:length(temp)
            d = A(k,:)*temp(:,l);
            c(k,l) = d;
      end
   end
% for을 이용한 일반적인 행렬 곱셈 구현방식과 동일
c

fprintf("  ② : for문을 이용, 일반적인 행렬 곱셈 A*temp 수행 \n");
fprintf("       A*temp는 c에 저장됨 \n");

A*B'

fprintf("  ③ : 검산, 반복문을 이용해 구한 A*temp 값(c)과 A*B'(ans)와 비교 \n");
fprintf("      서로 일치함을 확인 가능.\n\n\n");

%c와 A*B'가 서로 일치
%---------------------------
%방법 2 :
% B를 transpose하지 않고 B 그대로 쓴 채 for문 내에서 A*B' 구현하기

fprintf("------------------------------------------------\n");
fprintf("방법 2 : B를 Transpose하지 않고 for문 내에서 역행렬 곱셈 구현하기 \n\n");


for k = 1:length(A)
      for l = 1:length(B)
            sum = 0; % 각 항의 곱셈한 값들의 합을 구하기 위한 sum 변수 도입 (초깃값 = 0)
            for m = 1:length(B) % length(B)대신 length(A)넣어도 무방
                  sum = sum + A(k,m)*B(l,m); % sum에 순서대로 각 항의 곱이 더해짐
            end
            c(k,l)=sum; % sum 값을 c의 해당 요소에 저장 
      end
   end
c

fprintf("  ① : A의 k번째 row, B의 l번째 row의 성분끼리 차례대로 곱하고 더하면 A*B'의 (k,l)성분과 같음을 이용 \n");
fprintf("      for문을 이용해 구한 A*B'는 c에 저장됨 \n");

A*B'

fprintf("  ② : 검산, 반복문을 이용해 구한 값(c)과 A*B'(ans)와 비교 \n");
fprintf("      서로 일치함을 확인 가능.\n\n\n");

%c와 A*B'가 서로 일치
