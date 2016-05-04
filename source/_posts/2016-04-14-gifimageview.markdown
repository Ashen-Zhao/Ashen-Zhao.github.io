---
layout: post
title: "让UIImageView显示Gif图"
date: 2016-04-14 13:57:05 +0800
comments: true
keywords: iOS, Gif, UIImageView, GifUIImageView, UIImageViewGif,赵阿申,啊神
description: 让UIImageView显示Gif图,赵阿申,啊神
categories: i|OS
---
&emsp;各位同学们，这次给大家分享一个小工具，可以解决你在开发过程中，需要显示Gif图片的需求；由于太过于简单，我这里就不多说了；有需要的同学，请前往[https://github.com/ashen-zhao/asGifImageView](https://github.com/ashen-zhao/asGifImageView)进行下载，不需要的同学也可以去Star，留着以后使用，最后，记得关注我哦，哈哈😄；    

##接下来，简单写一下如何使用该工具
####示例图
![啊神gifUIImageView](/images/gifView.gif)  
####功能说明：
这是一个UIImageView的分类，可以让UIImageView支持显示本地Gif以及网络Gif图片。
####使用说明
1.导入分类头文件 `#import "UIImageView+ASGif.h"`  
2.调用  
&emsp;a.显示本地gif图片   
	`[self.gifImgV showGifImageWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"abc" ofType:@"gif"]]];`  
&emsp;b.显示网络gif图片  
	   `[self.gifImgV showGifImageWithURL:[NSURL URLWithString:@"http://ww1.sinaimg.cn/large/85cccab3gw1etdi67ue4eg208q064n50.gif"]];`