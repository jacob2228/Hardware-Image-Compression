clc

%step 1(Image acquisition)
[filename pathname]=uigetfile('*.*','Select An Image');
I=imread([pathname filename]);


figure;
imshow(I);
title('Input Image');

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
figure(1)
subplot(2,4,1)
imshow(X);
title('Orginal Image');
subplot(2,4,2)
imshow(mat2gray(cH1));
title('Horizontal Details Level 1');
subplot(2,4,3)
imshow(mat2gray(cV1));
title('Vertical Details Level 1');
subplot(2,4,4)
imshow(mat2gray(cD1));
title('Diagonal Details Level 1');
subplot(2,4,5)
imshow(mat2gray(cA2));
title('Approximation');
subplot(2,4,6)
imshow(mat2gray(cH2));
title('Horizontal Details Level 2');
subplot(2,4,7)
imshow(mat2gray(cV2));
title('Vertical DetailsLevel 2');
subplot(2,4,8)
imshow(mat2gray(cD2));
title('Diagonal Details Level 2');
[thr,sorh,keepapp]= ddencmp('cmp','wv',X0); 
[Xcomp,CXC,LXC,PERF0,PERFL2] = ... 
wdencmp('gbl',C,S,'bior3.7',2,thr,sorh,keepapp);
save Xcomp


figure(2)
subplot(121); 
image(X); 
title('Original Image'); 
axis square
subplot(122);
image(mat2gray(Xcomp)); 
title('Compressed Image'); 
axis square
X0 = waverec2(C,S,'bior3.7');
imwrite(mat2gray(X0),'comp.bmp')
imwrite(mat2gray(Xcomp),'comp1.n2fj.jpg')
figure(3)
imshow(mat2gray(Xcomp));
k=imfinfo('comp1.n2fj.jpg');
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