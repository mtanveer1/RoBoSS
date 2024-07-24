% Please cite the following paper if you are using this code.
% Reference: Mushir Akhtar, M. Tanveer, and Mohd. Arshad. "RoBoSS: A Robust, Bounded, Sparse, and Smooth Loss Function for Supervised Learning", IEEE Transactions on Pattern Analysis and Machine Intelligence (Under Revision).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% We have put a demo of the "RoBoSS-SVM" model with the "credit_approval" dataset

%%
clc;
clear;
warning off all;
format compact;

%% Data Preparation
addpath(genpath('C:\Users\mushi\OneDrive\Desktop\RoBoSS-Code'))
temp_data1=load('credit_approval.mat');

temp_data=temp_data1.credit_approval;
[d,e] = size(temp_data);
%define the class level +1 or -1
for i=1:d
    if temp_data(i,e)==0
        temp_data(i,e)=-1;
    end
end

X=temp_data(:,1:end-1); mean_X = mean(X,1); std_X = std(X);
X = bsxfun(@rdivide,X-repmat(mean_X,size(X,1),1),std_X);
All_Data=[X,temp_data(:,end)];

[samples,~]=size(All_Data);
split_ratio=0.8;
test_start=floor(split_ratio*samples);
training_Data = All_Data(1:test_start-1,:);
testing_Data = All_Data(test_start:end,:);
[length_train,~] = size(training_Data);


%% Hyperparameter range
% C=10.^[-6:1:6];
% sigma=10.^[-6:1:6];
% a= 0:0.1:5;
% b= 0.1:0.1:2;
%%
C=1; % Regularization parameters
sigma=1; % Kernel parameter
a= 1.4;   % loss function parameters
b= 1.8;

if length_train<100
    m=2^2;
else
    m=2^5;
end

[Accuracy,time] = RoBoSS_function(training_Data,testing_Data,a,b,C,m,sigma);

fprintf(1, 'Testing Accuracy of RoBoSS-SVM model is: %f\n', Accuracy);
fprintf(1, 'Training time of RoBoSS-SVM model is: %f\n', time);
