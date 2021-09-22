function [h,g] = getfilters(fltname)



switch fltname
    case {'9-7', '9/7'}
        h = [.037828455506995 -.023849465019380 -.11062440441842 ...
            .37740285561265];
        h = [h, .85269867900940, fliplr(h)];
        
        g = [-.064538882628938 -.040689417609558 .41809227322221];
        g = [g, .78848561640566, fliplr(g)];
        
    case {'5-3', '5/3'}
        h = [-1, 2, 6, 2, -1] / (4 * sqrt(2));
        g = [1, 2, 1] / (2 * sqrt(2));
        
    case {'pkva12', 'pkva'}
        v = [0.6300   -0.1930    0.0972   -0.0526    0.0272   -0.0144];
        h = [v(end:-1:1), v];
    case {'pkva8'}
        v = [0.6302   -0.1924    0.0930   -0.0403];
        h = [v(end:-1:1), v];
    case {'pkva6'}
        v = [0.6261   -0.1794    0.0688];
        h = [v(end:-1:1), v];
end