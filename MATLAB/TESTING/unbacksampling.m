function y = unbacksampling(x,level)

if level ==2
    y = x;
    return;
end
if level == 1
   
    for k = 1:2
	
	x{k}(:, 1:2:end) = resampling(x{k}(:, 1:2:end), 2, 1);
	x{k}(:, 2:2:end) = resampling(x{k}(:, 2:2:end), 2, 1);	
    y{k} = resampling(x{k}, 3, 1);
    end    
elseif level > 2
    N = 2^(level-2);
    
    for k = 1:N
	shift = (N + 1) - 2*k  ;
	
	
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