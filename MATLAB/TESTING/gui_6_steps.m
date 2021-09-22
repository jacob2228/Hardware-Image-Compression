function varargout = gui_6_steps(varargin)
% GUI_6_STEPS MATLAB code for gui_6_steps.fig
%      GUI_6_STEPS, by itself, creates a new GUI_6_STEPS or raises the existing
%      singleton*.
%
%      H = GUI_6_STEPS returns the handle to a new GUI_6_STEPS or the handle to
%      the existing singleton*.
%
%      GUI_6_STEPS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_6_STEPS.M with the given input arguments.
%
%      GUI_6_STEPS('Property','Value',...) creates a new GUI_6_STEPS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_6_steps_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_6_steps_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_6_steps

% Last Modified by GUIDE v2.5 03-Jan-2016 06:48:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_6_steps_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_6_steps_OutputFcn, ...
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


% --- Executes just before gui_6_steps is made visible.
function gui_6_steps_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_6_steps (see VARARGIN)

% Choose default command line output for gui_6_steps
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_6_steps wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_6_steps_OutputFcn(hObject, eventdata, handles) 
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
[filename, pathname]=uigetfile('TEST_IMAGES/*.*','Select An Image');
%name = filename;
% [pathstr, name, ext, versn] = fileparts(filename);
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
global median
if length(size(Input))==3
            Input = rgb2gray(Input);
end
median=medfilt2(Input);
axes(handles.axes2);
        imshow(median);

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
global Input approximation horizontal vertical diagonal;
[approximation,horizontal,vertical,diagonal]=dwt2(Input,'bior4.4');
axes(handles.axes4);
imshow(approximation,[]);
title('Approximation');
axes(handles.axes5);
imshow(horizontal,[]);
title('Horizontal detail');
axes(handles.axes6);
imshow(vertical,[]);
title('Vertical detail');
axes(handles.axes7);
imshow(diagonal,[]);
title('Diagonal detail');
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
 step4
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
