# HW3

PB18061243 张潇蓉

### prob1

相关代码在prob1.m中

#### (a)

令$\begin{cases}\dfrac{dx}{dt} = 0\\\dfrac{dy}{dt} = 0\end{cases}$易得不动点$\begin{cases}    x_0=\dfrac{\tau V_0}{a-2}\\    y_0=\dfrac{\tau V_0}{4}\dfrac{a-4}{a-2} \end{cases}$

本题中$f(x,y) = \dfrac{1}{\tau}(-ax-2y+\tau V_0)\\g(x,y ) = \dfrac{1}{\tau}(-(3-a)x-y-\tau V_0) $

 利用上课所讲方法进行展开得到

$J = \left(\begin{array}--\dfrac{a}{\tau}&	-\dfrac{2}{\tau}\\\dfrac{a-3}{\tau}&-\dfrac{1}{\tau}\end{array}\right)$

那么$\lambda_1+\lambda_2 = -\dfrac{1+a}{\tau}\\\lambda_1\cdot\lambda_2 = \dfrac{3a-6}{\tau^2}$

如果要求系统stable，那么就必须有$\lambda_1+\lambda_2<0, \lambda_1\cdot\lambda_2>0\Rightarrow a>2$

解方程易得$\lambda_{1,2} = -\dfrac{1+a}{2\tau}\pm\dfrac{|a-5|}{2\tau}$

继续利用上课讲到的方法，得到

$x = c_1e^{\lambda_1t}+c_2e^{\lambda_2t}+x_0$

由初始条件可得$\begin{cases}    c_1+c_2 +x_0= 0\\ \lambda_1c_1+\lambda_2c_2 = V_0 \end{cases}\Rightarrow \begin{cases}c_1 = \dfrac{\lambda_2x_0+V_o}{\lambda_1-\lambda_2}\\c_2 =-\dfrac{\lambda_1x_0+V_o}{\lambda_1-\lambda_2} \end{cases}$

当系统为stable情况时，随着时间的演化，$x$会收敛到不动点处，取值$V_0 = 1,\tau = 0.5,a = 3$时的模拟结果如下图所示

<img src=".\pics\xt.png" alt="xt" style="zoom:50%;" />

#### (b)

如果时perfect integrator，那么必然有$x=Vt,\dfrac{dx}{dt} = V$

那么方程变为$\tau V = -ax-2y+\tau V,\Rightarrow y = -a/2x$

代入第二个方程，$-a/2\tau V = -(3-a)x+(a/2)x-\tau V，\Rightarrow a = 2$

作图验证可得

<img src="F:\2020at\comp_neuron\hw3\pics\a2.png" alt="a2" style="zoom:50%;" />

通过调整参数作图可以得到$a\in (1.998,2.002)$时，误差在$0.1cm$范围内

在区间左侧，x值会发散，如下图

<img src="F:\2020at\comp_neuron\hw3\pics\a1.png" alt="a1" style="zoom:50%;" />

在区间右侧，会迅速收敛到不动点

<img src="F:\2020at\comp_neuron\hw3\pics\a4.png" alt="a4" style="zoom:50%;" />

### prob2

需要代码模拟的小问分别放进了代码的不同节中，运行`prob2.m`执行即可

gen_I 用来得到外部电流

gen_w 用来得到矩阵$\omega$

relu是完成线性整流

ring_evolution欧拉法解决微分方程来得到系统随时间演化的值

genplot 和 setaxis为绘图时设置坐标轴用到的函数

#### (a)

我们可以把$\cos(\mu \theta)+\sin(\mu\theta)$写在一起写成$e^{i\omega \theta}$，$\omega$为连续变量

对于式子$\int d\theta' J(\theta-\theta')\exp(i\omega\theta') $

换元$\tau = \theta-\theta'$后

原式$= (\int d\tau J(\tau)\exp(-i\omega\tau))\exp(i\omega \theta)$

易得$\exp(i\omega\theta)$为特征函数，$\omega$离散化后就为离散的$\mu$值

由上述推导易得$\lambda_\mu = \dfrac{1}{2\pi}\int_{-\pi}^{+\pi}d\tau J(\tau)\exp(-i\omega\tau) =\dfrac{1}{2\pi}\int_{-\pi}^{+\pi}d\tau J(\tau)\cos(\omega\tau)$

设$\cos(\mu\theta)$归一化系数为$a_n$，$\int_{-\pi}^{+\pi}d\theta a_n^2\cos^2(\mu\theta) = 1$

易得$a_0= \dfrac{1}{\sqrt{2\pi}},n\neq0,a_n =\dfrac{1}{\sqrt{\pi}}$

$\sin(\mu \theta)$的归一化系数$b_n$同理可得$b_n =\dfrac{1}{\sqrt{\pi}}$

#### (b)

选择$e_\mu = \dfrac{1}{\sqrt{2\pi}}(\cos(\mu\theta)+\sin(\mu\theta))$

设$u(\theta,t) = \sum_{\mu}c_\mu(t)e_\mu$

代入方程(4)

$\tau\sum\dfrac{dc_\mu(t)}{dt}e_\mu = -\sum_\mu c_\mu e_\mu+\sum_\mu c_\mu\lambda_\mu e_\mu+I$

再根据基矢的正交特性

$\tau\dfrac{dc_\mu(t)}{dt} = - c_\mu（1-\lambda_\mu） +\int_{-\pi}^{+\pi}I\cdot e_\mu d\theta$

记等式最右侧一项为$M_\mu = \int_{-\pi}^{+\pi}I\cdot e_\mu d\theta$

代入$I = I_0+I_1\cos(\theta-\theta_0)$得到

$M_0 = I_0 \sqrt{2\pi},M_1 = \sqrt{\pi/2}I_1\cos{\theta_0}$,其余均为0

$\lambda_0 =J_0,\lambda_1 = \dfrac{J_1}{2}$，其余为0

套用recurrent circuits中的结论（如下图），

![sol](F:\2020at\comp_neuron\hw3\pics\sol.png)

本题微分方程的解为

$c_\mu(t) = \dfrac{M_\mu}{1-\lambda_\mu}\{1-\exp[{\dfrac{-t(1-\lambda_\mu)}{\tau}]}\}+c_\mu(0)\exp(\dfrac{-t(1-\lambda_\mu)}{\tau})$

* 当$\lambda_0,\lambda_1$均小于1，即$J_0<1,J_1<2$时，当时间趋于正无穷时，u有一个**极限分布**$u_\infty = \sum\limits_{\mu = 1}^{N_\mu}\dfrac{M_\mu}{1-\lambda_\mu}e_\mu$

* 但当任意一个$\lambda_\mu>1$时，$c_\mu(t)$都会随着时间的增长趋向于无穷，u会**explode**

* 当$\lambda_\mu<0$时，时间常数$\dfrac{\tau}{1-\lambda_\mu}$会变得很小，u的收敛速度会很慢，同时，相应基矢上对应的扩大后的振幅也比较小

* 当某一项$\lambda_\mu$趋近于1时，这一项对收敛起**主导作用**，因为这一项的时间常数很小，且$\dfrac{M_\mu}{1-\lambda_\mu}$的值很大，这个系统就有了selective amplification的作用

#### (c)

因为$u$为homogeneous，故$u(\theta,t) = u(t)$，设稳态时，值为$u_0$，故有式子

$u_0 = [\dfrac{u_0}{2\pi}\int_{-\pi}^{+\pi}(J_0+J_1\cos(\theta-\theta'))d\theta'+I_0]_+ = u_0J_0+I_0\\u_0 = \dfrac{I_0}{1-J_0}$

这里要求$J_0<1$

如果假设系统在演化的过程中，系统的u始终与角度无关，那么我们直接将$J$代入演化方程，那么我们会得到$\tau\dfrac{du}{dt} = [-u+J_0u+I_0]_+$，这个式子说明这样的演化和$J_1$无关，那么就与题目中要进行的讨论就没有关系，所以说明$u$与角度无关这个条件在系统演化过程中并不成立

那么我们再回归到一般形式的方程，**理论上看**，根据(b)问中的分析，我们已经可以看到，当$J_1>2$时，指数项会随着时间的增加趋向于正无穷，系统不稳定，趋向于正无穷

我们也可以通过程序**模拟**演化过程来看，给定系统初始状态，并给一定的微扰，看系统是否能回到每个角度的u均相同的状态，如果落到了其他的状态或者进入了混沌的情况，那么就可以直观地说明，这个点的值确实unstable

下图将一部分神经元的u值偏移了这个naive值，然后让其随时间演化，结果如下图所示。如果这个点为stable的值，那么最后应该会回复到每个角度都相同的情况。

相关参数取值：J_0 = 0.8; J_1 = 2.5; I_0 = 1; I_1 = 0;

![2cini](F:\2020at\comp_neuron\hw3\pics\2cini.png)

![2cfin](F:\2020at\comp_neuron\hw3\pics\2cfin.png)

为确保系统的确演化到了稳定的状态，作了一张其中一个神经元随时间演化的图，如下

<img src="F:\2020at\comp_neuron\hw3\pics\2(c).png" alt="2(c)" style="zoom:50%;" />

可见在小波动的情况下，系统并没有回到每个角度都相同的值，可见当$J_1>2$时这并不是一个stable的解

那么改变初始值，当$J_1 = 1$时，我们得到下图结果，可见系统时可以恢复到homogeneous的状态的

![2cinistable](F:\2020at\comp_neuron\hw3\pics\2cinistable.png)

![2cfinstable](F:\2020at\comp_neuron\hw3\pics\2cfinstable.png)

#### (d)

这一问可以用**数学的方法直接证明**，上课时的推导过程是在$\varphi = 0$的特殊情况下得到的，那么在此题推导时，假设$u(\theta) =[u_0+u_1\cos(\theta-\varphi)]_+$

根据讲义上推导的思路，

得到$u(\theta) = u_1[\cos(\theta-\varphi)-\cos(\theta_c)]_+$

令$\theta_0 = 0$

有$u_1 = \dfrac{J_1}{2\pi}\int^{\theta_c}_{-\theta_c}u_1\cos{\theta}(\cos(\theta-\varphi)-\cos(\theta_c))d\theta\\ 1 =\dfrac{J_1}{2\pi}(\dfrac{1}{2}\sin(2\theta_c)\cos\varphi+\theta_c\cos\varphi-\sin{2\theta_c})$

得到$\theta_c = \theta_c(J_1)$的表达式

同理

$-u_1\cos{\theta_c} =\dfrac{J_1}{2\pi}\int^{\theta_c}_{-\theta_c}u_1(\cos(\theta-\varphi)-\cos(\theta_c))d\theta+I_0\\=\dfrac{J_0u_1}{\pi}(\sin\theta_c\cos\varphi-\theta_c\cos\theta_c)+I_0$

记$f(\theta_c) = \dfrac{1}{\pi}(\sin\theta_c\cos\varphi-\theta_c\cos\theta_c)\\u_1 = \dfrac{-I_0}{f(\theta_c)J_0+\cos\theta_c}$

得到$u_1 = u_1(\theta_c,J_0,I_0)$

上述式子与课堂上讨论的很相似，即任意一个$\varphi$都对应着一个稳定解

即不同的$J_0,J_1,I_0$对应于不同的稳定情况，即bump产生于不同的位置



同这个结果也可以通过**模拟**来说明，当给系统不同的$J_0,J_1,I_0$值时，bump会产生于不同的位置

u的初始值由random产生，为[0,1]上均匀分布的随机数

$J_0 = 0.8; J_1 = 2.2; I_0 = 1; I_1 = 0$

![0.800_2.200_1.000_0.000](F:\2020at\comp_neuron\hw3\pics\0.800_2.200_1.000_0.000.png)

$J_0 = 0.8; J_1 = 2.5; I_0 = 1; I_1 = 0$

<img src="F:\2020at\comp_neuron\hw3\pics\0.800_2.500_1.000_0.000.png" alt="0.800_2.500_1.000_0.000"  />

$J_0 = 0.8; J_1 = 3.0; I_0 = 1; I_1 = 0$

<img src="F:\2020at\comp_neuron\hw3\pics\0.800_3.000_1.000_0.000.png" alt="0.800_3.000_1.000_0.000"/>

$J_0 = 0.6; J_1 = 4.0; I_0 = 1; I_1 = 0$

![0.600_4.000_1.000_0.000](F:\2020at\comp_neuron\hw3\pics\0.600_4.000_1.000_0.000.png)

由后两种情形可以看出，最终结果虽然是relu后的正弦值，比较好看，但随着时间延长，它的幅值是发散的，$u_t$图像也可以看出

但总体上还是能看得到随着参数的变化，bump的值是在移动的物理图像

#### (e)

通过上面的讨论，以及选取了多组$J_0,J_1,I_0$值的讨论我们有下面的结论

当$J_0>1$时，结果必然是发散的，如下图

$J_0 = 1.5; J_1 = 1.9; I_0 = 1; I_1 = 0$

![1.500_1.900_1.000_0.000](F:\2020at\comp_neuron\hw3\pics\1.500_1.900_1.000_0.000.png)

故右半边不再讨论，下面讨论均在$J_0<1$范围内进行

$J_1<2$时，系统处于homogeneous的状态

$J_0 = 0.8; J_1 = 1.5; I_0 = 1; I_1 = 0$

![0.800_1.500_0.100_0.000](F:\2020at\comp_neuron\hw3\pics\0.800_1.500_0.100_0.000.jpeg)

根据(b)问中的讨论我们也知道，在某个特征值十分靠近1时，其对稳态的贡献就会比较明显，$J_0$贡献的是常数项，$J_1$贡献体现在余弦函数项上，我们发现在$J_1$逐渐靠近2的过程中，稳态结果逐渐显示出波动性

$J_0 = 0.8; J_1 = 1.9; I_0 = 1; I_1 = 0$

![0.800_1.900_1.000_0.000](F:\2020at\comp_neuron\hw3\pics\0.800_1.900_1.000_0.000.png)

$J_0 = 0.8; J_1 = 1.999; I_0 = 1; I_1 = 0$

![0.800_1.999_1.000_0.000](F:\2020at\comp_neuron\hw3\pics\0.800_1.999_1.000_0.000.png)

$J_0 = 0.8; J_1 = 1.999999; I_0 = 1; I_1 = 0$

![0.800_2.000_1.000_0.000](F:\2020at\comp_neuron\hw3\pics\0.800_2.000_1.000_0.000.png)

在$(d)$问的讨论中我们也看到，当$J_1>2$时，在其不超过某一值时，系统会处于较为稳定的stable态，但当$J_1$继续增大时，结果就会趋向无穷大直至发散，但现在还没有找到发散的临界值$J_s = f(J_0)$的具体形式，现在我们可以得到下面这样的相图

<img src="F:\2020at\comp_neuron\hw3\pics\dfraft.png" alt="54739FFAAE21E988083C92D209131558" style="zoom: 33%;" />

下面就需要求解$f(J_0)$的形式

根据讲义的求解内容

![image-20201224230438151](F:\2020at\comp_neuron\hw3\pics\notes1.png)

47式求得$\theta_c = \theta_c(J_1)$，再观察$(49)$式，如果分母为0，那么$u_1$就发散了

那么联立右边两式$\begin{cases}    1 = J_1/2\pi(\theta_c-1/2\sin2\theta_c)\\  u_1 = \dfrac{-I_0}{f(\theta_c)J_0+\cos\theta_c}\end{cases}$

得到的$J_1 = J_1(J_0)$的关系式即为分界线的解析值

#### (f)

这一问直接改变程序中的$\theta$的值运行程序，得到结果并观察即可，结果很清晰

$J_0 = 0.8; J_1 = 2.2; I_0 = 1; I_1 = 0.01$

$\theta =\pi /2$

<img src="F:\2020at\comp_neuron\hw3\pics\1.571_1.000_0.1000.png" alt="1.571_1.000_0.1000" style="zoom:50%;" />

$\theta =\pi$

<img src="F:\2020at\comp_neuron\hw3\pics\3.142_1.000_0.0100.png" alt="3.142_1.000_0.0100" style="zoom:50%;" />

$\theta =3\pi /2$

<img src="F:\2020at\comp_neuron\hw3\pics\4.712_1.000_0.0100.png" alt="4.712_1.000_0.0100" style="zoom:50%;" />

#### (g)

orzzzz 迟了一周，之前整大物实验再加上一直没理解第二题是在问什么于是就没有做完，bonus明天写，先把前面内容交掉