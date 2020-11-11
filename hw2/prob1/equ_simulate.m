clear; close all;

%% to calculate the value of V,m,n,h at stable status, then use it as initial condition
fun = @init_solve;
x0 = [0, 0, 0, 0];
x = fsolve(fun, x0);

%% solve system of ODEs
t0 = 0;
tfinal = 200;
i_e = 0.5;
hold on
% for i = 1:length(i_e)
% %set initial condition
p0 = x;
p0(1) = p0(1) + 20;
p0(5) = i_e;
[t, p] = ode45(@HHMODE, [t0, tfinal], p0);
% plot(t,p(:,1));
% end
% hold off

%% draw the result: V(t),n(t),m(t),h(t)
Ylabel = ["V", "n", "m", "h"];

for i = 1:4
    subplot(2, 2, i);
    plot(t, p(:, i));
    xlabel('t')
    ylabel(Ylabel(i));
end

%% define the function that encodes the equation
function dpdt = HHMODE(~, p)
    g_k_max = 0.36;
    g_na_max = 1.2;
    g_l_max = 0.003;
    E_l = -54.387;
    E_k = -77;
    E_na = 50;
    C_m = 10;

    V = p(1);
    n = p(2);
    m = p(3);
    h = p(4);
    I_e = p(5);

    alpha_n = 0.01 * (V + 55) / (1 - exp(-0.1 * (V + 55)));
    beta_n = 0.125 * exp(-0.0125 * (V + 65));
    alpha_m = 0.1 * (V + 40) / (1 - exp(-0.1 * (V + 40)));
    beta_m = 4 * exp(-0.0556 * (V + 65));
    alpha_h = 0.07 * exp(-0.05 * (V + 65));
    beta_h = 1 / (1 + exp(-0.1 * (V + 35)));

    dpdt = [1 / C_m * (-g_k_max * n^4 * (V - E_k) - g_na_max * m^3 * h * (V - E_na) - g_l_max * (V - E_l) + I_e);
        alpha_n .* (1 - n) - beta_n .* n;
        alpha_m .* (1 - m) - beta_m .* m;
        alpha_h .* (1 - h) - beta_h .* h;
        0;
        ];
end
