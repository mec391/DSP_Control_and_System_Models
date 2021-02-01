%Matthew Capuano -- EE 553
% HW 4: LMS Algorithm

%Original Signal + Noise Signal = input signal (x(n))
%Desired signal (D) = original signal
%Output Signal (Y) = input signal * Adaptive FIR(H(n))
%Adaptive FIR = FIR + delta * Error * X1

close all
clear all

%%%Initialize Variables and Signals%%%%%%%%%%%%%%%%%%%%%%
FS = 1000;      %sample freq
T = 1/FS;       %sample period
L = 10000;      %sample size

t = (0:L-1)*T; %x axis (time)
d = .5*sin(2*pi*50*t); %desired signal

delta = .05; %step size
N = 20; %FIR length

figure(1)
plot(FS*t(1:150), d(1:150));
title('Original Signal');
xlabel('time(ms)');
xlim([0 150]); ylim([-.6 .6]);

%Find power of original signal:
Pd0 = d.^2;
Pd1 = sum(Pd0);
Pd2 = Pd1 / (1 + length(Pd0)); 

%Orignal Signal Power = .1250

%Generate Noise Signal Approximately 4x Less Power than Orig. (.03125)
Noise0 = .18 * randn(size(t)); 

Pn0 = Noise0.^2;
Pn1 = sum(Pn0);
Pn2 = Pn1 / (1 + length(Pn0));

%Generate Noise Signal Approximately = Power to Orig. (.1250)
Noise1 = .35 * randn(size(t));

Pn00 = Noise1.^2;
Pn11 = sum(Pn00);
Pn22 = Pn11 / (1 + length(Pn00));

%Generate Noise Signal Approximately 4X More Power than Orig. (.5)
Noise2 = .7 * randn(size(t));

Pn000 = Noise2.^2;
Pn111 = sum(Pn000);
Pn222 = Pn111 / (1 + length(Pn000));

%%%% begin LMS application%%%%%%%%%%%%%%%%%%%%%%%

%start with FIR w/ Initial Weights of X
INIT = 1;

%Apply X Power Noise to signal
x = d + Noise1;

figure(2)
plot(FS*t(1:150),x(1:150));
title('Signal with MED Power Noise Applied');
xlabel('time(ms)');
xlim([0 150]); ylim([-1 1]);

[h, y, FIR, cnt, ASE] = mylms(x, d, delta, N, INIT);
figure(3);
plot(FS*t(1:150),y(1:150));
title('Output Signal after LMS - MED Power Noise, Init FIR = RND');
xlabel('time (ms)');
xlim([0 150]); ylim([-.6 .6]);

figure(4)
plot(1:1:N, h(1:1:N));
title('Final FIR Filter Cefficients - MED Power Noise, Init FIR = RND');

figure(5)
plot(1:1:length(ASE), ASE(1:end));
title('Error Function Plot - MED Power Noise, Init FIR = RND');

