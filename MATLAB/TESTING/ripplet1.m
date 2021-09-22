function y = ripplet1(x,levels,fltname1, fltname2)

% level check
s = max(log2(size(x))) ;
if s < length(levels) 
    disp(['can not support ',num2str(s),'levels']);
end

[h,g] = getfilters(fltname1);
f = getfilters(fltname2);

y = RipTran_LPD(x,levels,h,g,f);

