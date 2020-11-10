function F = init_solve(x)
    g_k_max = 0.36;
    g_na_max = 1.2;
    g_l_max = 0.003;
    E_l = -54.387;
    E_k = -77;
    E_na = 50;
    I_e = 0;
    %init_solve - solve the value of n,m,h at the initial time
    %
    % Syntax: F = init_solve(x)
    %
    % when the cell at the rest status, there is a forth order non_linear equation
    V = x(1);
    n = x(2);
    m = x(3);
    h = x(4);

    alpha_n = 0.01 * (V + 55) / (1 - exp(-0.1 * (V + 55)));
    beta_n = 0.125 * exp(-0.0125 * (V + 65));
    alpha_m = 0.1 * (V + 40) / (1 - exp(-0.1 * (V + 40)));
    beta_m = 4 * exp(-0.0556 * (V + 65));
    alpha_h = 0.07 * exp(-0.05 * (V + 65));
    beta_h = 1 / (1 + exp(-0.1 * (V + 35)));

    n_inf = alpha_n / (alpha_n + beta_n);
    m_inf = alpha_m / (alpha_m + beta_m);
    h_inf = alpha_h / (alpha_h + beta_h);

    F(1) = -g_k_max * n^4 * (V - E_k) - g_na_max * m^3 * h * (V - E_na) - g_l_max * (V - E_l) + I_e;
    F(2) = n - n_inf;
    F(3) = m - m_inf;
    F(4) = h - h_inf;

end
