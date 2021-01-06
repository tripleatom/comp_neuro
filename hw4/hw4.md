# hw4

张潇蓉 PB18061243

## prob1

先利用分部积分证明hint中提示的内容：$\langle xF(\alpha x)\rangle = \alpha\sigma^2\langle F'(\alpha x)\rangle$

$\begin{aligned}\alpha\sigma^2\langle F'(\alpha x)\rangle &= \alpha\sigma^2\int dxF'(\alpha x)\frac{1}{\sqrt{2\pi\sigma^2} } \exp (\frac{-x^2}{2\sigma^2}) \\&= \sigma^2\int dF(\alpha x)\frac{1}{\sqrt{2\pi\sigma^2} } \exp (\frac{-x^2}{2\sigma^2})\\&= \sigma^2[F(\alpha x)\frac{1}{\sqrt{2\pi\sigma^2} } \exp (\frac{-x^2}{2\sigma^2})|_{-\infty}^{+\infty}+\int dx \dfrac{x}{\sigma^2} F(\alpha x)\frac{1}{\sqrt{2\pi\sigma^2} } \exp (\frac{-x^2}{2\sigma^2})]\\&=\int dx [x F(\alpha x)]\frac{1}{\sqrt{2\pi\sigma^2} } \exp (\frac{-x^2}{2\sigma^2})\\& = \langle xF(\alpha x)\rangle\end{aligned}$

由题意可知stimulus$s(t)$是一个高斯白噪声过程，我们由随机过程的知识知道，这个特定的过程有**遍历性**，即在某个time window上的值在不同trail上的平均可以用这个过程在一次trial中的长时程平均表示，即时域上的长时程平均和trial的平均是等价的，再由这个过程是**平稳的**（至少是宽平稳的）可知过程的均值是一个与时间无关的常量。

由题目可知，s的stimulus autocorrelation function是$\sigma_s^2\delta(\tau)$，那么对某个时间节点的s，它在不同trial下的variance即$Var(s(t)) = \sigma_s^2$，是一个与时间无关的量

不加证明的给出这个命题：$F[L(t)]s(t-\tau)$也有上述的很好的性质。那么我们后就可以开始推导(4)式：

$\begin{align}\dfrac{1}{\sigma^2 T}\int_0^TF[L(t)]s(t-\tau)dt &= \dfrac{1}{\sigma^2 }\langle F[L(t)]s(t-\tau)\rangle \\&= \dfrac{Var(s(t))}{\sigma^2} \langle \dfrac{dF}{dL}\dfrac{\delta L}{\delta s}\rangle \\&=\langle \dfrac{dF}{dL}D(\tau)\rangle \\&=  \dfrac{D(\tau)}{T}\int_0^{T}dt\dfrac{dF}{dL} \end{align}$

## prob2



















## prob3

