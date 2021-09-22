clc;
clear all;
close all;


%step 1(Image acquisition)
[filename pathname]=uigetfile('*.jpg','Select An Image');
Input=imread([pathname filename]);
Input=imresize(Input,[256,256]);
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
figure(3);
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