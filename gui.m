function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 16-Apr-2015 21:25:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @gui_OpeningFcn, ...
    'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)
% Choose default command line output for gui
handles.current_data = '';
set(handles.pushbutton2,'Enable','off')
set(handles.iteracje_Edit,'String',sprintf('%s:\n','Iterations'))
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.pushbutton2,'Enable','off'); % wylaczenie przycisku "compute"
handles.results = '';
handles.start_x1 = 'x1';
handles.start_x2 = 'x2';
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in functionList.
function functionList_Callback(hObject, eventdata, handles)
% hObject    handle to functionList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = get(hObject,'Value');
str = get(hObject,'String');
handles.current_data = str{contents};
guidata(hObject, handles); %Jezeli zapisujemy jakas zmienna to trzeba uzyc
%tej funkcji, zeby byla ona widoczna w innych
%miejscach

% Hints: contents = cellstr(get(hObject,'String')) returns functionList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from functionList


% --- Executes during object creation, after setting all properties.
function functionList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to functionList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in drawButton.
function drawButton_Callback(hObject, eventdata, handles)
% hObject    handle to drawButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x=-2:0.001:2;
switch handles.current_data
    case 'Function with four local minima'
        [handles.results]=i_1_FourLocalMinima();
        set(handles.functionEquation,'String','x1^4+x2^4-0.62*x1^2-0.62*x2^2')
    case 'Rosenbrock function'
        [handles.results]=Function_RosenBrock();
        set(handles.functionEquation,'String','100*(x2-x1^2)^2+(1-x1)^2');
    case 'Goldsteina-Price function with four local minima'
        [handles.results]=Goldstein_price();
        set(handles.functionEquation,'String','(30+(1+(x1 + x2 + 1)^2)*19 - 14*x1 + 3*x1^2 - 14*x2 + 6*x1*x2 + 3*x2^2...');
    case 'Himmelblau modified function'
        [handles.results]=Himmelblau();
        set(handles.functionEquation,'String','(x1^2 + x2 - 11)^2 + (x1 + x2^2 - 7)^2');
    case 'Ackley function'
        [handles.results]=Ackley();
        set(handles.functionEquation,'String','-a*e(-b*sqrt((x1^2 + x2^2)/2)-e((cos(c*x1) + cos(c*x2))/2)+a+e');
    case 'Rastrigin function'
        [handles.results]=Rastrigin();
        set(handles.functionEquation,'String','x1^2 + x2^2 - 10*cos(2*pi*x1) - 10*cos(2*pi*x2) + 20');
end

guidata(hObject,handles); %update "handles'ow"
if (isempty(handles.results) | handles.start_x1 == 'x1' | handles.start_x2 == 'x2')  %sprawdzanie czy mamy jakies dane zapiane, zeby je przeliczyc
    set(handles.pushbutton2,'Enable','off') %brak danych - przucisk calculate wylaczony
else
    set(handles.pushbutton2,'Enable','on') %dane zeskladowane - mozna liczyc :)
end

function functionEquation_Callback(hObject, eventdata, handles)
% hObject    handle to functionEquation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of functionEquation as text
%        str2double(get(hObject,'String')) returns contents of functionEquation as a double


% --- Executes during object creation, after setting all properties.
function functionEquation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to functionEquation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function parametersEdit_Callback(hObject, eventdata, handles)
% hObject    handle to parametersEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of parametersEdit as text
%        str2double(get(hObject,'String')) returns contents of parametersEdit as a double


% --- Executes during object creation, after setting all properties.
function parametersEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to parametersEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function OwnFunction_Callback(hObject, eventdata, handles)
% hObject    handle to OwnFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
syms x y x1 x2 x3
f = get(hObject,'String');
symvar(f) %wykrywa symbole zdefiniowane w funkcji zadanej
ezmesh(f); %rysuje funkcje symboliczne
title([]); %usuwa tytu� dla ezmesh. jakis lipny strasznie si� pojawia
handles.results = sym(f);
guidata(hObject,handles); %update "handles'ow"
set(handles.functionEquation,'String',f);
if (isempty(handles.results) | handles.start_x1 == 'x1' | handles.start_x2 == 'x2')  %sprawdzanie czy mamy jakies dane zapiane, zeby je przeliczyc
    set(handles.pushbutton2,'Enable','off') %brak danych - przucisk calculate wylaczony
else
    set(handles.pushbutton2,'Enable','on') %dane zeskladowane - mozna liczyc :)
end


% Hints: get(hObject,'String') returns contents of OwnFunction as text
%        str2double(get(hObject,'String')) returns contents of OwnFunction as a double


% --- Executes during object creation, after setting all properties.
function OwnFunction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OwnFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double
x2 = str2double(get(hObject,'String'));
handles.start_x2 = x2; %zachowywanie punktu startowego x2
guidata(hObject,handles); %update "handles'ow"
if (isempty(handles.results) | handles.start_x1 == 'x1' | handles.start_x2 == 'x2')  %sprawdzanie czy mamy jakies dane zapiane, zeby je przeliczyc
    set(handles.pushbutton2,'Enable','off') %brak danych - przucisk calculate wylaczony
else
    set(handles.pushbutton2,'Enable','on') %dane zeskladowane - mozna liczyc :)
end

% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double
x1 = str2double(get(hObject,'String'));
handles.start_x1 = x1; %zachowywanie punktu startowego x1
guidata(hObject,handles); %update "handles'ow"
if (isempty(handles.results) | handles.start_x1 == 'x1' | handles.start_x2 == 'x2')  %sprawdzanie czy mamy jakies dane zapiane, zeby je przeliczyc
    set(handles.pushbutton2,'Enable','off') %brak danych - przucisk calculate wylaczony
else
    set(handles.pushbutton2,'Enable','on') %dane zeskladowane - mozna liczyc :)
end


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
y=handles.results;
syms x x1 x2 x3;
G=gradient(y);         %liczy gradient symbolicznie
H=hessian(y, [x1 x2]); %liczy hessian symbolicznie

%obliczanie kierunku z metody newtona - d
d = -inv(H)*G;

X_temp = [handles.start_x1; handles.start_x2];
tekst=[];
%parametry metody newtona
epsilon = 10^-10;        %warunek stopu (1)
licznik_iteracji = 0;   %warunek stopu (2)
max_iteracji = 100;
%%%%%%%%%%%%%%%%%%%%%%%%%

%parametry metody Goldstein'a
t_l=0; %wspolczynniki kroku
t_r=9;
beta = 0.25; %wspolczynnik testu
licznik_iteracji_goldstein = 0;   %warunek stopu (2)
max_iteracji_goldstein = 10;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%% tutaj powinna byc petla calego algorytmu %%%%%%%%%%
X= X_temp;
while 1
    %zachowamy sobie w pamieci d jako rownania symboliczne, a podstawiac
    %bedziemy konkretne punkty do zmiennej d_val
    d_val = evaluated_fx(d, X); %liczy wartosc kieruneku w punktach x1, x2
    
    if(d_val'*d_val <= epsilon || licznik_iteracji>max_iteracji) %gradient jest wystarczajaco blisko zera
        %(tzn. zerowy spadek w kazdym kierunku a wiec minimum)
        break
    end
    
    %%%%%%%%%% %metoda nimum w kierunku %%%%%%%%%%%%%%
    licznik_iteracji_goldstein = 0; %zerowanie licznika iteracji dla minimum w kierunku
    
    % krok 1 - oblicz pochodna w kierunku
    p=evaluated_fx(G, X)'*d_val;
    while 1
        % krok 2 - obliczanie f(x0) oraz f(x0+ td);
        t=0.5*(t_l+t_r);
        f_x_td=evaluated_fx(y, X + t*d_val);
        f_x = evaluated_fx(y, X);
        % krok 3 - sprawdzanie warunku mniejszosci/wiekszosci
        if(f_x_td < (f_x + (1-beta)*p*t))
            t_l=t
        else
            % krok 4 - t_r => t
            if(f_x_td > (f_x + beta*p*t))                
                t_r=t;              
            else
                break
            end
        end
        if(licznik_iteracji_goldstein>max_iteracji_goldstein)
            break
        end
        %zwiekszanie licznika iteracji dla petli minimum w kierunku
        licznik_iteracji_goldstein=licznik_iteracji_goldstein+1;
    end
    alfa = t;
    %%%%%%%%%% %metoda nimum w kierunku %%%%%%%%%%%%%%
    
    X = X+alfa*d_val;
    
    licznik_iteracji=licznik_iteracji+1
    tekst =[tekst, sprintf('%d:   %d ',licznik_iteracji,X)];
     tekst =[tekst, sprintf('\n')];
    set(handles.iteracje_Edit,'String',tekst)
end
X
set(handles.result_Edit,'String',num2str(X))
tekst
%%%%%% tutaj powinna byc petla calego algorytmu %%%%%%%%%%



function iteracje_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to iteracje_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iteracje_Edit as text
%        str2double(get(hObject,'String')) returns contents of iteracje_Edit as a double


% --- Executes during object creation, after setting all properties.
function iteracje_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iteracje_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function result_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to result_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of result_Edit as text
%        str2double(get(hObject,'String')) returns contents of result_Edit as a double


% --- Executes during object creation, after setting all properties.
function result_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to result_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
