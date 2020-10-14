# hw1

张潇蓉  PB18061243

## How granule cells sample inputs

1. given that the number of granule cells is $N$, the number of mossy fiber inputs $M$, convergence of a granule cell $K$

   the number of combination of inputs: $I = \binom{M}{K}$

   the number of receive type:$R = I^N$

   if all granule cells receive different combination, the number of receive type is :$R_d = \binom{I}{N} N! $

   then, $ p = \dfrac{R_d}{R} = \dfrac{\binom{M}{K}!}{\binom{M}{K}^N[\binom{M}{K}-N]!}$

2. `prob1_plot/.m`draw the picture

   M=10,N=5

   <img src="F:\2020at\comp_neuron\hw1\pic\pic2.png" alt="pic2" style="zoom:50%;" />

   M=15,N=5

   ![pic1](F:\2020at\comp_neuron\hw1\pic\pic1.png)

   M = 20,N = 5

   ![pic3](F:\2020at\comp_neuron\hw1\pic\pic3.png)

3. the calculation steps attached at the last page.

   Answer is k $\approx$2.48, comparing to the value on the Wikipedia :"Cerebellar granule cells receive excitatory input from 3 or 4 mossy fibers originating from pontine nuclei.". I think the answer I get with a lot of approximation is roughly correct.

4. It is beneficial to have small K when M is very large. Because when K has a small value, the granule cells can roughly accomplish the task that all receive different combinations of inputs. Given that the number of k is small, the cerebellum can save a lot of space to do other functional things. This result corresponds with the Occam's Razor: entities should not be multiplied without necessity.

## Visualization of dendritic morphology

1. change `path`  in `prob2_1and2_sphere.m` to draw different plot.

   for the sake of saving time, I also use the `scatter` function in `prob2_1and2_scatter.m`  rather than `sphere` and `surf` to draw a plot

   Purkinje:

   ![purkinje](F:\2020at\comp_neuron\hw1\pic\purkinje.png)

   ![purkinje_2d](F:\2020at\comp_neuron\hw1\pic\purkinje_2d.png)

   j8:

   ![j8_3d](F:\2020at\comp_neuron\hw1\pic\j8_3d.png)

   ![j8_2d](F:\2020at\comp_neuron\hw1\pic\j8_2d.png)

   zebra fish:

   ![fish_3d](F:\2020at\comp_neuron\hw1\pic\fish_3d.png)

   ![fish](F:\2020at\comp_neuron\hw1\pic\fish.png)

2. the point which connects with 3 or more other points is a branching point, so we use the following code in `prob2_3.m`  to count

   ```matlab
   for i = 1:total
   
       if father_segment(i) > 0%exclude the cell body
           
           branching_mark(i) = branching_mark(i) + 1;
           branching_mark(father_segment(i)) = branching_mark(father_segment(i)) + 1;
       end
   
   end
   
   
   % the point which connects with 3 or more points is a branching point
   for i = 1:total
       if branching_mark(i)>2
           is_branch(i) = 1;
       end
   end
   
   
   branching_num = sum(is_branch);
   fprintf("the branching number is %d\n", branching_num);
   ```

   the number of branching point in three files are 379, 51, 128

3. change path in `prob2_4_1.m` to draw different plot

   purkinje:

   ![purkinje_sholl](F:\2020at\comp_neuron\hw1\pic\purkinje_sholl.png)

   ![purkinje_sholl_2d](F:\2020at\comp_neuron\hw1\pic\purkinje_sholl_2d.png)

   j8:

   ![j8_sholl_3d](F:\2020at\comp_neuron\hw1\pic\j8_sholl_3d.png)

   ![j8_sholl_2d](F:\2020at\comp_neuron\hw1\pic\j8_sholl_2d.png)

   zebra fish:

   ![fish_sholl_3d](F:\2020at\comp_neuron\hw1\pic\fish_sholl_3d.png)

   ![fish_sholl_2d](F:\2020at\comp_neuron\hw1\pic\fish_sholl_2d.png)

    

   to get the intersections between sphere and dendrites, I consider this question as follows, there are two points, one is at the inner side of a sphere, another is at the outer side, then we can conclude that the line between this two points have an intersection with the sphere, vice versa. Then, we do these kind of things to every pair of points with a series of spheres which radii grow step by step. I get the algorithm as follows in `prob2_4_2.m`

   ```matlab
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
   ```

    then,  I get the plots

   purkinje:

   ![purkinje_inter](F:\2020at\comp_neuron\hw1\pic\purkinje_inter.png)

   j8:

    ![j8_inter](F:\2020at\comp_neuron\hw1\pic\j8_inter.png)

   zebra fish:

   ![zebra_fish_intersection](F:\2020at\comp_neuron\hw1\pic\fish_intersection.png)

    

   

## Derivation of the Goldman-Hodgkin-Katz formula for membrane potential

The thickness of the membrane is L, use a cartesian coordinate to describe the membrane.  z=0 is the inner side, and z = L is outer. Assume the system is symmetrical in the x and y direction, so, only the z direction should take into consideration.

According to Goldman's model, only two factors influence the motion of ions:

* the average electric field
* the difference in ionic concentration from one side of the membrane to the other

The electric field is assumed to be constant across the membrane, so that it can be set equal to $\dfrac{V_m}{L}$

For a given ion denoted A with valence $ n_A$, let us calculate its flux $ j_A$—in other words, the number of ions crossing per time and per area of the membrane.

First, consider the first part: the average electric field.

$A$ is the ionic concentration of ion A.

$j_1 = -D_A \dfrac{d[A]}{dz}$,  this term corresponds to [Fick's law of diffusion](https://en.wikipedia.org/wiki/Fick%27s_laws_of_diffusion), The constant $D_A$ is the diffusion constant of the ion A.

Second term: the difference in ionic concentration from one side of the membrane to the other.

$j_2 = [A]v$

$v = \mu_q E = \mu_q \dfrac{V_m}{L}$ ,$\mu _q$ is the [electrical mobility](https://en.wikipedia.org/wiki/Electrical_mobility)

$D_A = \dfrac{\mu_q k_B T}{q} = \dfrac{\mu_q k_B T}{n_A e}$, we can get is equation from [Einstein relation](https://en.wikipedia.org/wiki/Einstein_relation_(kinetic_theory))

$\mu _q = \dfrac{n_A eD_A}{k_B T}$

$v = \mu_q \dfrac{V_m}{L} =\dfrac{n_A eD_A}{k_B T} {\dfrac{V_m}{L}}$

$j_2  = D_A \dfrac{n_A e}{k_B T} {\dfrac{V_m}{L}[A]}$

$j_A = j_1+j_2 = -D_A (\dfrac{d[A]}{dz}-\dfrac{n_A e}{k_B T} {\dfrac{V_m}{L}[A]})$

then separate the variables:

$\dfrac{d[A]}{-\dfrac{j_A}{D_A}+\dfrac{n_A e}{k_B T} {\dfrac{V_m}{L}[A]}} = dz$

denote $\mu = \dfrac{e V_m}{k_B T}, P_A = \dfrac{D_A}{L}$,$P_A$is the ionic permeability.

Integrating both sides from *z*=0 (inside the membrane) to *z*=*L* (outside the membrane) yields the solution

$j_A = \mu n_A P_A \dfrac{[A]_{out}-[A]_{in}e^{n_A \mu}}{1-e^{n_A \mu}}$

The electric current density $J_A = q_Aj_A = n_A e j_A$

There is such a current associated with every type of ion that can cross the membrane; this is because each type of ion would require a distinct membrane potential to balance diffusion, but there can only be one membrane potential. By assumption, at the Goldman voltage $V_m$, the total current density is zero

$J_{tot} = \sum_AJ_A = 0$

If all the ions are monovalent—that is, if all the $n_A$ equal either +1 or -1, i.e. ${n_A}^2 = 1$, denote the particle with positive charge ${M_i}^+$, with negative charge is ${A_j}^-$  this equation can be written

$\sum_j (e^{\mu}P_{A_{j}^{-}}[A_{j}^{-}]_{out}-P_{A_{j}^{-}}[A_{j}^{-}]_{in}) = \sum_i (P_{M_{i}^{+}}[M_{i}^{+}]_{out}-e^{\mu}P_{M_{i}^{+}}[M_{i}^{+}]_{in})$

Then, we can easily get the result:

$V_{m}=\frac{k_{B}T}{e}\ln\left(\frac{\sum_{i=1}^{N}P_{M_{i}^{+}}[M_{i}^{+}]_{out}+\sum_{j=1}^{N}P_{A_{j}^{-}}[A_{j}^{-}]_{in}}{\sum_{i=1}^{N}P_{M_{i}^{+}}[M_{i}^{+}]_{in}+\sum_{j=1}^{N}P_{A_{j}^{-}}[A_{j}^{-}]_{out}}\right)$

## Integrate and Fire Neuron



### reference

* https://en.wikipedia.org/wiki/Granule_cell
* https://en.wikipedia.org/wiki/Goldman_equation