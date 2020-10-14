clear;close all;
M = 20; % mossy fiber inputs
N = 5; % granule cells number

save_k = []; % convergence of granule cell
save_p = []; % possibility

for k = 1:M - 1
    fac = factorial(N);
    I = nchoosek(M, k);
    R = power(I, N);

    if I >= N %to ensure that next step can calculate
        R_d = nchoosek(I, N);
        p = R_d * fac / R;

        save_k = [save_k; k];
        save_p = [save_p; p];
    end

end

stem(save_k, save_p,'.');
