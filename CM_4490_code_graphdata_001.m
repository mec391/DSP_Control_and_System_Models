%Processing data from the AFE4490
%Graphing data
%Finding HR

%Written by Chloe Melnick
%Last update 08/13/2019

%%
%HR CALCULATION%
%%%%%Open the data and put it in matrices
IR=readtable('ArduinoBoardTest_002.xlsx','Range','B3:B1549'); %open the column of IR voltages from the excel file
IR=IR{:,:}; %convert the table to a matrix
RED=readtable('ArduinoBoardTest_002.xlsx','Range','D3:D1549'); %open the column of RED voltages from the excel file
RED=RED{:,:}; %convert the table to a matrix

x=length(IR); %set the length of x to be equal to the number of elements in the IR array
time=linspace(1,x,x); %make a time vector with the same length as the data
time=time';%transpose it so the time array matches the data array
time=time./70;%divide by the number of samples taken per second to get the time in seconds

%%%%find the peaks of the data
[peaks_IR,locations_IR] = findpeaks(IR,time); %find the location (x value) and the peak (y value) for all the maximums of the IR light
[peaks_RED,locations_RED] = findpeaks(RED,time); %find the location (x value) and the peak (y value) for all the maximums of the RED light

smallPeakIndexes_IR=peaks_IR<0.65; %set your Y value rejection criteria
peaks_IR(smallPeakIndexes_IR)= []; %reject all Y values for peak values below 0.65 V 
locations_IR(smallPeakIndexes_IR)=[]; %reject all X values for peak values below 0.65 V 

smallPeakIndexes_RED=peaks_RED<0.65; %set your Y value rejection criteria
peaks_RED(smallPeakIndexes_RED)= []; %reject all Y values for peak values below 0.65 V 
locations_RED(smallPeakIndexes_RED)=[]; %reject all X values for peak values below 0.65 V 

IRpeaks=[locations_IR,peaks_IR]; %create a matrix of all the times and values of IR peaks
REDpeaks=[locations_RED,peaks_RED]; %create a matrix of all the times and values of RED peaks

%%%%%%plot the graphs of IR and RED and mark the peaks
subplot(2,1,1)
hold on
plot(time,IR,'k',time,RED,'r')
xlabel('Time (s)')
ylabel('Voltage (V)')
title('Pulse Ox Data')
plot(REDpeaks(:,1),REDpeaks(:,2),'bx')
plot(IRpeaks(:,1),IRpeaks(:,2),'gx')
legend('IR','RED','RED Peaks','IR Peaks')
hold off
subplot(2,1,2)
hpassIR=highpass(IR,0.1);
hpassRED=highpass(RED,0.1);
hold on
plot(hpassIR)
plot(hpassRED)



%%%%%%use IR peaks to calculate the HR because they are the cleanest 
% HRdiff=[diff(locations_IR(:,1))]; %calculation of the time between each heartbeat
% HR=[60./HRdiff]; %divide 60 seconds by number of seconds between each heart beat to find HR in bpm
% AverageHR=mean(HR);
% AVGhr=AverageHR * ones(length(HR),1)
% subplot(2,1,2)
% hold on
% plot(HR, '-md')
% plot(AVGhr,'b--')
% xlabel('Time (s)')
% ylabel('Heart Rate (bpm)')
% title('Heart Rate Calculated from Pulse Oximeter')
% legend('HR','Average HR')
% hold off


% figure (2)
% fourierIR=fft(IR);
% fourierIRreal=real(fourierIR)
% fourierIRimaginary=imag(fourierIR)
% hold on
% plot(fourierIRreal)
% plot(fourierIRimaginary)
%%
%OXYGENATION CALCULATION%
%%%%%















