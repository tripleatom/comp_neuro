clear;close all;
tic

path = 'Purkinje-slice-ageP43-6.CNG.swc.txt';
% path = 'j8_L23pc.CNG.swc.txt';
% path = '20150608_438NiE_fish01_ZCM_ROI1_ZCM_ZCM_warped.swc.txt';

[segment_index, segment_type, x_coord, y_coord, z_coord, segment_diameter, father_segment] = readvars(path);

segment_radius = segment_diameter / 2;
segment_index = int64(segment_index);
father_segment = int64(father_segment);
segment_type = int8(segment_type);
total = max(segment_index); % the number of whole points
branching_mark = zeros(1, total); % to count how many points is connecting to one point with the exact index
color = zeros(total, 3); % give different kind of cells different color
is_branch = zeros(1, total); % to judge whether a point is a branching point



for i = 1:total

    if father_segment(i) > 0% exclude the cell body

        branching_mark(i) = branching_mark(i) + 1;
        branching_mark(father_segment(i)) = branching_mark(father_segment(i)) + 1;
    end

end

% the point which connects with 3 or more points is a branching point
for i = 1:total

    if branching_mark(i) > 2
        is_branch(i) = 1;
    end

end

branching_num = sum(is_branch);
fprintf("the branching number is %d\n", branching_num);

toc
