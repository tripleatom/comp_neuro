function [x, y] = prob1_solve(t, V, tau, a)
    % solve pde
    dt = diff(t(1:2));

    x = zeros(1, length(t));
    y = zeros(1, length(t));

    x(1) = 0;
    y(1) = 0;

    for i = 1:length(t) - 1
        dxdt = 1 / tau * (-a * x(i) - 2 * y(i) + tau * V(i));
        dydt = 1 / tau * (-(3 - a) * x(i) - y(i) - tau * V(i));

        x(i + 1) = x(i) + dxdt * dt;
        y(i + 1) = y(i) + dydt * dt;
    end
