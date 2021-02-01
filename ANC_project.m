close all
clear all

[y, Fs] = audioread('dre.mp3');


%Generate Clean Audio - keep first 10 seconds:
clean_ref = y(1:(Fs*10));

%Generate Noisey Signals
source_noise = randn(size(clean_ref));
ear_noise = .05*source_noise;

ar = [1,1/2];   
source_noise1 = filter(1,ar, source_noise);
ear_noise1 = filter(1,ar, ear_noise);  

%combine audio and ear noise
audio_ear_noise = clean_ref + ear_noise1;

%mathworks says to do this 
ma = [1, -0.8, 0.4 , -0.2];
source_noise2 = filter(ma,1,source_noise);
ear_noise2 = filter(ma,1, ear_noise);

L = 128;
nlms = dsp.LMSFilter(L,'Method','Normalized LMS');
[mumaxnlms,mumaxmsenlms] = maxstep(nlms,audio_ear_noise);
nlms.StepSize = mumaxmsenlms/20;

[ynlms,enlms,wnlms] = nlms(ear_noise2.',audio_ear_noise.');

x = (1:Fs*10);
figure(1)
plot(x, audio_ear_noise);
title('Audio Signal with Noise Added');
figure(2)
plot(x, enlms);
title('Audio Signal After Trained Filtering');
figure(3)
plot(x, audio_ear_noise);
hold on
plot(x, enlms);
title('Audio Signal with Noise Overlapping Trained Filtered Signal');
figure(4)
plot(x, clean_ref);
title('Original Clean Audio Signal');
figure(5)
plot(x, enlms);
hold on
plot(x, clean_ref);
title('Original Signal Overlapping Trained Filtered Signal');


sound (audio_ear_noise, Fs); 
pause(10);
sound(enlms, Fs);

x = (1:Fs*10);
plot(x, audio_ear_noise);