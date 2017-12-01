---
layout: post
title: "Xcode修改版权Copyright、统一配置类前缀"
date: 2017-12-01 13:51:07 +0800
comments: true
keywords: 修改版权,copyright,类前缀
categories: i|OS  
---

####修改类的Copyright、类前缀
对于已经在项目中的文件，想要修改版权信息，使用全局替换就可以了，而对于新文件来说，想让Xcode帮你自动填充版权方，也是很方便的，之前都是傻瓜式的替换，现在发现了新大陆，就来这里记录下吧，具体操作流程如下图：  
![版权、前缀](/images/copyright.png)  

顺便加点料，对于有些项目，需要为每个类加一个前缀，也是可以按照这个流程来做的，设置上图中的`Class prefix`就可以了，这样Xcode会在新建的类的时候自动填充这个前缀了。