clear;close all;
tic

% path = 'Purkinje-slice-ageP43-6.CNG.swc.txt';
% path = 'j8_L23pc.CNG.swc.txt';
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

size = 4 * pi / 3 .* segment_radius.^3;

hold on

% set colors for cell body and dendrite
parfor i = 1:total

    if segment_type(i) == 1
        color(i, :) = [0.9290, 0.6940, 0.1250];
    else
        color(i, :) = [0.6350, 0.0780, 0.1840];
    end

end

% to save time, use scatter rather than sphere
% scatter3(x_coord, y_coord, z_coord, size, color, 'filled');
scatter3(x_coord, y_coord, z_coord, segment_diameter * 5, color, 'filled');

for i = 1:total

    if father_segment(i) > 0% exclude the cell body
        temp_x = [x_coord(i), x_coord(father_segment(i))];
        temp_y = [y_coord(i), y_coord(father_segment(i))];
        temp_z = [z_coord(i), z_coord(father_segment(i))];
        line(x_coord, y_coord, z_coord);
    end

end

r = sqrt(x_coord.^2 + y_coord.^2 + z_coord.^2);
r_max = ceil(max(r));
step = ceil(r_max / 20);

[x, y, z] = sphere();

for i = 1:step:r_max
    x2 = x * i;
    y2 = y * i;
    z2 = z * i;

    s = surface(x2, y2, z2);
    s.FaceColor = 'none';
    s.LineStyle = '-';
    s.EdgeColor = [0.6350, 0.7100, 0.8040];
    alpha(s, 0.1);
end

hold off

view(3);
toc
