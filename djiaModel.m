%Dan Katz Lab LI
%ES-2 Final Project
function [modelVals,timeVec,realValsPlus] = djiaModel(pastDays,futureDays)
%function [modelVals,timeVec,adjReal] = djiaModel(p,q)
%Purpose: This function predicts future values of the Dow Jones Industrial
%Average for an inputted number of future days using an inputted number of
%past days using linear prediction
%Inputs:
% - pastDays: number of past days used in linear prediction
% - futureDays: number of future days model will predict values for
%Outputs:
% - modelVals: Values for model from number of past days to end date of 
%data plus number of future days
% - timeVec: Vector of 1 to the number of total values calculated in the
%model
% - realValsPlus: Vector of real past DJIA data with NaNs added for future
%days

%Data is inputted and pulled out
data = dataset('XLSFile','HistoricalPrices.xls');
realVals = data.Open;
realVals = flipud(realVals);
dates = data.Date;

%Saves inputted number of past days because number will be needed later
holder = pastDays;

%Sizes of matrixes used for linear prediction are pre-allocated
w = 1:pastDays;
k = length(dates);
linPredictMat = zeros(k-pastDays,pastDays);
realValsMat = zeros(k-pastDays,1);

%Matrix of size n-p x p is created using the past values over the 
%specified time period
for n = 1:(k-pastDays)
    linPredictMat(n,:) = realVals(w);
    realValsMat(n) = realVals(pastDays+1);
    w = w+1;
    pastDays = pastDays+1;
end

%Co-efficient matrix is solved for
coEfficients = linPredictMat\realValsMat; 

%Predicted values are calculated
predictedVals = linPredictMat*coEfficients;

%Vector of values predicted by model is created. Zeros are added for the
%length future days for pre-allocations
modelVals = zeros(futureDays,1);
modelVals = vertcat(predictedVals,modelVals);
u = zeros(length(modelVals),(holder-1));
modelVals = horzcat(modelVals,u);
E = length(linPredictMat);
r = (E-(holder-1)):E;

%Future values are calculated for number of future days inputted
for n = (E+1):(E+1+futureDays)
    modelVals(n,:) = modelVals(r);
    modelVals(n,:) = modelVals(n,:)*coEfficients;
r = r+1;
end

%Only first column of modelVals is needed
modelVals(:,(2:holder)) = [];

%Vector representing number of data points is created
Busday = busdays('08-May-0116','02-Feb-0150','daily', []);
futureDaysUsed = flipud(Busday(1:futureDays));
penis = length(dates);
poop = penis - holder;
% pastDaysUsed = dates(poop:end);
pastDaysUsed = dates(1:holder);
% timeVec = vertcat(futureDaysUsed,pastDaysUsed);
% timeVecStr = datestr(timeVec);
% newPastDays = dates(poop:end);
timeVec = vertcat(futureDaysUsed,dates);
timeVec = timeVec(1:(length(timeVec)-holder+1));
% timeVec = vertcat(dates(end:(end-holder)),futureDaysUsed);
%NaN's are added to the vector of real DJIA data to allow it to be plotted
%with the model with future values
daysAfter = length(modelVals) - length(realVals)+holder;
daysAfterZeros = zeros(daysAfter,1);
newRealVals = vertcat(realVals,daysAfterZeros);
newRealVals(newRealVals==0) = NaN;
%realValsPlus contains the real DJIA values from the past days inputted and 
%NaNs for future days so the model can be compared with the real past data
realValsPlus = newRealVals(holder:end-1);
end


