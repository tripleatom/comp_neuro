clear; close all;
format short

a = -5;
b = 100;
c = 20;
max_length = 20;

I = 0;

%% draw vector field
v = -max_length:0.5:max_length;
w = -max_length:0.5:max_length;
[V, W] = meshgrid(v, w);

V_dot = V .* (a - V) .* (V - 1) - W + I;
W_dot = b * V - c * W;
hold on
quiver(V, W, V_dot, W_dot);
fplot(@(V) V .* (a - V) .* (V - 1) + I)
fplot(@(V) b / c * V)

xlabel("V")
ylabel("w")
axis([-max_length max_length -max_length max_length])
axis equal

% syms V W
% eqn = [V * (a - V) * (V - 1) - W + I == 0, b * V - c * W == 0];
% S = solve(eqn);
% a1 = vpa(S.V, 4)
% a2 = vpa(S.W, 4)

%% draw the tracks
delta_t = 0.01;
t0 = 0;
tfinal = 10;
t = t0:delta_t:tfinal;
% initial position
initial_x = 2;
initial_y = -1;
x = zeros(1, (tfinal - t0) / delta_t + 1);
y = zeros(1, (tfinal - t0) / delta_t + 1);
x(1) = initial_x;
y(1) = initial_y;

for i = 1:length(x) - 1
    delta_x = x(i) * (a - x(i)) * (x(i) - 1) - y(i) + I;
    delta_y = b * x(i) - c * y(i);
    x(i + 1) = x(i) + delta_x * delta_t;
    y(i + 1) = y(i) + delta_y * delta_t;
end

plot(x, y);
