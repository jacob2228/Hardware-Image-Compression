function [newim, sortv] = histtruncate(im, lHistCut, uHistCut, varargin)

    if lHistCut < 0 | lHistCut > 100 | uHistCut < 0 | uHistCut > 100
	error('Histogram truncation values must be between 0 and 100');
    end

    if ndims(im) == 3  
	hsv = rgb2hsv(im);     
       
	if nargin == 3
	    [hsv(:,:,3), sortv] = Ihisttruncate(hsv(:,:,3), lHistCut, uHistCut);
	else
	    [hsv(:,:,3), sortv] = Ihisttruncate(hsv(:,:,3), lHistCut, uHistCut, varargin{1});
	end
	newim = hsv2rgb(hsv); 
    else
	if nargin == 3
	    [newim, sortv] = Ihisttruncate(im, lHistCut, uHistCut);
	else
	    [newim, sortv] = Ihisttruncate(im, lHistCut, uHistCut, varargin{1});
	end
    end
    
    

%-----------------------------------------------------------------------
    
function [newim, sortv] = Ihisttruncate(im, lHistCut, uHistCut, varargin)    
    
    if ndims(im) > 2
	error('HISTTRUNCATE only defined for grey value images');
    end
    
    im = normalize8(im,0);  % Normalise to 0-1 and cast to double if needed
    
    [r c] = size(im); 
    m = r*c;          
    
    if nargin == 3            % Generate a sorted array of pixel values.
	sortv = sort(im(:));  
	sortv = [sortv(1); sortv; sortv(m)];
    else
	sortv = varargin{1};
    end
    
    x = 100*(0.5:m - 0.5)./m; % Indices of pixel value order as a percentage
    x = [0 x 100];            % from 0 - 100.
    
    % Interpolate to find grey values at desired percentage levels.
    gv = interp1(x,sortv,[lHistCut, 100 - uHistCut]); 

    newim = imadjust(im,gv,[0 1]);
    
    

