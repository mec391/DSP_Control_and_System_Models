%u = input
%y = output

u = csvread('Week_11_2_in.csv');

y = csvread('Week_11_2_out.csv');

tend = .4; % final time

[r,c] = size(u);
T = tend/r; %timestep
t = linspace(0,tend,r);

sys_data = iddata(y,u,T);

for order = 1:6
    H = tfest(sys_data, order);
    h = impulse(H);
    length(h)
    hold on;
end



tolerance = 0.5;
%this section initializes two vectors for comaprison
h_old = zeros(size(t));
h_new = zeros(size(t));

%here we perform the first impulse response estimate (order = 1)
H = tfest(sys_data,1);
h= impulse(H);
h_old (1:length(h)) = h;

%now we loop through orders 2 - 5 to see if there is improvement
for order = 2:5
H = tfest(sys_data,order);
h= impulse(H);
h_new (1:length(h)) = h;
error = immse(h_new,h_old);
if error < tolerance
order_final = order-1;
break;
end
h_old = h_new;
end

%noise filtering%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y = csvread('Week 11_3.csv');
[r,c] = size(y);
t_final = .02;
T = t_final/r; %timestep
t = linspace(0,t_final,r);

subplot(3,1,1);

plot(t, y)

BW = pwelch(y);
f_max = length(BW)/t_final;
f = linspace(1,f_max,length(BW));
subplot(3,1,2);
plot(f,BW)

sys_data = iddata(y,[],T);
y_filt = idfilt(sys_data,[1000 5000]);
subplot(3,1,3);
plot(y_filt,'r')

