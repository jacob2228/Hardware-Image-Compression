function x = fb_synthesis(p0,p1,h, stage,ch)

% 1  modulation 

h(1:2:end) = - h(1:2:end);


% 2 resample  
% stage 1st: Q
% stage 2nd: Q
% stafe 3rd....: R*Q

switch stage
    case 1
        
        %     filtering
        
         sh = 0;
        hl = floor((length(h)-1)/2) + sh;
        hr = length(h)-hl-1;
        mh = max(hl,hr);
        st = mh - hl+1;
        ed = mh - hr;
      
        
%          tp = padarray(p0,[mh,mh],'circular','both');
tp = specialpad(p0,mh);
        ep0 = tp(st:end-ed,st:end-ed);
        s1 = ( p1 + conv2(h,h,ep0,'valid'))/(-sqrt(2));
         sh = 1;
        hl = floor((length(h)-1)/2) + sh;
        hr = length(h)-hl-1;
        mh = max(hl,hr);
        st = mh - hl+1;
        ed = mh - hr;
      
%        ts = padarray(s1,[mh,mh],'circular','both');
ts = specialpad(s1,mh);
        es1 = ts(st:end-ed,st:end-ed);
        s0 = (p0*sqrt(2)+conv2(h,h,es1,'valid'));
        
       
         %         resamaple
        [m n] = size(s0);
        s = zeros(2*m,n);
        s(1:2:end,:)  = resampling(s0,4,1);
        s(2:2:end,[2:end,1]) = resampling(s1,4,1);
        x = resampling(s,1,1);
    case 2
          %     filtering
        sh = 0;
        hl = floor((length(h)-1)/2) + sh;
        hr = length(h)-hl-1;
        mh = max(hl,hr);
        st = mh - hl+1;
        ed = mh - hr;
      
        
         tp = padarray(p0,[mh,mh],'circular','both');
        ep0 = tp(st:end-ed,st:end-ed);
        s1 = ( p1 + conv2(h,h,ep0,'valid'))/(-sqrt(2));
         sh = 1;
        hl = floor((length(h)-1)/2) + sh;
        hr = length(h)-hl-1;
        mh = max(hl,hr);
        st = mh - hl+1;
        ed = mh - hr;
      
       ts = padarray(s1,[mh,mh],'circular','both');
        es1 = ts(st:end-ed,st:end-ed);
        s0 = (p0*sqrt(2)+conv2(h,h,es1,'valid'));
        
        
       
           %         resamaple
        [m n] = size(s0);
        s = zeros(m,2*n);
        s(:,1:2:end) = resampling(s0,2,1);
        s([2:end,1],2:2:end) = resampling(s1,2,1);
        x = resampling(s,3,1);
    otherwise  % >2
          %     filtering
         sh = 0;
        hl = floor((length(h)-1)/2) + sh;
        hr = length(h)-hl-1;
        mh = max(hl,hr);
        st = mh - hl+1;
        ed = mh - hr;
      
        
         tp = padarray(p0,[mh,mh],'circular','both');
        ep0 = tp(st:end-ed,st:end-ed);
        s1 = ( p1 + conv2(h,h,ep0,'valid'))/(-sqrt(2));
         sh = 1;
        hl = floor((length(h)-1)/2) + sh;
        hr = length(h)-hl-1;
        mh = max(hl,hr);
        st = mh - hl+1;
        ed = mh - hr;
      
       ts = padarray(s1,[mh,mh],'circular','both');
        es1 = ts(st:end-ed,st:end-ed);
        s0 = (p0*sqrt(2)+conv2(h,h,es1,'valid'));
        
       
        %      resample
        [m n] = size(s0);
        
        switch ch
            case 1
                x = zeros(2*m,n);
                x(1:2:end, :) = resampling(s0, 4,1);	
            	x(2:2:end, [2:end, 1]) = resampling(s1, 4,1);
            case 2
                x = zeros(2*m,n);
                x(1:2:end, :) = resampling(s0, 3,1);	
            	x(2:2:end, :) = resampling(s1, 3,1);
            case 3
                x = zeros(m,2*n);
                x(:,1:2:end) = resampling(s0, 2,1);	
            	x([2:end, 1], 2:2:end) = resampling(s1, 2,1);
            case 4
                x = zeros(m,2*n);
                x(:, 1:2:end) = resampling(s0, 1,1);	
            	x(:, 2:2:end) = resampling(s1, 1,1);
        end  
end
function y = specialpad(x,mh)

    
[rows, cols] = size(x);
cx = round(cols/2);
tmp_a = [[x(:,1:cx);x(:,cx+1:end)],[x(:,cx+1:end);x(:,1:cx)]];

tmp_b = padarray(tmp_a,[mh,0],'circular','both');
tmp = [tmp_b(1:rows+mh,:);tmp_b(2*rows+mh+1:end,cx+1:end),tmp_b(2*rows+mh+1:end,1:cx)];
y = padarray(tmp,[0,mh],'circular','both');
