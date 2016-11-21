%Dan Katz Lab LI
%ES-2 Final Project
function stockData = stockWebPull(ticker,time_interval)
%function stockData = stockWebPull(ticker,time_interval)
% Purpose: stockWebPull gives table of stock data for chosen stock over 
% chosen time interval
% Inputs:
% - ticker (ticker of any stock. Must be a string)
% - time_interval (time interval for stock data. Must be a string that is 
%   either '1-year','5-years','10-years', or 'all-time')
% Outputs:
% - stockData (table of stock data for stock over chosen time interval.
%   table contains: Date, Open, High, Low, Close, Volume, Adjusted Close)

%Possible string inputs are created
string1 = '1-year';
string2 = '5-years';
string3 = '10-years';
string4 = 'all-time';

%Current date info is calculated
currentDate = datetime('now');
currentYear = currentDate.Year;
currentMonth = currentDate.Month;
currentDay = currentDate.Day;

%Time interval is determined for each possible time interval input
if strcmp(time_interval,string1) == 1
    a = currentMonth - 1;
    b = currentDay;
    c = currentYear - 1;
    d = currentYear;
    
elseif strcmp(time_interval,string2) == 1
    a = currentMonth - 1;
    b = currentDay;
    c = currentYear - 5;
    d = currentYear;

elseif strcmp(time_interval,string3) == 1
    a = currentMonth - 1;
    b = currentDay;
    c = currentYear - 10;
    d = currentYear;
    
elseif strcmp(time_interval,string4) == 1
    a = currentMonth - 1;
    b = currentDay;
    c = currentYear - 100;
    d = currentYear;
end

%Full url is obtained by combiningg api with the ticker and dates for 
%time interval
api = 'http://real-chart.finance.yahoo.com/table.csv?s=';
parturl = sprintf('&a=%.0f&b=%.0f&c=%.0f&d=%.0f&e=%.0f&f=%.0f&g=d&ignore=.csv',a,b,c,a,b,d);
url = [api ticker parturl];

%Table of stock data is created by pulling data from YAHOO Finance
stockData = webread(url);
end