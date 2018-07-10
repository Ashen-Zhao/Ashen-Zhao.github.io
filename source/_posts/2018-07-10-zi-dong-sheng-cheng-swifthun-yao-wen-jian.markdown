---
layout: post
title: "自动生成混淆文件(swift版)"
date: 2018-07-10 14:00:16 +0800
comments: true
keywords: 垃圾代码、代码混淆、swift混淆代码、oc混淆代码、添加垃圾代码、规避审核
categories: i|OS
---

### 起因
你们都知道，AppStore审核机制，多款类似的APP，会被4.3拒绝，至于如何规避4.3，这里我只写如何给项目添加混淆代码（又叫垃圾代码），当然只添加垃圾代码，应该是规避不了4.3的，但至少可以迷惑机审，加大通过机审的概率，至于其他方法，不予多说。 我这里使用python脚本，自动生成swift垃圾文件代码，文件名随机，每个文件中含有少量变量，方法等。

### 实现原理
实现原理很简单，就是创建文件，向文件中，添加swift语言的字符串即可。


### 实现代码
[获取代码Demo文件点击此处](https://github.com/ashen-zhao/createSwift) 以下为实现代码
<!--more-->
```
# -*- coding: utf-8 -*-

import random

import os,sys

import string

#创建.swift文件

def createSwift(fileNmae,propertyNumber,methodArray):

    full_path =  sys.path[0] + '/SwiftFiles/' + fileNmae + '.swift'

    file = open(full_path, 'w')

    file.write('//\n//  '+fileNmae+'.swift\n//  Orange\n\n//  Created by Ashen on 18/06/06.\n//  Copyright ©  2018年 BeiLian. All rights reserved.\n//\n\n')

    file.write('import UIKit \n\n' + 'class '+fileNmae+': UIViewController {\n\n')
    
    propryNameArray = []

    for index in range(1,propertyNumber):

        propryNameArray.append(random.choice(array))

    propryNameArray = list(set(propryNameArray))

    for propertyName in propryNameArray:

        file.write('    public var '+propertyName+':'+random.choice(classArray)+'!\n')

    file.write('\n\n')
    
    file.write('    override func viewDidLoad() {\n        super.viewDidLoad()\n    }\n\n')
   

    for methodName in methodArray:

        file.write('    public func '+methodName+'TOVC() {\n\n       var realArr = Array<String>()\n')

        number = random.randint(3, 10)

        for i in range(1,number):

            file.write('       realArr.append("'+random.choice(array)+'")\n')

        file.write('\n    }\n\n')

    file.write('}')

    file.close()

    print('Done')


def createClassName():
    
    first = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    second = "abcdefghijklmnopqrstuvwxyz"

    index = 0

    array = []

    # 设置生成多少个类
    classNumber = 3
    for i in range(classNumber):

        final=(random.choice(first))

        index = random.randint(3, 5)

        for i in range(index):

            final+=(random.choice(second))

        final += (random.choice(first))

        for i in range(index):

            final+=(random.choice(second))

        array.append(final)
    return array

#属性类型
classArray = ['UIColor','UILabel','UITableView','UISlider','UIScrollView','UIView','UIButton']

array = createClassName()

array = list(set(array))

for name in array:

    number = random.randint(3, 10)

    methodArray = []

    for i in range(1,5):

        methodArray.append(random.choice(array))

    methodArray = list(set(methodArray))#数组去重
    
    createSwift(name+'VController',number,methodArray)
 
```

