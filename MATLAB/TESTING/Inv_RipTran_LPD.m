function x = Inv_RipTran_LPD(y,level,h,g,f)

 level = log2(length(y{end}));

if level == 0 
   x = y{1}{1};
   return;
end
    
  xlo = Inv_RipTran_LPD(y(1:end-1),level-1,h,g,f);
    

  xhi = dfb_synthesis(y{end},f,level);
  
  x = InverseLPT(xlo,xhi,h,g);