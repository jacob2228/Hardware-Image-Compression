function x = InverseLPT(xlo, xhi, h, g)

% According to the new reconstruction method for Laplacian pyramid by Min.
% Do.   Basically, we need to reconstruction the lowpass component based on
% the input xlo and xhi. 

% Filter and downsample xhi

        sh = 0;
        hl = floor((length(h)-1)/2) + sh;
        hr = length(h)-hl-1;
        mh = max(hl,hr);
        st = mh - hl + 1;
        ed = mh - hr;
        txhi = padarray(xhi,[mh,mh],'circular','both');         
        hhi = conv2(h,h,txhi(st:end-ed,st:end-ed),'valid');
%         downsample and differential
        dhi = xlo - hhi(1:2:end,1:2:end);
        uhi = zeros(2*size(dhi));
        uhi(1:2:end,1:2:end) = dhi;
 

  sh = mod(length(g) + 1, 2);
  gl = floor((length(g)-1)/2) + sh;
  gr = length(g)-gl-1;
  mg = max(gl,gr);
  st = mg - gl +1;
  ed = mg - gr;
  
 ty = padarray(uhi,[mg,mg],'circular','both');
 y = ty(st:end-ed,st:end-ed);
% reconstruction
th = conv2(g,g,y,'valid');

x = th + xhi;