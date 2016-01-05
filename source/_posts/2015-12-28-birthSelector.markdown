---
layout: post
title: "iOS 只需几步实现生日选择器"
date: 2015-12-29 15:19:49 +0800
comments: true
tags: [日历, iOS生日选择器, 日历选择]
keywords: 日历, iOS生日选择器, 日历选择
description:  iOS 实现生日选择器
categories: iOS
---
  项目开发中难免会遇到让用户填写出生年月的时候，本章来介绍一下我自己写的生日选择器的[ASBirthSheet](https://github.com/Ashen-Zhao/ASBirthSheet); 
大致就是这个样子![示例图](http://ashen-zhao.github.io/images/birthsrceenshot.png)
  我对生日选择器页面进行了简单的封装，算上.h文件只有两个文件，使用起来很简单；
<!--more-->
####以下是对.h文件中的说明
<pre><code>
@property (nonatomic, copy) void(^GetSelectDate)(NSString *dateStr);

@property (nonatomic, strong) NSString * selectDate;
</code></pre>
`GetSelectDate`是一个Block回调，是在选择完日期后确认后，就会触发，它返回一个日期格式为`2015-12-08`的字符串；
`selectDate`是设置选中时的日期格式也需要是`2015-12-08`才能匹配；
####以下是使用方法：
<pre><code>
-(void)chooseBirthdayAction{

    ASBirthSelectSheet *datesheet = [[ASBirthSelectSheet alloc] initWithFrame:self.view.bounds];
    datesheet.selectDate = @"2015-12-08";
    datesheet.GetSelectDate = ^(NSString *dateStr) {
        NSLog(@"ok Date:%@", dateStr);
    };
    [self.view addSubview:datesheet];
}
</code></pre>
使用起来很容易就这么几步，就可以实现一个简单的生日选择器；
由于只是使用，并没有对其进行很好地封装，如果你感兴趣，可以封装的更好点，来共同交流下；
附：
[Demo下载地址](https://github.com/Ashen-Zhao/ASBirthSheet)