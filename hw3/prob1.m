clear; close all;
time_interval = 1e-5;

%% 1(a)
disp('----1(a)----')
t = 0:time_interval:10;
V_0 = 1;
V = zeros(length(t), 1);

for i = 1:length(t)
    V(i) = V_0;
end

[x, y] = prob1_solve(t, V, 0.5, 3);

figure()
genplot('x', t, x, 'x');

%% 1(b)
disp('----1(b)----')
%a = 2
for i = 1:length(t)
    V(i) = 0.1;
end

[x, y] = prob1_solve(t, V, 0.1, 2);

figure()
genplot('a = 2', t, x, 'x');
disp('when a = 2')
disp('v(t = 10)=')
disp(x(int32(10 / time_interval)))

%a = 1
[x, y] = prob1_solve(t, V, 0.1, 1);
figure()
genplot('a = 1', t, x, 'x');

%a = 4
[x, y] = prob1_solve(t, V, 0.1, 4);
figure()
genplot('a = 4', t, x, 'x');
