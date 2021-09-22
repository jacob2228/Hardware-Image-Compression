clc;
clear all;
close all;


%step 1(Image acquisition)
[filename pathname]=uigetfile('*.jpg','Select An Image');
Input=imread([pathname filename]);
Input=imresize(Input,[255,255]);
figure(1);
subplot(1,2,1);
imshow(Input);
title('Input Image');

%step 2(preprocessing)

if length(size(Input))==3
            Input = rgb2gray(Input);
end
imwrite(Input,'Gray_Input.jpg');
subplot(1,2,2);
imshow(Input);
title('Gray Image')
pause(1)



[approximation,horizontal,vertical,diagonal]=dwt2(Input,'bior4.4');
figure(2);
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
pause(1)

%step 4(Smooth Partitioning)

Ig=imresize(diagonal,[256 256]);
figure(3);
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
pause(1)

%step 5(Renormalisation)

Y=single_scale_retinex(diagonal);
Y = double(Y)/255;
figure(4);
imshow(normalize8(Y),[]);
title('Renormalised image');
pause(1)

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
K=mat2gray(k);
u=im2uint8(K);
pause(1)
figure(5);
imshow(u);
title('Ripplet transform of the Image');
pause(1)

%step 7('Huffman Encoding')


n=Im1(:);
n=uint8(n);
n1=vertical(:);
n1=uint8(n1);
[zipped,info] = norm2huff(n);
[zipped1,info1] = norm2huff(n1);
a=imresize(zipped1,[90,90]);
figure(6);
imshow(a);
imwrite(a,'Final.jpg')
title('Huffman Encoded image');
pause(1)
save a
%step 8('Huffman Decoding')



unzipped=huff2norm(zipped,info);
unzipped1=huff2norm(zipped1,info1);
a=double(unzipped);
b=double(unzipped1);
output = reshape(a,32,32);
output1 = reshape(b,132,132);
figure(7);
imshow(output1,[]);
title('Decoded Image');
save compressed output output1



Final = idwt2(approximation,horizontal,vertical,output1,'bior4.4');
figure(8);
subplot(1,2,1);
imshow(Input);
title('GrayScale orginal image');
subplot(1,2,2);
imshow(mat2gray(Final));
imwrite(mat2gray(Final),'Final.jpg')
title('Decompressed Image')



I=imread([pathname filename]);

I=imresize(I,[256,256]);


X= im2double(I);
[C,S] = wavedec2(X,2,'bior3.7');
cA2 = appcoef2(C,S,'bior3.7',2);
cH2 = detcoef2('h',C,S,2);
cV2 = detcoef2('v',C,S,2);
cD2 = detcoef2('d',C,S,2);
cH1 = detcoef2('h',C,S,1);
cV1 = detcoef2('v',C,S,1);
cD1 = detcoef2('d',C,S,1);
X0 = waverec2(C,S,'bior3.7');

[thr,sorh,keepapp]= ddencmp('cmp','wv',X0); 
[Xcomp,CXC,LXC,PERF0,PERFL2] = ... 
wdencmp('gbl',C,S,'bior3.7',2,thr,sorh,keepapp);
save Xcomp;
XcompMAT=im2uint8(Xcomp);
ComIMG=norm2huff(XcompMAT);
X0 = waverec2(C,S,'bior3.7');
imwrite(mat2gray(X0),'comp.jpg')
imwrite(mat2gray(Xcomp),'comp1.n2fj.jpg')
k=imfinfo('comp.jpg');
ib=k.Width*k.Height*k.BitDepth/8;
cb=k.FileSize;
cr=ib/cb;
p=imfinfo([pathname filename]);
ib1=p.Width*p.Height*p.BitDepth/8;
cb1=p.FileSize;
cr1=ib1/cb1;
A = [' compression ratio of orginal image = ',num2str(cr1),];
disp(A)
A = [' compression ratio of compressed image = ',num2str(cr)];
disp(A)
[peaksnr, snr] =psnr(Xcomp, X0)
fprintf('\n The Peak-SNR value is %0.4f', peaksnr);
fprintf('\n The SNR value is %0.4f', snr);



