clear
close all

%% initiate variables
r0 = 100/1000; %Hz(s^-1) to ms^-1
t_final = 2000; %ms;
r_max = 2 * r0;
count = zeros(1, t_final + 100);
sample_num = 10000;
tau = 300;

%% sampling
% different sample_num means different trial
% we will do mento carlo simulation to roughly get r(t) through sample result
% r(t_i) \approx 1/time_bin_length <spikes number in ith bin>
% <> can obtained by summing spike number from different trial then dividing it by trial number
for s = 1:sample_num
    % generate spikes in 0-t_final
    % the same as the code in poisson_spike_generator.m
    t = 0;
    firing = zeros(1, 1);
    i = 1;

    while t < t_final
        xi = rand;
        t = t -log(xi) / r_max;
        firing(i) = t;
        i = i + 1;
    end

    n = length(firing);

    for i = 1:n
        temp = calculate_r(firing(i)) / r_max;
        xi = rand;

        if temp < xi
            firing(i) = 0;
        end

    end

    x = find(firing ~= 0);
    firing = firing(x);

    %% statistics
    % set time bin length,i.e. \Delta t = 1ms,we need to count spike numbers
    % in each bin. Label each firing time with a integer. Categorize times
    % by the integer, then count.
    % because of time bin is 1, round the number can finish mark work
    ceil_firing = ceil(firing);
    n = length(ceil_firing);

    for i = 1:n
        t = ceil_firing(i);
        count(t) = count(t) + 1;
    end

end

count = count(1:t_final);
count = count / sample_num;
plot(count)
hold on

% real r(t)
time = 1:0.01:t_final;
y = r0 * (1 + cos(2 * pi .* time / tau));
plot(time, y, 'LineWidth', 1.5);
hold off
%% function
function r = calculate_r(t)
    r0 = 100/1000; %Hz
    tau = 300; %ms
    r = r0 * (1 + cos(2 * pi * t / tau));
end
