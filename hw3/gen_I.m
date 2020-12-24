function [I] = gen_I(I_0, I_1, theta_0, I)
    %generate external current
    N = length(I);
    t = linspace(0, N, N);
    t = t';
    theta = 2 * pi .* t / N;
    I = I_0 + I_1 * cos(theta - theta_0);
end
