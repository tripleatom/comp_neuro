function [output_arg] = relu(arg)
    sz = size(arg);
    output_arg = zeros(sz);

    for i = 1:sz(1)

        for j = 1:sz(2)

            if arg(i, j) >= 0
                output_arg(i, j) = arg(i,j);
            end

        end

    end

end
