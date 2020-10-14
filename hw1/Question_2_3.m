clear;close all;

file_list=["j8_L23pc.CNG","Purkinje-slice-ageP43-6.CNG","20150608_438NiE_fish01_ZCM_ROI1_ZCM_ZCM_warped"];
title_list=["Given Pyramidal Dendrite","Given Purkinjie Dendrite","Given Arbor from Larval Zebrafish"];
save_list=["j8_L23pc_CNG","Purkinje-slice-ageP43-6_CNG","20150608_438NiE_fish01_ZCM_ROI1_ZCM_ZCM_warped"];

interval=10;

for file_num=1:3
    
    %load the data
    filename='data\'+file_list(file_num)+'.swc.txt';
    value=textread(filename);
    [point_num,parameter_num]=size(value);
    
    point_type=1:point_num;
    point_x=point_type;
    point_y=point_x;
    point_z=point_x;
    point_d=point_x;
    point_father=point_x;
    
    point_type(:)=value(1:point_num,2);
    point_x(:)=value(1:point_num,3);
    point_y(:)=value(1:point_num,4);
    point_z(:)=value(1:point_num,5);
    point_d(:)=value(1:point_num,6);
    point_father(:)=value(1:point_num,7);
    
    %find the last node of cell body as the center of coordination
    if point_type(1)==0
        max_d=max(point_d);
        center=1;
        for i=1:point_num
            if point_d(i)/max_d>=0.9
                center=i;
            end
        end
    else
        center=1;
        for i=1:point_num
            if point_type(i)==1
                center=i;
            end
        end
    end
    
    x0=point_x(center);
    y0=point_y(center);
    z0=point_z(center);
    r0=point_d(center)/2;
    
    %create two arrays to describe every line
    line_r_min=zeros(1,point_num);%the distance from center to the internal endpoint of every line
    line_r_max=zeros(1,point_num);%the distance from center to the external endpoint of every line
    
    %calculate the previous distance
    for i=1:point_num
        if point_type(i)~=1
            j=point_father(i);
            if j~=-1
                line_r_min(i)=sqrt((point_x(j)-x0)^2+(point_y(j)-y0)^2+(point_z(j)-z0)^2);
                line_r_max(i)=sqrt((point_x(i)-x0)^2+(point_y(i)-y0)^2+(point_z(i)-z0)^2);
                if line_r_min(i)>line_r_max(i)
                    temp=line_r_min(i);
                    line_r_min(i)=line_r_max(i);
                    line_r_max(i)=temp;
                end
            end
        end
    end
    
    %the number of layers in sphere where the endpoints of lines stay
    line_r_min_norm=ceil(line_r_min/interval);
    line_r_max_norm=floor(line_r_max/interval);
    
    max_sphere=max(line_r_max_norm);
    
    %count the spheres which the lines pass through
    sholl_list=zeros(1,max_sphere);
    for k=1:point_num
        if line_r_max_norm(k)~=0
            if line_r_min_norm(k)==0
                line_r_min_norm(k)=1;
            end
            for p=line_r_min_norm(k):line_r_max_norm(k)
                sholl_list(p)=sholl_list(p)+1;
            end
        end
    end
    
    %plot
    figure(file_num);
    xx=(1:max_sphere)*10;
    max_count=max(sholl_list);
    plot(xx,sholl_list);axis([0,max_sphere*10,0,ceil(max_count/5)*5]);
    xlabel('Sphere radius(nm)');ylabel('Number of intersections');
    figure_name='Sholl plot of '+title_list(file_num);
    title(figure_name);
    save_name='pic\'+save_list(file_num)+'_sholl.jpg';
    saveas(gcf,save_name);
    close(file_num);
    
end