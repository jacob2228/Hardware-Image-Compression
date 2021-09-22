function y = resampling(x, mode, shift)

s = size(x);

switch mode
    case 1 % R_1 = [1,  1; 0, 1]
       padsize = shift*(s(2)-1);
       ex = padarray(x,[padsize,0],'circular','post');
       for j = 1:s(2)
          y(:,j) = ex((j-1)*shift+1:(j-1)*shift+s(1),j);
       end
    case 2 % R_2 = [1, -1; 0, 1]
        padsize = shift*(s(2)-1);
        ex = padarray(x,[padsize,0],'circular','pre');
        for j = 1:s(2)
%           y(:,j) = ex(s(1)+s(2)-j+2:s(2)+2*s(1)-j+1,j);
          y(:,j)=ex(padsize+1-(j-1)*shift:padsize+s(1)-(j-1)*shift,j);
        end
    case 3 % R_3 = [1,  0; 1, 1]
        padsize = shift*(s(1)-1);
        ex = padarray(x,[0,padsize],'circular','post');
        for i = 1:s(1)
          y(i,:) = ex(i,1+(i-1)*shift:s(2)+(i-1)*shift);
        end
    case 4 % R_4 = [1, 0; -1, 1]
        padsize = shift*(s(1)-1);
        ex = padarray(x,[0,padsize],'circular','pre');
        for i = 1:s(1)
          y(i,:) = ex(i,padsize+1-(i-1)*shift:padsize+s(2)-(i-1)*shift);
        end
    otherwise
       error('resampling mode error in function -- resampling'); 
        
end