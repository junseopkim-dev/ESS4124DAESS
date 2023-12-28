
xm = 21.3
xs = 5.5
n = 10
df = n-1
alpha = 0.05

xe = 17.0
that = (xm-xe)*sqrt(n)/xs

tc = tinv(1-alpha,df)

x = [-5:0.01:5];
y = tpdf(x,df);

figure,plot(x,y)
xlabel('t-value'), ylabel('pdf')
grid on

jk = x >= tc;
hold on,area(x(jk),y(jk),'FaceColor','b')
yc = tpdf(tc,df);
hold on,stem(tc,yc,'g','filled')

yhat = tpdf(that,df)
hold on,stem(that,yhat,'r','filled')

%
% try xy = load('dewijs1.txt');
%
%[h,p,ci] = ttest(y,18.0);
%[h,p,ci,stats] = ttest2(y1,y2,alpha);

%---------------------------------------
% chi-square test & kstest2

hg = histogram(y,10);
v = hg.BinEdges(1:end-1)+hg.BinWidth/2;
nobs = hg.Values;

mm = mean(y);
ss = std(y);
nhat = normpdf(v,mm,ss);

% scale to nobs
nhat = nhat*sum(nobs)/sum(nhat);

hold on,plot(v,nhat,'--r','linewidth',1.0)


chi2 = sum((nobs-nhat).^2 ./nhat);

df = length(v)-3;
chi2c = chi2inv(1-alpha,df);

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
[h,p] = chi2gof(y)