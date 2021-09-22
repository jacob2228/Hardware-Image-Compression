function varargout = FINAL_GUI(varargin)
% FINAL_GUI MATLAB code for FINAL_GUI.fig
%      FINAL_GUI, by itself, creates a new FINAL_GUI or raises the existing
%      singleton*.
%
%      H = FINAL_GUI returns the handle to a new FINAL_GUI or the handle to
%      the existing singleton*.
%
%      FINAL_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINAL_GUI.M with the given input arguments.
%
%      FINAL_GUI('Property','Value',...) creates a new FINAL_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FINAL_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FINAL_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FINAL_GUI

% Last Modified by GUIDE v2.5 13-Jun-2019 10:49:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FINAL_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @FINAL_GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before FINAL_GUI is made visible.
function FINAL_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FINAL_GUI (see VARARGIN)

% Choose default command line output for FINAL_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FINAL_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FINAL_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Input pathname filename
%step 1(Image acquisition)
[filename, pathname]=uigetfile('TEST_IMAGES/*.jpg','Select An Image');
Input=imread([pathname filename]);
Input=imresize(Input,[255,255]);

%step 2(preprocessing)

if length(size(Input))==3
            Input = rgb2gray(Input);
end
imwrite(Input,'Gray_Input.jpg');
axes(handles.axes1);
imshow(Input)
title('Gray Image')



% --- Executes on button press in pushbutton2.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Input pathname filename
[approximation,horizontal,vertical,diagonal]=dwt2(Input,'bior4.4');


%step 4(Smooth Partitioning)

Ig=imresize(diagonal,[256 256]);




%step 5(Renormalisation)

Y=single_scale_retinex(diagonal);
Y = double(Y)/255;


%step 6(Ripplet Transform of the Image)


diagonal=imresize(diagonal,[256,256]);
diagonal=double(diagonal);
if size(diagonal,3)>1
diagonal = rgb2gray(diagonal);
end
diagonal = double(diagonal)/255;
nCoef = 80000;
d=3;
c=1;
lseed = 1:floor(log2(min(size(diagonal))))-4;
levels = floor(max(lseed*(1-1/d-log2(c)),0));
y = ripplet1(diagonal,levels,'9/7','pkva');
Im1=y{1,1}{1,1};
k=Im1;
K=mat2gray(k);
u=im2uint8(K);



%step 7('Huffman Encoding')


n=Im1(:);
n=uint8(n);
n1=vertical(:);
n1=uint8(n1);
[zipped,info] = norm2huff(n);
[zipped1,info1] = norm2huff(n1);
a=imresize(zipped1,[90,90]);
imwrite(a,'Final.jpg')
save a
%step 8('Huffman Decoding')



unzipped=huff2norm(zipped,info);
unzipped1=huff2norm(zipped1,info1);
a=double(unzipped);
b=double(unzipped1);
output = reshape(a,32,32);
output1 = reshape(b,132,132);
save compressed output output1



Final = idwt2(approximation,horizontal,vertical,output1,'bior4.4');

axes(handles.axes2);
imshow(mat2gray(Final));
imwrite(mat2gray(Final),'TEST_IMAGES/OUT/Final.jpg')
title('Decompressed Image')



I=imread([pathname filename]);

I=imresize(I,[256,256]);


X= im2double(I);
[C,S] = wavedec2(X,2,'bior3.7');
cA2 = appcoef2(C,S,'bior3.7',2);
cH2 = detcoef2('h',C,S,2);
cV2 = detcoef2('v',C,S,2);
cD2 = detcoef2('d',C,S,2);
cH1 = detcoef2('h',C,S,1);
cV1 = detcoef2('v',C,S,1);
cD1 = detcoef2('d',C,S,1);
X0 = waverec2(C,S,'bior3.7');

[thr,sorh,keepapp]= ddencmp('cmp','wv',X0); 
[Xcomp,CXC,LXC,PERF0,PERFL2] = ... 
wdencmp('gbl',C,S,'bior3.7',2,thr,sorh,keepapp);
save Xcomp;
XcompMAT=im2uint8(Xcomp);
ComIMG=norm2huff(XcompMAT);
X0 = waverec2(C,S,'bior3.7');
imwrite(mat2gray(X0),'TEST_IMAGES/OUT/comp.jpg')
imwrite(mat2gray(Xcomp),'comp1.n2fj.jpg')
k=imfinfo('TEST_IMAGES/OUT/comp.jpg');
ib=k.Width*k.Height*k.BitDepth/8;
cb=k.FileSize;
cr=ib/cb;
p=imfinfo([pathname filename]);
ib1=p.Width*p.Height*p.BitDepth/8;
cb1=p.FileSize;
cr1=ib1/cb1;
A = [' compression ratio of orginal image = ',num2str(cr1),];
disp(A)
A = [' compression ratio of compressed image = ',num2str(cr)];
disp(A)
cb=(k.FileSize/1024)
cb1=(p.FileSize/1024)
CR=cb1/cb
CRCOMP=['CR :',num2str(cr)]
set(handles.text2, 'String',CRCOMP);
[peaksnr, snr] =psnr(Xcomp, X0)
SNR=['SNR :',num2str(snr)]
set(handles.text3, 'String',SNR);
PSNR=['PSNR :',num2str(peaksnr)]
set(handles.text4, 'String',PSNR);
fprintf('\n The Peak-SNR value is %0.4f', peaksnr);
fprintf('\n The SNR value is %0.4f', snr);
