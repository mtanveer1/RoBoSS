% Load your dataset
% Assuming your feature matrix and labels are stored in  variable "X" and
% "y", respectively.
% "num_samples" and "num_features" denote the number of samples and
% number of feature in matrix X.


% Parameters for feature outliers
outlier_percentage = 10; % Percentage of outliers to add
num_outliers = round((outlier_percentage / 100) * num_samples); % Number of outliers
outlier_factor = 10; % Factor to create outliers

% Randomly select indices to add outliers
outlier_indices = randperm(num_samples, num_outliers);

% Add outliers
for i = 1:num_outliers
    feature_index = randi(num_features); % Randomly select a feature
    X(outlier_indices(i), feature_index) = X(outlier_indices(i), feature_index) * outlier_factor;
end
