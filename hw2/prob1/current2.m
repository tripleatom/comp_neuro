function [I] = current2(a_m, t)
    %% Calculates the external current
    I = a_m*square(20*pi.*t,10)+a_m;
end
