%Matthew Capuano
%EE 458 - Guassian Lowpass Filter - gray, RGB, HSV

close all 
clear all


color_img = imread('tower.jpg');
R = color_img(:,:,1);
G = color_img(:,:,2);
B = color_img(:,:,3);
gray_img = rgb2gray(color_img);

%color filters
%red
R_fft = fft2(double(R)); %compute fft
R_fft1 = fftshift(R_fft); %shift

[MR NR] = size(R_fft);
D_zero = 20; %radius value
XR = 0:NR-1;
YR = 0:MR-1;
[XR YR] = meshgrid(XR,YR);
CxR=0.5*NR;
CyR=0.5*MR;
LoR=exp(-((XR-CxR).^2+(YR-CyR).^2)./(2*D_zero).^2); %generate filter fn

fltr_R_fft = R_fft1.*LoR;%multiply fft'd image by filter fn
fltr_R_fft1 = ifftshift(fltr_R_fft);%shift
fltr_R = ifft2(fltr_R_fft1); %inverse fourier
%end R filter

%G Filter
G_fft = fft2(double(G)); %compute fft
G_fft1 = fftshift(G_fft); %shift

[MG NG] = size(G_fft);
D_zero = 20; %radius value
XG = 0:NG-1;
YG = 0:MG-1;
[XG YG] = meshgrid(XG,YG);
CxG=0.5*NG;
CyG=0.5*MG;
LoG=exp(-((XG-CxG).^2+(YG-CyG).^2)./(2*D_zero).^2); %generate filter fn

fltr_G_fft = G_fft1.*LoG;%multiply fft'd image by filter fn
fltr_G_fft1 = ifftshift(fltr_G_fft);%shift
fltr_G = ifft2(fltr_G_fft1); %inverse fourier
%end G fft

%B fft
B_fft = fft2(double(B)); %compute fft
B_fft1 = fftshift(B_fft); %shift

[MB NB] = size(B_fft);
D_zero = 20; %radius value
XB = 0:NB-1;
YB = 0:MB-1;
[XB YB] = meshgrid(XB,YB);
CxB=0.5*NB;
CyB=0.5*MB;
LoB=exp(-((XB-CxB).^2+(YB-CyB).^2)./(2*D_zero).^2); %generate filter fn

fltr_B_fft = B_fft1.*LoB;%multiply fft'd image by filter fn
fltr_B_fft1 = ifftshift(fltr_B_fft);%shift
fltr_B = ifft2(fltr_B_fft1); %inverse fourier
%end B filter

fltr_color = color_img;
fltr_color(:,:,1) = fltr_R(:,:);
fltr_color(:,:,2) = fltr_G(:,:);
fltr_color(:,:,3) = fltr_B(:,:);


%grayscale filters
gray_fft = fft2(double(gray_img)); %compute fft
gray_fft1 = fftshift(gray_fft); %shift

[M N] = size(gray_fft);
D_zero = 20; %radius value
X = 0:N-1;
Y = 0:M-1;
[X Y] = meshgrid(X,Y);
Cx=0.5*N;
Cy=0.5*M;
Lo=exp(-((X-Cx).^2+(Y-Cy).^2)./(2*D_zero).^2); %generate filter fn

fltr_gray_fft = gray_fft1.*Lo;%multiply fft'd image by filter fn
fltr_gray_fft1 = ifftshift(fltr_gray_fft);%shift
fltr_gray = ifft2(fltr_gray_fft1); %inverse fourier

%HSV filtering
HSV_img = rgb2hsv(color_img);
H = HSV_img(:,:,1);
S = HSV_img(:,:,2);
V = HSV_img(:,:,3);

%H filter
H_fft = fft2(double(H)); %compute fft
H_fft1 = fftshift(H_fft); %shift

[MH NH] = size(H_fft);
D_zero = 20; %radius value
XH = 0:NH-1;
YH = 0:MH-1;
[XH YH] = meshgrid(XH,YH);
CxH=0.5*NH;
CyH=0.5*MH;
LoH=exp(-((XH-CxH).^2+(YH-CyH).^2)./(2*D_zero).^2); %generate filter fn

fltr_H_fft = H_fft1.*LoH;%multiply fft'd image by filter fn
fltr_H_fft1 = ifftshift(fltr_H_fft);%shift
fltr_H = ifft2(fltr_H_fft1); %inverse fourier

%S filter
S_fft = fft2(double(S)); %compute fft
S_fft1 = fftshift(S_fft); %shift

[MS NS] = size(S_fft);
D_zero = 20; %radius value
XS = 0:NS-1;
YS = 0:MS-1;
[XS YS] = meshgrid(XS,YS);
CxS=0.5*NS;
CyS=0.5*MS;
LoS=exp(-((XS-CxS).^2+(YS-CyS).^2)./(2*D_zero).^2); %generate filter fn

fltr_S_fft = S_fft1.*LoS;%multiply fft'd image by filter fn
fltr_S_fft1 = ifftshift(fltr_S_fft);%shift
fltr_S = ifft2(fltr_S_fft1); %inverse fourier

%V filter
V_fft = fft2(double(V)); %compute fft
V_fft1 = fftshift(V_fft); %shift

[MV NV] = size(V_fft);
D_zero = 20; %radius value
XV = 0:NV-1;
YV = 0:MV-1;
[XV YV] = meshgrid(XV,YV);
CxV=0.5*NV;
CyV=0.5*MV;
LoV=exp(-((XV-CxV).^2+(YV-CyV).^2)./(2*D_zero).^2); %generate filter fn

fltr_V_fft = V_fft1.*LoV;%multiply fft'd image by filter fn
fltr_V_fft1 = ifftshift(fltr_V_fft);%shift
fltr_V = ifft2(fltr_V_fft1); %inverse fourier

fltr_HSV = HSV_img;
fltr_HSV(:,:,1) = fltr_H(:,:);
fltr_HSV(:,:,2) = fltr_S(:,:);
fltr_HSV(:,:,3) = fltr_V(:,:);

%I get an error if I try to convert back to RGB
%fltr_HSV = hsv2rgb(fltr_HSV);


%display
figure(1)
imshow(color_img);
title('original image','fontsize',14)

figure(2)
imshow(abs(gray_fft1),[-12 300000]), colormap gray
title('fft of original image','fontsize',14)

figure(3)
imshow(abs(fltr_gray),[12 290])
title('low pass filtered image','fontsize',14)

figure(4)
imshow(fltr_color)
title('low pass filtered color image - RGB','fontsize',14)

figure(5)
   mesh(X,Y,Lo)
   axis([ 0 N 0 M 0 1])
   h=gca; 
   get(h,'FontSize') 
   set(h,'FontSize',14)
   title('Gaussiab LPF H(f)','fontsize',14)
   
 figure(6)
imshow(fltr_HSV)
title('low pass filtered color image - HSV','fontsize',14)
