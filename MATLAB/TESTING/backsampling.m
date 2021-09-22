function y = backsampling(x,level)
 
if level ==2
    y = x;
    return;
end
if level == 1
   
    for k = 1:2
	y{k} = resampling(x{k}, 4, 1);
	y{k}(:, 1:2:end) = resampling(y{k}(:, 1:2:end), 1, 1);
	y{k}(:, 2:2:end) = resampling(y{k}(:, 2:2:end), 1, 1);	
    end    
elseif level > 2
    N = 2^(level-2);
    
    for k = 1:N
	shift = 2*k - (N + 1);
	
	
    if shift > 0
        y{2*k-1} = resampling(x{2*k-1}, 3, shift);
        y{2*k} = resampling(x{2*k}, 3, shift);
        
        y{2*k-1+2*N} = resampling(x{2*k-1+2*N}, 1, shift);
        y{2*k+2*N} = resampling(x{2*k+2*N}, 1, shift);	
    else
        y{2*k-1} = resampling(x{2*k-1}, 4, abs(shift));
        y{2*k} = resampling(x{2*k}, 4, abs(shift));

        y{2*k-1+2*N} = resampling(x{2*k-1+2*N}, 2, abs(shift));
        y{2*k+2*N} = resampling(x{2*k+2*N}, 2, abs(shift));	
    end
	
        
    end
end