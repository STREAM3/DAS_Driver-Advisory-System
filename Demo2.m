% Nima Ghaviha (nima.ghaviha@mdh.se)
% 2016-10-17
% The function for the offline calculation GUI. 



function varargout = Demo2(varargin)
% DEMO2 MATLAB code for Demo2.fig
%      DEMO2, by itself, creates a new DEMO2 or raises the existing
%      singleton*.
%
%      H = DEMO2 returns the handle to a new DEMO2 or the handle to
%      the existing singleton*.
%
%      DEMO2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEMO2.M with the given input arguments.
%
%      DEMO2('Property','Value',...) creates a new DEMO2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Demo2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Demo2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Demo2

% Last Modified by GUIDE v2.5 18-Jul-2016 11:35:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Demo2_OpeningFcn, ...
                   'gui_OutputFcn',  @Demo2_OutputFcn, ...
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


% --- Executes just before Demo2 is made visible.
function Demo2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Demo2 (see VARARGIN)

% Choose default command line output for Demo2
handles.Accuracy = 1;
handles.pop = 1;
axes(handles.axes2);
Bombardier_Logo = imread('bombardier.jpg');
image(Bombardier_Logo);
axis off;

axes(handles.axes3);
MDH_Logo = imread('MDH-logo.jpg');
image(MDH_Logo);
axis off;

axes(handles.axes4);
MDH_Logo = imread('SICS.jpg');
image(MDH_Logo);
axis off;

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Demo2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Demo2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when selected object is changed in uipanel1.
function uipanel1_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel1 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
switch get(eventdata.NewValue, 'Tag')
    case 'radiobutton12'
        handles.Accuracy = 12;
    case 'radiobutton13'
        handles.Accuracy = 13;
end
guidata(hObject,handles);
        


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



switch handles.Accuracy
    case 12
        tS = str2double(handles.InputNoT);
        xS = str2double(handles.InputNoX);
        vS = str2double(handles.InputNoV);
    case 13
        tS = round(handles.TTime2 / str2double(handles.InputTstep));
        xS = round(handles.TDistance2 / str2double(handles.InputXstep));
        vS = round(handles.MaxSpeed2 / str2double(handles.InputVstep));
end
handles.vstep = handles.MaxSpeed2 / vS;
handles.tstep = handles.TTime2 / tS;
handles.xstep = handles.TDistance2 / xS;

handles.PlusTstep = round(handles.PlusT2 / handles.tstep);
handles.MinusTstep = round(handles.MinusT2 / handles.tstep);
handles.NoT2 = tS + handles.PlusTstep + 1;

handles.Vop = zeros(handles.NoT2, xS+1, vS + 1);
CalTime = 0;
handles.SpeedL = zeros(xS+1, 1);
handles.Elevations = zeros(xS+1, 1);



[handles.Vop, CalTime, handles.SpeedL, handles.Elevations] = main(tS, xS, vS, handles.TTime2, handles.TDistance2, handles.RRA2, handles.RRB2, handles.RRC2, handles.TrainMass2, handles.MaxTractiveEffort2, handles.MaxBrakingEffort2, handles.BreakingPoint2, handles.MaxSpeed2, handles.Elev2, handles.SL2, handles.MinusT2, handles.PlusT2, handles.ACMPower2);
set(handles.text1, 'String', num2str(CalTime));

guidata(hObject, handles);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
switch handles.Accuracy
    case 12
        tS = str2double(handles.InputNoT);
        xS = str2double(handles.InputNoX);
        vS = str2double(handles.InputNoV);        
        %set(handles.text1, 'String', '3');
    case 13
        tS = round(handles.TTime2 / str2double(handles.InputTstep));
        xS = round(handles.TDistance2 / str2double(handles.InputXstep));
        vS = round(handles.MaxSpeed2 / str2double(handles.InputVstep));        
end
handles.NoT = tS+1;
handles.NoX = xS+1;
tstep_find = handles.TTime2/tS;
xstep_find = handles.TDistance2/xS;
vstep_find = handles.MaxSpeed2/vS;
handles.InputT2 = round(str2double(handles.InputT)/tstep_find) + 1;
handles.InputX2 = round(str2double(handles.InputX)/xstep_find) + 1;
handles.InputV2 = round(str2double(handles.InputV)/vstep_find) + 1;

handles.InputX_R = str2double(handles.InputX)/xstep_find + 1;
handles.InputV_R = str2double(handles.InputV)/vstep_find + 1;

handles.Vout = zeros(handles.NoT2, 1);
handles.Xout = zeros(handles.NoT2, 1);
handles.DistOpout = zeros(handles.NoT2, 1);
handles.EffortOpout = zeros(handles.NoT2, 1);
handles.FAccOpout = zeros(handles.NoT2, 1);
handles.FROpout = zeros(handles.NoT2, 1);
handles.Eopout = zeros(handles.NoT2, 1);
handles.Gopout = zeros(handles.NoT2, 1);
handles.Current = zeros(handles.NoT2, 1);
handles.Power = zeros(handles.NoT2, 1);
handles.Loss = zeros(handles.NoT2, 1);
handles.DEnergy = 0;
handles.BEnergy = 0;

[handles.Vout, handles.Xout, handles.DistOpout, handles.EffortOpout, handles.FAccOpout, handles.FROpout, handles.Eopout, handles.Gopout, handles.Loss, handles.DEnergy, handles.BEnergy, handles.Power, handles.Current] = find_n(handles.Vop, tS, xS, vS, handles.InputT2, handles.InputX2, handles.InputX_R, handles.InputV2, handles.InputV_R, handles.TTime2, handles.TDistance2, handles.MaxSpeed2, handles.MinusT2, handles.PlusT2, handles.SpeedL, handles.Elevations, handles.RRA2, handles.RRB2, handles.RRC2, handles.TrainMass2, handles.ACMPower2, handles.MaxTractiveEffort2, handles.MaxBrakingEffort2, handles.BreakingPoint2);


set(handles.text44, 'String', num2str(handles.DEnergy));
set(handles.text45, 'String', num2str(handles.BEnergy));
ETotal = handles.BEnergy + handles.DEnergy;
set(handles.text54, 'String', num2str(ETotal));

set(handles.text34, 'String', num2str(handles.EffortOpout(handles.InputT2)/1000));
toc
set(handles.text2, 'String', 'Done!');
axes(handles.axes1);
PlotX = (1:handles.NoX); 
PlotElev = adjust_elevations(handles.TDistance2, xstep_find, handles.Elev2);
PlotSpeed = adjust_speed(handles.TDistance2, xstep_find, handles.SL2);

plot((handles.Xout - 1) * handles.xstep, (handles.Vout - 1)*handles.vstep, 'b-*', (PlotX - 1) * handles.xstep, PlotSpeed, 'r:', (PlotX - 1) * handles.xstep, PlotElev, 'k--');
xlabel('Distance[m]');
ylabel('Velocity[Km/h]');
title('Velocity - Distance');
figure(12)
plot((handles.Xout - 1) * handles.xstep, (handles.Vout - 1)*handles.vstep, 'b-*', (PlotX - 1) * handles.xstep, PlotSpeed, 'r:', (PlotX - 1) * handles.xstep, PlotElev, 'k--');
xlabel('Distance[m]');
ylabel('Velocity[Km/h]');
title('Velocity - Distance');

guidata(hObject,handles);



function TripTime_Callback(hObject, eventdata, handles)
% hObject    handle to TripTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.TTime = get(hObject, 'String');
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of TripTime as text
%        str2double(get(hObject,'String')) returns contents of TripTime as a double


% --- Executes during object creation, after setting all properties.
function TripTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TripTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TripDistance_Callback(hObject, eventdata, handles)
% hObject    handle to TripDistance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.TDistance = get(hObject, 'String');
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of TripDistance as text
%        str2double(get(hObject,'String')) returns contents of TripDistance as a double


% --- Executes during object creation, after setting all properties.
function TripDistance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TripDistance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SL_Open.
function SL_Open_Callback(hObject, eventdata, handles)
% hObject    handle to SL_Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[sl, SL_path] = uigetfile('*.xlsx', 'Selcet Speed Limits file');
set(handles.text36, 'String', sl);
handles.SL = strcat(SL_path, sl);
guidata(hObject, handles);



% --- Executes on button press in Elev_Open.
function Elev_Open_Callback(hObject, eventdata, handles)
% hObject    handle to Elev_Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[elev, Elev_path] = uigetfile('*.xlsx', 'Select Elevations file');
set(handles.text38, 'String', elev);
handles.Elev = strcat(Elev_path, elev);
guidata(hObject, handles);


% --- Executes on button press in input.
function input_Callback(hObject, eventdata, handles)
% hObject    handle to input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Elev2 = handles.Elev;
handles.SL2 = handles.SL;
handles.TTime2 = str2double(handles.TTime);
handles.TDistance2 = str2double(handles.TDistance) * 1000;

handles.MinusT2 = str2double(handles.MinusT);
handles.PlusT2 = str2double(handles.PlusT);

handles.RRA2 = str2double(handles.RRA);
handles.RRB2 = str2double(handles.RRB);
handles.RRC2 = str2double(handles.RRC);

handles.TrainMass2 = str2double(handles.TrainMass) * 1000;
handles.MaxTractiveEffort2 = str2double(handles.MaxTractiveEffort) * 1000;
handles.MaxBrakingEffort2 = str2double(handles.MaxBrakingEffort) * 1000;
handles.BreakingPoint2 = str2double(handles.BreakingPoint);
handles.MaxSpeed2 = str2double(handles.MaxSpeed);

handles.ACMPower2 = str2double(handles.ACMPower);


if isnan(handles.MinusT2)
    handles.MinusT2 = 0;
end
if isnan(handles.PlusT2)
    handles.PlusT2 = 0;
end
if isnan(handles.RRA2)
    handles.RRA2 = 2222;
end
if isnan(handles.RRB2)
    handles.RRB2 = 5.25;
end
if isnan(handles.RRC2)
    handles.RRC2 = 0.508;
end
if isnan(handles.TrainMass2)
    handles.TrainMass2 = 184110;
end
if isnan(handles.MaxTractiveEffort2)
    handles.MaxTractiveEffort2 = 100000;
end
if isnan(handles.MaxBrakingEffort2)
    handles.MaxBrakingEffort2 = 100000;
end
if isnan(handles.BreakingPoint2)
    handles.BreakingPoint2 = 40;
end
if isnan(handles.MaxSpeed2)
    handles.MaxSpeed2 = 80;
end
if isnan(handles.ACMPower2)
    handles.MaxSpeed2 = 80;
end

guidata(hObject,handles);



function RRA_Callback(hObject, eventdata, handles)
% hObject    handle to RRA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.RRA = get(hObject, 'String');
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of RRA as text
%        str2double(get(hObject,'String')) returns contents of RRA as a double


% --- Executes during object creation, after setting all properties.
function RRA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RRA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RRB_Callback(hObject, eventdata, handles)
% hObject    handle to RRB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.RRB = get(hObject, 'String');
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of RRB as text
%        str2double(get(hObject,'String')) returns contents of RRB as a double


% --- Executes during object creation, after setting all properties.
function RRB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RRB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RRC_Callback(hObject, eventdata, handles)
% hObject    handle to RRC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.RRC = get(hObject, 'String');
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of RRC as text
%        str2double(get(hObject,'String')) returns contents of RRC as a double


% --- Executes during object creation, after setting all properties.
function RRC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RRC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TrainMass_Callback(hObject, eventdata, handles)
% hObject    handle to TrainMass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.TrainMass = get(hObject, 'String');
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of TrainMass as text
%        str2double(get(hObject,'String')) returns contents of TrainMass as a double


% --- Executes during object creation, after setting all properties.
function TrainMass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TrainMass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MaxTractiveEffort_Callback(hObject, eventdata, handles)
% hObject    handle to MaxTractiveEffort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.MaxTractiveEffort = get(hObject, 'String');
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of MaxTractiveEffort as text
%        str2double(get(hObject,'String')) returns contents of MaxTractiveEffort as a double


% --- Executes during object creation, after setting all properties.
function MaxTractiveEffort_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MaxTractiveEffort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MaxBrakingEffort_Callback(hObject, eventdata, handles)
% hObject    handle to MaxBrakingEffort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.MaxBrakingEffort = get(hObject, 'String');
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of MaxBrakingEffort as text
%        str2double(get(hObject,'String')) returns contents of MaxBrakingEffort as a double


% --- Executes during object creation, after setting all properties.
function MaxBrakingEffort_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MaxBrakingEffort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function BreakingPoint_Callback(hObject, eventdata, handles)
% hObject    handle to BreakingPoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.BreakingPoint = get(hObject, 'String');
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of BreakingPoint as text
%        str2double(get(hObject,'String')) returns contents of BreakingPoint as a double


% --- Executes during object creation, after setting all properties.
function BreakingPoint_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BreakingPoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MaxSpeed_Callback(hObject, eventdata, handles)
% hObject    handle to MaxSpeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.MaxSpeed = get(hObject, 'String');
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of MaxSpeed as text
%        str2double(get(hObject,'String')) returns contents of MaxSpeed as a double


% --- Executes during object creation, after setting all properties.
function MaxSpeed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MaxSpeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.pop = get(handles.popupmenu2,'value');


guidata(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
plot_time = (handles.InputT2 : handles.NoT2);
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
        figure(1)
        plot((plot_time - 1) * handles.tstep , (V_plot - 1)*handles.vstep, 'b-*');
        xlabel('Time[s]');
        ylabel('Velocity[km/h]');
        title('Velocity - Time');
        grid on;
    case 2
        figure(2)
        xlabel('Time[s]');
        ylabel('Distance[m]');
        title('Distance - Time');
        plot((plot_time - 1) * handles.tstep, (X_plot - 1) * handles.xstep, 'b-*');
        grid on;
    case 3
        figure(3)
        xlabel('Time[s]');
        ylabel('TractiveEffort[kN]');
        title('TractiveEffort - Time');
        plot((plot_time - 1) * handles.tstep, Ft_plot / 1000, 'b-*');
        grid on;
    case 4
        figure(4)
        xlabel('Time[s]');
        ylabel('Acceleration Rate[m/(s^2)]');
        title('Acceleration Rate - Time');
        plot((plot_time - 1) * handles.tstep, Fa_plot*1000/handles.TrainMass2, 'b-*');
        grid on;
    case 5
        figure(5)
        plot((handles.Xout - 1) * handles.xstep, (V_plot - 1)*handles.vstep, 'b-*');
        xlabel('Distance[m]');
        ylabel('Velocity[km/h]');
        title('Velocity - Distance');
        grid on;
    case 6
        figure(6)
        plot((V_plot - 1)*handles.vstep, Ft_plot / 1000, 'b-*');
        xlabel('Velocity[km/h]');
        ylabel('TractiveEffort[kN]');
        title('TractiveEffort - Velocity');
        grid on;
    case 7
        figure(7)
        plot((handles.Xout - 1) * handles.xstep, handles.EffortOpout / 1000, 'b-*');
        xlabel('Distance[m]');
        ylabel('TractiveEffort[KN]');
        title('Distance/TractiveEffort');
        grid on;
    case 8
        figure(8)
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
        PlotT = (1:handles.NoT2);
        figure(9)
        plot((PlotT - 1) * handles.tstep, AccumulativeE * 2.777778 * (10^(-7)), 'b-*');
        xlabel('Time[s]');
        ylabel('Total Energy[KwH]');
        title('Time/Total Energy');
        grid on;
    case 10
        PlotX = (1:handles.NoX);
        figure(10)
        plot((X_plot - 1) * handles.xstep, Ft_plot / 1000, 'b-*', (PlotX - 1) * handles.xstep, handles.SpeedL, 'k:', (PlotX - 1) * handles.xstep, handles.Elevations, 'k--');
        xlabel('Distance[m]');
        ylabel('Tractive Effort[kN]');
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
        plot((plot_time - 1) * handles.tstep, Loss_plot , 'b-*');
        xlabel('Time[s]');
        ylabel('Loss[?]');
        title('Loss - Time');
        grid on;
    case 16
        figure(19)
        plot((V_plot - 1)*handles.vstep, Loss_plot, 'b-*');
        xlabel('Velocity[km/h]');
        ylabel('Loss[?]');
        title('Velocity - Loss');
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


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch handles.Accuracy
    case 12
        tS = str2double(handles.InputNoT);
        xS = str2double(handles.InputNoX);
        vS = str2double(handles.InputNoV);
    case 13
        tS = round(handles.TTime2 / str2double(handles.InputTstep));
        xS = round(handles.TDistance2 / str2double(handles.InputXstep));
        vS = round(handles.MaxSpeed2 / str2double(handles.InputVstep));        
end
[Show_FileName, Show_FilePath] = uiputfile('*.xlsx', 'save results as');
Show_File = strcat(Show_FilePath, Show_FileName);
Energy = handles.DEnergy + handles.BEnergy + (handles.ACMPower2 * handles.TTime2 / 3600); 
tempo = Exc(handles.Vout, handles.Xout, handles.DistOpout, handles.EffortOpout, handles.FAccOpout, handles.FROpout, handles.Eopout, handles.Gopout, Show_File, tS, handles.tstep, handles.xstep, handles.vstep, Energy);
winopen(Show_File);
guidata(hObject, handles);



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


function inputNoT_Callback(hObject, eventdata, handles)
% hObject    handle to inputNoT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.InputNoT = get(hObject, 'String');
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of inputNoT as text
%        str2double(get(hObject,'String')) returns contents of inputNoT as a double


% --- Executes during object creation, after setting all properties.
function inputNoT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputNoT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inputNoX_Callback(hObject, eventdata, handles)
% hObject    handle to inputNoX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.InputNoX = get(hObject, 'String');
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of inputNoX as text
%        str2double(get(hObject,'String')) returns contents of inputNoX as a double


% --- Executes during object creation, after setting all properties.
function inputNoX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputNoX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inputNoV_Callback(hObject, eventdata, handles)
% hObject    handle to inputNoV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.InputNoV = get(hObject, 'String');
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of inputNoV as text
%        str2double(get(hObject,'String')) returns contents of inputNoV as a double


% --- Executes during object creation, after setting all properties.
function inputNoV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputNoV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.MinusT = get(hObject, 'String');
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.PlusT = get(hObject, 'String');
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.InputTstep = get(hObject, 'String');
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.InputXstep = get(hObject, 'String');
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.InputVstep = get(hObject, 'String');
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.AccNotches = get(hObject, 'String');
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit23_Callback(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.DecNotches = get(hObject, 'String');
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of edit23 as text
%        str2double(get(hObject,'String')) returns contents of edit23 as a double


% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch handles.Accuracy
    case 12
        tS = str2double(handles.InputNoT);
        xS = str2double(handles.InputNoX);
        vS = str2double(handles.InputNoV);
    case 13
        tS = round(handles.TTime2 / str2double(handles.InputTstep));
        xS = round(handles.TDistance2 / str2double(handles.InputXstep));
        vS = round(handles.MaxSpeed2 / str2double(handles.InputVstep));        
end

[GS_FileName, GS_FilePath] = uiputfile('*.dat', 'save General Solution as');
GS_File = strcat(GS_FilePath, GS_FileName);
temp = Export_file_int(handles.Vop, tS, xS, vS, handles.TTime2, handles.TDistance2, handles.MaxSpeed2, handles.TrainMass2, handles.SpeedL, handles.Elevations, GS_File, handles.MinusT2, handles.PlusT2, handles.RRA2, handles.RRB2, handles.RRC2, handles.ACMPower2, handles.MaxTractiveEffort2, handles.MaxBrakingEffort2, handles.BreakingPoint2);


guidata(hObject, handles);



function edit24_Callback(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.ACMPower = get(hObject, 'String');
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of edit24 as text
%        str2double(get(hObject,'String')) returns contents of edit24 as a double


% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
