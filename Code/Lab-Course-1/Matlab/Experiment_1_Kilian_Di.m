function varargout = Experiment_1_Kilian_Di(varargin)
% EXPERIMENT_1_KILIAN_DI MATLAB code for Experiment_1_Kilian_Di.fig
%      EXPERIMENT_1_KILIAN_DI, by itself, creates a new EXPERIMENT_1_KILIAN_DI or raises the existing
%      singleton*.
%
%      H = EXPERIMENT_1_KILIAN_DI returns the handle to a new EXPERIMENT_1_KILIAN_DI or the handle to
%      the existing singleton*.
%
%      EXPERIMENT_1_KILIAN_DI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXPERIMENT_1_KILIAN_DI.M with the given input arguments.
%
%      EXPERIMENT_1_KILIAN_DI('Property','Value',...) creates a new EXPERIMENT_1_KILIAN_DI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Experiment_1_Kilian_Di_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Experiment_1_Kilian_Di_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Experiment_1_Kilian_Di

% Last Modified by GUIDE v2.5 23-Mar-2021 18:52:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Experiment_1_Kilian_Di_OpeningFcn, ...
                   'gui_OutputFcn',  @Experiment_1_Kilian_Di_OutputFcn, ...
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


% --- Executes just before Experiment_1_Kilian_Di is made visible.
function Experiment_1_Kilian_Di_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Experiment_1_Kilian_Di (see VARARGIN)

% Choose default command line output for Experiment_1_Kilian_Di
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Experiment_1_Kilian_Di wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Experiment_1_Kilian_Di_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Mag_Callback(hObject, eventdata, handles)
% hObject    handle to Mag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Mag as text
%        str2double(get(hObject,'String')) returns contents of Mag as a double


% --- Executes during object creation, after setting all properties.
function Mag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Mag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Phi_Callback(hObject, eventdata, handles)
% hObject    handle to Phi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Phi as text
%        str2double(get(hObject,'String')) returns contents of Phi as a double


% --- Executes during object creation, after setting all properties.
function Phi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Phi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Omiga_Callback(hObject, eventdata, handles)
% hObject    handle to Omiga (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Omiga as text
%        str2double(get(hObject,'String')) returns contents of Omiga as a double


% --- Executes during object creation, after setting all properties.
function Omiga_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Omiga (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Wave_Num_Callback(hObject, eventdata, handles)
% hObject    handle to Wave_Num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Wave_Num as text
%        str2double(get(hObject,'String')) returns contents of Wave_Num as a double


% --- Executes during object creation, after setting all properties.
function Wave_Num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Wave_Num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Alpha_Callback(hObject, eventdata, handles)
% hObject    handle to Alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Alpha as text
%        str2double(get(hObject,'String')) returns contents of Alpha as a double


% --- Executes during object creation, after setting all properties.
function Alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Beita_Callback(hObject, eventdata, handles)
% hObject    handle to Beita (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Beita as text
%        str2double(get(hObject,'String')) returns contents of Beita as a double


% --- Executes during object creation, after setting all properties.
function Beita_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Beita (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Yita_Callback(hObject, eventdata, handles)
% hObject    handle to Yita (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Yita as text
%        str2double(get(hObject,'String')) returns contents of Yita as a double


% --- Executes during object creation, after setting all properties.
function Yita_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Yita (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Kesay_Callback(hObject, eventdata, handles)
% hObject    handle to Kesay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Kesay as text
%        str2double(get(hObject,'String')) returns contents of Kesay as a double


% --- Executes during object creation, after setting all properties.
function Kesay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Kesay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla(handles.Wave); %清空画图区域
u0 = 4 * pi * 1e-7;
e0 = (1 * 1e-9) / (36 * pi);
yita = sqrt(u0 / e0);

mag = str2num(get(handles.Mag,'string'));
phi = str2num(get(handles.Phi,'string'))*pi;
omiga = str2num(get(handles.Omiga,'string'))*pi*10^8;
wave_num = str2num(get(handles.Wave_Num,'string'))*pi;
alpha = str2num(get(handles.Alpha,'string'));
beita = str2num(get(handles.Beita,'string'))*pi;
yita = str2num(get(handles.Yita,'string'))*pi;
kesay = str2num(get(handles.Kesay,'string'))*pi;

Show = get(handles.Show_M,'value');
medium = get(handles.Medium,'value');

x = 0 : omiga / (pi * 10^12) : 8;
zero = 0 * ones(size(x));

%判断静态或者动态
t0 = 0;
if Show == 2
    t0 = 0:4e-10:1e-8;
end
%判断理想导体或者导电媒质
if medium == 1
    alpha = 0;
    beita = wave_num;
end

for t=t0
    %E和H的定义
    E = mag * exp(-alpha * x) .*cos(omiga * t - beita * x + phi);
    H = (mag / yita) * exp(-alpha * x) ...
        .* cos(omiga * t - beita * x + phi - kesay);
    axes(handles.Wave);
    %绘制电场
    h = quiver3(x,zero,zero,zero,zero,E,'R');
    set(h , 'maxheadsize' , 0);
    hold on;
    %绘制磁场
    h = quiver3(x,zero,zero,zero,H,zero,'B');
    set(h , 'maxheadsize' , 0);
    xlabel('电磁场传播方向','fontSize',12);
    ylabel('磁场方向','fontSize',12);
    zlabel('电场方向','fontSize',12);
    axis([0,8,-0.06,0.06,-0.06,0.06]);
    hold off;
    pause(0.001);
end


% --- Executes on selection change in Show_M.
function Show_M_Callback(hObject, eventdata, handles)
% hObject    handle to Show_M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Show_M contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Show_M


% --- Executes during object creation, after setting all properties.
function Show_M_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Show_M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Medium.
function Medium_Callback(hObject, eventdata, handles)
% hObject    handle to Medium (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Medium contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Medium


% --- Executes during object creation, after setting all properties.
function Medium_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Medium (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function Logo_Dut_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Logo_Dut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate Logo_Dut
imshow(imread('0202_6.jpg'));
