---
layout: post
title: "UITableView重用机制导致CABasicAnimation动画失效"
date: 2017-03-02 18:24:49 +0800
comments: true
keywords: CABasicAnimation ,动画失效, tableview重用导致动画失效，动画失灵，不起作用，摇摆动画  
categories: i|OS
---

开发随记，再给cell上添加一个小动画图片时，遇到一个很蛋疼的问题，动画明明会动，而且退出后台在回来也会动，可就是拉出屏幕外，在回来时，动画失效了，不会动了。以下是动画代码，就是一个简单的摇摆动画  

```
let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
            rotationAnim.toValue = M_PI/5
            rotationAnim.autoreverses = true
            rotationAnim.repeatCount = MAXFLOAT
            rotationAnim.duration = 0.2
            rotationAnim.isRemovedOnCompletion = false
            moveImgv.layer.add(rotationAnim, forKey: nil)
```
<!--more-->
于是就开始看CABasicAnimation的类的属性说明，该设置的都设置了，可还是不行，百度，谷歌，搜狗统统找不到原因，全是CABasicAnimation的简单教程。  

无奈至极呀，就开始检查代码，看有没有可以修改的地方，一通乱世只会，在上面代码中的最后一行  
`moveImgv.layer.add(rotationAnim, forKey: nil)`  
  
我发现forkey是nil，可当我给它一个值的时候，  

`moveImgv.layer.add(rotationAnim, forKey: "moveanimation")`  
再次调试，却发现重用后，动画终于可以动了，原来我废了那么久的时间，却是这样的问题，真是想哭，又想笑😁。  

就是这样的问题，在网上找了好久，却找不到结果，可能是大家都写了key了吧，在此写下这边文章，希望有遇到像我一样的问题的同学可以找到解决办法。 

