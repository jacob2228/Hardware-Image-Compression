function varargout = huffman(varargin)
% HUFFMAN MATLAB code for huffman.fig
%      HUFFMAN, by itself, creates a new HUFFMAN or raises the existing
%      singleton*.
%
%      H = HUFFMAN returns the handle to a new HUFFMAN or the handle to
%      the existing singleton*.
%
%      HUFFMAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HUFFMAN.M with the given input arguments.
%
%      HUFFMAN('Property','Value',...) creates a new HUFFMAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before huffman_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to huffman_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help huffman

% Last Modified by GUIDE v2.5 05-Apr-2019 11:20:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @huffman_OpeningFcn, ...
                   'gui_OutputFcn',  @huffman_OutputFcn, ...
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


% --- Executes just before huffman is made visible.
function huffman_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to huffman (see VARARGIN)

% Choose default command line output for huffman
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes huffman wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = huffman_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global Im1 vertical zipped zipped1 info info1
n=Im1(:);
n=uint8(n);
n1=vertical(:);
n1=uint8(n1);
[zipped,info] = norm2huff(n);
[zipped1,info1] = norm2huff(n1);
p=imresize(zipped1,[90,90]);
axes(handles.axes1);
imshow(p);
imwrite(p,'TEST_IMAGES/OUT/Final.jpg')
title('Huffman Encoded image');












% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global zipped info zipped1 info1

%step 8('Huffman Decoding')

global output

unzipped=huff2norm(zipped,info);
unzipped1=huff2norm(zipped1,info1);
a=double(unzipped);
b=double(unzipped1);
size(a)
output = reshape(a,32,32);
output1 = reshape(b,132,132);
axes(handles.axes2);
imshow(output1,[]);
title('Decoded Image');

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp_OUT

