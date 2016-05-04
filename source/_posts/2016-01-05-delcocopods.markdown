---
layout: post
title: "从工程中删除Cocoapods"
date: 2016-01-05 17:16:42 +0800
comments: true
tags: [删除Cocoapods, Cocoapods, 啊神]
keywords: 删除Cocoapods, Cocoapods, 啊神
description:  从工程中删除Cocoapods, 啊神

categories: i|OS
---
&emsp;会有这么一种情况，因为需要改动的第三方比较多，不想使用cocoapods管理第三方，这时候，对于已经使用cocoapods的情况，需要进行删除处理，就可以按照以下步骤进行：

1. 删除工程文件夹下的Podfile、Podfile.lock及Pods文件夹

2. 删除xcworkspace文件

3. 使用xcodeproj文件打开工程，删除Frameworks组下的Pods.xcconfig及libPods.a引用

4. 在工程设置中的Build Phases下删除Check Pods Manifest.lock及Copy Pods Resources, 可能还会有Embed Pods Frameworks也删了，总之带有Pods全删了
<!--more-->
![啊神删除图](/images/delcocopods.png)

**注意**:如果将cocoapods集成到工程中后不小心修改或删除了其相关文件导致无法便以通过例如：不小心把

Pods.xcconfig给删除了然后出现diff: /../Podfile.lock: No such file or directory，用上面的方法删除cocoapods后，

再重新$sudo pod install一下就好了。

如果编译的时候出现权限问题，对工程文件夹$sudo chmod 777 path-to-project-folder/*

$sudo chown 777 path-to-project-folder/*

