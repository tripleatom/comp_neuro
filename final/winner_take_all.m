clear;
close all;

%% initiate variables
n = 3; % number of neurons
alpha = 0.2;
beta = 0.6;
t_final = 20; %length of simulation time
dt = 0.0001; % step length
t = 0:dt:t_final;
nt = length(t);
xt = zeros(n, nt); % array to store every neuron's reaction number
x_i = [-1; 6; 3]; % initial state
b = [4; 5; 0.5]; % external exitation

W = (alpha + beta) * eye(n) - beta * ones(n); % define the matrix W
dx = zeros(n, 1); % to store the increment for every dt

%% the system evolves
for i = 1:nt
    xt(:, i) = x_i;
    dx = (-x_i + relu(b + W * x_i)) * dt;
    x_i = x_i + dx;
end

%% plot and add text
figure;

for j = 1:3
    subplot(3, 1, j);
    str = ['neuron', num2str(j)];
    genplot(str, t, 't/s', xt(j, :), 'r(t)')
end

txt = ['\alpha = ', num2str(alpha); '\beta = ', num2str(beta), ' '];
text(17, 1.5, txt)
