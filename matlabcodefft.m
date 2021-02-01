close all;
clear all;
%Ts = 3.2e-8;                 % Sampling Interval goven by CSV file
%Fs = 1/Ts;                   % Sample Frequency
M = xlsread('T0023CH1.csv');    % read data from your excel file
Ts = .76e-6; %read data from 6th row, 2nd column (sampling time)
Fs = 1/Ts; %sampling frequency
sizeM=size(M);
L = sizeM(1);          % length of data
% L=round(L);         % reduce data by 20 to have good resolution
t=M(16:L,1);          % capture time axis, 17th row, first column
myAmplitude=M(16:L,2);     % capture amplitude, 16th row, second column
plot(t,myAmplitude)
                        % plot waveform
title('Triangle Pulse')
ylabel('Amplitude')
xlabel('time (seconds)') ; grid on
%It is difficult to identify the frequency components by looking at the
%original signal. Converting to the frequency domain, the discrete Fourier
%transform of the noisy signal y is found by taking the
%fast Fourier transform (FFT):

% NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y = fft(myAmplitude)/L; %% FFT of little my square
f = (Fs/2)*linspace(0,1,round(L/2));
figure
plot(f,2*abs(Y(1:round(L/2))))  % plot half of the spctrum
title('Complete spectrum')
ylabel('Magnitude')
xlabel('Frequency (Hz)');grid on
xlim([0 100])
ylim([0 1])