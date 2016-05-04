---
layout: post
title: "多样式UILabel"
date: 2016-01-04 16:22:19 +0800
comments: true
tags: [iOS, 多样式Label,啊神]
keywords: iOS, 多样式Label,啊神
description:  iOS 如何实现多样式Label,啊神
categories: i|OS
---
 有时候产品经理说，能把一句话显示多种颜色、多种字体吗？ 灵光一闪，弄多个UILabel来显示不就行了，我只能说可以，也只能说这法有点笨。于是我坚决不用这种方法，苦思冥想，终于有了眉目。先配张图来显摆显摆，其实很容易实现，我也就不啰嗦了，看招：
 <!--more-->
![啊神多样式UILabel](/images/doubleLabel.png)

#####由于很简单，不喜请喷我。
ok, 上代码，一看也就是一个方法：
<pre><code>
-(void)txtArr:(NSArray *)txtArr colorArr:(NSArray *)colorArr fontArr:(NSArray *)fontArr {

    NSInteger okCount = 0;
    okCount = txtArr.count < colorArr.count ? txtArr.count : colorArr.count;
    okCount = okCount < fontArr.count ? okCount : fontArr.count;

    NSMutableString *txt = [NSMutableString string];
    for (NSString *str in txtArr) {
        [txt appendString:str];
    }
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:txt];
    NSInteger startLoc = 0;
    for (int i = 0; i < okCount; i++) {
        [str addAttributes:@{NSForegroundColorAttributeName:colorArr[i], NSFontAttributeName:[UIFont systemFontOfSize:[fontArr[i] integerValue]]} range:NSMakeRange(startLoc, [txtArr[i] length])];
        startLoc += [txtArr[i] length];
    }
    self.attributedText = str;
}
</code></pre>
#####参数说明基本都是见明知意（大人，请允许我自恋吧）
1. txtArr: 传入的文本数组（对象是字符串）
2. colorArr: 颜色数组  （对象是UIColor）
3. fontArr: 字体数组  (对象是字符串如：@"18" 号字体)

#####使用方法，写给新手哦，老手请过滤吧，不然你又该喷我了
我还是以代码使用为主
<pre><code>
NSArray *a = [NSArray arrayWithObjects:@"瞅啥瞅", @"我不就是", @"多样式label么，哈哈", nil];

    NSArray *b = [NSArray arrayWithObjects:[UIColor redColor], [UIColor blackColor], [UIColor blueColor], nil];
    NSArray *c = [NSArray arrayWithObjects:@"19", @"13", @"17", nil];
    [self.multiLabel txtArr:a colorArr:b fontArr:c];
</code></pre>
哎，对了，我将此方法写成了UILabel的分类了，所以这么使用没什么不妥；至于分类，不懂得，去google吧，没翻墙的还是百度吧；

[Demo下载地址](https://github.com/Ashen-Zhao/multiLabel)