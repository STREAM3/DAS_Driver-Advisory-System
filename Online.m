% Nima Ghaviha (nima.ghaviha@mdh.se)
% 2016-10-17

% This function is used to handle the GUI for the online calculations. 

function varargout = Online(varargin)
% ONLINE MATLAB code for Online.fig
%      ONLINE, by itself, creates a new ONLINE or raises the existing
%      singleton*.
%
%      H = ONLINE returns the handle to a new ONLINE or the handle to
%      the existing singleton*.
%
%      ONLINE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ONLINE.M with the given input arguments.
%
%      ONLINE('Property','Value',...) creates a new ONLINE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Online_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Online_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Online

% Last Modified by GUIDE v2.5 09-Aug-2016 16:23:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Online_OpeningFcn, ...
                   'gui_OutputFcn',  @Online_OutputFcn, ...
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


% --- Executes just before Online is made visible.
function Online_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Online (see VARARGIN)
handles.pop = 1;
axes(handles.axes1);
Bombardier_Logo = imread('bombardier.jpg');
image(Bombardier_Logo);
axis off;

axes(handles.axes2);
MDH_Logo = imread('MDH-logo.jpg');
image(MDH_Logo);
axis off;

axes(handles.axes4);
MDH_Logo = imread('SICS.jpg');
image(MDH_Logo);
axis off;

axes(handles.axes5);
MDH_Logo = imread('Train.jpg');
image(MDH_Logo);
axis off;

% Choose default command line output for Online
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Online wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Online_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function InputT_Callback(hObject, eventdata, handles)
% hObject    handle to InputT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.InputT = get(hObject, 'String');
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of InputT as text
%        str2double(get(hObject,'String')) returns contents of InputT as a double


% --- Executes during object creation, after setting all properties.
function InputT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InputT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function InputX_Callback(hObject, eventdata, handles)
% hObject    handle to InputX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.InputX = get(hObject, 'String');
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of InputX as text
%        str2double(get(hObject,'String')) returns contents of InputX as a double


% --- Executes during object creation, after setting all properties.
function InputX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InputX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function InputV_Callback(hObject, eventdata, handles)
% hObject    handle to InputV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.InputV = get(hObject, 'String');
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of InputV as text
%        str2double(get(hObject,'String')) returns contents of InputV as a double


% --- Executes during object creation, after setting all properties.
function InputV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InputV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in find_n.
function find_n_Callback(hObject, eventdata, handles)
%tstep_find = handles.TTime/handles.tS;
%xstep_find = handles.TDistance/handles.xS;

handles.InputT2 = round(str2double(handles.InputT)/handles.tstep) + 1;
handles.InputX2 = round(str2double(handles.InputX)/handles.xstep) + 1;
handles.InputV2 = round(str2double(handles.InputV)/handles.vstep) + 1;

handles.InputX_R = str2double(handles.InputX)/handles.xstep + 1;
handles.InputV_R = str2double(handles.InputV)/handles.vstep + 1;

handles.Vout = zeros(handles.tS+1, 1);
handles.Xout = zeros(handles.tS+1, 1);
handles.DistOpout = zeros(handles.tS+1, 1);
handles.EffortOpout = zeros(handles.tS+1, 1);
handles.FAccOpout = zeros(handles.tS+1, 1);
handles.FROpout = zeros(handles.tS+1, 1);
handles.Eopout = zeros(handles.tS+1, 1);
handles.Gopout = zeros(handles.tS+1, 1);
handles.Current = zeros(handles.NoT2, 1);
handles.Power = zeros(handles.NoT2, 1);
handles.Loss = zeros(handles.tS+1, 1);

[handles.Vout, handles.Xout, handles.DistOpout, handles.EffortOpout, handles.FAccOpout, handles.FROpout, handles.Eopout, handles.Gopout, handles.Loss, handles.DEnergy, handles.BEnergy, handles.Power, handles.Current] = find_n(handles.Vop, handles.tS, handles.xS, handles.vS, handles.InputT2, handles.InputX2, handles.InputX_R, handles.InputV2, handles.InputV_R, handles.TTime, handles.TDistance, handles.MaxSpeed, handles.minusT, handles.plusT, handles.SpeedL, handles.Elevations, handles.Arr, handles.Brr, handles.Crr, handles.TrainMass, handles.ACMPower, handles.MaxTrac, handles.MaxBrake, handles.BRPoint);
set(handles.text12, 'String', num2str(handles.DEnergy));
set(handles.text13, 'String', num2str(handles.BEnergy));
ETotal = handles.BEnergy + handles.DEnergy;
set(handles.text17, 'String', num2str(ETotal));


set(handles.text6, 'String', num2str(handles.EffortOpout(handles.InputT2) / 1000));


PlotX = (1:handles.NoX);
figure(20)
plot((handles.Xout-1) * handles.xstep, (handles.Vout-1) * handles.vstep, 'b-', (PlotX-1) * handles.xstep, handles.SpeedL, 'k:', (PlotX - 1) * handles.xstep, handles.Elevations, 'k--', 'LineWidth', 2);
ylim([-12 200]);
%xlim([handles.InputX_R (handles.NoX * handles.xstep) + 20]);
%axis([0 +inf -10 90]);
xlabel('Distance[m]', 'FontSize', 15);
ylabel('Velocity[Km/h]', 'FontSize', 15);
%ylabel('Gradient[0/00]');
title('Velocity - Distance', 'FontSize', 15);
legend({'Velocity[km/h]', 'Speed Limits[km/h]', 'Elevation[%]'}, 'FontSize', 12);
guidata(hObject, handles);


% hObject    handle to find_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.pop = get(handles.popupmenu1,'value');
guidata(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
plot_time = (handles.InputT2 : handles.NoT2);
%plot_time = (1:handles.NoT2);
V_plot = zeros(handles.NoT2 - handles.InputT2, 1);
X_plot = zeros(handles.NoT2 - handles.InputT2, 1);
Fa_plot = zeros(handles.NoT2 - handles.InputT2, 1);
Ft_plot = zeros(handles.NoT2 - handles.InputT2, 1);
E_plot = zeros(handles.NoT2 - handles.InputT2, 1);
Power_plot = zeros(handles.NoT2 - handles.InputT2, 1);
Current_plot = zeros(handles.NoT2 - handles.InputT2, 1);
Loss_plot = zeros(handles.NoT2 - handles.InputT2, 1);

for i = handles.InputT2 : handles.NoT2
    V_plot(i - handles.InputT2 + 1) = handles.Vout(i);
    X_plot(i - handles.InputT2 + 1) = handles.Xout(i);
    Fa_plot(i - handles.InputT2 + 1) = handles.FAccOpout(i);
    Ft_plot(i - handles.InputT2 + 1) = handles.EffortOpout(i);
    E_plot(i - handles.InputT2 + 1) = handles.Eopout(i);
    Power_plot(i - handles.InputT2 + 1) = handles.Power(i);
    Current_plot(i - handles.InputT2 + 1) = handles.Current(i);
    Loss_plot(i - handles.InputT2 + 1) = handles.Loss(i);
end


switch handles.pop
    case 1
        figure(01)
        plot((plot_time - 1) * handles.tstep , (V_plot - 1) * handles.vstep, 'b-', 'LineWidth', 2);
        xlabel('Time[s]', 'FontSize', 15);
        ylabel('Velocity[km/h]', 'FontSize', 15);
        title('Velocity - Time', 'FontSize', 15);
        grid on;
    case 2
        figure(02)
        xlabel('Time[s]');
        ylabel('Distance[m]');
        title('Distance - Time');
        plot((plot_time - 1) * handles.tstep, (X_plot - 1) * handles.xstep, 'b-*', 'LineWidth', 3);
        grid on;
    case 3
        figure(03)
        xlabel('Time[s]');
        ylabel('TractiveEffort[kN]');
        title('TractiveEffort - Time');
        plot((plot_time - 1) * handles.tstep, Ft_plot, 'b-*');
        grid on;
    case 4
        figure(04)
        xlabel('Time[s]');
        ylabel('Acceleration Rate[m/(s^2)]');
        title('Acceleration Rate - Time');
        plot((plot_time - 1) * handles.tstep, Fa_plot*1000/handles.TrainMass, 'b-*');
        grid on;
    case 5
        figure(05)
        plot((X_plot - 1) * handles.xstep, (V_plot - 1) * handles.vstep, 'b-*');
        xlabel('Distance[m]');
        ylabel('Velocity[km/h]');
        title('Velocity - Distance');
        grid on;
    case 6
        figure(06)
        plot((V_plot - 1) * handles.vstep, Ft_plot, 'b-*');
        xlabel('Velocity[km/h]');
        ylabel('TractiveEffort[kN]');
        title('TractiveEffort - Velocity');
        grid on;
    case 7
        figure(07)
        plot((X_plot - 1) * handles.xstep, Fa_plot / 1000, 'b-', 'LineWidth', 3);
        xlabel('Distance[m]', 'FontSize', 15);
        ylabel('TractiveEffort[kN]', 'FontSize', 15);
        title('Distance/TractiveEffort', 'FontSize', 15);
        grid on;
    case 8
        figure(08)
        plot((plot_time - 1) * handles.tstep, E_plot, 'b-*');
        xlabel('Time[s]');
        ylabel('Energy[J]');
        title('Time/Energy');        
        grid on;
    case 9
        AccumulativeE = zeros(handles.NoT2, 1);
        AccumulativeE(2, 1) = handles.Eopout(1,1);
        for count = 3 : handles.NoT2
            AccumulativeE(count, 1) = AccumulativeE(count - 1, 1) + handles.Eopout(count - 1, 1); 
        end
        figure(09)
        PlotT = (1:handles.NoT2);
        plot((PlotT - 1) * handles.tstep, AccumulativeE * 2.777778 * (10^(-7)), 'b-', 'LineWidth', 2);
        xlabel('Time[s]', 'FontSize', 12);
        ylabel('Total Energy[KwH]', 'FontSize', 15);
        title('Time/Total Energy', 'FontSize', 15);
        legend({'Energy[kWh]'}, 'FontSize', 15);
        grid on;
    case 10
        PlotX = (1:handles.NoX);
        figure(10)
        plot((X_plot - 1) * handles.xstep, Ft_plot, 'b-*', (PlotX - 1) * handles.xstep, handles.SpeedL, 'k:', (PlotX - 1) * handles.xstep, handles.Elevations, 'k--');
        xlabel('Distance[m]');
        ylabel('Tractive Effort[KN]');
        title('Tractive Effort - Distance');
        grid on;
    case 11
        figure(14)
        plot((X_plot - 1) * handles.xstep, Power_plot / 1000, 'b-*');
        xlabel('Distance[m]');
        ylabel('Power[kW]');
        title('Power - Distance');
        grid on;
    case 12
        figure(15)
        plot((V_plot - 1)*handles.vstep, Power_plot / 1000, 'b-*');
        xlabel('Velocity[km/h]');
        ylabel('Power[kW]');
        title('Velocity - Power');
        grid on;
    case 13
        figure(16)
        plot((plot_time - 1) * handles.tstep, Power_plot / 1000, 'b-*');
        xlabel('Time[s]');
        ylabel('Power[kW]');
        title('Power - Time');
        grid on;
    case 14
        figure(17)
        plot((plot_time - 1) * handles.tstep, Current_plot / 1000, 'b-*');
        xlabel('Time[s]');
        ylabel('Current[kA]');
        title('Current - Time');
        grid on;
    case 15
        figure(18)
        plot((plot_time - 1) * handles.tstep, Loss_plot, 'b-*');
        xlabel('Time[s]', 'FontSize', 15);
        ylabel('Loss[kWh]', 'FontSize', 15);
        title('Loss - Time', 'FontSize', 15);
        grid on;
    case 16
        figure(19)
        plot((V_plot - 1)*handles.vstep, Loss_plot * 2.77777777778 / (10^7) , 'b-', 'LineWidth', 2);
        xlabel('Velocity[km/h]', 'FontSize', 15);
        ylabel('Loss[kWh]', 'FontSize', 15);
        title('Velocity - Loss', 'FontSize', 15);
        grid on;
    case 17
        figure(20)
        plot(Ft_plot / 1000, Loss_plot, 'b-*');
        xlabel('Tractive Effort[kN]');
        ylabel('Loss[?]');
        title('Velocity - Loss');
        grid on;
end
guidata(hObject,handles);
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Excel_W.
function Excel_W_Callback(hObject, eventdata, handles)
[Show_FileName, Show_FilePath] = uiputfile('*.xlsx', 'save results as');
Show_File = strcat(Show_FilePath, Show_FileName);
Energy = handles.DEnergy + handles.BEnergy + (handles.ACMPower * handles.TTime / 3600); 
tempo = Exc(handles.Vout, handles.Xout, handles.DistOpout, handles.EffortOpout, handles.FAccOpout, handles.FROpout, handles.Eopout, handles.Gopout, Show_File, handles.tS, handles.tstep, handles.xstep, handles.vstep, Energy);
winopen(Show_File);
guidata(hObject, handles);
% hObject    handle to Excel_W (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
[GS, GS_path] = uigetfile('*.dat', 'Selcet General Solution file');
handles.GS_file = strcat(GS_path, GS);
set(handles.text8, 'String', GS);
guidata(hObject, handles);
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
[Vop, t, x, v, TripTime, TripDistance, Max_speed, Mass, handles.SpeedL, handles.Elevations, handles.minusT, handles.plusT, A, B, C, handles.ACMPower, handles.MaxTrac, handles.MaxBrake, handles.BRPoint] = import_file_int(handles.GS_file);
handles.Vop = Vop;

handles.tS = t;
handles.xS = x;
handles.vS = v;

handles.NoT = t + 1;
handles.NoX = x + 1;
handles.TTime = TripTime;
handles.TDistance = TripDistance;
handles.MaxSpeed = Max_speed;
handles.TrainMass = Mass;
handles.tstep = TripTime / t;
handles.xstep = TripDistance / x;
handles.vstep = Max_speed / v;
handles.Arr = A;
handles.Brr = B;
handles.Crr = C;
handles.plusTstep = round(handles.plusT/handles.tstep);
handles.NoT2 = handles.NoT + handles.plusTstep;
guidata(hObject, handles);

% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
