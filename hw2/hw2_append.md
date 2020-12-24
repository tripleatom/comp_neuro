## hw2 补

PB18061243 张潇蓉

### prob1

运行prob1.m，结果便会在不同的figure里展示出来。

#### (1)

第一次做作业时没有理解清楚题意，将外部电流设为了一个不随时间变化的常数，再改变初始时刻膜电位的值，来产生action potential。虽然也看到了一个向上的小尖峰，或许可以称之为action potential，但结果图总觉得不太对劲，且当系统达到稳定时，静息膜电位的值会向上移动。于是，这次重新设置了外部电流，在某一时间段内为正弦函数的值，得到的结果较为满意。

![action_potential](pics\1_1a.png)

![action_potential_1](pics\1_1b.png)

![1_1c](pics\1_1c.png)

![1_1d](pics\1_1d.png)

![1_1e](pics\1_1e.png)

#### (2)

要产生periodic pulses，所需要的外部电流也是周期性变化的，按照题意，改变外部电流的幅度值，我们应该会得到不同的动作电位频率。

感觉外部电流的选取挺tricky的，我参考了GitHub上一个有关HHM中的input current:

$I(t) = \sum_{m = -M}^{M}a_m \exp(j\dfrac{m\Omega t}{M})$,where,$\Omega = 2\pi \cdot 50Hz,M = 50$

给定$a_m = 3$，重复第一问的工作，得到下面的结果

![1_2a](F:\2020at\comp_neuron\hw2\pics\1_2a.png)



![1_2b](F:\2020at\comp_neuron\hw2\pics\1_2b.png)

设置当峰值大于-64mV时即可视为神经细胞产生了动作电位。通过上图我们可以看到，两个较大的峰之间还有若干小峰值，当外部电流的电流值逐渐增大时，这些峰值会逐渐超过-64mV，那么单位时间内发放动作电位的频率也就会增大。

计算firing rate可以简单地转换为对单位时间内的spike进行计数。

结果如下

![1_2d](F:\2020at\comp_neuron\hw2\pics\1_2d.png)

如果将49行的current1换成current2，current2用来产生方波，并运行那一节，可以得到下图所示结果，可以看到，动作电位的发放很强地依赖于外部电流的形式。在这种情况下，firing frequency与外部电流的frequency保持一致，不会因为方波电流的幅值的变化产生变化

![1_2e](F:\2020at\comp_neuron\hw2\pics\1_2e.png)

![1_2f](F:\2020at\comp_neuron\hw2\pics\1_2f.png)

结果好像挺简洁的，但是在调节参数上花了很多时间

以上。