function varargout = disp_OUT(varargin)
% DISP_OUT MATLAB code for disp_OUT.fig
%      DISP_OUT, by itself, creates a new DISP_OUT or raises the existing
%      singleton*.
%
%      H = DISP_OUT returns the handle to a new DISP_OUT or the handle to
%      the existing singleton*.
%
%      DISP_OUT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DISP_OUT.M with the given input arguments.
%
%      DISP_OUT('Property','Value',...) creates a new DISP_OUT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before disp_OUT_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to disp_OUT_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help disp_OUT

% Last Modified by GUIDE v2.5 13-Jun-2019 12:42:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @disp_OUT_OpeningFcn, ...
                   'gui_OutputFcn',  @disp_OUT_OutputFcn, ...
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


% --- Executes just before disp_OUT is made visible.
function disp_OUT_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to disp_OUT (see VARARGIN)

% Choose default command line output for disp_OUT
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes disp_OUT wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = disp_OUT_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Input approximation horizontal vertical output1 filename pathname

axes(handles.axes1);
imshow(Input);
title('GRAY INPUT');
Final = idwt2(approximation,horizontal,vertical,output1,'bior4.4');
axes(handles.axes2);
imshow(mat2gray(Final));
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
set(handles.text5, 'String',CRCOMP);
[peaksnr, snr] =psnr(Xcomp, X0)
SNR=['SNR :',num2str(snr)]
set(handles.text6, 'String',SNR);
PSNR=['PSNR :',num2str(peaksnr)]
set(handles.text7, 'String',PSNR);
fprintf('\n The Peak-SNR value is %0.4f', peaksnr);
fprintf('\n The SNR value is %0.4f', snr);
