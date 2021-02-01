fs = 40; % Sampling frequency (samples per second) 
 dt = 1/fs; % seconds per sample 
 StopTime = 25.6; % seconds 
 t = (0:dt:StopTime)'; % seconds 
 F = 2; % Sine wave frequency (hertz) 
  data = 10000*sin(2*pi*F*t)+ 10000;
  
fileID = fopen('sine.txt','w');
fprintf(fileID,'%x\n', round(data));