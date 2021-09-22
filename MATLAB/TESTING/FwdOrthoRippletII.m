% Function description
%   [P,L] = FwdOrthoRippletII(I,nlevels,wname,degree)
% This function implements ripplet transform through Fourier series.
%
% inputs:
%         I: maxtrix of input image
%         nlevels: number of levels used in wavelet transform
%         wname: name of wavelets
%         degree: degree of ripplet II
% outputs:
%         P: Orthogonal Ripplet II coefficients
%         L: the bookkeeping matrix of wavelet transform
% author:
%        Jun Xu
%   Electrical and Computer Engineering
%   University of Florida
% creat: 8/31/2009

function [P,L] = FwdOrthoRippletII(I,nlevels,wname,degree)


[m,n] = size(I);
padsize = 3;
Ipad = padarray(I,[padsize,padsize],'both');

m2 = floor(m/2);
n2 = floor(n/2);
moe = 1-mod(m,2);
noe = 1-mod(n,2);
vy = (-m2-padsize+moe/2:(m2)+padsize-moe/2)/m2;
vx = (-n2-padsize+noe/2:n2+padsize-noe/2)/n2;

[ix,iy] = meshgrid(vx,vy);

%--- convert to polar
vr = 1/m:1/m:1;
[ir,itheta] = meshgrid(vr,-pi+2*pi/n:2*pi/n:pi);

[tx,ty] = pol2cart(itheta,ir);

Ip = interp2(ix,iy, Ipad,tx, ty,'linear');
%-- x axis: r; y axis: theta
%--- 1D Fourier Trans. along theta
Fn = zeros(size(Ip));
for k = 1:size(Ip,2)
    Fn(:,k) = fft(Ip(:,k));
end





%-------Fourier series interpolation---------
Fn_hat = zeros(size(Fn));
if degree >0
    for n = 1:size(Fn,1)
        for ip = 1:size(Fn,2)
            p = vr(ip);
            r = vr(ip+1:end);
            item1 = Fn(n,ip+1:end);
            item2 = chebpoly(abs(degree)*n,(p./r).^(1/degree));
            item3 = (1-(p./r).^(2/degree)).^(-1/2);
            val = item1.*item2.*item3;
            Fn_hat(n,ip) = sum(val);
        end
    end
else
    for n = 1:size(Fn,1)
        for ip = 2:size(Fn,2)
            p = vr(ip);
            r = vr(1:ip-1);
            item1 = Fn(n,1:ip-1);
            item2 = chebpoly(abs(degree)*n,(p./r).^(1/degree));
            item3 = (1-(p./r).^(2/degree)).^(-1/2);
            val = item1.*item2.*item3;
            Fn_hat(n,ip) = sum(val);
        end
    end
    
end

%^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


%=== inverse ===

fprec = zeros(size(Ip));
for k = 1:size(Ip,2)
    fprec(:,k) = ifft(Fn_hat(:,k));
end
Ra = abs(fprec)/2/pi;
%-- 2-D wavelet along r
if exist('wname','var')
    wavname = wname;
else
    wavname = 'db4';
end

[rows, cols] = size(Ra);
lev = wmaxlev(min(rows,cols),wavname);
if exist('nlevels','var')
    lev = min(lev,nlevels);
end



[C,L]= wavedec2(Ra,lev,wavname);

P = C;
