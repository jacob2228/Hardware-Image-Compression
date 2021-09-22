function varargout = gui_modification(varargin)
% GUI_MODIFICATION MATLAB code for gui_modification.fig
%      GUI_MODIFICATION, by itself, creates a new GUI_MODIFICATION or raises the existing
%      singleton*.
%
%      H = GUI_MODIFICATION returns the handle to a new GUI_MODIFICATION or the handle to
%      the existing singleton*.
%
%      GUI_MODIFICATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_MODIFICATION.M with the given input arguments.
%
%      GUI_MODIFICATION('Property','Value',...) creates a new GUI_MODIFICATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_modification_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_modification_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_modification

% Last Modified by GUIDE v2.5 03-Jan-2016 06:18:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_modification_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_modification_OutputFcn, ...
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


% --- Executes just before gui_modification is made visible.
function gui_modification_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_modification (see VARARGIN)

% Choose default command line output for gui_modification
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_modification wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_modification_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global filename
global pathname
global Input
global name
[filename pathname]=uigetfile('*.jpg','Select An Image');
Input=imread([pathname filename]);
Input=imresize(Input,[256,256]);
axes(handles.axes1);
imshow(Input);

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global Input
global red
global green
global blue
global just_red
global just_green
global just_blue
red = Input(:,:,1); % Red channel
green = Input(:,:,2); % Green channel
blue = Input(:,:,3); % Blue channel
a = zeros(size(Input, 1), size(Input, 2));
just_red = cat(3, red, a, a);
axes(handles.axes2);
imshow(just_red,[]);
just_green = cat(3, a, green, a);
axes(handles.axes3);
imshow(just_green,[]);
just_blue = cat(3, a, a, blue);
axes(handles.axes4);
imshow(just_blue,[]);
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
global red green blue  
medfilInput(:,:,1)=medfilt2(red);
medfilInput(:,:,2)=medfilt2(green);
medfilInput(:,:,3)=medfilt2(blue);
axes(handles.axes5);
imshow(medfilInput);
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
global back_to_original_img red green blue
back_to_original_img = cat(3, red, green, blue);
axes(handles.axes6);
imshow(back_to_original_img);
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
