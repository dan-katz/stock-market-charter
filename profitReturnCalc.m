%Dan Katz Lab LI
%ES-2 Final Project
function [profit,totalReturn] = profitReturnCalc(stockData,numShares,buyDateNum,sellDateNum)
%function [profit,totalReturn] = profitReturnCalc(stocks,numShares,startDateNum,endDateNum)
%Purpose: profitReturnCalc calculates the profit and return on a number of
%shares of a stock bought and sold at user specified dates
% Inputs:
% - stockData: stock data containing at least dates, adjusted close, and 
%open values
% - numShares: number of shares
% - buyDateNum: date number of buy date
% - sellDateNum: date number of sell date
% Outputs:
% - profit: profit for number of shares of stock bought at buy date and 
% sold at sell date
% - totalReturn: percent return for number of shares of stock bought at buy
%date and sold at sell date

%stock data is converted to a structure and then to a dataset
stockData = table2struct(stockData);
stockData = struct2dataset(stockData);

%Date column of stock data is pulled out and converted to date numbers and
%then flipped so oldest date is at top
dates = stockData.Date;
dates = datenum(dates);
dates = flipud(dates);

%Adjusted close column of stock data is pulled out and flipped so adjusted
%close from oldest date is at top
adjClose = stockData.AdjClose;
adjClose = flipud(adjClose);

%Index of date closest to buy date is obtained
[~,buyIndex] = min(abs(dates-buyDateNum));
%Adjusted close of buy date is obtained
buyStockValue = adjClose(buyIndex);

%Index of date cloesest to sell date is obtained
[~,sellIndex] = min(abs(dates-sellDateNum));
%Adjusted close of sell date is obtained
sellStockValue = adjClose(sellIndex);

%Open values from stock data is pulled out and flipped so value from oldest
%date is at top
stockOpen = stockData.Open;
stockOpen = flipud(stockOpen);

%Difference in value of stock at buy date and sell date is calculated
valueDifference = sellStockValue - buyStockValue;

%Original investment is calculated
originalInvestment = numShares*stockOpen(buyIndex);
adjNumShares = originalInvestment/adjClose(buyIndex); 

%Profit is calculated
profit = valueDifference * adjNumShares;

%Total return is calculated
totalReturn = (profit)/(originalInvestment)*100;
end