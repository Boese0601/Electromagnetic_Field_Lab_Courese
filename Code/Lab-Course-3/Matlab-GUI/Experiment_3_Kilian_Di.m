

function varargout = Experiment_3_Kilian_Di(varargin)
% EXPERIMENT_3_KILIAN_DI MATLAB code for Experiment_3_Kilian_Di.fig
%      EXPERIMENT_3_KILIAN_DI, by itself, creates a new EXPERIMENT_3_KILIAN_DI or raises the existing
%      singleton*.
%
%      H = EXPERIMENT_3_KILIAN_DI returns the handle to a new EXPERIMENT_3_KILIAN_DI or the handle to
%      the existing singleton*.
%
%      EXPERIMENT_3_KILIAN_DI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXPERIMENT_3_KILIAN_DI.M with the given input arguments.
%
%      EXPERIMENT_3_KILIAN_DI('Property','Value',...) creates a new EXPERIMENT_3_KILIAN_DI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Experiment_3_Kilian_Di_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Experiment_3_Kilian_Di_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Experiment_3_Kilian_Di

% Last Modified by GUIDE v2.5 23-Mar-2021 18:54:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Experiment_3_Kilian_Di_OpeningFcn, ...
                   'gui_OutputFcn',  @Experiment_3_Kilian_Di_OutputFcn, ...
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


% --- Executes just before Experiment_3_Kilian_Di is made visible.
function Experiment_3_Kilian_Di_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Experiment_3_Kilian_Di (see VARARGIN)

% Choose default command line output for Experiment_3_Kilian_Di
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Experiment_3_Kilian_Di wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Experiment_3_Kilian_Di_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Run_Wave.
function Run_Wave_Callback(hObject, eventdata, handles)
% hObject    handle to Run_Wave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% 初始参数
clc;
cla(handles.Wave);
ao = 22.86;bo = 10.16;
d  = 15;H0 = 1;
f  = 9.375*10^9;
% t=0:1:2 ;
%% 计算数据并显示
%d     采样精度
%t     t时刻的场结构图
a=ao/1000;b=bo/1000;
lc=2*a;    %TE10截止频率
l0=(3*10^8)/f;
u=4*pi*10^(-7);
lg=l0/((1-(l0/lc)^2)^0.5);
c=lg;
B=2*pi/lg;
w=2*pi*(3*10^8);

if(l0>lc)
    return;
else
    %根据下拉菜单选择需要显示的对象
    switch get(handles.Show_M,'value')
        %第一种情况，显示完整TE10波
        case 1
            move_w = get(handles.Move_W,'value');
            static_w = get(handles.Static_W,'value');
            %判断显示动态还是静态
            if move_w == 1
                t0 = 0:0.2*10^(-9):10^(-8);
            elseif static_w == 1
                t0 = str2num(get(handles.Sta2,'string'))*0.2*10^(-9);
            else
                return;
            end
            x=0:a/d:a;y=0:b/d:b;z=0:c/d:c;
            [x1,y1,z1]=meshgrid(x,y,z);
                for t=t0
                    zerosx=zeros(size(x1));
                    zerosy=zeros(size(y1));
                    zerosz=zeros(size(z1));
                    ey=w.*u.*a.*H0.*sin(pi./a.*x1).*cos(w*t-B.*z1-pi/2)./pi;
                    hx=B.*a.*H0.*sin(pi./a.*x1).*cos(w*t-B.*z1+pi/2)./pi;
                    hz=H0.*cos(pi./a.*x1).*cos(w*t-B.*z1);
                    axes(handles.Wave);
                    quiver3(z1,x1,y1,zerosz,zerosx,ey,'r');
                    hold on;
                    quiver3(z1,x1,y1,hz,hx,zerosy,'b');
                    title('波导管内电磁场分布图')
                    axis equal
                    xlabel('传输方向z');ylabel('宽边a');zlabel('窄边b');
                    hold off;
                end
        %第二种情况，显示电（磁）场曲面图
        case 2
            t = str2num(get(handles.Time_C,'string'))*0.2*10^(-9);
            x = 0:a/d:a;
            z = 0:lg/d:lg;
            [x1,z1] = meshgrid(x,z);
            %选择显示电场还是磁场曲面
            switch get(handles.E_M,'value')
                case 1
                    ey = w*u*a*H0*sin(pi/a*x1).*sin(w*t-B*z1)/pi;
                    Show = ey;
                case 2
                    hx=B.*a.*H0.*sin(pi./a.*x1).*cos(w*t-B.*z1+pi/2)./pi;
                    hz=H0.*cos(pi./a.*x1).*cos(w*t-B.*z1);
                    Show = hx+hz;
            end
                axes(handles.Wave);
                surf(x1,z1,Show);
                title('任意x处Y电(磁)场强度')
                ylabel('传输方向z');xlabel('宽边a');zlabel('窄边b');
       %第三种情况，显示坐标切片图
        case 3
            move_w2 = get(handles.Move_W2,'value');
            static_w2 = get(handles.Static_W2,'value');
            %判断显示动态还是静态
            if move_w2 == 1
                t0 = 0:0.2*10^(-9):10^(-8);
            elseif static_w2 == 1
                t0 = str2num(get(handles.Time_S,'string'))*0.2*10^(-9);
            else
                return;
            end
            position = str2num(get(handles.Position,'string'));
            x=0:a/d:a;y=0:b/d:b;z=0:c/d:c;
            %根据所选的切片坐标轴，将该轴上的坐标值做切片
            switch get(handles.Axis_C,'value')
                %该轴的总长度乘以系数
                case 1
                    x = position*a;
                case 2
                    y = position*b;
                case 3
                    z = position*c;
            end
            [x1,y1,z1]=meshgrid(x,y,z);
            zerosx=zeros(size(x1));
            zerosy=zeros(size(y1));
            zerosz=zeros(size(z1));
            for t = t0
                ey=w.*u.*a.*H0.*sin(pi./a.*x1).*cos(w*t-B.*z1-pi/2)./pi;
                hx=B.*a.*H0.*sin(pi./a.*x1).*cos(w*t-B.*z1+pi/2)./pi;
                hz=H0.*cos(pi./a.*x1).*cos(w*t-B.*z1);
                axes(handles.Wave);
                quiver3(z1,x1,y1,zerosz,zerosx,ey,'r');
                hold on;
                quiver3(z1,x1,y1,hz,hx,zerosy,'b');
                title('波导管内电磁场分布图')
                axis equal
                xlabel('传输方向z');ylabel('宽边a');zlabel('窄边b');
                hold off;
            end
    end
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


% --- Executes on selection change in E_M.
function E_M_Callback(hObject, eventdata, handles)
% hObject    handle to E_M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns E_M contents as cell array
%        contents{get(hObject,'Value')} returns selected item from E_M


% --- Executes during object creation, after setting all properties.
function E_M_CreateFcn(hObject, eventdata, handles)
% hObject    handle to E_M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Axis_C.
function Axis_C_Callback(hObject, eventdata, handles)
% hObject    handle to Axis_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Axis_C contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Axis_C


% --- Executes during object creation, after setting all properties.
function Axis_C_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Axis_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Time_S_Callback(hObject, eventdata, handles)
% hObject    handle to Time_S (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Time_S as text
%        str2double(get(hObject,'String')) returns contents of Time_S as a double


% --- Executes during object creation, after setting all properties.
function Time_S_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Time_S (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Position_Callback(hObject, eventdata, handles)
% hObject    handle to Position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Position as text
%        str2double(get(hObject,'String')) returns contents of Position as a double


% --- Executes during object creation, after setting all properties.
function Position_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Move_W.
function Move_W_Callback(hObject, eventdata, handles)
% hObject    handle to Move_W (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Move_W

set(handles.Static_W,'value',0);
set(handles.Sta1,'visible',0);
set(handles.Sta2,'visible',0);
set(handles.Sta3,'visible',0);
guidata(hObject,handles);



% --- Executes on button press in Static_W.
function Static_W_Callback(hObject, eventdata, handles)
% hObject    handle to Static_W (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Static_W
set(handles.Move_W,'value',0);
set(handles.Sta1,'visible',1);
set(handles.Sta2,'visible',1);
set(handles.Sta3,'visible',1);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function Logo_DUT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Logo_DUT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate Logo_DUT
imshow(imread('2.png'));



function Time_C_Callback(hObject, eventdata, handles)
% hObject    handle to Time_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Time_C as text
%        str2double(get(hObject,'String')) returns contents of Time_C as a double


% --- Executes during object creation, after setting all properties.
function Time_C_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Time_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Sta2_Callback(hObject, eventdata, handles)
% hObject    handle to Sta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Sta2 as text
%        str2double(get(hObject,'String')) returns contents of Sta2 as a double


% --- Executes during object creation, after setting all properties.
function Sta2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Move_W2.
function Move_W2_Callback(hObject, eventdata, handles)
% hObject    handle to Move_W2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Move_W2
set(handles.Static_W2,'value',0);
set(handles.Time_S,'visible',0);
set(handles.Staq,'visible',0);
set(handles.Staw,'visible',0);
guidata(hObject,handles);


% --- Executes on button press in Static_W2.
function Static_W2_Callback(hObject, eventdata, handles)
% hObject    handle to Static_W2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Static_W2

set(handles.Move_W2,'value',0);
set(handles.Time_S,'visible',1);
set(handles.Staq,'visible',1);
set(handles.Staw,'visible',1);
guidata(hObject,handles);
