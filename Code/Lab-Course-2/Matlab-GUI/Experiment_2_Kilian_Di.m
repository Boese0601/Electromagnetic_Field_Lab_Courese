function varargout = Experiment_2_Kilian_Di(varargin)
% EXPERIMENT_2_KILIAN_DI MATLAB code for Experiment_2_Kilian_Di.fig
%      EXPERIMENT_2_KILIAN_DI, by itself, creates a new EXPERIMENT_2_KILIAN_DI or raises the existing
%      singleton*.
%
%      H = EXPERIMENT_2_KILIAN_DI returns the handle to a new EXPERIMENT_2_KILIAN_DI or the handle to
%      the existing singleton*.
%
%      EXPERIMENT_2_KILIAN_DI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXPERIMENT_2_KILIAN_DI.M with the given input arguments.
%
%      EXPERIMENT_2_KILIAN_DI('Property','Value',...) creates a new EXPERIMENT_2_KILIAN_DI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Experiment_2_Kilian_Di_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Experiment_2_Kilian_Di_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Experiment_2_Kilian_Di

% Last Modified by GUIDE v2.5 23-Mar-2021 18:51:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Experiment_2_Kilian_Di_OpeningFcn, ...
                   'gui_OutputFcn',  @Experiment_2_Kilian_Di_OutputFcn, ...
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


% --- Executes just before Experiment_2_Kilian_Di is made visible.
function Experiment_2_Kilian_Di_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Experiment_2_Kilian_Di (see VARARGIN)

% Choose default command line output for Experiment_2_Kilian_Di
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Experiment_2_Kilian_Di wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Experiment_2_Kilian_Di_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Show.
function Show_Callback(hObject, eventdata, handles)
% hObject    handle to Show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% 初始化
u0 = str2num(get(handles.u0,'string'))*pi*10.^(-7);
e0 = str2num(get(handles.e0,'string'))*pi^(-1)*10.^(-9);
u1 = str2num(get(handles.u1,'string'))*u0;
u2 = str2num(get(handles.u2,'string'))*u0;
e1 = str2num(get(handles.e1,'string'))*e0;
e2 = str2num(get(handles.e2,'string'))*e0;
omiga = str2num(get(handles.omiga,'string'))*pi*10^(3);
Ei0 = str2num(get(handles.Ei0,'string'));
phi0 = str2num(get(handles.phi0,'string'));
Show_Mode = get(handles.Show_Mode,'value');
Show_Plan = get(handles.Show_Plan,'value');
k1 = omiga *sqrt(u1*e1);
k2 = omiga *sqrt(u2*e2);
eta1 = sqrt(u1/e1);
eta2 = sqrt(u2/e2);
R = (eta2-eta1)/(eta2+eta1);
T = (2*eta2)/(eta2+eta1);

n=2;
lambda1 = 2*pi/k1;
z = -n*lambda1:lambda1/100:0;
z1 = 0:lambda1/100:n*lambda1;
zero=zeros(size(z));
Show_R = 1;

if Show_Plan == 2
    R = -1;
    Show_R = 0;
elseif Show_Plan == 1
    return;
end

%根据展现动/静态，对循环次数进行规定
if Show_Mode == 2
    %为了展现更好的效果，静态时t不是0
    t0 = 0.00005;
elseif Show_Mode == 3
    t0 = 0:0.00005:0.001;
elseif Show_Mode == 1
    return;
end

for t = t0
    %计算电磁场的数值
    E1 = Ei0*(cos(omiga*t-k1*z+phi0)+R*cos(omiga*t+k1*z+phi0));
    E2 = Ei0*T.*cos(omiga*t-k2*z1+phi0);
    H1 = Ei0/eta1.*(cos(omiga*t-k1*z+phi0)-R*cos(omiga*t+k1*z+phi0));
    H2 = Ei0/eta2*T.*cos(omiga*t-k2*z1+phi0);
    
    %如果入射理想导体，则只展现入射端的波
    axes(handles.wave);
    h=quiver3(z,zero,zero,zero,zero,E1,'R',...
        'autoscale','off');
    set(h,'maxheadsize',0);
    hold on
    h=quiver3(z,zero,zero,zero,H1,zero,'B',...
        'autoscale','off');
    set(h,'maxheadsize',0);
    %如果入射理想介质，则展现界面两端的波
    if Show_R == 1
        h=quiver3(z1,zero,zero,zero,zero,E2,'R',...
            'autoscale','off');
        set(h,'maxheadsize',0);
        h=quiver3(z1,zero,zero,zero,H2,zero,'B',...
            'autoscale','off');
        set(h,'maxheadsize',0);
    end
    hold off;
    axis([-inf inf -2*Ei0/eta1 2*Ei0/eta1 -2*Ei0 2*Ei0]);
    legend('E','H','location','northeast');
    xlabel(' Dissemination Direction','fontSize',12);
    ylabel(' Magnetic Field Direction','fontSize',12);
    zlabel(' Electric Field Direction','fontSize',12);
end

hold off;



function u0_Callback(hObject, eventdata, handles)
% hObject    handle to u0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of u0 as text
%        str2double(get(hObject,'String')) returns contents of u0 as a double


% --- Executes during object creation, after setting all properties.
function u0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to u0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function u1_Callback(hObject, eventdata, handles)
% hObject    handle to u1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of u1 as text
%        str2double(get(hObject,'String')) returns contents of u1 as a double


% --- Executes during object creation, after setting all properties.
function u1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to u1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function u2_Callback(hObject, eventdata, handles)
% hObject    handle to u2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of u2 as text
%        str2double(get(hObject,'String')) returns contents of u2 as a double


% --- Executes during object creation, after setting all properties.
function u2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to u2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e1_Callback(hObject, eventdata, handles)
% hObject    handle to e1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e1 as text
%        str2double(get(hObject,'String')) returns contents of e1 as a double


% --- Executes during object creation, after setting all properties.
function e1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e2_Callback(hObject, eventdata, handles)
% hObject    handle to e2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e2 as text
%        str2double(get(hObject,'String')) returns contents of e2 as a double


% --- Executes during object creation, after setting all properties.
function e2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function omiga_Callback(hObject, eventdata, handles)
% hObject    handle to omiga (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of omiga as text
%        str2double(get(hObject,'String')) returns contents of omiga as a double


% --- Executes during object creation, after setting all properties.
function omiga_CreateFcn(hObject, eventdata, handles)
% hObject    handle to omiga (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ei0_Callback(hObject, eventdata, handles)
% hObject    handle to Ei0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ei0 as text
%        str2double(get(hObject,'String')) returns contents of Ei0 as a double


% --- Executes during object creation, after setting all properties.
function Ei0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ei0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function phi0_Callback(hObject, eventdata, handles)
% hObject    handle to phi0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of phi0 as text
%        str2double(get(hObject,'String')) returns contents of phi0 as a double


% --- Executes during object creation, after setting all properties.
function phi0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to phi0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e0_Callback(hObject, eventdata, handles)
% hObject    handle to e0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e0 as text
%        str2double(get(hObject,'String')) returns contents of e0 as a double


% --- Executes during object creation, after setting all properties.
function e0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Show_Mode.
function Show_Mode_Callback(hObject, eventdata, handles)
% hObject    handle to Show_Mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Show_Mode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Show_Mode


% --- Executes during object creation, after setting all properties.
function Show_Mode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Show_Mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function Logo_DUT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Logo_DUT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate Logo_DUT
imshow(imread('Kaiming_He.jpg'));


% --- Executes on button press in Break.
function Break_Callback(hObject, eventdata, handles)
% hObject    handle to Break (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
return;


% --- Executes on selection change in Show_Plan.
function Show_Plan_Callback(hObject, eventdata, handles)
% hObject    handle to Show_Plan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Show_Plan contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Show_Plan


% --- Executes during object creation, after setting all properties.
function Show_Plan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Show_Plan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
