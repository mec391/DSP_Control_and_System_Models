close all
clear all

load 'noisyecg_20.mat';

figure(1)
plot(t, mynoisyecg);
title('Original Time Domain Signal');

%1. 5208 samples/ 7.812 seconds -- 666 sps = FS

%2. Removed DC comp
m = mean(mynoisyecg);
mynoisyecg_AC = mynoisyecg - m;
figure(2)
plot(t, mynoisyecg_AC);
title('Signal with DC Removed');

%3. Apply 4th order butter with Fcutoff at 4Hz
fc = 4;
fs = 666;
[b,a] = butter(4,fc/(fs/2));
figure(2)
freqz(b,a);
LP_mynoisyecg_AC = filter(b,a,mynoisyecg_AC);
figure(3)
plot(t, LP_mynoisyecg_AC);
title('Signal with LP Butter @4Hz');


%4. Apply FFT
L = 5208;
ECG_FFT = fft(LP_mynoisyecg_AC, L);
ECG_FFT = abs(ECG_FFT/L);
ECG_FFT = ECG_FFT(1:L/2+1);


f = fs*(0:(L/2))/L; %define freq range
f_BPM = f * 60; %convert Hz to BPM
figure(4)
plot(f_BPM, ECG_FFT);
xlim([0,400]);
title('Frequency Domain Representation of ECG Signal');
xlabel('Frequency (BPM)');
ylabel('Magnitude (Voltage)');
