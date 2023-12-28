# Matlab-----------------------------
function cn = convolution(x,y)

n = length(y);
m = length(x);
N = n+m-1;

cn = zeros(N,1);

for k=1:n
    for l=1:m
        cn(k+l-1) = cn(k+l-1) + y(k)*x(l);
    end
end    


   
    
# python-----------------------------
# eg) s2 = np.bartlett(11)
n = len(s1)
m = len(s2)
mm = n+m-1

cn = np.zeros(mm)

for k in range(n):
    for l in range(m):
        cn[k+l] += s1[k]*s2[l] 
        
    
