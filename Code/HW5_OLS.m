% HW5 bayesianols %
clear
clc
close all

% Input data

dataT = readtable('card.csv');
data = table2array(dataT);

% Create Variables

lwage = data (:,33);
educ  = data (:,4);
exper = data (:,32);
SMSA  = data (:,23);
Race  = data (:,22);
Regi  = data (:,24);


% Define indep and dependent variable

X = [educ exper SMSA Race Regi];
Y = lwage;
[N,k] = size(X);
X_wI = [ones(N,1) X];


% Run Initial OLS model
model = fitlm(X,Y,'VarNames',{'educ','exper','smsa','black','south','lwage'});
df = model.DFE;                                     % degree of freedom
beta_hat_ini = table2array(model.Coefficients(:, 1));   % Beta Coefficients
se_beta_hat_ini = model.Coefficients(:,2);              % standard error of B Coefficents
var_beta_hat_ini = diag(model.CoefficientCovariance);   % Variance of B Coefficients
sigma_sq_hat_ini = model.MSE;                       
sigma_hat_ini = model.RMSE;
sigma_var_ini = 2/df*(sigma_sq_hat_ini);

save(fullfile(tempdir,'OLS_results'));






