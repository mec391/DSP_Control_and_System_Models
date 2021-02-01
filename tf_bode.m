close all
clear all


%this will tell you magnitude and phase of response at specific frequency(
%in this case 10 rad/s)
syms s;
H = 1/(s^2 + 2*s + 26);
w = 10;
s = w*1j;
J = subs(H,s);
J_mag = vpa(abs(J), 3)
J_phase = vpa(angle(J), 3)

%%
clearvars;
close;
syms s;
H = tf(500, [1 12 125 250 500]);
bode(H);
grid on;