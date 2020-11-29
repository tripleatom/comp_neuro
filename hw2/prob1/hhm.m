%   HODGKIN_HUXLEY Hodgkin-Huxley neuron model.
%   V = HODGKIN_HUXLEY(T,I_EXT) simulates the membrane voltage V of
%   the Hodgkin-Huxley neuron model in response to an external current
%   I_EXT over t T. The lengths of T and I_EXT must be the same.
%
%   units: T(seconds), I_EXT(nA), V(mV)

function [V, n, m, h] = hhm(t, I_ext)
    % Assume that the t is given in seconds, and convert it to
    % number of milliseconds:
    t = 1000 * t;
    dt = diff(t(1:2));

    % channel conductances
    g_k_max = 36;
    g_na_max = 120;
    g_l_max = 0.3;

    % Reverse potentials
    E_l = -54.387;
    E_k = -77;
    E_na = 50;

    C_m = 10;

    %% initial condition
    fun = @init_solve;
    x0 = [0, 0, 0, 0];
    x = fsolve(fun, x0);

    %% solve the pde use Euler method
    %allocate memory
    alpha_n = zeros(1, length(t));
    beta_n = zeros(1, length(t));
    alpha_m = zeros(1, length(t));
    beta_m = zeros(1, length(t));
    alpha_h = zeros(1, length(t));
    beta_h = zeros(1, length(t));
    V = zeros(1, length(t));
    n = zeros(1, length(t));
    m = zeros(1, length(t));
    h = zeros(1, length(t));

    V(1) = x(1);
    n(1) = x(2);
    m(1) = x(3);
    h(1) = x(4);

    for i = 1:length(t) - 1
        alpha_n(i) = 0.01 * (V(i) + 55) / (1 - exp(-0.1 * (V(i) + 55)));
        beta_n(i) = 0.125 * exp(-0.0125 * (V(i) + 65));
        alpha_m(i) = 0.1 * (V(i) + 40) / (1 - exp(-0.1 * (V(i) + 40)));
        beta_m(i) = 4 * exp(-0.0556 * (V(i) + 65));
        alpha_h(i) = 0.07 * exp(-0.05 * (V(i) + 65));
        beta_h(i) = 1 / (1 + exp(-0.1 * (V(i) + 35)));

        dVdt = 1 / C_m * (-g_k_max * n(i)^4 * (V(i) - E_k) - g_na_max * m(i)^3 * h(i) * (V(i) - E_na) - g_l_max * (V(i) - E_l) + I_ext(i));
        dndt = alpha_n(i) * (1 - n(i)) - beta_n(i) * n(i);
        dmdt = alpha_m(i) * (1 - m(i)) - beta_m(i) * m(i);
        dhdt = alpha_h(i) * (1 - h(i)) - beta_h(i) * h(i);

        V(i + 1) = V(i) + dVdt * dt;
        n(i + 1) = n(i) + dndt * dt;
        m(i + 1) = m(i) + dmdt * dt;
        h(i + 1) = h(i) + dhdt * dt;
    end
