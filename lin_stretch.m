clear all;
clc;
itemp = imread('flower.jpeg'); %read the image
i_new = histeq(itemp);  
figure (1)
imshow(itemp);
% display original image
figure (2)
imshow(i_new);   % display transformed image