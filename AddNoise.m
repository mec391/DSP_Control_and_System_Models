%% add white gaussian noise to RLC response

data = readtable("RLC_Data_2_MATLAB.xlsx");
data = table2array(data);
timepoints = data(:,1);
values = data(:,2);

y = awgn(values,30,'measured'); %adds white gaussian noise
plot(timepoints,[values y])
legend('Original Signal','Signal with AWGN')

output = array2table([timepoints y]);
writetable(output,"RLC_Data_2_MATLAB_Noise.xlsx"); %saves noisy data to excel file