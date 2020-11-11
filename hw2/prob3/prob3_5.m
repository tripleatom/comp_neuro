clear;
close all;
max_length = 4;
J = 0;
G = -2;
K = 1;
%% x(t),y(t)
t0 = 0;
tfinal = 30;
p0 = [0.001, 0.001];
[t, p] = ode45(@limitcycleODE, [t0, tfinal], p0);
plot(t, p)
title('x/y evolvement over time')
xlabel('t')
ylabel('amplitude')
legend('x', 'y')

%% draw phase plot
plot(p(:, 1), p(:, 2))
title('x/y')
xlabel('x')
ylabel('y')

%% draw vector field
x = -max_length:0.5:max_length;
y = -max_length:0.5:max_length;
[X, Y] = meshgrid(x, y);

x_dot = -X + tanh(J * X - K * Y);
y_dot = -Y + G * X;
hold on
quiver(X, Y, x_dot, y_dot);
xlabel("x")
ylabel("y")
axis([-max_length max_length -max_length max_length])
axis equal

%% function
function dpdt = limitcycleODE(~, p)
    J = 0;
    G = -2;
    K = 1;
    x = p(1);
    y = p(2);
    dpdt = [-x + tanh(J * x - K * y);
        -y + G * x];
end
