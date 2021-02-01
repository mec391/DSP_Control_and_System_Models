%%Matthew Capuano -- EE 553 - Weighted Median Filter

close all
clear all


filter_size = 9; %3x3 window
filter_weights = zeros(size(filter_size));

for i=1:1:filter_size
    prompt = 'Please enter filter weight # '; %get those weight values
    disp(i);
    filter_weights(i) = input(prompt);
end

pic = imread('duck.jpg'); % load that image and apply those weights
sum_weights = sum(filter_weights);
%run window
pic_rows = size(pic,1);
pic_cols = size(pic,2);

figure(1)
imshow(pic);

pic = imnoise(pic, 'salt & pepper');
figure(2)
imshow(pic);

window = zeros(9,1); %run a window
for col = 1:1:3
for i=1:1:pic_rows
    for j = 1:1:pic_cols
        if i == 1 || i == pic_rows || j == 1 || j == pic_cols 
        %need if statement for edges (if row = 1 or row = max , or if col
        %= 1 or if col = max
        
        
        else
        window(1) = pic(i-1, j-1,col); %get window values, store in array
        window(2) = pic(i-1, j,col);
        window(3) = pic(i-1, j+1,col);
        window(4) = pic(i, j-1,col);
        window(5) = pic(i, j,col);
        window(6) = pic(i, j+1,col);
        window(7) = pic(i+1, j-1,col);
        window(8) = pic(i+1, j);
        window(9) = pic(i+1, j+1);
        weighted_array = zeros(size(sum_weights));
        counter = 1;
        for m = 1:1:9       %apply weights to stored array
           for n = 1:1:filter_weights(m)
               weighted_array(counter) = window(m);
               counter = counter +1;
           end
        end
        weighted_array = sort(weighted_array); % sort the weighted array
        med = median(weighted_array); % find med of sorted array
        pic(i,j,col) = med;     %apply med to centered window value
        end
    end
end
end

figure(3)
imshow(pic);
        