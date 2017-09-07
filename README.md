
# Table of Contents
 <p><div class="lev1 toc-item"><a href="#简介" data-toc-modified-id="简介-1"><span class="toc-item-num">1&nbsp;&nbsp;</span>简介</a></div><div class="lev1 toc-item"><a href="#问题描述" data-toc-modified-id="问题描述-2"><span class="toc-item-num">2&nbsp;&nbsp;</span>问题描述</a></div><div class="lev1 toc-item"><a href="#前提与假设" data-toc-modified-id="前提与假设-3"><span class="toc-item-num">3&nbsp;&nbsp;</span>前提与假设</a></div><div class="lev1 toc-item"><a href="#模型设计" data-toc-modified-id="模型设计-4"><span class="toc-item-num">4&nbsp;&nbsp;</span>模型设计</a></div><div class="lev2 toc-item"><a href="#构造元胞空间" data-toc-modified-id="构造元胞空间-41"><span class="toc-item-num">4.1&nbsp;&nbsp;</span>构造元胞空间</a></div><div class="lev2 toc-item"><a href="#车辆行进规则" data-toc-modified-id="车辆行进规则-42"><span class="toc-item-num">4.2&nbsp;&nbsp;</span>车辆行进规则</a></div><div class="lev2 toc-item"><a href="#车辆延误分析" data-toc-modified-id="车辆延误分析-43"><span class="toc-item-num">4.3&nbsp;&nbsp;</span>车辆延误分析</a></div><div class="lev2 toc-item"><a href="#数据处理" data-toc-modified-id="数据处理-44"><span class="toc-item-num">4.4&nbsp;&nbsp;</span>数据处理</a></div><div class="lev1 toc-item"><a href="#结论" data-toc-modified-id="结论-5"><span class="toc-item-num">5&nbsp;&nbsp;</span>结论</a></div><div class="lev1 toc-item"><a href="#文件说明" data-toc-modified-id="文件说明-6"><span class="toc-item-num">6&nbsp;&nbsp;</span>文件说明</a></div>

# 简介

毕业论文题目为__《高速路收费广场优化设计与分析》__，主要运用了交通流理论中常用的模型方法与现今较为广泛应用的模型方法__（元胞自动机）__，具体考察高速公路出入口收费站（单收费窗口模式）提高车流量的优化问题，通过计算机模拟不同车道情况下，设置不同的__收费窗口数__，与其__位置__，得到大量数据进行分析，得出适用于各种车道路段情况下最优的__收费广场形状__和__收费窗口数__，并得出普适的__线性模型__。

# 问题描述

多车道收费高速路收费方式通常用__匝道收费__和__主线收费__以此来收取车辆在高速路行驶的费用，在这里我们对匝道收费站（高速公路与地方道路相接处）不做分析，我们分析主线收费站。主线收费站是一排收费窗口横跨在高速公路主线路段中间，垂直于车辆行驶的方向。通常__收费窗口__的数量总是大于__车道数量__。因此，当车辆进入收费站时，会从数量较少的常规行驶车道__“散开进入”__到较多数量的收费车道上，当车辆驶出收费站时，车辆必须从数量较多的收费站出口车道__“合并进入”__到数量较少的常规行驶车道。__收费广场__是高速公路上一块用于便于进行收费的区域，包括在收费之前__“散开进入”区域__，__收费车道__本身，和收费车道出口之后的__“合并进入”区域__。

例如，__三车道单向高速公路__可以在主线收费站中使用__8__个收费窗口。在缴费之后，车辆驶出收费广场，在与进入收费广场__相同__数量的车道（上述为三个）的高速公路上继续行驶。

考虑在单向L车道B个收费窗口的收费站的收费高速公路$(B > L)$。确定收费广场区域的__形状__，__收费窗口__数和__合并模式__。在模型中需要考虑的变量包括__吞吐量（单位时间内进入收费广场和驶出收费广场的车辆数）__和__成本（时间成本）__

# 前提与假设

* 所有车辆遵循同样交通规则
* 所有收费窗口提供同样的服务，车辆不会区分它们
* 模拟路段的车流量是由车道数$(L)$决定的，而不是收费窗口数$(B)$；改变收费窗口数不会改变车道数
* 收费窗口在模拟过程中保持不变
* 所有车辆体积一样

# 模型设计

## 构造元胞空间

构造二维平面元胞空间，每个元胞晶格取值为两种离散状态$\left\{有车, 无车\right\}$，形状为正四边形。如下图所示，此图模拟$L=6$，$B=8$，且$B$靠近收费广场中央区域的情形，其中黑色区域为边界。

<center>![L6-B8-center](https://github.com/tankeryang/graduate_works/blob/master/result/plaza.jpg)</center>

## 车辆行进规则

* __前进__：当前方车辆为空时，即当前元胞的前方元胞邻居状态为$[无车]$时，当前车辆以$P_{move\_forward}=0.7$的概率向前进一格（即随机慢化概率为$1−P_{move\_forward}$），若前方有车，即当前元胞的前方元胞邻居状态为$[有车]$时，则停留在当前位置。

* __变道__：变道车辆紧限于上一时刻没有前进的车辆。设变道概率为$P_{switch\_lane}=0.8$，若当前车辆（上一时刻没有前进）左/右道无车，即当前元胞的左/右元胞邻居状态为$[无车]$时，当前车辆以$P_{switch\_lane}$的概率向左/右元胞邻居变道，左道优先。

* __等待收费__：当车辆进入收费窗口时，会停留$5$个单位时间，以模拟收费时长。

## 车辆延误分析

* 统计每一时刻整个模拟收费路段状态为$[有车]$的元胞数。此值代表了每一时刻$i$的车辆延误时间。而每一时刻i的总车辆延误时间为：

$$W_{i} = W_{i-1} + l\left(plaza\left(x,y\right) > 0\right)$$

> 其中$plaza$为整个模拟收费路段，$plaza(x,y$)为第$x$行$y$列的元胞，$l$表示一个指示函数。

* 统计收费路段出口车流量，即每一时刻路段末尾状态为$[有车]$的元胞数总和，为：

$$output_{i} = ouput_{i-1} + l\left(plaza\left(plazalength, y\right) > 0\right)$$

> 其中$plazalength$为整个模拟收费路段长度。$output$的意义为被抵消掉的总延误时间。

* 定义总成本为$C_{total}$，有：

> $$C_{total} = (W/ouput)𝛼 + B𝛾$$

> 其中$W$为整个模拟过程的总延误时间，$W/output$为单位化总延误时间，$𝛼$为每小时人均时间价值，$𝛾$为每个收费窗口每小时的成本(收费工作人员的平均时薪)，根据实际参考，设置$𝛾=￥12.5/h$，$𝛼$的计算公式参考为：
$$𝛼={V[(100-t)/100]}/C$$
> > 其中V为当地人均薪资，t为税率，C为当地人均消费水平。根据实际参考，设置$𝛼=￥2.68/h$。

## 数据处理

模拟$B=\left\{b | b=L+i ,\left(i=0,1,2,\cdots,10\right)\right\}$的$11$种情况，记录每一种情况下的$C_{total}$，每种情况模拟$20$次，取其中$C_{total}$平均值最小的对应的B值作为最优结果。

# 结论

$B$设置在收费广场中央，个数满足方程 $\hat{B}=\left \lfloor 1.74545\times L \right \rfloor$时取得最优通行效率。

# 文件说明

* ```source_code文件夹```：元胞自动机模拟过程源码，语言为```matlab```。直接运行```cellular.m```即可。自定义函数功能可通过单步调试```celluar.m```进行跳转了解其功能，这里不作赘述
* ```data文件夹```：运行```cellular.m```所得结果，格式为```.csv```
* ```result文件夹```：包括```data```数据可视化后的结果，回归分析的结果（截图）和模拟过程（截图）。格式为```.png```，```.jpg```；还有```jupyter_notebook_file```文件夹下的源文件生成的```html```文件，用浏览器打开。
* ```jupyter_notebook_file```：数据可视化和回归分析的源文件，格式为```.ipynb```
