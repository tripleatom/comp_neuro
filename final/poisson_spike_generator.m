clear
close all

%% initiate variables
r0 = 100/1000; %Hz(s^-1) to ms^-1
t_final = 200; %ms;
r_max = 2 * r0;
t = 0;
i = 1;
firing = zeros(1, 1); %use array to store the exact time of firing spike

% generate spike times with constant firing rate
while t < t_final
    xi = rand;
    t = t -log(xi) / r_max;
    firing(i) = t;
    i = i + 1;
end

n = length(firing);

% use rejection sampling to extend the results to time-dependent rates
% we set the time value does not matches the condition to 0,
% then weed out all 0
for i = 1:n
    temp = calculate_r(firing(i)) / r_max;
    xi = rand;

    if temp < xi
        firing(i) = 0;
    end

end

% weed out step
x = find(firing ~= 0);
firing = firing(x);
n = length(firing);

% draw all of the spikes
for i = 1:n
    temp = firing(i);
    line([temp, temp], [0, 1]);
end

% arrange the pic
ylabel('spikes')
xlabel('time/ms')
yticks([])
t = max(firing);
set(gca, 'PlotBoxAspectRatio', [10, 1, 1], ...
    'XLim', [0, t + 10])

% define r
function r = calculate_r(t)
    r0 = 100/1000; %Hz
    tau = 300; %ms
    r = r0 * (1 + cos(2 * pi * t / tau));
end
