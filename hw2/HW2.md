# HW2

PB18061243 张潇蓉

## prob1

### （1）

首先利用所给方程求解神经元的静息状态，令所有变化率为0，且令$I_e = 0$，求解非齐次方程，将方程存入`init_solve.m`。相应不带单位的数值为：$V = -64.9964,n = 0.3177,m = 0.0530,h = 0.5960$

初始时，给$V$一个偏离稳态的扰动，并设置合适的$I_e$值，即可得到，$(V= -44，I_e = 0.5)$

![V-44_ie0.5](F:\2020at\comp_neuron\hw2\pics\V-44_ie0.5.png)

如果设置其他值会有可能得到发散的结果，例如当i较大时就会发散，如下图，曲线由下到上代表i逐渐增大

![V_t](F:\2020at\comp_neuron\hw2\pics\V_t.png)

### （2）

如果设置稳恒电流，V的图像与上图相同，不会有周期性的行为，若能设置方波电流，应该可以使得V有周期性行为（没赶在ddl前完成，之后补上orz）

## prob2

### (1)

令时间变化率为0，画图，易得nullclines，下图参数

```
a = 5;
b = 100;
c =  30;
I = 0;
```

![vector_field2](F:\2020at\comp_neuron\hw2\pics\vector_field2.png)

### （2)

如果（0，0）为不动点，I 为0。

![handdraft](F:\2020at\comp_neuron\hw2\pics\handdraft.PNG)

可分别取位于五个区域中的点画出其在V-w相图上的轨迹

```
I：a = -4,b = 100,c = 30;
II:a = -24.9,b = 500,c = 20;
III:a = -32,b = 1000,c = 30;
IV:a = 20,b = 100,c = 20;
V:a = -5;b = 100;c = 20
```

i. 选择 I:a = -4,b = 100,c = 30;作图后发现,一共有三个不动点，虽然(0,0)为不稳定不动点，但是另一个与它位置很近的点是稳定的，相点没过多久就落到另一个不动点(0.2078,0.6928)上了。如下图那条很短的紫色的线条

![-4_100_30](F:\2020at\comp_neuron\hw2\pics\-4_100_30.png)

ii.![-24_500_20](F:\2020at\comp_neuron\hw2\pics\-24_500_20.png)

iii.![-32_1000_30](F:\2020at\comp_neuron\hw2\pics\-32_1000_30.png)

iv.![20_100_20](F:\2020at\comp_neuron\hw2\pics\20_100_20.png)

v.![-5_100_20](F:\2020at\comp_neuron\hw2\pics\-5_100_20.png)

### (3)

设方程的根为$\omega_0,V_0$

$Jaccobi = \left(\begin{array}{ccc}-3V_0^2+2(a-1)V_0-a&	-1\\b&-c\end{array}\right)$

若有两个稳定的不动点，则要求$\tau<0,\Delta>0$

即$-3V_0^2+2(a-1)V_0-a-c<0\\c(3V_0^2-2(a-1)V_0+a)+b>0$

方程有两个根满足该条件即可

## prob3

### (1)

（0，0）始终为不动点

如果有其余的不动点存在，说明方程组$\begin{cases}-x+\tanh(Jx-Ky) = 0 \\-y+Gx = 0\end{cases}$有解，即$x = \tanh(J-KG)x$有解

记$\alpha = J-KG$，有$\alpha = \dfrac{\tanh ^{-1}x}{x}$,容易求得其最小值为$1$，所以当$J-KG> 1$时有3个不动点。

不动点的x坐标为交点的横坐标$x$，$y = Gx$。

eg.$J-KG = 1.3$时，解得$x \approx \pm 0.752$，还有$x=0$,

$J-KG<1$或$J-KG = 1$时仅有一个不动点

### (2)

对于此题

$f(x) =-x+\tanh(Jx-Ky) = 0\\g(x) = -y+Gx = 0 $ 

用上课所用方法展开，得到行列式

$Jaccobi = \left(\begin{array}{ccc}-1+J&	-K\\G&-1\end{array}\right)$

$\tau = J-2\\\Delta = 1-J+GK\\\tau^2-4\Delta  =J^2-4GK$

![handdraft2](F:\2020at\comp_neuron\hw2\pics\handdraft2.png)

未涂色的另一侧也为不稳定点，即不会返回（0，0）点

### (3)

仅有一个不动点时，$\Delta = 1-J+GK \geq 0$

取$J = 3,K = 2,G = 1$,选择$[-15,15]*[-15,15]$的区域为R，取格子长度为2的格点分别为x，y的初始位置，考察其随时间的演化，用`prob3`文件夹中的`prob3_3.m`画图，可以看到，无论初始位置在哪里，最终都趋向于（0，0）点附近的一个椭圆形状的极限环(用了步进的方法，没有解微分方程orz)

![3_3](F:\2020at\comp_neuron\hw2\pics\3_3.png)

### (4)

由第二问的结果可以考察出只有一个不动点时的情形，以下手写部分考察除(0,0)点外其他两个不动点的行为

![3_4](F:\2020at\comp_neuron\hw2\pics\3_4.png)

### （5)

利用代码`prob3_5.m`进行模拟

1. 

![1_t](F:\2020at\comp_neuron\hw2\prob3\1_t.png)

![1_phase](F:\2020at\comp_neuron\hw2\prob3\1_phase.png)

2. ![2_t](F:\2020at\comp_neuron\hw2\prob3\2_t.png)

   ![2_phase](F:\2020at\comp_neuron\hw2\prob3\2_phase.png)

3. ![3_t(3,4,5)](F:\2020at\comp_neuron\hw2\prob3\3_t(3,4,5).png)

   ![3_phase(3,4,5)](F:\2020at\comp_neuron\hw2\prob3\3_phase(3,4,5).png)

4. ![4_t](F:\2020at\comp_neuron\hw2\prob3\4_t.png)

   ![4_phase](F:\2020at\comp_neuron\hw2\prob3\4_phase.png)

可见最后一张图，轨迹从（0，0）附近出发，没有恢复原状态，但由于有另一个不动点，所以最后落到了另一个不动点上

