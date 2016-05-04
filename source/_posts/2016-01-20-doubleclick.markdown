---
layout: post
title: "简单实现双击tabBarItem刷新页面"
date: 2016-01-20 17:44:11 +0800
comments: true
keywords: 双击tabBar, 刷新页面, UITabBarController, UITabBarItem,啊神
description: 简单实现iOS双击tabbaritem刷新页面数据,啊神
categories: i|OS
---
###如何实现双击tabbarItem刷新页面？
&emsp;在网上寻找了一圈，众说纷纭，大差不差，而且基本上实现的不是双击才刷新，而是双击刷新一次后，只要再次单击就会刷新，这样很容易造成用户不小心点着，降低用户体验；见于这种局面，我花费了近一个小时，鼓捣出来了，只有双击的时候，才会去刷新页面（其实是伪双击，也就是单击两次，没有做两次单击时间间隔限制），废话不说了，直接上代码：   

<pre><code>
int i = 0;
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    i++;
    UIViewController *tbSelectedController = tabBarController.selectedViewController;
    if ([tbSelectedController isEqual:viewController]) {
        if (currentIndex == 1 && tabBarController.selectedIndex == 1 && i % 2 != 0) {
            UINavigationController *nav = self.viewControllers[1];
            TestViewController *tVC = nav.viewControllers[0];
            [tVC doubleClickRefrsh];
        }
        currentIndex = tabBarController.selectedIndex;
        return NO;
    }
    i = 1;
    return YES;
}
</code></pre>  
这里是 `UITabBarDelegate` 的代理方法，实现的是双击第二个tabBarItem，则刷新其对应的第一个视图的节目数据;  
至于`i`的存在，是为了记录是否是双击，我是根据`i`是偶数还是奇数来进行判断的；  
就酱紫吧，不清楚的只管拿去用就行了，我就不多解释了，只有这几行代码，真没啥解释的了\(^o^)/~
