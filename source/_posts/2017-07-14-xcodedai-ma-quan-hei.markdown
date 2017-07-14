---
layout: post
title: "Xcode代码全黑的另一种解决办法"
date: 2017-07-14 16:44:48 +0800
comments: true
keywords: Xcode代码全黑
categories: i|OS
---
#### Xcode代码全黑且没有智能提示，应该算是开发中最烦恼的事之一了吧，一旦遇到这样问题，之前除了Clean项目，删除DerivedData文件夹，然而这样并没有什么用，偶尔重启Xcode或许运气好的话，彩色世界就会回来了。

#### 运气为什么好就能回来了，联想到Xcode比较吃内存，在联想到我苦逼的4g内存，估计Xcode代码全黑，可内存有联系呀，瞬间茅塞顿开呀，赶紧打开活动监视器，看到占用内存最多的 SourceKitService，大概百度了下SourceKitService这个进程，也没发现有什么比较严重的东东，就退出SourceKitService这个进程，回到Xcode发现，代码不再是全黑了，又回到彩色世界了，世界又是那么的美好，编程也变得快乐了  

#### 总结，Xcode代码全黑的另一种解决办法，就是打开活动监视器，退出SourceKitService进程，就可以了。

注：可能只针对内存比较小的电脑（另外：我的项目是swift项目）
