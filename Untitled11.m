close all
clear all

I = imread('examnoise.jpg');
I = rgb2gray(I);

H = ones(3)/9;
filtered = filter2(H,I);

figure(1)
imshow(I);
figure(2)
imshow(filtered);