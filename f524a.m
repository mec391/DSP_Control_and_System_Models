close all
clear all

A = 1444;
B = [1 1008.02 8160 144000];

sys = tf(A,B);
opt = stepDataOptions;

opt.StepAmplitude = -5;

y = step(sys, opt);
t_final = 1.6;
BW = pwelch(y);
f_max = length(BW)/t_final;
f = linspace(1,f_max,length(BW));
subplot(3,1,2)
plot(f,10*log10(BW));
title("Frequency Response of Step Response")
xlabel("frequency (Hz)");
ylabel("Magnitude (dB)");
xlim([0,100]);
%bw = 15 hz, nyquist = 30 sps, fig. 2->100 samples per 1.5 sec = 66sps,
%yes it meets the criteria