close all;clear all;clc;

load("Train.txt");
load("Test.txt");



%% Set default values for parameters
k = 0.1; % learning rate decay factor
r=0.6; % momentum parameter
max_iter = 1000; % maximum iteration number
t=0;
m=2^5; % mini batch size
a=2.3;  %  a and b are loss parameter
b=1.8;
C=1;  % tradeoff parameter
mew=1; % kernel parameter





[gamma_opt,accuracy,valid_time] = RoBoSS_NAG_function(Train,Test,a,b,C,k,r,max_iter,t,m,mew);


 disp(accuracy);

