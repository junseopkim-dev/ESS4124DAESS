cd C:\Users\kjs\Documents\3-2\DAESS\1005Thu\HW2
% 3&1, 3&2 두번 비교 해보기. two-tailed
%% schist 1
sch1 = load('schist1.txt');
sch1x = sch1(:,1); %silicate wt%
%sch1y = sch1(:,2); %titanium wt%

figure('Name','Schist1_silicate','NumberTitle','off');
h_sch1_silicate=histogram(sch1x,10);

nn1 = length(sch1x); % 자료 갯수
%mm1 = mean(sch1x) % 평균
%ss1 = std(sch1x) % 표준편차

mm1 = sum(sch1x)/nn1; % 평균
ss1 = sqrt(sum((sch1x - mm1).^2) / (nn1-1)); % 표준편차

fprintf('---------------------------------------------- \n');
fprintf('schist1 : \n평균 : %5.3f, 표준편차 : %5.3f\n',mm1,ss1);

xlabel('Silicate, wt%');
ylabel('number of samples');

%% schist 2
sch2 = load('schist2.txt');
sch2x = sch2(:,1); %silicate wt%
%sch2y = sch1(:,2); %titanium wt%

nn2 = length(sch2x); % 자료 갯수
%mm2 = mean(sch2x); % 평균
%ss2 = std(sch2x); % 표준편차

figure('Name','Schist2_silicate','NumberTitle','off');
h_sch2_silicate=histogram(sch2x,10);

mm2 = sum(sch2x)/nn2; % 평균
ss2 = sqrt(sum((sch2x - mm2).^2) / (nn2-1)); % 표준편차

fprintf('---------------------------------------------- \n');
fprintf('schist2 : \n평균 : %5.3f, 표준편차 : %5.3f\n',mm2,ss2);

xlabel('Silicate, wt%');
ylabel('number of samples');

%% schist 3
sch3 = load('schist3.txt');
sch3x = sch3(:,1); %silicate wt%


nn3 = length(sch3x); % 자료 갯수
%mm3 = mean(sch3x); % 평균
%ss3 = std(sch3x); % 표준편차

figure('Name','Schist3_silicate','NumberTitle','off');
h_sch3_silicate=histogram(sch3x,10);

mm3 = sum(sch3x)/nn3; % 평균
ss3 = sqrt(sum((sch3x - mm3).^2) / (nn3-1)); % 표준편차

fprintf('---------------------------------------------- \n');
fprintf('schist3 : \n평균 : %5.3f, 표준편차 : %5.3f\n',mm3,ss3);

xlabel('Silicate, wt%');
ylabel('number of samples');

%% overall histogram
figure('Name','Overall_silicate','NumberTitle','off');
h_sch1_silicate=histogram(sch1x,10);
hold on
h_sch2_silicate=histogram(sch2x,10);
h_sch3_silicate=histogram(sch3x,10);
hold off

legend('schist1','schist2','schist3');

xlabel('Silicate, wt%');
ylabel('number of samples');

%% schist3-schist1 (silicate)



t31A = (nn3+nn1)/(nn3*nn1);
t31B = ((nn3-1)*ss3^2+(nn1-1)*ss1^2)/(nn3+nn1-2);
t31 = abs(mm3-mm1)/sqrt(t31A*t31B);

alpha = 0.05;
df31 = (nn3-1)+(nn1-1);
tc31 = tinv(1-alpha/2,df31); % two-tailed => 1-alpha/2 적용
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

xlabel('t-value');
ylabel('pdf');

fprintf('---------------------------------------------- \n');
fprintf('* schist3-schist1간 직접 t-test 수행 (alpha = %5.2f) \n',alpha);

fprintf('t값은 %5.3f이며, \nt_critical의 값은 %5.3f, %5.3f이므로, \n',t31,-tc31,tc31);

if t31 > -tc31 && t31 < tc31
    fprintf('t값이 파란 영역 외에 존재하므로, 같은 집단이라 볼 수 있습니다. \n');
else
    fprintf('t값이 파란 영역 내에 존재하므로, 같은 집단이라 보기 힘듭니다. \n');
end

%% schist3-schist2 (silicate)


t32A = (nn3+nn2)/(nn3*nn2);
t32B = ((nn3-1)*ss3^2+(nn2-1)*ss2^2)/(nn3+nn2-2);
t32 = abs(mm3-mm2)/sqrt(t32A*t32B);

alpha = 0.05;
df32 = (nn3-1)+(nn2-1);
tc32 = tinv(1-alpha/2,df32); % two-tailed => 1-alpha/2 적용

p32 = [-5:0.01:5];
q32 = tpdf(p32,df32);

figure('Name','Schist3 = Schist2?','NumberTitle','off');
plot(p32,q32,'linewidth',1.2);

jk32 = p32 >= tc32;
hold on,area(p32(jk32),q32(jk32),'FaceColor','b');
jk32 = p32 <= -tc32;
hold on,area(p32(jk32),q32(jk32),'FaceColor','b');

y32=tpdf(t32,df32);

hold on,stem(t32,y32,'rs','filled','LineWidth',1.2);

xlabel('t-value');
ylabel('pdf');

fprintf('---------------------------------------------- \n');
fprintf('* schist3-schist2간 직접 t-test 수행 (alpha = %5.2f) \n',alpha);


fprintf('t값은 %5.3f이며, \nt_critical의 값은 %5.3f, %5.3f이므로, \n',t32,-tc32,tc32);

if t32 > -tc32&& t32 < tc32
    fprintf('t값이 파란 영역 외에 존재하므로, 같은 집단이라 볼 수 있습니다. \n');
else
    fprintf('t값이 파란 영역 내에 존재하므로, 같은 집 단이라 보기 힘듭니다. \n');
end

%% ttest2 이용한 판별
fprintf('---------------------------------------------- \n')
fprintf('* ttest2 명령어 이용해 판별 \n')

if ttest2(sch3x,sch1x) == 0
    fprintf('Schist3은 Schist1에 속한다고 볼 수 있습니다. \n') 
else
    fprintf('Schist3은 Schist1에 속한다고 보기 힘듭니다. \n')
end



if ttest2(sch3x,sch2x) == 0
    fprintf('Schist3은 Schist2에 속한다고 볼 수 있습니다. \n') 
else
    fprintf('Schist3은 Schist2에 속한다고 보기 힘듭니다. \n')
end

fprintf('---------------------------------------------- \n')