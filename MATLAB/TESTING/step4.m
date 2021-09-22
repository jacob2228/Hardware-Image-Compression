function varargout = step4(varargin)
% STEP4 MATLAB code for step4.fig
%      STEP4, by itself, creates a new STEP4 or raises the existing
%      singleton*.
%
%      H = STEP4 returns the handle to a new STEP4 or the handle to
%      the existing singleton*.
%
%      STEP4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STEP4.M with the given input arguments.
%
%      STEP4('Property','Value',...) creates a new STEP4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before step4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to step4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help step4

% Last Modified by GUIDE v2.5 22-Feb-2016 22:10:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @step4_OpeningFcn, ...
                   'gui_OutputFcn',  @step4_OutputFcn, ...
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


% --- Executes just before step4 is made visible.
function step4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to step4 (see VARARGIN)

% Choose default command line output for step4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes step4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = step4_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global diagonal;
Ig=imresize(diagonal,[256 256]);
axes(handles.axes1);
imshow(Ig,[]);
hold on

M = size(Ig,1);
N = size(Ig,2);
for k = 1:32:M
x=[1 N];
y=[k k];
    plot(x,y,'Color','w','LineStyle','-');
    plot(x,y,'Color','black','LineStyle',':');
end

for k = 1:32:N
    x = [k k];
    y = [1 M];
    plot(x,y,'Color','w','LineStyle','-');
    plot(x,y,'Color','black','LineStyle',':');
end
hold off
title('Smooth Partitioned image');
pause(1)

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global diagonal;
Y=single_scale_retinex(diagonal);
Y = double(Y)/255;
axes(handles.axes2);
imshow(normalize8(Y),[]);
title('Renormalised image');

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
global diagonal Im1;

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
axes(handles.axes3);
imshow(u);
title('Ripplet transform of the Image');


% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
huffman
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
