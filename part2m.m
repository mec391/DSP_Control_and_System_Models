close all 
clear all
%problem 2
pulse_in = csvread('pulse_input');
output = csvread('output');
input = csvread('input');

t = linspace(0,1.5,1000);
T = .0015;
u = input;
y = output;

%step 3, plot input and output data vs time
figure(1)
plot(t,y);
title("Step 3: Output Data Vs. Time")
xlabel("time t");
ylabel("output y");
figure(2)
plot(t,u);
ylim([-60000 0]);
title("Step 3: Output Data Vs. Time")
xlabel("time t");
ylabel("input u");

%step 5: differentiation for impulse
numpts = 1000;
for i = 2:1:numpts
    dy(i) = (y(i)-y(i-1))/T;
end
h_1 = dy / -50000;
figure(3)
plot(t,h_1)
title("Step 5: Differentiate the Step Response");
xlabel("time t");
ylabel("output h_1");
%starts and stops at 0, this is an impulse response

%step 6: input-output plot
y = transpose(y);
u = transpose(u);
data = iddata(y,u,T);
figure(4)
plot(data);

%step 7/8 order approximation, tf approximation
sys = ssest(data,1:10);
H_est = tfest(data, 2)

%step 9 - eliminate s term
num = [.002004];
den = [1 10.01 400.8];
H_est_numeratorfix = tf(num, den);

%step 10, syms plot, ilaplace to get impulse
syms s;
H_2 = .002004 / (s^2 + 10.01 * s + 400.8);
h_2 = ilaplace(H_2);
h2_eval = eval(h_2);
figure(5)
plot(t, h2_eval);
title("Step 10: ilaplace impulse");
xlabel("time t");
ylabel("output h2_eval");

%step 11-second pulse plot
u_pulse = pulse_in;
figure(6)
plot(t, u_pulse);
title("Step 11 - second pulse plot");
xlabel("time t");
ylabel("output u_pulse");

%step 12 - convolution plot
y_new = conv(h_1,u_pulse);
y_new = y_new(1:1000);
y_new = y_new / -1000
figure(7)
plot(t, y_new);
title("Step 12 - convolution plot");
xlabel("time t");
ylabel("output y_new");