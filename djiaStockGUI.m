%Daniel Katz Lab LI
%ES-2 Final Project
%djiaStockGUI.m is a tabbed user interface
%The first tab is 'DJIA Predictor'. In this tab the user is able to use
%a model that predicts future values for the Dow Jones Industrial Average.
%The model takes an input of past days and calculates the values over an
%inputted number of future days
%The second tab is 'Stock Charter'. In this tabh the user is able to choose
%from either a pre-determined list of stocks or input their own. They can 
%chart the stock over one of four pre-determined time interval. They can 
%also calculate hypothetical profit and returns on a number of shares of 
%the stock bought and sold at user inputted dates

function varargout = djiaStockGUI(varargin)
% DJIASTOCKGUI MATLAB code for djiaStockGUI.fig
%      DJIASTOCKGUI, by itself, creates a new DJIASTOCKGUI or raises the existing
%      singleton*.
%
%      H = DJIASTOCKGUI returns the handle to a new DJIASTOCKGUI or the handle to
%      the existing singleton*.
%
%      DJIASTOCKGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DJIASTOCKGUI.M with the given input arguments.
%
%      DJIASTOCKGUI('Property','Value',...) creates a new DJIASTOCKGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before djiaStockGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to djiaStockGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help djiaStockGUI

% Last Modified by GUIDE v2.5 09-May-2016 19:17:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @djiaStockGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @djiaStockGUI_OutputFcn, ...
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

%Closes any open windows before GUI opens
function closeStuff(~)
close all


% --- Executes just before djiaStockGUI is made visible.
function djiaStockGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to djiaStockGUI (see VARARGIN)

% Choose default command line output for djiaStockGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%Tabs are created
handles.tgroup = uitabgroup('Parent', handles.figure1,'TabLocation', 'top');
handles.tab1 = uitab('Parent', handles.tgroup, 'Title', 'DJIA Predictor');
handles.tab2 = uitab('Parent', handles.tgroup, 'Title', 'Stock Charter');

%Place panels into each tab
set(handles.P1,'Parent',handles.tab1)
set(handles.P2,'Parent',handles.tab2)

%Data for portfolio
%Stock tickers for portfolio are set
stockTickers = {'AAPL' 'FB' 'GOOG' 'MSFT' 'NKE'};

%Size of dataTable is pre-allocated
dataTable = zeros(5,1);

%For each stock ticker, current stock value is obtained
for n = 1:length(stockTickers)
    stockTicker = char(stockTickers(n));
    stockData = stockWebPull(stockTicker,'1-year');
    stockData(:,2:6) = [];
    stockData = table2struct(stockData);
    stockData = struct2dataset(stockData);
    adjClose = stockData.AdjClose;
    adjClose = flipud(adjClose);
    dataTable(n) = adjClose(end);
end

%Data is put into portfolio
set(handles.portfolioTable,'data',dataTable);
%closes any open axes
arrayfun(@cla,findall(0,'type','axes'))
%Reposition each panel to same location as panel 1
set(handles.P2,'position',get(handles.P1,'position'));
% UIWAIT makes djiaStockGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = djiaStockGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function pastDaysText_Callback(hObject, eventdata, handles)
% hObject    handle to pastDaysText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pastDaysText as text
%        str2double(get(hObject,'String')) returns contents of pastDaysText as a double


% --- Executes during object creation, after setting all properties.
function pastDaysText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pastDaysText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function futureDaysText_Callback(hObject, eventdata, handles)
% hObject    handle to futureDaysText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of futureDaysText as text
%        str2double(get(hObject,'String')) returns contents of futureDaysText as a double


% --- Executes during object creation, after setting all properties.
function futureDaysText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to futureDaysText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in djiaPush1.
function djiaPush1_Callback(hObject, eventdata, handles)
% hObject    handle to djiaPush1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Entered number of past days is obtained and converted to a double
pastDays = get(handles.pastDaysText,'String');
pastDaysNum = str2double(pastDays);

%Entered number of future days is obtained and converted to a double
futureDays = get(handles.futureDaysText,'String');
futureDaysNum = str2double(futureDays);

%Numbers are entered into the djia prediction model
[modelVals,timeVec,adjReal] = djiaModel(pastDaysNum,futureDaysNum);
timeVec = x2mdate(timeVec,0);
%Time vector for 'zoomed in' graph is set
poop = length(timeVec);
zoomFactor = 20 + futureDaysNum;
zoomStart = poop - zoomFactor;
zoomTimeVec = timeVec(1:zoomFactor);
%Real values and model values for 'zoomed in' graph is obtained
% zoomAdjReal = adjReal(zoomTimeVec);
% zoomModelVals = modelVals(zoomTimeVec);
zoomAdjReal = flipud(adjReal(zoomStart+1:end));
zoomModelVals = flipud(modelVals(zoomStart+1:end));
% adjReal = flipud(adjReal);
% modelVals = flipud(modelVals);
adjReal = flipud(adjReal);
modelVals = flipud(modelVals);
%Real values vs Model values is plotted on the 'zoomed out' axes
% plot(handles.djiaAxes1,timeVec,adjReal,timeVec,modelVals)
plot(handles.djiaAxes1,timeVec,adjReal,timeVec,modelVals)
datetickzoom(handles.djiaAxes1,'x','mm/dd/yy')

%Data cursor converts date numbers on x-axis to regular date format
dcm_obj = datacursormode(gcf);   
set(dcm_obj, 'UpdateFcn',@dateCursor); 

%X and Y labels are set
xlabel(handles.djiaAxes1,'Stock Days')
ylabel(handles.djiaAxes1,'DJIA Value')

%Real values vs Model values is plotted on the 'zoomed in' axes
plot(handles.djiaAxes2,zoomTimeVec,zoomAdjReal,zoomTimeVec,zoomModelVals)
datetickzoom(handles.djiaAxes2,'x','mm/dd/yy')
%X and Y labels are set
xlabel(handles.djiaAxes2,'Date')
ylabel(handles.djiaAxes2,'DJIA Value')

%Predicted DJIA value for last future day is put into the textbox
predictedFinalVal = modelVals(1);
string = sprintf('Predicted DJIA value: %.2f',predictedFinalVal);
set(handles.predictedStaticText,'String',string)

%Final DJIA value for number of past and future days used is outputted to
%a text file called 'djiaPrediction.txt'
fid = fopen('djiaPrediction.txt','at');
x = [];
finalDateNum = timeVec(1);
% finalDateNum = x2mdate(finalDateNum, 0);
startDateStr = datestr(timeVec(end));
finalDateStr = datestr(finalDateNum);
set(handles.text45,'String',startDateStr);

fprintf(fid,'DJIA prediction results: \n'); 
fprintf(fid,'Past days used: %0.0f\n',pastDaysNum); 
fprintf(fid,'Business days into future: %0.0f\n',futureDaysNum); 
fprintf(fid,'End date: %s\n',finalDateStr);
fprintf(fid,'Predicted DJIA value: %0.2f\n',predictedFinalVal); 
fprintf(fid,' %f\n',x);

fclose(fid);

%For some reason the 'zoomed out' chart was also plotting on stockAxes so
%stockAxes is cleared
% cla(handles.stockAxes,'reset')


function startDateText_Callback(hObject, eventdata, handles)
% hObject    handle to startDateText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of startDateText as text
%        str2double(get(hObject,'String')) returns contents of startDateText as a double


% --- Executes during object creation, after setting all properties.
function startDateText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startDateText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function endDateText_Callback(hObject, eventdata, handles)
% hObject    handle to endDateText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of endDateText as text
%        str2double(get(hObject,'String')) returns contents of endDateText as a double


% --- Executes during object creation, after setting all properties.
function endDateText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to endDateText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numSharesText_Callback(hObject, eventdata, handles)
% hObject    handle to numSharesText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numSharesText as text
%        str2double(get(hObject,'String')) returns contents of numSharesText as a double


% --- Executes during object creation, after setting all properties.
function numSharesText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numSharesText (see GCBO)
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

%Stock selected by user is obtained
% itemsStock = get(handles.stockSelector,'String');
% indexStockSelected = get(handles.stockSelector,'Value');
% stock_selected = itemsStock{indexStockSelected};

%Buy date and sell date are converted to their serial date numbers
formatIn = 'mm/dd/yyyy';
buyDate = get(handles.startDateText,'String');
buyDateNum = datenum(buyDate,formatIn);
sellDate = get(handles.endDateText,'String');
sellDateNum = datenum(sellDate,formatIn);

%Ticker is set as UserData in a textbox so it can be accessed in other 
%functions
ticker = get(handles.tickerText,'UserData');

%Time interval selected by user is obtained
% itemsTime = get(handles.timeIntervalSelector,'String');
% indexTimeSelected = get(handles.timeIntervalSelector,'Value');
% time_interval = itemsTime{indexTimeSelected};
time_interval = 'all-time';
%Number of shares selected by user is obtained
numSharesText = get(handles.numSharesText,'String');
numShares = str2double(numSharesText);

%Stock data for chosen stock and time interval is obtained using
%stockWebPull function
stocks = stockWebPull(ticker,time_interval);

%Profit and total return for chosen stock and time interval is obtained
%using profitReturnCalc function
[profit,totalReturn] = profitReturnCalc(stocks,numShares,buyDateNum,sellDateNum);

%Profit is turned into a string and set as text in profit text box
profitString = sprintf('$ %0.2f',profit);
set(handles.profitText,'String',profitString);

%Total return is turned into a string and set as text in total return text
%box
totalReturnString = sprintf('%0.2f %%',totalReturn);
set(handles.returnText,'String',totalReturnString);

% --- Executes on selection change in timeIntervalSelector.
function timeIntervalSelector_Callback(hObject, eventdata, handles)
% hObject    handle to timeIntervalSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns timeIntervalSelector contents as cell array
%        contents{get(hObject,'Value')} returns selected item from timeIntervalSelector

%Stock selected is obtained
% itemsStock = get(handles.stockSelector,'String');
% indexStockSelected = get(handles.stockSelector,'Value');
% stock_selected = itemsStock{indexStockSelected};

%Ticker of selected stock is obtained
ticker = get(handles.tickerText,'UserData');
tickerString = num2str(ticker);
%Name of selected stock is set as the plot title
% set(handles.stockPlotTitle,'String',stock_selected);

%Time interval selected is obtained
itemsTime = get(handles.timeIntervalSelector,'String');
indexTimeSelected = get(handles.timeIntervalSelector,'Value');
time_interval = itemsTime{indexTimeSelected};
set(handles.timeIntervalText,'String',time_interval);
if strcmp('Time interval', time_interval) == 1
    x = [];
%     set(handles.stockSelectedText,'UserData',x);
    cla(handles.stockAxes,'reset');
    set(handles.timeIntervalText,'String',x);
%     set(handles.stockSelector,'Value',1);
%     set(handles.tickerText,'UserData',x);
%     set(handles.stockPlotTitle,'String',x);
elseif (strcmp('Time interval',time_interval) == 0) && strcmp('',tickerString) == 1
    set(handles.timeIntervalText,'String',time_interval);
elseif (strcmp('Time interval',time_interval) == 0) && strcmp('',tickerString) == 0
%Runs stockWebPull and checks if error occurs
%If error occurs, a dialog box pops up with instructions
try
stocks = stockWebPull(ticker,time_interval);
catch
    errorString = sprintf('Error: Stock ticker does not exist\n Please try again');
    errordlg(errorString);
end

%Output from stockWebPull is converted to a structure and then a dataset
stocks = table2struct(stocks);
stocks = struct2dataset(stocks);

%Dates are pulled out and converted to date numbers and column is flipped 
%so first date in column is the oldest 
dates = stocks.Date;
dates = datenum(dates);
dates = flipud(dates);

%Adjusted Close values are pulled out and column is flipped
adjClose = stocks.AdjClose;
adjClose = flipud(adjClose);

%Adjusted close over the time interval is plotted
plot(handles.stockAxes,dates,adjClose);

%Dateticks with zoom capability are used
datetickzoom(handles.stockAxes,'x','mm/dd/yy')

%Data cursor converts date numbers on x-axis to regular date format
dcm_obj = datacursormode(gcf);   
set(dcm_obj, 'UpdateFcn',@dateCursor); 

%X and Y labels are set
xlabel(handles.stockAxes,'Date')
ylabel(handles.stockAxes,'Share Price ($)')
end
% --- Executes during object creation, after setting all properties.
function timeIntervalSelector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to timeIntervalSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in stockSelector.
function [addedStock,addedTicker] = stockSelector_Callback(hObject, eventdata, handles)
% hObject    handle to stockSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns stockSelector contents as cell array
%        contents{get(hObject,'Value')} returns selected item from stockSelector

%Stock selected is obtained
itemsStock = get(handles.stockSelector,'String');
indexStockSelected = get(handles.stockSelector,'Value');
stock_selected = itemsStock{indexStockSelected};

%Ticker is set for chosen stock and set as UserData in a textbox so it can
%be accessed in other functions
%If user chooses 'other' stock selected is stock entered by user and ticker
%is ticker entered by the user
if strcmp('Apple',stock_selected) == 1
    ticker = 'AAPL';
    set(handles.tickerText,'UserData',ticker);
    set(handles.stockSelectedText,'UserData',stock_selected);  
    
elseif strcmp('Facebook',stock_selected) == 1
    ticker = 'FB';
    set(handles.tickerText,'UserData',ticker);
    set(handles.stockSelectedText,'UserData',stock_selected);
    
elseif strcmp('Google',stock_selected) == 1
    ticker = 'GOOG';
    set(handles.tickerText,'UserData',ticker);
    set(handles.stockSelectedText,'UserData',stock_selected);
    
elseif strcmp('Microsoft',stock_selected) == 1
    ticker = 'MSFT';
    set(handles.tickerText,'UserData',ticker);
    set(handles.stockSelectedText,'UserData',stock_selected);
       
elseif strcmp('Nike',stock_selected) == 1
    ticker = 'NKE';
    set(handles.tickerText,'UserData',ticker);
    set(handles.stockSelectedText,'UserData',stock_selected);
    
elseif strcmp('Other',stock_selected) == 1
    %If user chooses other, dialog box pops up and user enters stock name
    %and ticker
    prompt = {'Enter stock name:','Enter stock ticker:'};
    dlg_title = 'Add stock to list';
    num_lines = 2;
    %Name and ticker of added stock are obtained and converted to strings
    addedStockInfo = inputdlg(prompt,dlg_title,num_lines);
    addedStock = addedStockInfo(1);
    addedStock = char(addedStock);
    addedTicker = addedStockInfo(2);
    addedTicker = char(addedTicker);
    %User inputted stocks is added to drop down menu of stocks
    stockChoices = {'Stock' 'Apple','Facebook','Google','Microsoft','Nike','Other',addedStock};
    set(handles.stockSelector,'String',stockChoices);
    set(handles.tickerText,'UserData',addedTicker);
    set(handles.stockSelectedText,'UserData',addedStock);
    set(handles.stockSelector,'Value',8);
    set(handles.addedTickerText,'UserData',addedTicker);
    set(handles.addedStockText,'UserData',addedStock);
elseif strcmp('Stock',stock_selected) == 1 
    x = [];
    set(handles.stockSelectedText,'UserData',x);
    cla(handles.stockAxes,'reset');
%     set(handles.timeIntervalText,'String',x);
%     set(handles.timeIntervalSelector,'Value',1);
    set(handles.tickerText,'UserData',x);
    set(handles.stockPlotTitle,'String',x);
% elseif strcmp(stock_selected,get(handles.stockSelectedText,'UserData')) == 1
else
    ticker = get(handles.addedTickerText,'UserData');
    set(handles.tickerText,'UserData',ticker);
    stock = get(handles.addedStockText,'UserData');
    set(handles.stockPlotTitle,'String',stock);
    set(handles.stockSelectedText,'UserData',stock);
end
% cla(handles.stockAxes,'reset')
plotTitle = get(handles.stockSelectedText,'UserData');
set(handles.stockPlotTitle,'String',plotTitle);
% set(handles.timeIntervalSelector,'Value',1);
% x = [];
y = get(handles.timeIntervalSelector,'String');
itemsTime = get(handles.timeIntervalSelector,'String');
indexTimeSelected = get(handles.timeIntervalSelector,'Value');
time_interval = itemsTime{indexTimeSelected};
% set(handles.timeIntervalText,'String',x);
if strcmp('Time interval',time_interval) == 1 && strcmp('Stock',stock_selected) == 1
    x = [];
    set(handles.timeIntervalText,'String',x);
elseif strcmp('Time interval',time_interval) == 1 && strcmp('Stock',stock_selected) == 0
    x = [];
    set(handles.timeIntervalText,'String',x);
%     cla(handles.stockAxes,'reset');
%     set(handles.stockSelector,'Value',indexStockSelected);
elseif strcmp('Time interval',time_interval) == 0 && strcmp('Stock',stock_selected) == 1
    x = [];
    set(handles.stockSelectedText,'UserData',x);
    cla(handles.stockAxes,'reset');
%     set(handles.timeIntervalText,'String',x);
%     set(handles.timeIntervalSelector,'Value',1);
%     set(handles.tickerText,'UserData',x);
    set(handles.stockPlotTitle,'String',x);
else
    ticker = get(handles.tickerText,'UserData');
    set(handles.timeIntervalText,'String',time_interval);
    try
    stocks = stockWebPull(ticker,time_interval);
    catch
    errorString = sprintf('Error: Stock ticker does not exist\n Please try again');
    errordlg(errorString);
    end

%Output from stockWebPull is converted to a structure and then a dataset
    stocks = table2struct(stocks);
    stocks = struct2dataset(stocks);

%Dates are pulled out and converted to date numbers and column is flipped 
%so first date in column is the oldest 
    dates = stocks.Date;
    dates = datenum(dates);
    dates = flipud(dates);

%Adjusted Close values are pulled out and column is flipped
    adjClose = stocks.AdjClose;
    adjClose = flipud(adjClose);

%Adjusted close over the time interval is plotted
    plot(dates,adjClose);

%Dateticks with zoom capability are used
    datetickzoom('x','mm/dd/yy')

%Data cursor converts date numbers on x-axis to regular date format
    dcm_obj = datacursormode(gcf);   
    set(dcm_obj, 'UpdateFcn',@dateCursor); 

%X and Y labels are set
    xlabel('Date')
    ylabel('Share Price ($)')
end

    
% --- Executes during object creation, after setting all properties.
function stockSelector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stockSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in djiaPush2.
function djiaPush2_Callback(hObject, eventdata, handles)
% hObject    handle to djiaPush2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%If user pushes clear, data boxes and axes are cleared
set(handles.pastDaysText,'String',[])
set(handles.futureDaysText,'String',[])
set(handles.predictedStaticText,'String',[])
% arrayfun(@cla,findall(0,'type','axes'))
cla(handles.djiaAxes1,'reset');
cla(handles.djiaAxes2,'reset');


% --- Executes on button press in exportDataButton.
function exportDataButton_Callback(hObject, eventdata, handles)
% hObject    handle to exportDataButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Stock selected is obtained
% itemsStock = get(handles.stockSelector,'String');
% indexStockSelected = get(handles.stockSelector,'Value');
% stock_selected = itemsStock{indexStockSelected};
stock_selected = get(handles.stockSelectedText,'UserData');
%Time interval selected is obtained
% itemsTime = get(handles.timeIntervalSelector,'String');
% indexTimeSelected = get(handles.timeIntervalSelector,'Value');
% time_interval = itemsTime{indexTimeSelected};
time_interval = get(handles.timeIntervalText,'String');
%Ticker is obtained
ticker = get(handles.tickerText,'UserData');

%Stock data is obtained
stocks = stockWebPull(ticker,time_interval);
filename = sprintf('%s(%s).csv',stock_selected,time_interval);
writetable(stocks,filename);
