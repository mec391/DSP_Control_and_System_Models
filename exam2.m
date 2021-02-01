close all
clear all

I = imread('morales0.jpg');
I = rgb2gray(I);
I = double(I)/255;
guass_noise = imnoise(I, 'gaussian', 0.2, 0.01);
salt_noise = imnoise(I, 'salt & pepper', .2);

minf=@(x) min(x(:)); %create handle to min filter
maxf=@(x) max(x(:)); %create handle to max filter

L = nlfilter(guass_noise,[3 3], minf); %apply min filter to guass noise image
M = nlfilter(guass_noise,[3 3], maxf); %apply max filter to guass noise image

guass_filtered = .5 * (L + M); %take 1/2(max + min)

%repeate process for salt and peppered image
N = nlfilter(salt_noise,[3 3], minf);
O = nlfilter(salt_noise,[3 3], maxf);

salt_filtered =  .5 * (N + O);

figure(1)
imshow(I);
hold on
caption = sprintf('Original Image');
	title(caption, 'FontSize', 14);
hold off

figure(2)
imshow(guass_noise);
hold on
caption = sprintf('Gaussian Noise Added');
	title(caption, 'FontSize', 14);
hold off

figure(3)
imshow(salt_noise);
hold on
caption = sprintf('Salt and Pepper Noise Added');
	title(caption, 'FontSize', 14);
hold off

figure(4)
imshow(guass_filtered);
hold on
caption = sprintf('Midpoint Filter of Gaussian Noise Image');
	title(caption, 'FontSize', 14);
hold off

figure(5)
imshow(salt_filtered);
hold on
caption = sprintf('Midpoint Filter of Salt and Pepper Noise Image');
	title(caption, 'FontSize', 14);
hold off
