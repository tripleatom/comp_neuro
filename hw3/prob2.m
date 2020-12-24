%% initialize
clear;
close all;
N_neuron = 1e2;
t_final = 1e3;
t_step = 1e-2;
t = 1:t_step:t_final;
N_t = length(t);
tau = 1;
theta_0 = pi;
theta = linspace(0, 2 * pi, N_neuron);
theta = theta';

%% 2(c)
disp('----2(c)----')
J_0 = 0.8;
J_1 = 1;
I_0 = 1;
I_1 = 0;
w = zeros(N_neuron);
w = gen_w(J_0, J_1, w);
u = zeros(N_neuron, N_t);
u(:, 1) = I_0 / (1 - J_0);
u(1:25, 1) = u(1:25, 1) + 1;

I = zeros(N_neuron);
I = gen_I(I_0, I_1, theta_0, I);
u = ring_evolution(t, u, w, I);
figure;
genplot("amplitude", t, 't', u(1, :), 'u');
figure;
subplot(211)
genplot('initial condition', theta, 'theta', u(:, 1), 'reaction')
subplot(212)
genplot('final condition', theta, 'theta', u(:, N_t), 'reaction')

%% 2(d)
disp('----2(d)----')
J_0 = 0.8;
J_1 = 2.5;
I_0 = 1;
I_1 = 0;
w = zeros(N_neuron);
w = gen_w(J_0, J_1, w);
u = zeros(N_neuron, N_t);
u(:, 1) = rand(N_neuron, 1);
I = zeros(N_neuron);
I = gen_I(I_0, I_1, theta_0, I);
u = ring_evolution(t, u, w, I);
figure;
subplot(311)
genplot("amplitude", t, 't', u(1, :), 'u');
subplot(312)
genplot('initial condition', theta, 'theta', u(:, 1), 'reaction')
subplot(313)
genplot('final condition', theta, 'theta', u(:, N_t), 'reaction')
fname = ['./pics/', num2str(J_0, '%.3f'), '_', num2str(J_1, '%.3f'), '_', num2str(I_0, '%.3f'), '_', num2str(I_1, '%.3f'), '.png'];
%saveas(gca, fname, 'png');

%% 2(f)
disp('----2(f)----')
J_0 = 0.8;
J_1 = 2.2;
I_0 = 1;
I_1 = 0.01;
theta_0 = 3 * pi / 2;
w = zeros(N_neuron);
w = gen_w(J_0, J_1, w);
u = zeros(N_neuron, N_t);
u(:, 1) = rand(N_neuron, 1);
I = zeros(N_neuron);
I = gen_I(I_0, I_1, theta_0, I);
u = ring_evolution(t, u, w, I);
figure;
subplot(211)
genplot("amplitude", t, 't', u(1, :), 'u');
subplot(212)
genplot('final condition', theta, 'theta', u(:, N_t), 'reaction')
hold on
y = max(u(:, N_t));
plot([theta_0, theta_0], [0, y])
text_theta = ['theta_0 = ', num2str(theta_0)];
text(theta_0, y / 2, text_theta)
fname = ['./pics/', num2str(theta_0, '%.3f'), '_', num2str(I_0, '%.3f'), '_', num2str(I_1, '%.4f'), '.png'];
%saveas(gca, fname, 'png');
