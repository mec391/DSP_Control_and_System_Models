%Matthew Capuano - EE 458 Final Project - Image Coding: Transform Methods

%Image Blocks
image = imread("dog.jpg");
image = rgb2gray(image);
image2 = image;
image = im2double(image);
block = zeros(8,8);
for i=1:1:8
    for j = 1:1:8
        block(i, j) = image(i,j);
    end
end

T = dctmtx(8); %dct coeffs
dct = @(block_struct) T * block_struct.data * T';
B = blockproc(block,[8 8],dct);                         

reduced_block = block - .5; %dct coeffs - 128
B2 = blockproc(reduced_block, [8 8], dct);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

quant_example = [16, 11, 10, 16, 24, 40, 51, 61; 12, 12, 14, 19, 26, 58, 60, 55;
       14, 13, 16, 24, 40, 57, 69, 56; 14, 17, 22, 29, 51, 87, 80, 62;
       18, 22, 37, 56, 68, 109, 103, 77;24, 35, 55, 64, 81, 104, 113, 92;
       49, 64, 78, 87, 103, 121, 120, 101; 72, 92, 95, 98, 112, 100, 103, 99];
 
quant_lum = [16	11	10	16	24	40	51	61;
12	12	14	19	26	58	60	55;
14	13	16	24	40	57	69	56;
14	17	22	29	51	87	80	62;
18	22	37	56	68	109	103	77;
24	35	55	64	81	104	113	92;
49	64	78	87	103	121	120	101;
72	92	95	98	112	100	103	99];

quant_chrom = [17	18	24	47	99	99	99	99;
18	21	26	66	99	99	99	99;
24	26	56	99	99	99	99	99;
47	66	99	99	99	99	99	99;
99	99	99	99	99	99	99	99;
99	99	99	99	99	99	99	99;
99	99	99	99	99	99	99	99;
99	99	99	99	99	99	99  99];

I = imread('dog.jpg');
I = im2double(I);
I = rgb2gray(I);
T = dctmtx(8);
dct = @(block_struct) T * block_struct.data * T';
B = blockproc(I,[8 8],dct);

%apply each table with 3 levels of q factor
%calculate max bit allocation needed
%determine q value with best compression

%apply quant_example
%q factor = 100
quant_example100 = floor((1 * quant_example + 50) /100);

quant_exmaple100out = round(B / quant_example100);