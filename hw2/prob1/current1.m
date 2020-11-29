function [I] = current1(a_m, t)
    %% Calculates the external current

    % predefined resistance
    omega = 2 * pi * 50;

    % 1/M * (-M : M)
    m = -1:1/5:1;

    % I is the sum of the fourier series
    % sum o-ver the row dimension of a rank-one matrix
    I = a_m * sum(exp(1j * omega * m' * t));

end