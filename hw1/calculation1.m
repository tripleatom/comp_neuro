M = 7000;
N = 21000;

syms m;
s1 = solve(2 * log(0.95) / power(N, 3) == -m * m - m / N);

for i = 1:2

    if s(i) > 0
        op_s = s1(i);
    end

end

t = 1 / op_s;

syms k;
s2 = vpasolve(log(t) == M * log(M) - k * log(k) - (M - k) * log(M - k), k);

fprintf("%3.2f\n", s2);
