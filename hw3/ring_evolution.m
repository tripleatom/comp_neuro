function [u] = ring_evolution(t, u, w, I)
    tau = 1;
    N_t = length(t);
    diffen = diff(t);
    t_step = diffen(1);

    for i = 2:N_t
        d_udt = 1 \ tau * (-u(:, i - 1) + arrayfun(@relu, w * u(:, i - 1) + I));
        u(:, i) = u(:, i - 1) + d_udt * t_step;
    end

end
