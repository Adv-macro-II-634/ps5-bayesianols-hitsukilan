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

%X=[ones(length(lwage),1) x];

model = fitlm(X,Y);

model;




