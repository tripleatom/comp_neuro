%% define D(t)
function D = calculate_D(t)
    %t is ms
    D = -cos(2 * pi .* (t - 20) / 140) .* exp(-t / 60);
end
