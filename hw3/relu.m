function [output_arg] = relu(arg)

    if arg >= 0
        output_arg = arg;
    else
        output_arg = 0;
    end

end
