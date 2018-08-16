---
layout: post
title: "一行代码搞定UITextField的输入格式限制"
date: 2018-08-16 14:00:16 +0800
comments: true
keywords: UITextField、ZASTextFieldFormat、swift、oc、赵阿申、阿申、zhaoashen、ashen
categories: i|OS
---

### ZASTextFieldFormat开发背景
   在开发的过程中，每次写到UITextField，就不由得心里不爽，因为要考虑到各种输入限制，实现代理、通知等一些麻烦繁琐的东西，就心中不爽，所以才写了这个[ZASTextFieldFormat](https://github.com/ashen-zhao/uitextfieldformat)简单的轮子，先暂时用着，等后期在慢慢优化完善。

### ZASTextFieldFormat 简介
一行代码，设置UITextField的输入格式限制，比如手机号、身份证号、银行卡号格式以及输入字符类型个数的限制等；


### 接口说明
```

/**
 * ZASTextFieldFormatDelegate代理
 *
 */
@property (nonatomic, assign) id<ZASTextFieldFormatDelegate> zasDelegate;

/**
 * 设置浮点类型,只允许输入两位小数的浮点类型（default=NO）
 * 
 */
@property (nonatomic, assign) Boolean isFloat;

/**
 * 设置正则匹配模式（如果设置正则模式，则忽略其他格式限制）
 *
 */
@property (nonatomic, copy) NSString * pattern;

/**
 * 设置UITextFiled格式控制的入口 (注：这个入口必须被调用)
 * format=nil或者""则不限制格式, charactersInString=nil或者""则不限制字符, maxLimit=0则不限制个数
 *
 * 示例: 以手机号为例
 * @param format              格式，eg: ### #### ####
 * @param charactersInString  支持输入的字符，eg: 0123456789
 * @param maxLimit            最大输入限制个数，eg: 11
 * 结果输入：159 1234 5678
 */
 - (void)textFieldWithFormat:(NSString *)format charactersInString:(NSString *)charactersInString maxLimit:(NSInteger)maxLimit;
```

### 具体使用
使原有UITextField继承自ZASTextFieldFormat，然后调用如何接口即可；

```
[_tfPhone textFieldWithFormat:@"### #### ####" charactersInString:@"0123456789" maxLimit:11];
```

### 参考Demo
[点击此处获取Demo](https://github.com/ashen-zhao/uitextfieldformat)