function [num, spike] = find_spike(V)
    %% Count the number of spikes in voltage

    spike = V(2:end - 1) > V(1:end - 2) & V(2:end - 1) > V(3:end) & V(2:end - 1) > -64;
    spike = [false spike false];
    num = sum(double(spike));

end
