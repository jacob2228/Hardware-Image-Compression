%step 1(Image acquisition)
[filename pathname]=uigetfile('*.jpg','Select An Image');
Input=imread([pathname filename]);
d=input('Enter the value of d');
c=input('Enter the value of c');
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
imshow(normalize8(Y));
title('Renormalised image');

%step 6(Ripplet Transform of the Image)


diagonal=imresize(diagonal,[256,256]);
diagonal=double(diagonal);
if size(diagonal,3)>1
diagonal = rgb2gray(diagonal);
end
diagonal = double(diagonal)/255;
nCoef = 80000;

%d=5;
%c=4;
lseed = 1:floor(log2(min(size(diagonal))))-4;
levels = floor(max(lseed*(1-1/d-log2(c)),0));
y = ripplet1(diagonal,levels,'9/7','pkva');
Im1=y{1,1}{1,1};
k=Im1;
imshow(mat2gray(Im1));
title('Ripplet Transform of the Image')


