pic0 = imread('ch5hw.jpeg');
pic0 = rgb2gray(pic0);
pic0 = imresize(pic0, [244,240]);

H = fspecial('average',3);
mean33 = imfilter(pic0, H);

%harmonic filter
Im = double(pic0);
S_=size(Im);
Mask=7; %3x3 mean filter
for i=1:S_(1)
    j=1;
    while(j<S_(2)-Mask)
        T(1:Mask)=Im(i,j:j+(Mask-1));
        Data=harmmean(T);
        Im(i,j+1)=Data;
        j=j+1;
    end
end

X = imdilate(pic0, true(9));


I = fspecial('average',7);
mean77 = imfilter(pic0,I);

J = fspecial('average',9);
mean99 = imfilter(pic0,J);

figure(1)
imshow(pic0);

figure(2)
imshow(mean33);

figure(3)
imshow(mean77);

figure(4)
imshow(mean99);

figure(5)
imshow(Im,[]);
title('Harmonic filter');

figure(6)
imshow(X);
