clear;close all;

t = log(2);

x_1 = linspace(0.001,t);
y_1_temp = 1./(1-exp(-x_1))-2;
y_1 = 1./(x_1.*ceil(y_1_temp));

plot(x_1,y_1);
hold on

x_2 = linspace(t,20);
y_2 = 1./x_2;

plot(x_2,y_2);

xlabel('T');
ylabel('f');

hold off