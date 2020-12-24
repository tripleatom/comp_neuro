clear; close all;
time_interval = 1e-5;


%% part 1
disp('part 1')
t = -0.05:time_interval:0.2;
% external current
I_ext = zeros(length(t), 1);

omega = 2 * pi * 10;
T = 2 * pi / omega;
a_m = 3;
fire_t = 0:time_interval:T / 2;

for i = 1:length(fire_t)
    I_ext(i + 0.05 / time_interval) = a_m * sin(omega * fire_t(i));
end

[V, n, m, h] = hhm(t, I_ext);

figure()
subplot(2, 1, 1)
genplot('External stimulus current', ...
    t, I_ext, 'I_{ext} (nA)');
subplot(2, 1, 2)
[~, spikes] = find_spike(V);
plot(t, V, 'b-', t(spikes), V(spikes), 'r*');
setaxis(t, V);
title('Hodgkin-Huxley voltage with spikes');
xlabel('t(s)');
ylabel('Voltage (mV)');

figure()
subplot(3, 1, 1)
genplot('n', ...
    t, n, 'n');

subplot(3, 1, 2)
genplot('m', ...
    t, m, 'm');
subplot(3, 1, 3)
genplot('h', ...
    t, h, 'h');

%% part2
disp('part 2')
a_m = 0.5;
I_ext_1 = real(current1(a_m, t));
[V_1] = hhm(t, I_ext_1);
figure()
subplot(211);
genplot('External stimulus current', ...
    t, I_ext_1, 'I_{ext} (nA)');

subplot(212);
[~, spikes_1] = find_spike(V_1);
plot(t, V_1, 'b-', t(spikes_1), V_1(spikes_1), 'r*');
setaxis(t, V_1);
title('Hodgkin-Huxley voltage with spikes');
xlabel('t (s)');
ylabel('Voltage (mV)');

%% count spike time in a period of time
all_am = 0.1:0.1:4;

num_spikes = [];
for am = all_am
    V = hhm(t, current1(am, t));
    V = V(t >= 0);
    num_spikes(end + 1) = find_spike(V);
end

figure()
subplot(211);
plot(all_am, num_spikes);
setaxis(all_am, num_spikes);
title('a_{m}-- total spikes');
ylabel('Total spikes');

subplot(212);
avg_spikes = num_spikes / 0.2;
plot(all_am, avg_spikes);
setaxis(all_am, avg_spikes);
title('a_{m} -- firing frequency/s');
xlabel('a_{m}');
ylabel('firing frequency/s');
