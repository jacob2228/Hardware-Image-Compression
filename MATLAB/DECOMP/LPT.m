
function [xlo xhi]=LPT(h,g,x)
 sh = 0;
  hl = floor((length(h)-1)/2) + sh;
  hr = length(h)-hl-1;
  mh = max(hl,hr);
  st = mh - hl + 1;
  ed = mh - hr;
  ty = padarray(x,[mh,mh],'circular','both');
  y =  ty(st:end-ed,st:end-ed);

% get the lowpass component
tl = conv2(h,h,y,'valid');
% downsampling 
xlo = tl(1:2:end,1:2:end);


% upsampling;
tt = zeros(size(x));
tt(1:2:end,1:2:end) = xlo;
sh = mod(length(g) + 1, 2);
 gl = floor((length(g)-1)/2) + sh;
  gr = length(g)-gl-1;
  mg = max(gl,gr);
  st = mg - gl +1;
  ed = mg - gr;
  
 ty = padarray(tt,[mg,mg],'circular','both');
 y = ty(st:end-ed,st:end-ed);
% reconstruction
th = conv2(g,g,y,'valid');

% get highpass componet

xhi = x - th;