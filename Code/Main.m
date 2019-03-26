function varargout = Main(varargin)
%MAIN MATLAB code file for Main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('Property','Value',...) creates a new MAIN using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to Main_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      MAIN('CALLBACK') and MAIN('CALLBACK',hObject,...) call the
%      local function named CALLBACK in MAIN.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Main

% Last Modified by GUIDE v2.5 22-Nov-2018 19:04:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Main_OpeningFcn, ...
                   'gui_OutputFcn',  @Main_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function saveState(handles)

    
    global settingCropStack;
    global settingForwardProjection;
    global settingCrop;
    
    fileName1 = '../RUN/recentsettingCropStack.mat';
    fileName2 = '../RUN/recentsettingForwardProjection.mat';
    fileName3 = '../RUN/recentsettingCrop.mat';
    runPath = '../RUN/';
    if exist(runPath,'dir')==7
        ;
    else
        mkdir(runPath);
    end
    
    settingCropStack.StackDepth = get(handles.editStackDepth,'string');
    settingCropStack.Overlap = get(handles.editOverlap,'string');
    settingCropStack.dx = get(handles.editdx,'string');
    settingCropStack.Nnum = get(handles.editNnum, 'string');
    settingCropStack.RangeAdjust = get(handles.editRangeAdjust,'string');
    settingCropStack.ZsamplingPara = get(handles.editZsamplingPara,'string');
    settingCropStack.RotatingStep = get(handles.editRotatingStep,'string');
    
    settingCropStack.RectifyImage = get(handles.checkboxRectifyImage,'Value');
    settingCropStack.Rotate = get(handles.checkboxRotate,'Value');
    settingCropStack.VideoMode = get(handles.checkboxVideoMode,'Value');
    
    settingForwardProjection.ConvPara = get(handles.editConvPara,'string');
    
    settingCrop.SizeX = get(handles.editSizeX,'string');
    settingCrop.SizeY = get(handles.editSizeY,'string');
    settingCrop.SizeZ = get(handles.editSizeZ,'string');
    settingCrop.SumThreshold = get(handles.editSumThreshold,'string');
    settingCrop.VarThreshold = get(handles.editVarThreshold,'string');
    
    save(fileName1,'settingCropStack');
    save(fileName2,'settingForwardProjection');
    save(fileName3,'settingCrop');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function loadState(handles)

global settingCropStack;
global settingForwardProjection;
global settingCrop;


fileName1 = '../RUN/recentsettingCropStack.mat';
if exist(fileName1)
    load(fileName1);
    set(handles.editStackDepth,'string',settingCropStack.StackDepth);
    set(handles.editOverlap,'string',settingCropStack.Overlap);
    set(handles.editdx,'string',settingCropStack.dx);
    set(handles.editNnum,'string',settingCropStack.Nnum);
    set(handles.editRangeAdjust,'string',settingCropStack.RangeAdjust);
    set(handles.editZsamplingPara,'string',settingCropStack.ZsamplingPara);
    set(handles.editRotatingStep,'string',settingCropStack.RotatingStep);
    set(handles.checkboxRectifyImage,'value',settingCropStack.RectifyImage);
    set(handles.checkboxRotate,'value',settingCropStack.Rotate);
    set(handles.checkboxVideoMode,'value',settingCropStack.VideoMode);
else
    set(handles.editStackDepth,'string','31');
    set(handles.editOverlap,'string','0.5');
    set(handles.editdx,'string','23.265');
    set(handles.editNnum,'string','11');
    set(handles.editRangeAdjust,'string','1.3');
    set(handles.editZsamplingPara,'string','4');
    set(handles.editRotatingStep,'string','15')
    set(handles.checkboxRectifyImage,'value',1);
    set(handles.checkboxRotate,'value',1);
    set(handles.checkboxVideoMode,'value',0);
end

fileName2 = '../RUN/recentsettingForwardProjection.mat';
if exist(fileName2)
    load(fileName2);
    set(handles.editConvPara,'string',settingForwardProjection.ConvPara);
else
    set(handles.editConvPara,'string','6');
end

fileName3 = '../RUN/recentsettingCrop.mat';
if exist(fileName3)
    load(fileName3);
    set(handles.editSizeX,'string',settingCrop.SizeX);
    set(handles.editSizeY,'string',settingCrop.SizeY);
    set(handles.editSizeZ,'string',settingCrop.SizeZ);
    set(handles.editSumThreshold,'string',settingCrop.SumThreshold);
    set(handles.editVarThreshold,'string',settingCrop.VarThreshold);
else
    set(handles.editSizeX,'string','176');
    set(handles.editSizeY,'string','176');
    set(handles.editSizeZ,'string','16');
    set(handles.editSumThreshold,'string','1e5');
    set(handles.editVarThreshold,'string','1e0');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function readState(handles)
    global settingCropStack;
    global settingForwardProjection;
    global settingCrop;
    
    settingCropStack.StackDepth = get(handles.editStackDepth,'string');
    settingCropStack.Overlap = get(handles.editOverlap,'string');
    settingCropStack.dx = get(handles.editdx,'string');
    settingCropStack.Nnum = get(handles.editNnum, 'string');
    settingCropStack.RangeAdjust = get(handles.editRangeAdjust,'string');
    settingCropStack.ZsamplingPara = get(handles.editZsamplingPara,'string');
    settingCropStack.RotatingStep = get(handles.editRotatingStep,'string');

    settingCropStack.RectifyImage = get(handles.checkboxRectifyImage,'Value');
    settingCropStack.Rotate = get(handles.checkboxRotate,'Value');
    settingCropStack.VideoMode = get(handles.checkboxVideoMode,'Value');
    
    settingForwardProjection.ConvPara = get(handles.editConvPara,'string');
    
    settingCrop.SizeX = get(handles.editSizeX,'string');
    settingCrop.SizeY = get(handles.editSizeY,'string');
    settingCrop.SizeZ = get(handles.editSizeZ,'string');
    settingCrop.SumThreshold = get(handles.editSumThreshold,'string');
    settingCrop.VarThreshold = get(handles.editVarThreshold,'string');
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function CropStackcheckState(handles)
    global settingCropStack;
    readState(handles);
    settingCropStack.check = 1;
    
    if ~(str2num(settingCropStack.StackDepth) > 0)
        disp('The StackDepth should be larger than 0');
        settingCropStack.check = 0;
    end
    if (str2num(settingCropStack.Overlap)<0) || (str2num(settingCropStack.Overlap)>1)
        disp('Overlap is between 0 and 1');
        settingCropStack.check = 0;
    end
    if ~(str2num(settingCropStack.dx)>0)
        disp('dx equals to 150/PixelSize');
        settingCropStack.check = 0;
    end
    if mod(str2num(settingCropStack.Nnum),2)==0 || mod(str2num(settingCropStack.Nnum),1)>0 || str2num(settingCropStack.Nnum)<1
        disp('Nnum should be an odd integer number');
        settingCropStack.check = 0;
    end
    if ~(str2num(settingCropStack.RangeAdjust)>=1)
        disp('RangeAdjust should be larger than 1');
        settingCropStack.check = 0;
    end
    if mod(str2num(settingCropStack.ZsamplingPara),1)>0 || str2num(settingCropStack.ZsamplingPara)<1
        disp('ZsamplingPara should be an integer number');
        settingCropStack.check = 0;
    end
    if mod(str2num(settingCropStack.RotatingStep),1)>0 || str2num(settingCropStack.RotatingStep)<0 || str2num(settingCropStack.RotatingStep) > 180
        disp('RotatingStep should be an integer number between 0-180 degree');
        settingCropStack.check = 0;
    end
    
    if settingCropStack.check == 1
        saveState(handles);
        disp('=============Start CropStack==============');
        
        CropStacks;
        
    else
        disp('========= Retry after changing the variables according to the message =======');
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ForwardProjectioncheckState(handles)
    global settingForwardProjection
    readState(handles);
    settingForwardProjection.check = 1;
    
    if ~(str2num(settingForwardProjection.ConvPara) > 1)
        disp('The ConvPara should be larger than 1');
        settingForwardProjection.check = 0;
    end

    
    if settingForwardProjection.check == 1
        saveState(handles);
        disp('=============Start ForwardProjection==============');
        
        forward;
        
    else
        disp('========= Retry after changing the variables according to the message =======');
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function CropTestcheckState(handles)
    global settingCrop;
    readState(handles);
    settingCrop.check = 1;
    settingCrop.saveAll = 1;
    
    if ~(str2num(settingCrop.SizeX) > 0)
        disp('The SizeX should be larger than 0');
        settingCrop.check = 0;
    end
    if ~(str2num(settingCrop.SizeY) > 0)
        disp('The SizeY should be larger than 0');
        settingCrop.check = 0;
    end
    if ~(str2num(settingCrop.SizeZ) > 0)
        disp('The SizeZ should be larger than 0');
        settingCrop.check = 0;
    end
    if ~(str2num(settingCrop.SumThreshold) > 0)
        disp('The SumThreshold should be larger than 0');
        settingCrop.check = 0;
    end
    if ~(str2num(settingCrop.VarThreshold) > 0)
        disp('The VarThreshold should be larger than 0');
        settingCrop.check = 0;
    end
   
    if settingCrop.check == 1
        saveState(handles);
        disp('=============Start CropTest==============');
        
        crop;
        
    else
        disp('========= Retry after changing the variables according to the message =======');
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function CropcheckState(handles)
    global settingCrop;
    readState(handles);
    settingCrop.check = 1;
    settingCrop.saveAll = 0;
    
    if ~(str2num(settingCrop.SizeX) > 0)
        disp('The SizeX should be larger than 0');
        settingCrop.check = 0;
    end
    if ~(str2num(settingCrop.SizeY) > 0)
        disp('The SizeY should be larger than 0');
        settingCrop.check = 0;
    end
    if ~(str2num(settingCrop.SizeZ) > 0)
        disp('The SizeZ should be larger than 0');
        settingCrop.check = 0;
    end
    if ~(str2num(settingCrop.SumThreshold) > 0)
        disp('The SumThreshold should be larger than 0');
        settingCrop.check = 0;
    end
    if ~(str2num(settingCrop.VarThreshold) > 0)
        disp('The VarThreshold should be larger than 0');
        settingCrop.check = 0;
    end
   
    if settingCrop.check == 1
        saveState(handles);
        disp('=============Start Crop==============');
        
        crop;
        
    else
        disp('========= Retry after changing the variables according to the message =======');
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes just before Main is made visible.
function Main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for Main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global settingCropStack;
global settingForwardProjection;
global settingCrop;
loadState(handles);



% UIWAIT makes Main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Main_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Operate.
function Operate_Callback(hObject, eventdata, handles)
% hObject    handle to Operate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CropStackcheckState(handles);



function editStackDepth_Callback(hObject, eventdata, handles)
% hObject    handle to editStackDepth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editStackDepth as text
%        str2double(get(hObject,'String')) returns contents of editStackDepth as a double


% --- Executes during object creation, after setting all properties.
function editStackDepth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editStackDepth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOverlap_Callback(hObject, eventdata, handles)
% hObject    handle to editOverlap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOverlap as text
%        str2double(get(hObject,'String')) returns contents of editOverlap as a double


% --- Executes during object creation, after setting all properties.
function editOverlap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOverlap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editdx_Callback(hObject, eventdata, handles)
% hObject    handle to editdx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editdx as text
%        str2double(get(hObject,'String')) returns contents of editdx as a double


% --- Executes during object creation, after setting all properties.
function editdx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editdx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkboxRectifyImage.
function checkboxRectifyImage_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxRectifyImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxRectifyImage
global settingCropStack;
if (get(hObject,'Value') == get(hObject,'Max'))
    settingCropStack.RectifyImage = 1;
else
    settingCropStack.RectifyImage = 0;
end


function editNnum_Callback(hObject, eventdata, handles)
% hObject    handle to editNnum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editNnum as text
%        str2double(get(hObject,'String')) returns contents of editNnum as a double


% --- Executes during object creation, after setting all properties.
function editNnum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editNnum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editRangeAdjust_Callback(hObject, eventdata, handles)
% hObject    handle to editRangeAdjust (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editRangeAdjust as text
%        str2double(get(hObject,'String')) returns contents of editRangeAdjust as a double


% --- Executes during object creation, after setting all properties.
function editRangeAdjust_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editRangeAdjust (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editZsamplingPara_Callback(hObject, eventdata, handles)
% hObject    handle to editZsamplingPara (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editZsamplingPara as text
%        str2double(get(hObject,'String')) returns contents of editZsamplingPara as a double


% --- Executes during object creation, after setting all properties.
function editZsamplingPara_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editZsamplingPara (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function editRotatingStep_Callback(hObject, eventdata, handles)
% hObject    handle to editRotatingStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editRotatingStep as text
%        str2double(get(hObject,'String')) returns contents of editRotatingStep as a double


% --- Executes during object creation, after setting all properties.
function editRotatingStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editRotatingStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function editSumThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to editSumThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSumThreshold as text
%        str2double(get(hObject,'String')) returns contents of editSumThreshold as a double


% --- Executes during object creation, after setting all properties.
function editSumThreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSumThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editVarThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to editVarThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editVarThreshold as text
%        str2double(get(hObject,'String')) returns contents of editVarThreshold as a double


% --- Executes during object creation, after setting all properties.
function editVarThreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editVarThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editSizeX_Callback(hObject, eventdata, handles)
% hObject    handle to editSizeX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSizeX as text
%        str2double(get(hObject,'String')) returns contents of editSizeX as a double


% --- Executes during object creation, after setting all properties.
function editSizeX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSizeX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonCropTest.
function pushbuttonCropTest_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonCropTest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CropTestcheckState(handles);

% --- Executes on button press in pushbuttonCrop.
function pushbuttonCrop_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonCrop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CropcheckState(handles);


function editSizeY_Callback(hObject, eventdata, handles)
% hObject    handle to editSizeY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSizeY as text
%        str2double(get(hObject,'String')) returns contents of editSizeY as a double


% --- Executes during object creation, after setting all properties.
function editSizeY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSizeY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editSizeZ_Callback(hObject, eventdata, handles)
% hObject    handle to editSizeZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSizeZ as text
%        str2double(get(hObject,'String')) returns contents of editSizeZ as a double


% --- Executes during object creation, after setting all properties.
function editSizeZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSizeZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editConvPara_Callback(hObject, eventdata, handles)
% hObject    handle to editConvPara (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editConvPara as text
%        str2double(get(hObject,'String')) returns contents of editConvPara as a double


% --- Executes during object creation, after setting all properties.
function editConvPara_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editConvPara (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Project.
function Project_Callback(hObject, eventdata, handles)
% hObject    handle to Project (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ForwardProjectioncheckState(handles);


% --- Executes on button press in checkboxRotate.
function checkboxRotate_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxRotate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxRotate
global settingCropStack;
if (get(hObject,'Value') == get(hObject,'Max'))
    settingCropStack.Rotate = 1;
else
    settingCropStack.Rotate = 0;
end

% --- Executes on button press in checkboxVideoMode1.
function checkboxVideoMode_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxVideoMode1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxVideoMode1
global settingCropStack;
if (get(hObject,'Value') == get(hObject,'Max'))
    settingCropStack.VideoMode = 1;
else
    settingCropStack.VideoMode = 0;
end

function CropStacks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% To cut the ground truth volumes into required stacks(Depth,PixelSize,Rotation)
%%% Input Raw volumes with required Z step
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
warning('off');

load('../RUN/recentsettingCropStack.mat');
%%%%%%%%%%%%%%%%%%%%%%%%% Substacks Parameters%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SubStackDepth = str2num(settingCropStack.StackDepth);
Overlap = str2num(settingCropStack.Overlap);
dx = str2num(settingCropStack.dx); 
Nnum = str2num(settingCropStack.Nnum);
RangeAdjust = str2num(settingCropStack.RangeAdjust);
ZsamplingPara = str2num(settingCropStack.ZsamplingPara);
RotatingStep = str2num(settingCropStack.RotatingStep);
RectVolumeEnable = settingCropStack.RectifyImage;
RotateEnable = settingCropStack.Rotate;
VideoMode = settingCropStack.VideoMode;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
savePath = '../Data/Substacks';
if exist('savePath','dir') ~=7
    mkdir(savePath);
end

Overlapslice = floor(Overlap * SubStackDepth);

if VideoMode  %% if processing video (different folder structure)
    filepath = uigetdir();
    filedir = dir(filepath);
    Foldernum = size(filedir,1);
    disp(['Choose VideoMode...in directory  ' filepath  '......' num2str(Foldernum-2) ' Folders']);
    disp(['RotateEnable: ' num2str(RotateEnable)]);
    disp(['RectVolumeEnable: ' num2str(RectVolumeEnable)]);
    disp('================================================================');
    for n = 3:Foldernum  % 3 because the 
        Folder = fullfile(filepath,filedir(n).name);
        Folderdir = dir(Folder);
        framenum = size(Folderdir,1);
        disp(['Processing Folder...  ' num2str(n-2) ]);
        for nn = 3:framenum
            tic;
            if nn == 3              
                frameName = fullfile(Folder,Folderdir(nn).name);
                frameInfo = imfinfo(frameName);
                depth = numel(frameInfo);
                [OriginalFrame,row,col] = readVolume(frameName,depth,1);               
                %% Z sampling 
                Zindex = 1:ZsamplingPara:depth;
                ZsampledVol = OriginalFrame(:,:,Zindex);
                %% update depth
                depth = size(ZsampledVol,3);
                
                subStackNum = ceil((depth-SubStackDepth)/(SubStackDepth-Overlapslice)) + 1;
                subRotateNum = (180*RotateEnable)/RotatingStep + 1;
                subTargetNum = subStackNum*subRotateNum;
                
                %% Rotate and CropZ
                for angle = 0:RotatingStep:(179*RotateEnable)
                    frameRot = imrotate(ZsampledVol,angle,'bicubic','loose');
                    for subStackn = 1:subStackNum
                        s = 1 + (subStackn-1)*(SubStackDepth-Overlapslice);
                        e = s + SubStackDepth - 1;
                        if e > depth   % Wrap the last SubStack
                            s = s - (e - depth);
                            e = depth;
                        end            
                        subStack = frameRot(:,:,s:e);
                        if RectVolumeEnable
                            xCenter = col/2;   
                            yCenter = row/2;
                            rectStack = VolumeRectify(subStack,xCenter,yCenter,dx,Nnum,depth);
                        else
                            rectStack = subStack;
                        end
                        rectStack = (rectStack ./ (RangeAdjust * max(rectStack(:)))) .* 255.0;
                        % Create Save Folders                
                        subVideoFolderName = sprintf('%02d_%03d_%02d',(n-2),angle,subStackn);
                        subVideoFolderDir = [savePath '/' subVideoFolderName];                                                
                        if exist('subVideoFolderDir','dir') ~= 7
                            mkdir(subVideoFolderDir);
                        end
                        % Save intial stacks
                        subStackName = sprintf('%02d_%03d_%02d_%04d.tif',(n-2),angle,subStackn,(nn-2));
                        SaveStack([subVideoFolderDir '/' subStackName],rectStack);
                    end
                end
            else
                frameName = fullfile(Folder,Folderdir(nn).name);
                frameInfo = imfinfo(frameName);
                depth = numel(frameInfo);
                [OriginalFrame,row,col] = readVolume(frameName,depth,1);               
                %% Z sampling 
                Zindex = 1:ZsamplingPara:depth;
                ZsampledVol = OriginalFrame(:,:,Zindex);
                %% update depth
                depth = size(ZsampledVol,3);
                
                subStackNum = ceil((depth-SubStackDepth)/(SubStackDepth-Overlapslice)) + 1;
                subRotateNum = (180*RotateEnable)/RotatingStep + 1;
                subTargetNum = subStackNum*subRotateNum;
                
                %% Rotate and CropZ
                for angle = 0:RotatingStep:(179*RotateEnable)
                    frameRot = imrotate(ZsampledVol,angle,'bicubic','loose');
                    for subStackn = 1:subStackNum
                        s = 1 + (subStackn-1)*(SubStackDepth-Overlapslice);
                        e = s + SubStackDepth - 1;
                        if e > depth   % Wrap the last SubStack
                            s = s - (e - depth);
                            e = depth;
                        end            
                        subStack = frameRot(:,:,s:e);
                        if RectVolumeEnable
                            xCenter = col/2;   
                            yCenter = row/2;
                            rectStack = VolumeRectify(subStack,xCenter,yCenter,dx,Nnum,depth);
                        else
                            rectStack = subStack;
                        end
                        rectStack = (rectStack ./ (RangeAdjust * max(rectStack(:)))) .* 255.0;
                        % Choose Existing Save Folders                
                        subVideoFolderName = sprintf('%02d_%03d_%02d',(n-2),angle,subStackn);
                        subVideoFolderDir = [savePath '/' subVideoFolderName];                                                

                        % Save following stacks
                        subStackName = sprintf('%02d_%03d_%02d_%04d.tif',(n-2),angle,subStackn,(nn-2));
                        SaveStack([subVideoFolderDir '/' subStackName],rectStack);
                    end
                end
                
            end
            disp(['        Processing Frame...  ' num2str(nn-2) ' in ' num2str(toc) ' sec']);
        end
    end
       
else
    [file_name,filepath] = uigetfile('*.tif','Select Original Volumes','MultiSelect','on');
    if ~iscell(file_name)
        file_name = {file_name};
    end
    fileNum = size(file_name,2);

    for n=1:fileNum
        saveName = file_name{n};
        saveName = saveName(1:end-4);

        file = fullfile(filepath,file_name{n});
        fileInfo = imfinfo(file);
        depth = numel(fileInfo);
        [OriginalVol,row,col] = readVolume(file,depth,1);

        Zindex = 1:ZsamplingPara:depth;
        ZsampledVol = OriginalVol(:,:,Zindex);
        depth = size(ZsampledVol,3);

        for angle = 0 : RotatingStep : (179*RotateEnable)
            
            VolRot = imrotate(ZsampledVol, angle, 'bicubic', 'loose');
            subStackNum = ceil((depth-SubStackDepth)/(SubStackDepth-Overlapslice)) + 1;   % when Overlap = 0 and depth = SubStackDepth, subStackNum = 1; No Wrap;
            for nn = 1:subStackNum
                tic;
                s = 1 + (nn-1)*(SubStackDepth-Overlapslice);
                e = s + SubStackDepth - 1;
                if e > depth   % Wrap the last SubStack
                    s = s - (e - depth);
                    e = depth;
                end
                subVol = VolRot(:,:,s:e);
                if RectVolumeEnable
                    xCenter = col/2;   
                    yCenter = row/2;
                    rectVol = VolumeRectify(subVol,xCenter,yCenter,dx,Nnum,depth);
                else
                    rectVol = subVol;
                end        
                rectVol = (rectVol ./ (RangeAdjust * max(rectVol(:)))) .* 255.0;
                subVolname = sprintf('%s_Angle%03d_SUB%02d.tif',saveName,angle, nn);
                SaveStack([savePath '/' subVolname],rectVol);
                disp([subVolname ' ... ' '  done  ' ' in ' num2str(toc) ' sec']);
            end
              
        end
    end
end
disp('Crop,Rotate and Rectify ... done');


function forward
%% Multi Stacks Light Field Forward Projection
% The Stacks slice number should correspond to the depth of PSF
% Input: uint8 tif stacks
warning('off');

load('../RUN/recentsettingForwardProjection.mat');
%%%%%%%%%%%%%%%%%%%%%%%%% Projection Parameters%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ConvPara = str2num(settingForwardProjection.ConvPara);
xCenter             = 657.0;   
yCenter             = 661.0;
dx                  = 23.455000; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[psf_name,psfpath] = uigetfile('*.mat','Select PSF','MultiSelect','off','../PSFmatrix');

disp([ 'Loading LF_PSF...' ]);
[LFpsf,psf_h,psf_w,psf_d,Nnum,CAindex] = readPSF([psfpath, psf_name]);
disp(['LF_PSF has been loaded. Size: ' num2str(psf_h) 'x' num2str(psf_w) 'x' num2str(Nnum) 'x' num2str(Nnum) 'x' num2str(psf_d) '.']);
depth = psf_d;

savePath = '../Data/LFforward';
if exist('savePath','dir') ~=7
    mkdir(savePath);
end

sourcePath = '../Data/Substacks';
volSource = dir(sourcePath);
targetNum = size(volSource,1); 

for t =3:targetNum
    target = volSource(t);
    if target.isdir
        folderSourceName = [sourcePath '/' target.name];
        folderSaveName = [savePath '/' target.name];
        if exist('folderSaveName','dir') ~= 7
            mkdir(folderSaveName);
        end
        subVolSource = dir(folderSourceName);
        for tt = 3:size(subVolSource,1)
            tic;
            subVolName = subVolSource(tt).name;
            volume = readVolume([folderSourceName '/' subVolName],depth,1);
            volume_dims = size(volume);
            stacks = zeros(volume_dims);
            for d = 1 : depth 
                for i = 1 : Nnum
                    for j = 1 : Nnum
                        sub_region =  zeros(volume_dims(1),volume_dims(2));
                        sub_region(i: Nnum: end,j: Nnum: end) = volume(i: Nnum: end, j: Nnum: end, d);
                        sub_psf = squeeze(LFpsf( CAindex(d,1):CAindex(d,2), CAindex(d,1):CAindex(d,2) ,i,j,d));
                        sub_psf = sub_psf/sum(sub_psf(:));
                        sub_out = conv2(sub_region,sub_psf,'same');
                        stacks(:, :, d) = stacks(:, :, d) + sub_out;
                    end
                end
            end
            LF_raw  = (sum(stacks , 3))./ConvPara;
            LF_raw = uint8(LF_raw);
            imwrite(LF_raw, [folderSaveName '/' subVolName]);
            disp( ['Projected Image : ' subVolName   ' ... ' num2str(toc) 'sec' ] ); 
        end
    else
        tic;
        volume = readVolume([sourcePath '/' target.name],depth,1);
        volume_dims = size(volume);
        volume = gpuArray(single(volume));
        stacks = zeros(volume_dims,'double');
        
        global zeroImageEx;
        global exsize;
        xsize = [volume_dims(1), volume_dims(2)];
        msize = [size(LFpsf,1), size(LFpsf,2)];
        mmid = floor(msize/2);
        exsize = xsize + mmid;  
        exsize = [ min( 2^ceil(log2(exsize(1))), 128*ceil(exsize(1)/128) ), min( 2^ceil(log2(exsize(2))), 128*ceil(exsize(2)/128) ) ];    
        zeroImageEx = gpuArray(zeros(exsize, 'single'));
%         disp(['FFT size is ' num2str(exsize(1)) 'X' num2str(exsize(2))]); 
               
        for d = 1 : depth 
            for i = 1 : Nnum
                for j = 1 : Nnum
                    sub_region =  gpuArray.zeros(volume_dims(1),volume_dims(2),'single');
                    sub_region(i: Nnum: end,j: Nnum: end) = volume(i: Nnum: end, j: Nnum: end, d);
                    sub_psf = gpuArray(single(squeeze(LFpsf( CAindex(d,1):CAindex(d,2), CAindex(d,1):CAindex(d,2) ,i,j,d))));
                    sub_psf = sub_psf/sum(sub_psf(:));
%                     sub_Out = conv2(sub_region,sub_psf,'same');
                    sub_Out = conv2FFT(sub_region, sub_psf);
                    sub_out = gather(sub_Out);
                    stacks(:, :, d) = stacks(:, :, d) + sub_out;
                end
            end
        end
        LF_raw  = (sum(stacks , 3))./ConvPara;
        LF_raw = uint8(LF_raw);
        imwrite(LF_raw, [savePath '/' target.name]);
        disp( ['Projected Image : ' target.name   ' ... ' num2str(toc) 'sec' ] );
    end
end
disp(['Forward Projection ... Done']);


function crop
warning('off');
load('../RUN/recentsettingCropStack.mat');
load('../RUN/recentsettingCrop.mat');

%%%%%%%%%%%%%%%%%%%%%%%%%%Crop Parameter%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cropped_size = [str2num(settingCrop.SizeX),str2num(settingCrop.SizeY),str2num(settingCrop.SizeZ)];
overlap = [0.5,0.5,0.];
pixel_threshold = str2num(settingCrop.SumThreshold);
var_threshold   = str2num(settingCrop.VarThreshold);
save_all = settingCrop.saveAll;
videoMode = settingCropStack.VideoMode;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
series_path_3d = '../Data/Substacks';
save_path_3d = '../Data/TrainingPair/WF';
series_path_2d = '../Data/LFforward';
save_path_2d = '../Data/TrainingPair/LF';


if save_all    
    if videoMode
        crop_time_series_3d(cropped_size, overlap, series_path_3d, save_path_3d, save_all, pixel_threshold, var_threshold);
    else
        crop_static_3d(cropped_size, overlap, series_path_3d, save_path_3d, save_all, pixel_threshold, var_threshold);
    end
else
    delete('../Data/TrainingPair/LF/*.tif');
    delete('../Data/TrainingPair/WF/*.tif');
    if videoMode
        crop_time_series_3d(cropped_size, overlap, series_path_3d, save_path_3d, save_all, pixel_threshold, var_threshold);
        crop_time_series_lightfield(cropped_size(1), overlap, series_path_2d, save_path_2d);
    else
        crop_static_3d(cropped_size, overlap, series_path_3d, save_path_3d, save_all, pixel_threshold, var_threshold);
        crop_static_lightfield(cropped_size(1), overlap, series_path_2d, save_path_2d);
    end
end

disp('Crop ...Done');
