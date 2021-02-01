%EMCH524A project 2 code

close all
clear all

%% plot noisy data

%x_axis = csvread('RLC_Data_2_MATLAB_Noise.csv', 1,0);
noise_signal = csvread('RLC_Data_2_MATLAB_Noise.csv', 1,1);

%noise filtering%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y = noise_signal;
[r,c] = size(y);
t_final = 0.00014192;
T = t_final/r; %timestep
t = linspace(0,t_final,r);

figure (1)
plot(t, y) %noisy data
set(gcf,'color','w'); % Sets axes background to white
title("Noisy Data")
xlabel("time (s)");
ylabel("Voltage (V)");

%% plot frequency response of step response
figure(2)
BW = pwelch(y);
f_max = length(BW)/t_final;
f = linspace(1,f_max,length(BW));
plot(f, 10*log10(BW)) %decibels vs frequency
title("Frequency Response of Step Response")
xlabel("frequency (Hz)");
ylabel("Magnitude (dB)");
xlim([0 2000000]);
%% filter data with low pass filter

sys_data = iddata(y,[],T);
y_filt = idfilt(sys_data,[0 3*10^5]); %300kHz cutoff
y_out = y_filt.OutputData;

figure(3)
plot(t,y_out);
title("Filtered Data")
xlabel("time (s)");
ylabel("Voltage (V)");


%% differentiate step response to find impulse response

%simple differentiation
dy(1) = 0.001;
for i = 2:r
    dy(i) = (y_out(i) - y_out(i-1))/T; 
end

subplot(4,1,4);
plot(t,dy)
title("Impulse Response")
xlabel("time (s)");
ylabel("Magnitude");



%% Plot of step response for system identification

%{

figure(2)
plot(t,y_out)

%}

%% plot filtered and system ID impulse responses aligned

figure(2)

cutoffIndex = 1500; %data points to eliminate form start of impulse
impulse_shifted = dy(cutoffIndex:end); %cut off 0 values of impulse
points = length(impulse_shifted); % # data points
t_new = 0:T:(T*points-T);
plot(t_new,impulse_shifted, 'LineWidth',3)

hold on 

%system ID approximation values
%impulse: y(t) = e^(-30035*t)/259314 * sin(259314*t);
sigma = -30035;
wd = 259314;
Amplitude = 1400000;
y_impulse = Amplitude.*exp(sigma.*t).*sin(wd.*t);

plot(t, y_impulse, 'LineWidth',3)

set(gcf,'color','w'); % Sets axes background to white
set(gca,'FontSize',14);
title("Impulse Responses")
xlabel("time (s)");
ylabel("Magnitude");
legend("Measured Impulse","Approximated Impulse");


%% IGNORE: find order to approximate system

%{

cutoffIndex = 1000; %data points to eliminate form start of impulse
impulse_shifted = transpose(dy(cutoffIndex:end)); %cut off 0 values of impulse
points = length(impulse_shifted); % # data points
u_shifted = [zeros(5,1); 9*ones(points-5,1)];
t_new = 0:T:(T*points-T);
plot(t_new,impulse_shifted, 'LineWidth',3)

sys_data_impulse = iddata(impulse_shifted,[],T);
%ss_order = 1:10;
%ssest(sys_data_impulse,ss_order);  %4th order selected

%H = tfest(sys_data_impulse,4)

%hold on
%impulse(H)

%}

%{

figure(3)

cutoffIndex = 1200; %data points to eliminate
step_shifted = y_out(cutoffIndex:end);
points = length(step_shifted); % # data points
u_shifted = [zeros(5,1); 9*ones(points-5,1)];
t_new = 0:T:(T*points-T);
plot(t_new,step_shifted, 'LineWidth',3)

sys_data_step = iddata(step_shifted,u_shifted,T);
%ss_order = 1:10;
%ssest(sys_data_step,ss_order);  %4th order selected

figure(4)

cutoffIndex = 1000; %data points to eliminate form start of impulse
impulse_shifted = transpose(dy(cutoffIndex:end)); %cut off 0 values of impulse
points = length(impulse_shifted); % # data points
t_new = 0:T:(T*points-T);
plot(t_new,impulse_shifted, 'LineWidth',3)



H = -9*tfest(sys_data_step,4)

hold on
impulse(H)

%transfer function
syms s

transferFunction = 2.815e05*s^3 + 7.775e10*s^2 - 1.421e17*s + 5.741e22 / (s^4 + 7.979e05*s^3 + 2.224e11*s^2 + 5.449e16*s + 6.284e21)
ilaplace(transferFunction)
%ilaplce does not result in clean answer, stick with 2nd order approx for
%analytical green's function

%}

%% analytical green's function

figure(5)

syms x t

%y_impulse = 1400000*exp(-30035*t)*sin(259314*t)
complex_input = 9*exp(-10000*t);

fplot(complex_input);
hold on

complex_output_analytical = int((1400000*exp(-30035*(t-x))*sin(259314*(t-x)))*(exp(-10000*x)),x,0,t)
pretty(complex_output_analytical)

fplot(complex_output_analytical)
xlim([0 4*10^-4])
ylim([0 10])


set(gcf,'color','w'); % Sets axes background to white
set(gca,'FontSize',14);
title("Analytical Convolution for Complex Input")
xlabel("time (s)");
ylabel("Voltage (V)");
legend("Complex Input","Complex Output");

%% vector convolution green's function

%conv()
%vector of transfer function   dy
%timestep T
%vector for complex input

figure (6)

fplot(complex_output_analytical)
xlim([0 4*10^-4])
ylim([0 10])

hold on

t = 0:T:5*10^-4;
points = length(t);

vector_input = exp(-10000*t);

hold on

plot(t,9*vector_input)

hold on

complex_output_vector = T*conv(dy,vector_input);
scalefactor = 0.76;
complex_output_vector = scalefactor*complex_output_vector;

%shift complex_output_vector to match analytical
cutoffIndex = 1600; %data points to eliminate form start of impulse
output_shifted = transpose(complex_output_vector(cutoffIndex:end)); %cut off 0 values of impulse
points = length(output_shifted); % # data points
t_new = 0:T:(T*points-T);

plot(t_new,output_shifted)

set(gcf,'color','w'); % Sets axes background to white
set(gca,'FontSize',14);
title("Discrete and Analytical Convolution for Complex Input")
xlabel("time (s)");
ylabel("Voltage (V)");
legend("Complex Output Analytical","Complex Input", "Complex Output Discrete");

%% testing step input and shifting step response

%{

figure(7)

cutoffIndex = 1200; %data points to eliminate form start of impulse
impulse_shifted = dy(cutoffIndex:end); %cut off 0 values of impulse
points = length(impulse_shifted); % # data points
t_1 = 0:T:(T*points-T);

vector_input_comp = heaviside(t_1);

complex_output_vector2 = T*conv(impulse_shifted,vector_input_comp);

points = length(complex_output_vector2); % # data points
t_2 = 0:T:(T*points-T);


plot(t_2,complex_output_vector2)
xlim([0 1.2*10^-4])

hold on

cutoffIndex = 1200; %data points to eliminate form start of impulse
step_shifted = y_out(cutoffIndex:end); %cut off 0 values of impulse
points = length(step_shifted); % # data points
t_3 = 0:T:(T*points-T);
plot(t_3,step_shifted)

%}

%% input compensation 1-exp decay -90k

figure(8)

cutoffIndex = 1200; %data points to eliminate form start of impulse
impulse_shifted = dy(cutoffIndex:end); %cut off 0 values of impulse
points = length(impulse_shifted); % # data points
t_1 = 0:T:(T*points-T);

vector_input_comp = 1 - exp(-90000.*t_1);

complex_output_vector2 = T*conv(impulse_shifted,vector_input_comp);
points = length(complex_output_vector2); % # data points

t_2 = 0:T:(T*points-T);

plot(t_1,9*vector_input_comp, 'LineWidth',3)
hold on
plot(t_2,complex_output_vector2, 'LineWidth',3)

hold on

cutoffIndex = 1200; %data points to eliminate form start of impulse
step_shifted = y_out(cutoffIndex:end); %cut off 0 values of impulse
points = length(step_shifted); % # data points
t_3 = 0:T:(T*points-T);
plot(t_3,step_shifted, 'LineWidth',3)

xlim([0 1.2*10^-4])

set(gcf,'color','w'); % Sets axes background to white
set(gca,'FontSize',14);
title("Input Compensation (1-exp(-90000t)")
xlabel("time (s)");
ylabel("Voltage (V)");
legend("Input Function","Complex Response", "Original Step Response");

%% input compensation 1-exp decay -60k

figure(9)

cutoffIndex = 1200; %data points to eliminate form start of impulse
impulse_shifted = dy(cutoffIndex:end); %cut off 0 values of impulse
points = length(impulse_shifted); % # data points
t_1 = 0:T:(T*points-T);

vector_input_comp = 1 - exp(-60000.*t_1);

complex_output_vector2 = T*conv(impulse_shifted,vector_input_comp);
points = length(complex_output_vector2); % # data points

t_2 = 0:T:(T*points-T);

plot(t_1,9*vector_input_comp, 'LineWidth',3)
hold on
plot(t_2,complex_output_vector2, 'LineWidth',3)

hold on

cutoffIndex = 1200; %data points to eliminate form start of impulse
step_shifted = y_out(cutoffIndex:end); %cut off 0 values of impulse
points = length(step_shifted); % # data points
t_3 = 0:T:(T*points-T);
plot(t_3,step_shifted, 'LineWidth',3)

xlim([0 1.2*10^-4])

set(gcf,'color','w'); % Sets axes background to white
set(gca,'FontSize',14);
title("Input Compensation (1-exp(-60000t)")
xlabel("time (s)");
ylabel("Voltage (V)");
legend("Input Function","Complex Response", "Original Step Response");

%% input compensation ramp

figure(10)

cutoffIndex = 1200; %data points to eliminate form start of impulse
impulse_shifted = dy(cutoffIndex:end); %cut off 0 values of impulse
points = length(impulse_shifted); % # data points
t_1 = 0:T:(T*points-T);

vector_input_comp = [];
for i = 1:length(t_1)
    magnitude = 40000*t_1(i);
    if magnitude > 1
        magnitude = 1;
    end
    vector_input_comp = [vector_input_comp; magnitude];
end

complex_output_vector2 = T*conv(impulse_shifted,vector_input_comp);
points = length(complex_output_vector2); % # data points
t_2 = 0:T:(T*points-T);

plot(t_1,9*vector_input_comp, 'LineWidth',3)

hold on

plot(t_2,complex_output_vector2, 'LineWidth',3)

hold on

cutoffIndex = 1200; %data points to eliminate form start of impulse
step_shifted = y_out(cutoffIndex:end); %cut off 0 values of impulse
points = length(step_shifted); % # data points
t_3 = 0:T:(T*points-T);
plot(t_3,step_shifted, 'LineWidth',3)

xlim([0 1.2*10^-4])

set(gcf,'color','w'); % Sets axes background to white
set(gca,'FontSize',14);
title("Input Compensation Ramp Function")
xlabel("time (s)");
ylabel("Voltage (V)");
legend("Input Function","Complex Response", "Original Step Response");