%
% Gaussian mixture model 
%
xy = load('icecore_gripd18o.txt');
x = xy(:,1);
y = xy(:,2);

y = y(2000:4300);
figure,hg = histogram(y,30)

% fit to a Gaussian mixture model with 2 peaks
mdl = fitgmdist(y,2);		
properties(mdl)

m1 = mdl.mu(1);
m2 = mdl.mu(2);

s1 = mdl.Sigma(1);
s2 = mdl.Sigma(2);

p1 = mdl.PComponents(1);
p2 = mdl.PComponents(2);

dt = 0.2;
t = [-45:dt:-30];

y1 = normpdf(t,m1,s1);
y1 = y1*p1/trapz(t,y1);

y2 = normpdf(t,m2,s2);
y2 = y2*p2/trapz(t,y2);

yy = y1+y2;
dh = h.BinWidth
%v = h.BinEdges(1:end-1)+h.BinWidth/2;
%n = h.Values;
%A1 = trapz(v,n); 		% exact integration 
%A1 = length(y)*dh;		% approx. area sum
yy = yy*(length(y)*dh)/trapz(t,yy);

hold on, plot(t,yy,'--r','linewidth',1.2)