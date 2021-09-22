function [p0 p1] = fb_analysis(x,h, stage,ch)


h(1:2:end) = - h(1:2:end);



switch stage
    case 1
        %         resamaple
        s = resampling(x,2,1);
        s0 = resampling(s(1:2:end,:),3,1);
        s1 = resampling(s(2:2:end,[2:end,1]),3,1);
        %     filtering
   
        
        sh = 1;
        hl = floor((length(h)-1)/2) + sh;
        hr = length(h)-hl-1;
        mh = max(hl,hr);
        st = mh - hl + 1;
        ed = mh - hr;
%         ts = padarray(s1,[mh,mh],'circular','both');
ts = specialpad(s1,mh);
        es1 = ts(st:end-ed,st:end-ed);

        p0 = (s0-conv2(h,h,es1,'valid'))/sqrt(2);
        sh = 0;
        hl = floor((length(h)-1)/2) + sh;
        hr = length(h)-hl-1;
        mh = max(hl,hr);
        st = mh - hl + 1;
        ed = mh - hr;
%         tp = padarray(p0,[mh,mh],'circular','both');
tp = specialpad(p0,mh);
        ep0 = tp(st:end-ed,st:end-ed);
        p1 = (-sqrt(2) * s1) - conv2(h,h,ep0,'valid');
      
    case 2
        %         resamaple
        s = resampling(x,4,1);
        s0 = resampling(s(:,1:2:end),1,1);
        s1 = resampling(s([2:end,1],2:2:end),1,1);
        %          filtering
        sh = 1;
        hl = floor((length(h)-1)/2) + sh;
        hr = length(h)-hl-1;
        mh = max(hl,hr);
        st = mh - hl + 1;
        ed = mh - hr;
        ts = padarray(s1,[mh,mh],'circular','both');
        es1 = ts(st:end-ed,st:end-ed);

        p0 = (s0-conv2(h,h,es1,'valid'))/sqrt(2);
        sh = 0;
        hl = floor((length(h)-1)/2) + sh;
        hr = length(h)-hl-1;
        mh = max(hl,hr);
        st = mh - hl + 1;
        ed = mh - hr;
        tp = padarray(p0,[mh,mh],'circular','both');
        ep0 = tp(st:end-ed,st:end-ed);
        p1 = (-sqrt(2) * s1) - conv2(h,h,ep0,'valid');
    otherwise  % >2
        %      resample
        switch ch
            case 1
                s0 = resampling(x(1:2:end, :), 3,1);	
            	s1 = resampling(x(2:2:end, [2:end, 1]), 3,1);
            case 2
                s0 = resampling(x(1:2:end, :), 4,1);	
            	s1 = resampling(x(2:2:end, :), 4,1);
            case 3
                s0 = resampling(x(:,1:2:end), 1,1);	
            	s1 = resampling(x([2:end, 1], 2:2:end), 1,1);
            case 4
                s0 = resampling(x(:, 1:2:end), 2,1);	
            	s1 = resampling(x(:, 2:2:end), 2,1);
        end
                
         %          filtering
        sh = 1;
        hl = floor((length(h)-1)/2) + sh;
        hr = length(h)-hl-1;
        mh = max(hl,hr);
        st = mh - hl + 1;
        ed = mh - hr;
        ts = padarray(s1,[mh,mh],'circular','both');
        es1 = ts(st:end-ed,st:end-ed);
        p0 = (s0-conv2(h,h,es1,'valid'))/sqrt(2);
        
        sh = 0;
        hl = floor((length(h)-1)/2) + sh;
        hr = length(h)-hl-1;
        mh = max(hl,hr);
        st = mh - hl + 1;
        ed = mh - hr;
        tp = padarray(p0,[mh,mh],'circular','both');
        ep0 = tp(st:end-ed,st:end-ed);
        p1 = (-sqrt(2) * s1) - conv2(h,h,ep0,'valid');
end


function y = specialpad(x,mh)

    
[rows, cols] = size(x);
cx = round(cols/2);
tmp_a = [[x(:,1:cx);x(:,cx+1:end)],[x(:,cx+1:end);x(:,1:cx)]];

tmp_b = padarray(tmp_a,[mh,0],'circular','both');
tmp = [tmp_b(1:rows+mh,:);tmp_b(2*rows+mh+1:end,cx+1:end),tmp_b(2*rows+mh+1:end,1:cx)];
y = padarray(tmp,[0,mh],'circular','both');

