
# 简介

毕业论文题目为《高速路收费广场优化设计与分析》，主要运用了交通流理论中常用的模型方法与现今较为广泛应用的模型方法（元胞自动机），具体考察高速公路出入口收费站（单收费窗口模式）提高车流量的优化问题，通过计算机模拟不同车道情况下，设置不同的收费窗口数，与其位置，得到大量数据进行分析，得出适用于各种车道路段情况下最优的收费广场形状和收费窗口数，并得出普适的线性模型。

# 问题描述

多车道收费高速路收费方式通常用“匝道收费”和“主线收费”以此来收取车辆在高速路行驶的费用，在这里我们对匝道收费站（高速公路与地方道路相接处）不做分析，我们分析主线收费站。主线收费站是一排收费窗口横跨在高速公路主线路段中间，垂直于车辆行驶的方向。通常收费窗口的数量总是大于车道数量。因此，当车辆进入收费站时，会从数量较少的常规行驶车道“散开进入”到较多数量的收费车道上，当车辆驶出收费站时，车辆必须从数量较多的收费站出口车道“合并进入”到数量较少的常规行驶车道。收费广场是高速公路上一块用于便于进行收费的区域，包括在收费之前“散开进入”区域，收费车道本身，和收费车道出口之后得而“合并进入”区域。例如，三车道单向高速公路可以在主线收费站中使用8个收费窗口。在缴费之后，车辆驶出收费广场，在与进入收费广场相同数量的车道（上述为三个）的高速公路上继续行驶。
考虑在单向L车道B个收费窗口的收费站的收费高速公路（B > L）。确定收费广场区域的形状，收费窗口数和合并模式。在模型中需要考虑的变量包括吞吐量（单位时间内进入收费广场和驶出收费广场的车辆数）和成本（时间成本）

# 前提与假设

* 所有车辆遵循同样交通规则
* 所有收费窗口提供同样的服务，车辆不会区分它们
* 模拟路段的车流量是由车道数（L）决定的，而不是收费窗口数（B）；改变收费窗口数不会改变车道数
* 收费窗口在模拟过程中保持不变
* 所有车辆体积一样

# 模型设计

## 构造元胞空间

构造二维平面元胞空间，每个元胞晶格取值为两种离散状态{有车,无车}，形状为正四边形。如图1所示，此图模拟L=6，B=8，且B靠近收费广场中央区域的情形，其中黑色区域为边界。

![L6-B8-center](https://github.com/tankeryang/graduate_works/blob/master/result/plaza.jpg)

## 车辆行进规则

* 前进：当前方车辆为空时，即当前元胞的前方元胞邻居状态为[无车]时，当前车辆以Pmove_forward=0.7的概率向前进一格（即随机慢化概率为1−Pmove_forward），若前方有车，即当前元胞的前方元胞邻居状态为[有车]时，则停留在当前位置。

* 变道：变道车辆紧限于上一时刻没有前进的车辆。设变道概率为Pswitch_lane=0.8，若当前车辆（上一时刻没有前进）左/右道无车，即当前元胞的左/右元胞邻居状态为[无车]时，当前车辆以Pswitch_lane的概率向左/右元胞邻居变道，左道优先。

* 等待收费：当车辆进入收费窗口时，会停留5个单位时间，以模拟收费时长。

## 车辆延误分析

* 统计每一时刻整个模拟收费路段状态为[有车]的元胞数。此值代表了每一时刻i的车辆延误时间。而每一时刻i的总车辆延误时间为：

> W_i = W_i-1 + l(plaza(x, y) > 0)
>
> 其中plaza为整个模拟收费路段，plaza(x, y)为第x行y列的元胞，1( )表示一个指示函数。

* 统计收费路段出口车流量，即每一时刻路段末尾状态为[有车]的元胞数总和，为：

> output_i = ouput_i-1 + l(plaza(plazalength, y) > 0)
>
> 其中plazalength为整个模拟收费路段长度。output的意义为被抵消掉的总延误时间。

* 定义总成本为C_total，有：

> C_total = (W/ouput)a + Bb
>
> 其中W为整个模拟过程的总延误时间，W/output为单位化总延误时间，a为每小时人均时间价值，b为每个收费窗口每小时的成本(收费工作人员的平均时薪)，根据实际参考，设置b=￥12.5/h，a的计算公式参考为：
> > a={V[(100-t)/100]}/C
> >
> > 其中V为当地人均薪资，t为税率，C为当地人均消费水平。根据实际参考，设置a=￥2.68/h。

## 数据处理

模拟B={b|b=L+i ,(i=0,1,2…,10)}的11种情况，记录每一种情况下的C_total，每种情况模拟20次，取其中C_total平均值最小的对应的B值作为最优结果。

# 结论

B设置在收费广场中央，个数满足方程 B^=f(L)=<[1.74545 * L]>时取得最优通行效率。其中<[]>为向下取整。