---
layout: post
title: "iOS进阶之逆向工程（越狱、砸壳、反编译）"
date: 2019-08-14 17:51:57 +0800
comments: true
tags: [iOS逆行工程, 越狱, 砸壳, 反编译]
keywords: iOS逆行工程, 越狱, 砸壳, 反编译
description:  iOS 进阶逆向工程（越狱、砸壳、反编译）
categories: i|OS
---


### 背景
这篇文章只是我的一个记录，记录我是如何一步一步的，从越狱一部手机到反编译一个APP，故不作为教程文章，只为自己以后方便复现，文章内容大部分从别人文章中采集整合，如若使用，仅供参考。
### 第一步、越狱
关于越狱看[这篇文章](https://baijiahao.baidu.com/s?id=1626241403987098895&wfr=spider&for=pc)足以，这里简单对这篇文章做下记录：  
1、用苹果手机自带的Safari浏览器打开app.ignition.fun  
2、进去后点击中间的按钮  
3、点击Jailbreaks  
4、点击Jailbreaks进去后拉倒最后点击Pwn20wnd  
5、点击GET然后点安装  
6、去设置信任证书，如果无法信息，卸载重新下载  
7、打开刚才安装的unc0ver APP  
8、点击「Jailbreak」按钮，越狱过程可能会重启三次，每次重启后再打开unc0ver APP点击Jailbreak按钮。  
9、出现Cydia后代表越狱成功  
注：如果越狱过程中，卡住OTA问题上，请到设置->存储管理里删除已经下载好的系统文件，如果删除了还是不行的话，请自行谷歌或者百度, 我因为有部专门测试手机，我选择了直接重置手机。懒得去找其他办法了。

### 第二步、砸壳
#### 这里选择一键砸壳工具frida-ios-dump
frida-ios-dump[下载地址](https://github.com/AloneMonkey/frida-ios-dump)
<!--more-->
#### 1、先安装frida  
##### 首页安装pip，打开终端，执行以下命令(如果已安装请跳过)  
`sudo easy_install pip `  
##### 其次，执行以下命令安装frida  
`sudo pip install frida-tools`  
如果安装报以下错误,  
`Uninstalling a distutils installed project (six) has been deprecated and will be removed in a future version. This is due to the fact that uninstalling a distutils project will only partially uninstall the project.`  
执行以下命令，  
`sudo pip install frida –upgrade –ignore-installed six`  
然后重新执行,  
`sudo pip install frida-tools `

#### 2、使用你的越狱手机，启动 Cydia，安装frida插件
软件源 Sources-> 编辑 Edit（右上角）-> 添加 Add（左上角）-> 输入 `https://build.frida.re`，通过刚才添加的软件源安装 frida 插件。
#### 3、通过USB链接手机和电脑
具体如何链接ssh这里[有篇文章](https://blog.csdn.net/youshaoduo/article/details/81097802), 我这里做简单记录：  
1、在手机上打开`Cydia`，搜索`openssh`并安装  
2、在Mac终端执行`brew install libimobiledevice`  
3、完成第二步后执行`iproxy 2222 22`,进行端口转换，此时终端界面显示`waiting for connection`  
4、打开新的终端执行`ssh -p 2222 root@127.0.0.1`, 这时候可能会出现   `The authenticity of host '[127.0.0.1]:2222 ([127.0.0.1]:2222)' can't be established.
ECDSA key fingerprint is SHA256:+0hOqiykO/N5kh9p+mYk2pb+2MAb5Q1DkFK9tTCZ7TU.
Are you sure you want to continue connecting (yes/no)?`. 
输入yes后按回车，此时会提示你输入手机的root密码，默认密码是：alpine  ，然后之前的那个`waiting for connection`终端窗口，就显示连接成功了。
#### 4、执行`frida-ps -U` 查看手机上安装的app
新开一个终端,执行`frida-ps -U` 即可在终端显示已安装app
#### 5、cd到已经下载的`frida-ios-dump`目录，执行以下命令安装依赖库  `sudo pip install -r requirements.txt --upgrade`  
#### 6、开始砸壳
终端执行以下命令  
`./dump.py app名称`  
这里的app名称为在手机桌面上显示的名称，砸壳完成后，会在frida-ios-dump目录里生成一个已砸壳的ipa文件，即可脱壳的app。
#### 7、判断是否砸壳
判断是否砸壳，进入app目录- otool -l WeChat  | grep crypt


### 安装 MonkeyDev、Reavl、 Hopper
##### 安装 [MonkeyDev](https://github.com/AloneMonkey/MonkeyDev/wiki/%E5%AE%89%E8%A3%85)  
##### 安装 [Reveal](https://www.jianshu.com/p/51c539f61ab0)  
##### 安装 [Hopper Disassemble](https://download.csdn.net/download/arr0813/10600870)
先把工具安装了，后续可能会继续更新，如何使用。

### 参考文章
[https://baijiahao.baidu.com/s?id=1626241403987098895&wfr=spider&for=pc](https://baijiahao.baidu.com/s?id=1626241403987098895&wfr=spider&for=pc)  
[https://blog.csdn.net/youshaoduo/article/details/81133492](https://blog.csdn.net/youshaoduo/article/details/81133492)  
[https://blog.csdn.net/youshaoduo/article/details/81097802](https://blog.csdn.net/youshaoduo/article/details/81097802)  
[http://mobile.51cto.com/hot-573146.htm](http://mobile.51cto.com/hot-573146.htm)  
[https://www.jianshu.com/p/28eb7616fd3a](https://www.jianshu.com/p/28eb7616fd3a)  
[https://blog.csdn.net/skylin19840101/article/details/54669815](https://blog.csdn.net/skylin19840101/article/details/54669815)  
[http://kuailejim.com/2016/04/25/%E6%89%8B%E6%8A%8A%E6%89%8B%E6%95%99%E4%BD%A0%E5%8F%8D%E7%BC%96%E8%AF%91%E5%88%AB%E4%BA%BA%E7%9A%84app/](http://kuailejim.com/2016/04/25/%E6%89%8B%E6%8A%8A%E6%89%8B%E6%95%99%E4%BD%A0%E5%8F%8D%E7%BC%96%E8%AF%91%E5%88%AB%E4%BA%BA%E7%9A%84app/)  
[http://www.alonemonkey.com/2018/01/30/frida-ios-dump/](http://www.alonemonkey.com/2018/01/30/frida-ios-dump/)