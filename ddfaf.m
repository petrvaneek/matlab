function varargout = ddfaf(varargin)
% DDFAF MATLAB code for ddfaf.fig
%      DDFAF, by itself, creates a new DDFAF or raises the existing
%      singleton*.
%
%      H = DDFAF returns the handle to a new DDFAF or the handle to
%      the existing singleton*.
%
%      DDFAF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DDFAF.M with the given input arguments.
%
%      DDFAF('Property','Value',...) creates a new DDFAF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ddfaf_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ddfaf_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ddfaf

% Last Modified by GUIDE v2.5 02-Apr-2022 22:36:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ddfaf_OpeningFcn, ...
                   'gui_OutputFcn',  @ddfaf_OutputFcn, ...
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
function statictext_Callback(hObject, eventdata, handles)
% hObject    handle to statictext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of statictext as text
%        str2double(get(hObject,'String')) returns contents of statictext as a double


% --- Executes during object creation, after setting all properties.
function statictext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to statictext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes just before ddfaf is made visible.
function ddfaf_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ddfaf (see VARARGIN)

% Choose default command line output for ddfaf
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ddfaf wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ddfaf_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% --- Executes on button press in nula.
% --- Executes on button press in j.
function j_Callback(hObject, eventdata, handles)
x = get(handles.statictext,'String');
set(handles.statictext,'String',strcat(x,'i'));

function nula_Callback(hObject, eventdata, handles)
% hObject    handle to nula (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.statictext,'String');
set(handles.statictext,'String',strcat(x,'0'));
% Hint: get(hObject,'Value') returns toggle state of nula


% --- Executes on button press in jedna.
function jedna_Callback(hObject, eventdata, handles)
% hObject    handle to jedna (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.statictext,'String');
set(handles.statictext,'String',strcat(x,'1'));

% --- Executes on button press in dva.
function dva_Callback(hObject, eventdata, handles)
% hObject    handle to dva (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.statictext,'String');
set(handles.statictext,'String',strcat(x,'2'));

% --- Executes on button press in tri.
function tri_Callback(hObject, eventdata, handles)
% hObject    handle to tri (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.statictext,'String');
set(handles.statictext,'String',strcat(x,'3'));

% --- Executes on button press in ctyri.
function ctyri_Callback(hObject, eventdata, handles)
% hObject    handle to ctyri (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.statictext,'String');
set(handles.statictext,'String',strcat(x,'4'));

% --- Executes on button press in pet.
function pet_Callback(hObject, eventdata, handles)
% hObject    handle to pet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.statictext,'String');
set(handles.statictext,'String',strcat(x,'5'));

% --- Executes on button press in sest.
function sest_Callback(hObject, eventdata, handles)
% hObject    handle to sest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.statictext,'String');
set(handles.statictext,'String',strcat(x,'6'));

% --- Executes on button press in sedm.
function sedm_Callback(hObject, eventdata, handles)
% hObject    handle to sedm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.statictext,'String');
set(handles.statictext,'String',strcat(x,'7'));

% --- Executes on button press in osm.
function osm_Callback(hObject, eventdata, handles)
% hObject    handle to osm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.statictext,'String');
set(handles.statictext,'String',strcat(x,'8'));

% --- Executes on button press in devet.
function devet_Callback(hObject, eventdata, handles)
% hObject    handle to devet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.statictext,'String');
set(handles.statictext,'String',strcat(x,'9'));
function pluss_Callback(hObject, eventdata, handles)
% hObject    handle to devet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.statictext,'String');
set(handles.statictext,'String',strcat(x,'+'));
function minuss_Callback(hObject, eventdata, handles)
% hObject    handle to devet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.statictext,'String');
set(handles.statictext,'String',strcat(x,'-'));
% --- Executes on button press in pluss.
function plus_Callback(hObject, eventdata, handles)
x = get(handles.statictext,'String');
global a Selector
a = str2num(get(handles.statictext,'String'))
Selector = 1;
set(handles.statictext,'String','');

% --- Executes on button press in minuss.
function minus_Callback(hObject, eventdata, handles)
% hObject    handle to minuss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.statictext,'String');
global a Selector
a = str2num(get(handles.statictext,'String'))
Selector = 2;
set(handles.statictext,'String','');


% --- Executes on button press in delitko.
function delitko_Callback(hObject, eventdata, handles)
% hObject    handle to delitko (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.statictext,'String');
global a Selector
a = str2num(get(handles.statictext,'String'))
Selector = 3;
set(handles.statictext,'String','');


% --- Executes on button press in krat.
function krat_Callback(hObject, eventdata, handles)
% hObject    handle to krat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.statictext,'String');
global a Selector
a = str2num(get(handles.statictext,'String'))
Selector = 4;
set(handles.statictext,'String','');


% --- Executes on button press in desetinnatecka.
function desetinnatecka_Callback(hObject, eventdata, handles)
% hObject    handle to desetinnatecka (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.statictext,'String');
set(handles.statictext,'String',strcat(x,'.'));


% --- Executes on button press in rovnitk
% --- Executes on button press in odmocnina.
function odmocnina_Callback(hObject, eventdata, handles)
% hObject    handle to odmocnina (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.statictext,'String');
global a Selector
a = str2num(get(handles.statictext,'String'))
Selector = 6;
set(handles.statictext,'String','');


% --- Executes on button press in sin.
function sin_Callback(hObject, eventdata, handles)
% hObject    handle to sin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.statictext,'String');
global a Selector
a = str2num(get(handles.statictext,'String'))
Selector = 7;
set(handles.statictext,'String','');


% --- Executes on button press in cos.
function cos_Callback(hObject, eventdata, handles)
% hObject    handle to cos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.statictext,'String');
global a Selector
a = str2num(get(handles.statictext,'String'))
Selector = 8;
set(handles.statictext,'String','');


% --- Executes on button press in tg.
function tg_Callback(hObject, eventdata, handles)
% hObject    handle to tg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.statictext,'String');
global a Selector
a = str2num(get(handles.statictext,'String'))
Selector = 9;
set(handles.statictext,'String','');


% --- Executes on button press in arcsin.
function arcsin_Callback(hObject, eventdata, handles)
% hObject    handle to arcsin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.statictext,'String');
global a Selector
a = str2num(get(handles.statictext,'String'))
Selector = 10;
set(handles.statictext,'String','');


% --- Executes on button press in arccos.
function arccos_Callback(hObject, eventdata, handles)
% hObject    handle to arccos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.statictext,'String');
global a Selector
a = str2num(get(handles.statictext,'String'));
Selector = 11;
set(handles.statictext,'String','');


% --- Executes on button press in cotg.
function cotg_Callback(hObject, eventdata, handles)
% hObject    handle to cotg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.statictext,'String');
global a Selector
a = str2num(get(handles.statictext,'String'));
Selector = 12;
set(handles.statictext,'String','');

% --- Executes on button press in argtan.
function argtan_Callback(hObject, eventdata, handles)
% hObject    handle to argtan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.statictext,'String');
global a Selector
a = str2num(get(handles.statictext,'String'))
Selector = 13;
set(handles.statictext,'String','');


% --- Executes on button press in argcotg.
function argcotg_Callback(hObject, eventdata, handles)
% hObject    handle to argcotg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.statictext,'String');
global a Selector
a = str2num(get(handles.statictext,'String'))
Selector = 14;
set(handles.statictext,'String','');


% --- Executes on button press in del.
function del_Callback(hObject, eventdata, handles)
% hObject    handle to del (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.statictext,'String','');

% --- Executes on button press in AC.
function AC_Callback(hObject, eventdata, handles)
% hObject    handle to AC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.statictext,'String','');

% --- Executes on button press in exp.
function exp_Callback(hObject, eventdata, handles)
% hObject    handle to exp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.statictext,'String');
global a Selector
a = str2num(get(handles.statictext,'String'))
Selector = 15;
set(handles.statictext,'String','');


% --- Executes on button press in logdeset.
function logdeset_Callback(hObject, eventdata, handles)
% hObject    handle to logdeset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.statictext,'String');
global a Selector
a = str2num(get(handles.statictext,'String'))
Selector = 16;
set(handles.statictext,'String','');


% --- Executes on button press in ln.
function ln_Callback(hObject, eventdata, handles)
% hObject    handle to ln (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.statictext,'String');
global a Selector
a = str2num(get(handles.statictext,'String'))
Selector = 17;
set(handles.statictext,'String','');


% --- Executes on button press in nadruhou.
function nadruhou_Callback(hObject, eventdata, handles)
% hObject    handle to nadruhou (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.statictext,'String');
global a Selector
a = str2num(get(handles.statictext,'String'))
Selector = 18;
set(handles.statictext,'String','');
function rovnitko_Callback(hObject, eventdata, handles)
% hObject    handle to rovnitko (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a Selector
switch Selector
    case 1
        a = a+str2num(get(handles.statictext,'String'));
        set(handles.statictext, 'String',num2str(a));
    case 2
        a = a-str2num(get(handles.statictext,'String'));
        set(handles.statictext, 'String',num2str(a));
    case 3
        a = a/str2num(get(handles.statictext,'String'));
        set(handles.statictext, 'String',num2str(a));
    case 4
        a = a*str2num(get(handles.statictext,'String'));
        set(handles.statictext, 'String',num2str(a));
    case 6
        a = sqrt(str2num(get(handles.statictext,'String')));
        set(handles.statictext, 'String',num2str(a));
    case 7
        a = sin(str2num(get(handles.statictext,'String')));
        set(handles.statictext, 'String',num2str(a));
    case 8
        a = cos(str2num(get(handles.statictext,'String')));
        set(handles.statictext, 'String',num2str(a));
    case 9
        a = tan(str2num(get(handles.statictext,'String')));
        set(handles.statictext, 'String',num2str(a));
    case 10
        a = asin(str2num(get(handles.statictext,'String')));
        set(handles.statictext, 'String',num2str(a));
    case 11
        a = acos(str2num(get(handles.statictext,'String')));
        set(handles.statictext, 'String',num2str(a));
    case 12
        a = cot(str2num(get(handles.statictext,'String')));
        set(handles.statictext, 'String',num2str(a));
    case 13
        a = atan(str2num(get(handles.statictext,'String')));
        set(handles.statictext, 'String',num2str(a));
    case 14
        a = acot(str2num(get(handles.statictext,'String')));
        set(handles.statictext, 'String',num2str(a));
    case 15
        a = exp(str2num(get(handles.statictext,'String')));
        set(handles.statictext, 'String',num2str(a));
    case 16
        a = log10(str2num(get(handles.statictext,'String')));
        set(handles.statictext, 'String',num2str(a));
    case 17
        a = log(str2num(get(handles.statictext,'String')));
        set(handles.statictext, 'String',num2str(a));
    case 18
        a = a^str2num(get(handles.statictext,'String'));
        set(handles.statictext, 'String',num2str(a));
end
