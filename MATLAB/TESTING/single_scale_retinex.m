function Y = single_scale_retinex(X,hsiz)
Y=0;
if nargin == 1
    hsiz = 15;
elseif nargin > 2
    disp('Wrong number of input parameters!')
    return;
end
[a,b]=size(X);
cent = ceil(a/2);
X1=normalize8(X)+0.01; 
filt = zeros(a,b);
summ=0;
for i=1:a
    for j=1:b
        radius = ((cent-i)^2+(cent-j)^2);
        filt(i,j) = exp(-(radius/(hsiz^2)));
        summ=summ+filt(i,j);
    end
end
filt=filt/summ;
Z = ceil(imfilter(X1,filt,'replicate','same'));
if(sum(sum(Z==0))~=0)
    for i=1:a
        for j=1:b
            if Z(i,j)==0;
                Z(i,j)=0.01;
            end
        end
    end
end
Y=log(X1)-log(Z);
[Y, dummy] =histtruncate(Y, 0.2, 0.2);
Y=normalize8(Y);
