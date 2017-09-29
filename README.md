
# Table of Contents
 <p><div class="lev1 toc-item"><a href="#简介" data-toc-modified-id="简介-1"><span class="toc-item-num">1&nbsp;&nbsp;</span>简介</a></div><div class="lev1 toc-item"><a href="#问题描述" data-toc-modified-id="问题描述-2"><span class="toc-item-num">2&nbsp;&nbsp;</span>问题描述</a></div><div class="lev1 toc-item"><a href="#前提与假设" data-toc-modified-id="前提与假设-3"><span class="toc-item-num">3&nbsp;&nbsp;</span>前提与假设</a></div><div class="lev1 toc-item"><a href="#模型设计" data-toc-modified-id="模型设计-4"><span class="toc-item-num">4&nbsp;&nbsp;</span>模型设计</a></div><div class="lev2 toc-item"><a href="#构造元胞空间" data-toc-modified-id="构造元胞空间-41"><span class="toc-item-num">4.1&nbsp;&nbsp;</span>构造元胞空间</a></div><div class="lev2 toc-item"><a href="#车辆行进规则" data-toc-modified-id="车辆行进规则-42"><span class="toc-item-num">4.2&nbsp;&nbsp;</span>车辆行进规则</a></div><div class="lev2 toc-item"><a href="#车辆延误分析" data-toc-modified-id="车辆延误分析-43"><span class="toc-item-num">4.3&nbsp;&nbsp;</span>车辆延误分析</a></div><div class="lev2 toc-item"><a href="#数据处理" data-toc-modified-id="数据处理-44"><span class="toc-item-num">4.4&nbsp;&nbsp;</span>数据处理</a></div><div class="lev1 toc-item"><a href="#结论" data-toc-modified-id="结论-5"><span class="toc-item-num">5&nbsp;&nbsp;</span>结论</a></div><div class="lev1 toc-item"><a href="#文件说明" data-toc-modified-id="文件说明-6"><span class="toc-item-num">6&nbsp;&nbsp;</span>文件说明</a></div>

# 简介

毕业论文题目为 __《高速路收费广场优化设计与分析》__ ，主要运用了交通流理论中常用的模型方法与现今较为广泛应用的模型方法 __（元胞自动机）__ ，具体考察高速公路出入口收费站（单收费窗口模式）提高车流量的优化问题，通过计算机模拟不同车道情况下，设置不同的 __收费窗口数__ ，与其 __位置__，得到大量数据进行分析，得出适用于各种车道路段情况下最优的 __收费广场形状__ 和 __收费窗口数__ ，并得出普适的 __线性模型__ 。

# 问题描述

多车道收费高速路收费方式通常用 __匝道收费__ 和 __主线收费__ 以此来收取车辆在高速路行驶的费用，在这里我们对匝道收费站（高速公路与地方道路相接处）不做分析，我们分析主线收费站。主线收费站是一排收费窗口横跨在高速公路主线路段中间，垂直于车辆行驶的方向。通常 __收费窗口__ 的数量总是大于 __车道数量__ 。因此，当车辆进入收费站时，会从数量较少的常规行驶车道 __“散开进入”__ 到较多数量的收费车道上，当车辆驶出收费站时，车辆必须从数量较多的收费站出口车道 __“合并进入”__ 到数量较少的常规行驶车道。 __收费广场__ 是高速公路上一块用于便于进行收费的区域，包括在收费之前 __“散开进入”区域__ ，__收费车道__ 本身，和收费车道出口之后的 __“合并进入”区域__。

例如，__三车道单向高速公路__ 可以在主线收费站中使用__8__个收费窗口。在缴费之后，车辆驶出收费广场，在与进入收费广场 __相同__ 数量的车道（上述为三个）的高速公路上继续行驶。

考虑在单向L车道B个收费窗口的收费站的收费高速公路 __(B > L)__。确定收费广场区域的 __形状__ ，__收费窗口数__ 和 __合并模式__。在模型中需要考虑的变量包括 __吞吐量（单位时间内进入收费广场和驶出收费广场的车辆数）__ 和 __成本（时间成本）__

# 前提与假设

* 所有车辆遵循同样交通规则
* 所有收费窗口提供同样的服务，车辆不会区分它们
* 模拟路段的车流量是由车道数 __(L)__ 决定的，而不是收费窗口数 __(B)__；改变收费窗口数不会改变车道数
* 收费窗口在模拟过程中保持不变
* 所有车辆体积一样

# 模型设计

## 构造元胞空间

构造二维平面元胞空间，每个元胞晶格取值为两种离散状态 __{有车, 无车}__，形状为正四边形。如下图所示，此图模拟 __L=6__，__B=8__，且 __B__ 靠近收费广场中央区域的情形，其中黑色区域为边界。

![L6-B8-center](https://github.com/tankeryang/graduate_works/blob/master/result/plaza.jpg)

## 车辆行进规则

* __前进__：当前方车辆为空时，即当前元胞的前方元胞邻居状态为 __{无车}__ 时，当前车辆以 __P_move_forward = 0.7__ 的概率向前进一格（即随机慢化概率为 __1−P_move_forward__），若前方有车，即当前元胞的前方元胞邻居状态为 __{有车}__ 时，则停留在当前位置。

* __变道__：变道车辆紧限于上一时刻没有前进的车辆。设变道概率为 __P_switch_lane = 0.8__，若当前车辆（上一时刻没有前进）左/右道无车，即当前元胞的左/右元胞邻居状态为 __{无车}__ 时，当前车辆以 __P_switch_lane__ 的概率向左/右元胞邻居变道，左道优先。

* __等待收费__：当车辆进入收费窗口时，会停留 __5__ 个单位时间，以模拟收费时长。

## 车辆延误分析

* 统计每一时刻整个模拟收费路段状态为 __{有车}__的元胞数。此值代表了每一时刻 __i__ 的车辆延误时间。而每一时刻 __i__ 的总车辆延误时间为：

![1](https://github.com/tankeryang/graduate_works/blob/master/readme_pics/1.jpg)

> 其中 __plaza__ 为整个模拟收费路段，__plaza(x,y)__ 为第 __x__ 行 __y__ 列的元胞，__l__ 表示一个指示函数。

* 统计收费路段出口车流量，即每一时刻路段末尾状态为 __{有车}__ 的元胞数总和，为：

![2](https://github.com/tankeryang/graduate_works/blob/master/readme_pics/2.jpg)

> 其中 __plazalength__ 为整个模拟收费路段长度。__output__ 的意义为被抵消掉的总延误时间。

* 定义总成本为 __C_total__，有：

![3](https://github.com/tankeryang/graduate_works/blob/master/readme_pics/3.jpg)

>其中 __W__ 为整个模拟过程的总延误时间，__W/output__ 为单位化总延误时间，__𝛼__
>为每小时人均时间价值，__𝛾__ 为每个收费窗口每小时的成本(收费工作人员的平均时薪)
>，根据实际参考，设置 __𝛾=￥12.5/h__，__𝛼__ 的计算公式参考为：
>![4](https://github.com/tankeryang/graduate_works/blob/master/readme_pics/.jpg)
> >其中 __V__ 为当地人均薪资，__t__ 为税率，__C__ 为当地人均消费水平。根据实际参考，设置 __𝛼=￥2.68/h__。

## 数据处理

模拟![5](https://github.com/tankeryang/graduate_works/blob/master/readme_pics/5.jpg)
的 __11__ 种情况，记录每一种情况下的 __C_total__，每种情况模拟 __20__ 次，取其中 __C_total__ 平均值最小的对应的 __B__ 值作为最优结果。

# 结论

__B__ 设置在收费广场中央，个数满足方程 __B = 1.74545 * L__ 时取得最优通行效率。

# 文件说明

* ```source_code文件夹```：元胞自动机模拟过程源码，语言为```matlab```。直接运行```cellular.m```即可。自定义函数功能可通过单步调试```celluar.m```进行跳转了解其功能，这里不作赘述
* ```data文件夹```：运行```cellular.m```所得结果，格式为```.csv```
* ```result文件夹```：包括```data```数据可视化后的结果，回归分析的结果（截图）和模拟过程（截图）。格式为```.png```，```.jpg```；还有```jupyter_notebook_file```文件夹下的源文件生成的```html```文件，用浏览器打开
* ```jupyter_notebook_file文件夹```：数据可视化和回归分析的源文件，格式为```.ipynb```

![](http://latex.codecogs.com/gif.latex?\\frac{1}{1+sin(x)})