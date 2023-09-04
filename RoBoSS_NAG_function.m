function [gamma_opt,Accuracy,time] = RoBoSS_NAG_function(alltrain,test,a,b,C,k,r,max_iter,t,m,mew)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%      Inputs of function
   %       alltrain denotes the training data.
   %       test denotes the test data.
   %       a and b are RoboSS loss parameters.
   %       c and mew are trade-off parameter and kernel parameter,
   %       respectively.
   %       m denotes the size of mini-batch.
   %       max_iter denotes the number of maximum iteration.
   %       k and r are the learning rate decay factor and momemtum
   %       parameter related to NAG algorithm, respectively.
   %       t denotes the iteration number. 

   %%     Output of function
   %      gamma_opt denotes the optimal parameter of model
   %      Accuracy and time denotes the the classification accuracy and
   %      training time of the model.

l=size(alltrain,1);
rand_num=randperm(l);
rand_data=zeros(m,size(alltrain,2));

for i=1:m
    rand_data(i,:)=alltrain(rand_num(i),:);
end
%% xrand and yrand are the feature matrix and labels of m randomly selected training samples.
xrand=rand_data(:,1:end-1); yrand=rand_data(:,end);

%% Split the feature and label of the Test set
Xtest=test(:,1:end-1);
Ytest=test(:,end);

%%%generating the kernel matrix for the training data using m randomly selected training samples.
XX=sum(xrand.^2,2)*ones(1,m);
omega=XX+XX'-2*(xrand*xrand');   %%%omega is the kernel matrix for data X.
omega=exp(-omega./(2*mew^2));



% initialize the parameters
n1=size(xrand,2);       % feature in dataset
eta0=0.01;              % learning rate of NAG algorithm
gamma=0.01*ones(m,1);   % initialize model parameter
v=0.01*ones(m,1);       % initialize velocity for NAG algorithm



%%% finding \xi_k

q=zeros(m,1);  % This is summation term in xi_k (See RoBoSS paper) 
for i=1:m
    q(i)=sum(gamma.*omega(:,i));
end


u=zeros(m,1);   % This is xi_i
for i=1:m
    u(i)=1-(yrand(i)*q(i));
end


% derivate of loss
E=zeros(m,m);
for i=1:m
    if u(i)>0
        E(i,:)= -b*a^2*u(i)*exp(-a*u(i))*yrand(i)*omega(i,:);
    elseif u(i) >= 0
        E(i,:)= zeros(1,m);
    end
end


tic
%% Optimization loop for NAG algorithm

for i = 1:max_iter
    t = t + 1;

    gamma=gamma+r*v;
    grad= (gamma/l)+ (C/m)*sum(E,1)';
    v=r*v-eta0*grad;
    gamma=gamma+v;
    eta0=eta0*exp(-k*t);
end


% Return optimal solution and function value
gamma_opt = gamma;

XK=xrand; %storing X in another matrix so that all the upgradation while calculating kernel will be done in new matrix.

p=size(Xtest,1);
%HT=zeros(m,n);
omega1=-2*XK*Xtest';
XK=sum(XK.^2,2)*ones(1,p);
Xtest=sum(Xtest.^2,2)*ones(1,m);
omega1=omega1+XK+Xtest';
omega1=exp(-omega1./2*mew^2); %%omega1 is the kernel matrix corresponding to test data projected on training data(including univwersum)

HT=omega1.*yrand;


f=sign(HT'*gamma_opt);
% predictedY = sign(HT'*alpha+b0 );
time=toc;

%% Finding Accuracy using true positive(tp), true negative(tn), false positive(fp) and false negative(fn).
tp=0;tn=0;fp=0;fn=0;
for j=1:length(Ytest)
    if Ytest(j)>0
        if Ytest(j)==f(j)
            tp=tp+1;
        else
            fn=fn+1;
        end
    end
    if Ytest(j)<0
        if Ytest(j)==f(j)
            tn=tn+1;
        else
            fp=fp+1;
        end
    end
end
Accuracy=((tp+tn)/(tp+fn+fp+tn))*100;
end
