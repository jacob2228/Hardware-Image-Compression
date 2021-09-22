function y = RipTran_LPD(x,levels,h,g,f)

if levels(end) == 0
    y{1} = {x};
    return;
end

[xlo xhi] = LPT(h,g,x);


yhi = dfb_analysis(xhi,f,levels(end));
ylo = RipTran_LPD(xlo,levels(1:end-1),h,g,f);

y={ylo{:},yhi};