% Load your dataset
% Assuming your labels are stored in a variable "y"
% and the dataset has N samples

y = [1, -1, 1, 1, -1, ... ]; % Replace with your actual labels
N = length(y);

% Specify the noise level (percentage of labels to be flipped)
noise_level = 0.1; % 10% noise
num_noisy_labels = round(noise_level * N);

% Generate random indices to flip
rng('default'); % For reproducibility
noisy_indices = randperm(N, num_noisy_labels);

% Flip the labels at the selected indices
noisy_labels = y;
noisy_labels(noisy_indices) = -noisy_labels(noisy_indices);
