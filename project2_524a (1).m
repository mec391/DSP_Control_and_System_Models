%524a project 2 code
close all
clear all

x_axis = csvread('RLC_Data_2_MATLAB_Noise.csv', 1,0);

noise_signal = csvread('RLC_Data_2_MATLAB_Noise.csv', 1,1);


%noise filtering%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y = noise_signal;
[r,c] = size(y);
t_final = 8.7858;
T = t_final/r; %timestep
t = linspace(0,t_final,r);

subplot(3,1,1);

plot(t, y)

BW = pwelch(y);
f_max = length(BW)/t_final;
f = linspace(1,f_max,length(BW));
subplot(3,1,2);
plot(f,BW)
xlim([0,20]);


sys_data = iddata(y,[],T);
y_filt = idfilt(sys_data,[0 5]);
subplot(3,1,3);
plot(y_filt,'r')

