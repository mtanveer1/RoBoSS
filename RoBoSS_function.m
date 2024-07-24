function [Accuracy,time] = RoBoSS_function(train,test,a,b,C,m,sigma)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      Inputs of function
%       train denotes the training data.
%       test denotes the test data.
%       a and b are RoboSS loss parameters.
%       C and sigma are trade-off parameter and kernel parameter,
%       respectively.
%       m denotes the size of mini-batch.

%%     Output of function
%      Accuracy and time denotes the classification accuracy and
%      training time of the model.

l=size(train,1);
rand_num=randperm(l);
rand_data=zeros(m,size(train,2));

for i=1:m
    rand_data(i,:)=train(rand_num(i),:);
end
% xrand and yrand are the feature matrix and labels of m randomly selected training samples.
xrand=rand_data(:,1:end-1); yrand=rand_data(:,end);

% Split the feature and label of the Test set
Xtest=test(:,1:end-1);
Ytest=test(:,end);


% Generate the kernel matrix for the training data
omega = exp(-pdist2(xrand, xrand, 'euclidean').^2 / (2 * sigma^2));

% initialize the parameters
eta0=0.01;              % learning rate of NAG algorithm
gamma=0.01 * ones(m,1);   % initialize model parameter
v=0.01 * ones(m,1);       % initialize velocity for NAG algorithm
k = 0.1; % learning rate decay factor
r = 0.6; % momentum parameter
max_iter = 1000;
t=0;

q = omega * gamma; % Summation term in xi_i
u = 1 - (yrand .* q); % Calculate xi_i

% derivate of loss
E = zeros(m, m);
    for i = 1:m
        if u(i) > 0
            E(i, :) = -b * a^2 * u(i) * exp(-a * u(i)) * yrand(i) * omega(i, :);
        end
    end


tic
% Optimization loop for NAG algorithm

for i = 1:max_iter
    t = t + 1;

    gamma=gamma+r*v;
    grad= (gamma/l)+ (C/m)*sum(E,1)';
    v=r*v-eta0*grad;
    gamma=gamma+v;
    eta0=eta0*exp(-k*t);
end
time=toc;



% Kernel matrix for test data projected on training data
omega1 = exp(-pdist2(xrand, Xtest, 'euclidean').^2 / (2 * sigma^2));


HT=omega1.*yrand;
f=sign(HT'*gamma);

% Finding Accuracy
tp = sum((Ytest > 0) & (Ytest == f));
tn = sum((Ytest < 0) & (Ytest == f));
fp = sum((Ytest < 0) & (Ytest ~= f));
fn = sum((Ytest > 0) & (Ytest ~= f));

Accuracy = ((tp + tn) / (tp + fn + fp + tn)) * 100;
end
