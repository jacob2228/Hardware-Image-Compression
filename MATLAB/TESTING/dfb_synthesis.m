function x = dfb_synthesis(y, h, level)
% Flip back the order of the second half channels
y(2^(level-1)+1:end) = fliplr(y(2^(level-1)+1:end));
y = unbacksampling(y,level);
% y = rebacksamp(y);

if level > 1
  


for i = level:-1:3
    ch_index = reshape(repmat([1 2;3 4],1,2^(i-3))',1,[]);
    for k = 1 : 2^(i-2)
       y{k} = fb_synthesis(y{2*k},y{2*k-1}, h,i,ch_index(k)); 
    end    
    
    for k = 2^(i-2)+1 : 2^(i-1)
      y{k} = fb_synthesis(y{2*k},y{2*k-1}, h,i,ch_index(k)); 
    end
    
end


% second stage
y{1} = fb_synthesis(y{2},y{1},h,2);
y{2} = fb_synthesis(y{4},y{3},h,2);

end
% first stage
 x = fb_synthesis(y{1},y{2},h,1,1);
