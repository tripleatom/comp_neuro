clear;close all;

a = -5;
b = 100;
c =  20;
max_length = 10;

I = 0;
v =-max_length:0.5:max_length;
w = -max_length:0.5:max_length;
[V,W] = meshgrid(v,w);


V_dot = V.*(a-V).*(V-1)-W+I;
W_dot = b*V-c*W;
hold on
quiver(V,W,V_dot,W_dot);
fplot(@(V) V.*(a-V).*(V-1)+I )
fplot(@(V) b/c*V)
xlabel("V")
ylabel("w")
axis([-max_length max_length -max_length max_length])
axis equal

%% draw the tracks
delta_t = 0.1;
t0 = 0;
tfinal = 1000;
t = t0:delta_t:tfinal;
initial_x = 0;
initial_y = 0;
x = zeros(1,(tfinal-t0)/delta_t);
y = 