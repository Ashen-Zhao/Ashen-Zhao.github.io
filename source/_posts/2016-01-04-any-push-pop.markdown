---
layout: post
title: "iOS 如何随意的push来pop去"
date: 2016-01-04 11:08:00 +0800
comments: true
tags: [iOS push, pop, 随意pop]
keywords: iOS穿插pop, push, pop
description:  iOS 如何随意的push来pop去
categories: iOS
---
##iOS 导航控制器如何随意push和pop
---
第一次开始写技术文章，请同学们多多关照，有错的地方请给我指出，大家学习一起成长，好了，我就废话不多少了；	

---

####主题思想：如A、B、C、D 四个视图控制器

想要在 A push B 后， B 在push 到 D ，然后从 D pop 到 C ,在从 C pop 的A

---

####解决方法如下：

1.假如此时在 A 控制器下，想要到 push 到 B， 可以这样写

 	 [self.navigationController pushViewController: B :YES];
 <!--more-->
这时 `self.navigationController.viewControllers` 中按顺序含有 [A，B]

2.此时已经到 B 控制器下了， 接下来是 push 到 D, 可以这样写

 	 [self.navigationController pushViewController: D :YES];
这时 `self.navigationController.viewControllers` 中按顺序含有 [A，B，D]

接下来**很重要，很重要，很重要**：

如何想从 D pop 到 C, 看数组[A，B，D] 中压根就没有C 该如何pop 到C呢？

这时就需要对这个数组进行修改，将C 加入进去

**于是 你会如下写：**

 	[self.navigationController.viewControllers addObject:C]; 
发现报错，这是因为`self.navigationController.viewControllers` 是不可变数组，没办法了，我们只好转换一下了：

	NSMutableArray*tempMarr =[NSMutableArrayarrayWithArray:self.navigationController.viewControllers];
此时再加入C 就容易多了，咦，聪明的你会发现从 D pop C 不能直接将 C直接 addObject;

**当然，我会这样做：**

	[tempMarr insertObject:C atIndex:tempMarr.count- 2];
这时候 `tempMarr` 是这样的 [A，B，C，D],  可是 要想 从 C pop 到 A ,数组中就不能有 B

就需要 将`tempMarr` 变成 [A，C，D] ，至于怎么变，你比我懂得多，

懂得思考的同学会发现 这时的`self.navigationController.viewControllers` 依然是 [A，B，D]， 不用急，不用怕`navigationController` 有这样一个方法, 可以搞定，如下：

	[self.navigationController setViewControllers:tempMarr animated:YES];
有的同学会说，这不是直接把 B 替换 成 C 吗

看上去是这样，可是跳转的时机，时机，时机重要的事情说三遍，还有视图的切换，切换，切换

此时还在 B 控制器中，这些处理过程都是在 B 中处理的 ， 也必须是 B 执行了 push 到 D 方法后，也就是说

 	[self.navigationController pushViewController:D animated:YES];
 之后 进行的 数组处理；

####附加代码：

在B 控制器中处理：

	-(void)pushTest {

		[self.navigationController pushViewController:D animated:YES];

	NSMutableArray*tempMarr =[NSMutableArrayarrayWithArray:self.navigationController.viewControllers];

	[tempMarr insertObject:C atIndex:tempMarr.count- 2];

	[tempMarr removeObject:self]; //此时 的self 就是指 B ,因为在 B 中呢
	
	[self.navigationController setViewControllers:tempMarr animated:YES];

	}
[Demo下载地址](https://github.com/Ashen-Zhao/anypushpop)