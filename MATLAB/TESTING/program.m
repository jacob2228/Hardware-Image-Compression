
clc;
clear all;
close all;


%step 1(Image acquisition)
[filename pathname]=uigetfile('*.jpg','Select An Image');
Input=imread([pathname filename]);
Input=imresize(Input,[256,256]);
figure;
imshow(Input);
title('Input Image');

%step 2(preprocessing)

if length(size(Input))==3
            Input = rgb2gray(Input);
end
median=medfilt2(Input);
figure;
imshow(median);
title('Median filtered image');

%step 3(Wavelet decomposition)

[approximation,horizontal,vertical,diagonal]=dwt2(median,'bior4.4');
figure;
subplot(2,2,1);
imshow(approximation,[]);
title('Approximation');
subplot(2,2,2);
imshow(horizontal,[]);
title('Horizontal detail');
subplot(2,2,3);
imshow(vertical,[]);
title('Vertical detail');
subplot(2,2,4);
imshow(diagonal,[]);
title('Diagonal detail');

%step 4(Smooth Partitioning)

Ig=imresize(diagonal,[256 256]);
figure;
imshow(Ig,[]);
hold on

M = size(Ig,1);
N = size(Ig,2);
for k = 1:32:M
x=[1 N];
y=[k k];
    plot(x,y,'Color','w','LineStyle','-');
    plot(x,y,'Color','black','LineStyle',':');
end

for k = 1:32:N
    x = [k k];
    y = [1 M];
    plot(x,y,'Color','w','LineStyle','-');
    plot(x,y,'Color','black','LineStyle',':');
end
hold off
title('Smooth Partitioned image');

%step 5(Renormalisation)

Y=single_scale_retinex(diagonal);
Y = double(Y)/255;
figure;
imshow(normalize8(Y),[]);
title('Renormalised image');

%step 6(Ripplet Transform of the Image)


diagonal=imresize(diagonal,[256,256]);
diagonal=double(diagonal);
if size(diagonal,3)>1
diagonal = rgb2gray(diagonal);
end
diagonal = double(diagonal)/255;
nCoef = 80000;
d=3;
c=1;
lseed = 1:floor(log2(min(size(diagonal))))-4;
levels = floor(max(lseed*(1-1/d-log2(c)),0));
y = ripplet1(diagonal,levels,'9/7','pkva');
Im1=y{1,1}{1,1};
k=Im1;
figure;
imshow(k);
title('Ripplet Domain')
K=mat2gray(k);
u=im2uint8(K);
figure;
imshow(u);
title('Ripplet transform of the Image');

%step 7('Huffman Encoding')


n=Im1(:);
n=uint8(n);
n1=vertical(:);
n1=uint8(n1);
[zipped,info] = norm2huff(n);
[zipped1,info1] = norm2huff(n1);
a=imresize(zipped1,[90,90]);
figure;
imshow(a);
title('Huffman Encoded image');


%step 8('Huffman Decoding')



unzipped=huff2norm(zipped,info);
unzipped1=huff2norm(zipped1,info1);
a=double(unzipped);
b=double(unzipped1);
output = reshape(a,32,32);
output1 = reshape(b,132,132);
figure,imshow(output,[]);title('Decoded Image');
figure,imshow(output1,[]);title('Decoded Image');
save compressed output output1
figure,imshow(output,[]);title('Decoded Image');
figure,imshow(output1,[]);title('Decoded Image');
save compressed output output1

imshow('compressed');



%better if huffman encoded data is in a table form.
