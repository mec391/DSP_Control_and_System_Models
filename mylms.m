function [h, y, FIR, cnt, ASE] = mylms(x,d,delta,N, INIT)

M = length(x);
y = zeros(1,M);

if(INIT == 0) %If 0 is passed for INIT, initialize FIR weights to 0
    h = zeros(1,N);
else
    h = randn(1,N); % if value other than 0 passed for INIT, initialize FIR weights to random values
end


cnt = 1;
for n = N:M
    x1 = x(n:-1:n-N+1);
    y(n) = h*x1';
    e = d(n) - y(n);
    h = h + delta * e * x1;
    
    error_plot(cnt) = e * e;
    cnt = cnt + 1;
end

error_plot = error_plot / cnt;
ASE = error_plot;
FIR = h;