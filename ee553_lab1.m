%Matthew Capuano -- EE 553 -- LAB 1

T = 1.92E-3;  %sampling period
fs = 1 / T; %sampling freq
L = 5208; % number of samples
    
Chan1 = CH1;
Time1 = TIME;

%remove 10x from output signal
Chan1 = Chan1 / 10;
 
figure(1)
plot(Time1, Chan1);
title('Time Domain Representation of ECG Signal');
xlabel('time (seconds)');
ylabel('Amplitude (voltage)');

%We could actually downsample since we don't care about double or triple
%digit frequencies - but we won't

%Make size as large as possible to keep resolution as low (and thus accurate) as possible
% res = sps / size = 520.83 / 5208 = .01
Chan1FFT = fft(Chan1, L);
Chan1FFT = abs(Chan1FFT/L); % find magnitude, we don't care about phase and thus don't care about complex form, might not need 5208
Chan1FFT = Chan1FFT(1:L/2+1); % only care about first half of freqs, rest are negative freqs
%Chan1FFT(2:end-1) = 2*Chan1FFT(2:end-1); % mathworks suggested, I assume this puts emphasis on freqency magnitude other than dc comp.

f = fs*(0:(L/2))/L; %define freq range
figure(2)
plot(f, Chan1FFT);
title('Frequency Domain Representation of ECG Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude (Voltage)');
