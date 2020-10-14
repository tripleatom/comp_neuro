clear;close all;
tic

%path = 'Purkinje-slice-ageP43-6.CNG.swc.txt';
%path = 'j8_L23pc.CNG.swc.txt';
path = '20150608_438NiE_fish01_ZCM_ROI1_ZCM_ZCM_warped.swc.txt';

[segment_index, segment_type, x_coord, y_coord, z_coord, segment_diameter, father_segment] = readvars(path);

segment_radius = segment_diameter / 2;
segment_index = int64(segment_index);
father_segment = int64(father_segment);
segment_type = int8(segment_type);
total = max(segment_index); % the number of whole points
branching_mark = zeros(1, total); % to count how many points is connecting to one point with the exact index
color = zeros(total, 3); % give different kind of cells different color
is_branch = zeros(1, total); % to judge whether a point is a branching point

r = sqrt(x_coord.^2 + y_coord.^2 + z_coord.^2);
r_max = ceil(max(r));
n = 300;
step = ceil(r_max / n);

inter_num = zeros(1, n + 5);
r_length = zeros(1, n + 5);

for i = 1:n + 5
    temp_r = step * i;
    r_length(i) = temp_r;
    count = 0;

    for j = 2:total

        if (r(j) - temp_r) * (r(father_segment(j) )- temp_r) <= 0
            count = count + 1;
        end

    end

    inter_num(i) = count;
end

plot(r_length, inter_num);
xlabel('r');
ylabel('inter number');

toc
