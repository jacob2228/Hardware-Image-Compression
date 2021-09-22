% create the data
% Create the column and row names in cell arrays 
[filename pathname]=uigetfile('*.jpg','Select An Image');
Input=imread([pathname filename]);
Input=imresize(Input,[256,256]);
figure;
imshow(Input);
title('Input Image');
% Create the column and row names in cell arrays 
cnames = {'1','2','3','4','5','6','7','8'};
rnames = {'1','2','3','4','5','6','7','8'};
% Create the uitable
t = uitable(Input,'Data',rand(8),...
            'ColumnName',cnames,... 
            'RowName',rnames,...
            'ColumnWidth',{30})
subplot(2,1,1),plot(3)
pos = get(subplot(2,1,2),'position');
title('table')
xlabel('xlabel')
ylabel('ylabel')
set(subplot(2,1,2),'yTick',[])
set(subplot(2,1,2),'xTick',[])
set(t,'units','normalized')
set(t,'position',pos)
set(t,'ColumnName',{'a','b','c','d','e','f','g','h'})
set(t,'RowName',{'aa','bb','cc','dd','ee','ff','gg','hh'})