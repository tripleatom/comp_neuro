tic

path = '20150608_438NiE_fish01_ZCM_ROI1_ZCM_ZCM_warped.swc.txt';

[segment_index, segment_type, x_coord, y_coord, z_coord, segment_diameter, father_segment] = readvars(path);

segment_radius = segment_diameter / 2;
segment_index = int64(segment_index);
father_segment = int64(father_segment);
segment_type = int8(segment_type);
total = max(segment_index);
branching_mark = zeros(1, total);

n = 30;
[x, y, z] = sphere(n);

color1 = zeros(size(x));
color3 = zeros(size(x));

for i = 1:1:length(color1(1, :))

    for j = 1:1:length(color1(:, 1))
        color1(i, j, 1) = 1;
        color1(i, j, 2) = 1;
        color1(i, j, 3) = 0;
    end

end

for j = 1:1:length(color3(1, :))

    for k = 1:1:length(color3(:, 1))
        color3(j, k, 1) = 0.6350;
        color3(j, k, 2) = 0.0780;
        color3(j, k, 3) = 0.1840;
    end

end

hold on

parfor i = 1:total

    x2 = x * segment_radius(i);
    y2 = y * segment_radius(i);
    z2 = z * segment_radius(i);

    if segment_type(i) == 1
        s = surf(x2 + x_coord(i), y2 + y_coord(i), z2 + z_coord(i), color1);
    else
        s = surf(x2 + x_coord(i), y2 + y_coord(i), z2 + z_coord(i), color3);
    end

    s.EdgeColor = 'none';
end

%r = sqrt(x_coord.^2+y_coord.^2+z_coord.^2);

%scatter3(x_coord, y_coord, z_coord, size, color, 'filled');

for i = 1:total

    if father_segment(i) > 0
        branching_mark(father_segment(i)) = 1;
        temp_x = [x_coord(i), x_coord(father_segment(i))];
        temp_y = [y_coord(i), y_coord(father_segment(i))];
        temp_z = [z_coord(i), z_coord(father_segment(i))];
        line(x_coord, y_coord, z_coord);
    end

end

branching_num = sum(branching_mark);
hold off

toc
