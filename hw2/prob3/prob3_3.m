clear; close all;
format short

J = 3;
K = 2;
G = 1;
max_length = 20;

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

%% draw the tracks
delta_t = 0.001;
t0 = 0;
tfinal = 1000;
t = t0:delta_t:tfinal;
x_set = -15:2:15;
y_set = -15:2:15;

for j = 1:length(x_set)

    for k = 1:length(y_set)
        initial_x = x_set(j);
        initial_y = y_set(k);
        x = zeros(1, (tfinal - t0) / delta_t + 1);
        y = zeros(1, (tfinal - t0) / delta_t + 1);
        x(1) = initial_x;
        y(1) = initial_y;

        for i = 1:length(x) - 1
            delta_x = -x(i) + tanh(J * x(i) - K * y(i));
            delta_y = -y(i) + G * x(i);
            x(i + 1) = x(i) + delta_x * delta_t;
            y(i + 1) = y(i) + delta_y * delta_t;
        end

        plot(x, y);
    end

end

hold off
