function  y = dfb_analysis(x, h, level)




y = cell(1,2^level);
% 1. first stage
[y{1} y{2}] = fb_analysis(x,h,1); 
 if level > 1     
     
 
 
% 2. second stage
[y{4} y{3}] = fb_analysis(y{2},h,2); 
[y{2} y{1}] = fb_analysis(y{1},h,2); 

% 3. remaining stages

for i = 3:level
    ch_index = reshape(repmat([1 2;3 4],1,2^(i-3))',1,[]);
    for k = 2^(i-1):-1:2^(i-2)+1
       [ y{2*k}, y{2*k-1}] = fb_analysis(y{k},h,i,ch_index(k)); 
    end
    for k = 2^(i-2):-1:1
       [y{2*k}, y{2*k-1} ] = fb_analysis(y{k},h,i,ch_index(k)); 
    end    
end
end
% 4. backsampling
y = backsampling(y,level);
% y = backsamp(y);

% Flip the order of the second half channels
y(2^(level-1)+1:end) = fliplr(y(2^(level-1)+1:end));

