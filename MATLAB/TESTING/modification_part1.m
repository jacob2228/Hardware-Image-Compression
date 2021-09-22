%step 1(Image acquisition)
[filename pathname]=uigetfile('*.jpg','Select An Image');
Input=imread([pathname filename]);
unzipped=input('Enter the value of c,the support of Ripplet');
unzipped1=input('Enter the value od d,the degree of Ripplet');

figure;
imshow(Input);
title('Input Image');


%step 2(Seperation of R,G,B components)


red = Input(:,:,1); % Red channel
green = Input(:,:,2); % Green channel
blue = Input(:,:,3); % Blue channel
a = zeros(size(Input, 1), size(Input, 2));
just_red = cat(3, red, a, a);
figure;
subplot(3,1,1);
imshow(just_red,[]);
title('Red Channel')
just_green = cat(3, a, green, a);
subplot(3,1,2);
imshow(just_green,[]);
title('Blue Channel')
just_blue = cat(3, a, a, blue);
subplot(3,1,3);
imshow(just_blue,[]);
title('Green Channel')

%step 3 (Median Filtering)


medfilInput(:,:,1)=medfilt2(red);
medfilInput(:,:,2)=medfilt2(green);
medfilInput(:,:,3)=medfilt2(blue);
figure;
imshow(medfilInput);
title('Median Filtered Colour Image');





%step 3(wavelet Decomposition of Red Channel')


[ca,cb,cc,diagonalb]=dwt2(medfilt2(red),'bior4.4');
figure;
subplot(2,2,1);
imshow(ca,[]);
title('Approximation (red)');
subplot(2,2,2);
imshow(cb,[]);
title('Horizontal detail(red)');
subplot(2,2,3);
imshow(cc,[]);
title('Vertical detail(red)');
subplot(2,2,4);
imshow(diagonalb,[]);
title('Diagonal detail(red)');





%step 4(Smooth Partitioning)

Igb=imresize(diagonalb,[256 256]);
figure;
imshow(Igb,[]);
hold on

Mb = size(Igb,1);
Nb = size(Igb,2);
for kb = 1:32:Mb
x=[1 Nb];
yb=[kb kb];
    plot(x,yb,'Color','w','LineStyle','-');
    plot(x,yb,'Color','black','LineStyle',':');
end

for kb = 1:32:Nb
    x = [kb kb];
    yb = [1 Mb];
    plot(x,yb,'Color','w','LineStyle','-');
    plot(x,yb,'Color','black','LineStyle',':');
end
hold off
title('Smooth Partitioned image (red)');

%step 5(Renormalisation)

Yb=single_scale_retinex(diagonalb);
Yb = double(Yb)/255;
figure;
imshow(normalize8(Yb),[]);
title('Renormalised image (red)');

%step 6(Ripplet Transform of the Image)

diagonalb=imresize(diagonalb,[256,256]);
diagonalb=double(diagonalb);
if size(diagonalb,3)>1
diagonalb = rgb2gray(diagonalb);
end
diagonalb = double(diagonalb)/255;
nCoef = 80000;
%d=3;
%c=1;
lseed = 1:floor(log2(min(size(diagonalb))))-4;
levels = floor(max(lseed*(1-1/unzipped1-log2(unzipped)),0));
yb = ripplet1(diagonalb,levels,'9/7','pkva');
Im1b=yb{1,1}{1,1};
kb=Im1b;
figure;
imshow(kb);
title('Ripplet Domain (red)')
Kb=mat2gray(kb);
u=im2uint8(Kb);
figure;
imshow(u);
title('Ripplet transform (red part)of the Image');

%blue

%step 3(wavelet Decomposition of Blue Channel')


[cab,cbb,ccb,diagonalb]=dwt2(medfilt2(blue),'bior4.4');
figure;
subplot(2,2,1);
imshow(cab,[]);
title('Approximation (blue)');
subplot(2,2,2);
imshow(cbb,[]);
title('Horizontal detail(blue)');
subplot(2,2,3);
imshow(ccb,[]);
title('Vertical detail(blue)');
subplot(2,2,4);
imshow(diagonalb,[]);
title('Diagonal detail(blue)');





%step 4(Smooth Partitioning)

Igb=imresize(diagonalb,[256 256]);
figure;
imshow(Igb,[]);
hold on

Mb = size(Igb,1);
Nb = size(Igb,2);
for kb = 1:32:Mb
x=[1 Nb];
yb=[kb kb];
    plot(x,yb,'Color','w','LineStyle','-');
    plot(x,yb,'Color','black','LineStyle',':');
end

for kb = 1:32:Nb
    x = [kb kb];
    yb = [1 Mb];
    plot(x,yb,'Color','w','LineStyle','-');
    plot(x,yb,'Color','black','LineStyle',':');
end
hold off
title('Smooth Partitioned image(blue)');

%step 5(Renormalisation)

Yb=single_scale_retinex(diagonalb);
Yb = double(Yb)/255;
figure;
imshow(normalize8(Yb),[]);
title('Renormalised image(blue)');

%step 6(Ripplet Transform of the Image)

diagonalb=imresize(diagonalb,[256,256]);
diagonalb=double(diagonalb);
if size(diagonalb,3)>1
diagonalb = rgb2gray(diagonalb);
end
diagonalb = double(diagonalb)/255;
nCoef = 80000;
%d=3;
%c=1;
lseed = 1:floor(log2(min(size(diagonalb))))-4;
levels = floor(max(lseed*(1-1/unzipped1-log2(unzipped)),0));
yb = ripplet1(diagonalb,levels,'9/7','pkva');
Im1b=yb{1,1}{1,1};
kb=Im1b;
figure;
imshow(kb);
title('Ripplet Domain(blue)')
Kb=mat2gray(kb);
ub=im2uint8(Kb);
figure;
imshow(ub);
title('Ripplet transform (blue part) of the Image');




%green

%step 3(wavelet Decomposition of Green Channel')


[cab,cbb,ccb,diagonalb]=dwt2(medfilt2(blue),'bior4.4');
figure;
subplot(2,2,1);
imshow(cab,[]);
title('Approximation (blue)');
subplot(2,2,2);
imshow(cbb,[]);
title('Horizontal detail(blue)');
subplot(2,2,3);
imshow(ccb,[]);
title('Vertical detail(blue)');
subplot(2,2,4);
imshow(diagonalb,[]);
title('Diagonal detail(blue)');





%step 4(Smooth Partitioning)

Igb=imresize(diagonalb,[256 256]);
figure;
imshow(Igb,[]);
hold on

Mb = size(Igb,1);
Nb = size(Igb,2);
for kb = 1:32:Mb
x=[1 Nb];
yb=[kb kb];
    plot(x,yb,'Color','w','LineStyle','-');
    plot(x,yb,'Color','black','LineStyle',':');
end

for kb = 1:32:Nb
    x = [kb kb];
    yb = [1 Mb];
    plot(x,yb,'Color','w','LineStyle','-');
    plot(x,yb,'Color','black','LineStyle',':');
end
hold off
title('Smooth Partitioned image(blue)');

%step 5(Renormalisation)

Yb=single_scale_retinex(diagonalb);
Yb = double(Yb)/255;
figure;
imshow(normalize8(Yb),[]);
title('Renormalised image(blue)');

%step 6(Ripplet Transform of the Image)

diagonalb=imresize(diagonalb,[256,256]);
diagonalb=double(diagonalb);
if size(diagonalb,3)>1
diagonalb = rgb2gray(diagonalb);
end
diagonalb = double(diagonalb)/255;
nCoef = 80000;
%d=3;
%c=1;
lseed = 1:floor(log2(min(size(diagonalb))))-4;
levels = floor(max(lseed*(1-1/unzipped1-log2(unzipped)),0));
yb = ripplet1(diagonalb,levels,'9/7','pkva');
Im1b=yb{1,1}{1,1};
kb=Im1b;
figure;
imshow(kb);
title('Ripplet Domain(blue)')
Kb=mat2gray(kb);
ub=im2uint8(Kb);
figure;
imshow(ub);
title('Ripplet transform (blue part) of the Image');









% back_to_original_img = cat(3, red, green, blue);
