close all
I = imread('cameraman.tif');
J=I; % keep the orginal
% I = im2double(I)*255;
mymean=mean(mean(I))
% I=I-mymean
I=im2double(I);
T = dctmtx(8);
B = blkproc(I,[8 8],'P1*x*P2',T,T');
mask = [1   1   1   1   0   0   0   0
        1   1   1   0   0   0   0   0
        1   1   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0];
B2 = blkproc(B,[8 8],'P1.*x',mask);
% I2 = blkproc(B2,[8 8],'P1*x*P2',T',T)+mymean;
I2 = blkproc(B2,[8 8],'P1*x*P2',T',T);
figure;imshow(uint8(I));title('Original Image');
figure; imshow(uint8(I2));title('Output Image');