clear;
close all;

%% initiate variables
r_0 = 50;
delta_t = 10; %ms
mean = 0;
sigmas2 = 10;
sigma2 = sigmas2 / delta_t;
t_start = -50 * 1000; %ms
t_final = 10 * 1000; %ms
delta = 0.5; %ms
t = t_start:delta:t_final;
time = 0:delta:t_final;
time_new = time / 1000; %convert the unit of time from ms to s
time_length = length(time);
r = zeros(time_length, 1); % store the reaction of neuron
rand_num = ceil((t_final - t_start) / delta_t);

%% generate white noise stimuli
s = sqrt(sigma2) * randn(rand_num, 1) + mean;

%% expand s
% set the stimuli number at every mm
% at front we get the stimuli value at every 10 mm
% so, we need to let 1-10mm, 11-20mm... is same
s_n = delta_t / delta;
ss = zeros(s_n * length(s), 1);
j = 1:length(s);
j = s_n * j;
j = [1, j];
j = j(1:length(s));

for k = 1:s_n
    ss(j) = s;
    j = j + 1;
end

ss(:, 2) = t(1:length(ss))';

%% calculate r
% replace integrate with discrete sum 
parfor i = 1:time_length
    t = time(i);
    % determine sum range
    n_min = 1;
    n_max = ceil((t - t_start) / delta + 1);
    n2 = n_min:n_max;

    if length(n2) <= length(ss)
        temp_s = ss(n2, 1);
        temp_D = calculate_D(t - ss(n2, 2));
        r(i) = r_0 + sum(temp_s .* temp_D) * delta;
    end

end

%% calculate Q
T = 10000; %ms
tau_final = -1 * 1000; %ms
tau = tau_final:delta:0;
l_tau = length(tau);
tau = fliplr(tau); % reverse the array, so that we could plot Q(-tau) directly
length_T = T / delta;
Q = zeros(l_tau, 1);

for i = 1:l_tau
    temp_tau = tau(i);
    tau_start = int32((temp_tau - t_start) / delta);
    Q(i) = 1 / T * delta * sum((r(1:length_T)-50) .* ss(tau_start:tau_start + length_T - 1)');
end

DD = Q / sigmas2;
Q_t = 0:delta:-tau_final;
% theoretical result
Dreal = calculate_D(Q_t);

%% plot stimuli and reaction
figure;
subplot(211)
s_time = linspace(t_start, t_final, length(ss(:, 1))) / 1000;
genplot('stimuli', s_time, 't/s', ss(:, 1), 's(t)')
subplot(212)
genplot('reaction', time_new, 't/s', r, 'r(t)')

%% plot D
figure;
hold on
plot(Q_t, DD)
plot(Q_t, Dreal, 'LineWidth', 1.5);
legend('Q_{rs}(-\tau)/\sigma^2','D(\tau)');
xlabel('t/ms')
