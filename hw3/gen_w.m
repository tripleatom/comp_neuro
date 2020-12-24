function [w] = gen_w(J_0, J_1, w)
    % generate matrix w
    N = length(w);

    for i = 1:N

        for j = 1:i
            w(i, j) = 1 / N * (J_0 + J_1 * cos(2 * pi / N * (i - j)));
            w(j, i) = w(i, j);
        end

    end

end
