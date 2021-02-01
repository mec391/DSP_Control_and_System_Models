data=xlsread('raw_data_1.xlsx')
x=data(1:9,1:15);
t=data(11:15,1:15);
% [x,t] = simpleclass_dataset; 
% plot(x(1,:),x(2,:),'+') 
net = patternnet(10); net = train(net,x,t);
